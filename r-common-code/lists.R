# lists
# rank-based overlap calculations

# start with position-weighted average overlap

# testing - 0
# 1/2 squared - 0.02, 0.12
# same
firstList <- c(1,2,3,4,5,6,7,8,9,10)
secondList <- c(1,2,3,4,5,6,7,8,9,10)
(RankBiasedOverlap(firstList, secondList, p = 0.9))
(RankBiasedOverlap(firstList, secondList))
# opposite
firstList <-  c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
secondList <- c(10,9, 8, 7, 6, 5, 4, 3, 2, 1)
(RankBiasedOverlap(firstList, secondList, p = 0.9))
(RankBiasedOverlap(firstList, secondList))
# top 3 similar - 0.52, 0.42
firstList <- c(1,2,3,4,5,6,7,8,9,10)
secondList <- c(1,2,3,7,8,9,4,10,5,6)
(RankBiasedOverlap(firstList, secondList, p = 0.9))
(RankBiasedOverlap(firstList, secondList))
# top 2 similar 0.71
firstList <- c(1,2,3,4,5,6,7,8,9,10)
secondList <- c(1,2,8,7,6,5,4,10,9,3)
(RankBiasedOverlap(firstList, secondList, p = 0.9))
(RankBiasedOverlap(firstList, secondList))


# another test - 0.25 ----
firstList <- c(1,2,3)
secondList <- c(3,2,1)
# simplest case - 1
firstList <- c(1,2)
secondList <- c(1,3)
# slightly longer - 1
# sq - 0.75
firstList <- c(1, 2, 3)
secondList <- c(1, 2, 4)
# slightly more different - 0.72
# sq - 0.58
firstList <- c(1, 2, 3)
secondList <- c(1, 3, 4)
# should be slightly higher - 0.83
# sq - 0.64
firstList <- c(1, 2, 3)
secondList <- c(1, 3, 2)

# top half is generally similar: 0.875 ----
firstList <- c(1, 2, 3, 4, 5)
secondList <- c(1, 2, 3, 4, 5)
(RankBiasedOverlap(firstList, secondList, p = 0))
# these should be in descending order of similarity
secondList <- c(1, 2, 3, 5, 4)
(RankBiasedOverlap(firstList, secondList, p = 0.6))
secondList <- c(1, 2, 4, 3, 5)
(RankBiasedOverlap(firstList, secondList, p = 0.6))
secondList <- c(1, 2, 4, 5, 3)
(RankBiasedOverlap(firstList, secondList, p = 0.6))
secondList <- c(1, 3, 2, 4, 5)
(RankBiasedOverlap(firstList, secondList, p = 0.6))
secondList <- c(2, 1, 3, 4, 5)
(RankBiasedOverlap(firstList, secondList, p = 0.6))
secondList <- c(5, 4, 3, 2, 1)
(RankBiasedOverlap(firstList, secondList, p = 0.6))
# 1/2 squared - .64, .57

## function ----
RankBiasedOverlap <- function(firstList, 
                              secondList, 
                              listDepth = min(length(firstList), 
                                              length(secondList)), 
                              p = 0.5) {
  # listDepth is how far into the list we will go
  # set the initial parameter p such that 0 < p < 1 ----
  ## when p = 0, only the top rank has any value
  ## when p = 1, weights are approximately equal across the ranking
  # p <- 0
  if (p > 1) p <- 1
  if (p < 0) p <- 0
  # agreement is the vector of proportion of firstList and secondList that ----
  ## that are overlapped at depth d
  agreement <- NULL
  # weight is the vector of convergent weights
  weight <- NULL
  # overlap is the cumulative overlap score
  overlap <- 0
  # infinite sum formula for total weight
  totalWeight <- (1 - p)
  for (d in 1:listDepth) {
    # agreement is the proportion of both lists that are overlapped at d
    agreement[d] <- (length(intersect(firstList[1:d], secondList[1:d])) / d)
    # in the loop, the weight's value is p ^ d - 1
    weight[d] <- (1 - p) * p ^ (d - 1)
    newWeight <- sum(weight)
    overlap <- overlap + (weight[d] * agreement[d])
    print(paste("step", d, ": weight:", weight[d]))
    print(paste("agreement:", agreement[d]))
    print(paste("overlap:", overlap))
    print(paste("net weight:", sum(weight) * totalWeight))
    print(paste("new weight:", sum(weight) * newWeight))
  }
  newWeight <- (1 / sum(weight))
  print(paste("cumulative weight:", sum(weight) * totalWeight))
  print(paste("totalWeight:", totalWeight))
  print(paste("newWeight:", newWeight))
  print(paste("trialScore:", overlap * newWeight))
  return(overlap * totalWeight)
}

# testing convergence
cumulative <- 0
weight <- NULL
p <- 0.1
l <- 10
for (i in 1:l) {
  cumulative <- cumulative + p ^ (1 / i)
  print (paste("step ", i, ": score: ", cumulative, sep = ""))
}
print(cumulative * (1 - p))

(WeightedAverageOverlap(firstList, secondList))
WeightedAverageOverlap <- function(firstList, secondList) {
  overlap <- NULL
  rankScore <- 0
  # both lists do NOT need to be numeric, since we can compare product IDs
  # Assume that both lists are rank-ordered
  # let's change this to a version where we just compare based on the shorter list
  loopCounter <- min(length(firstList), length(secondList))
  # create the exponential weight for Zipf's distribution
  expWeight <- 1.2
  # now figure out the total weight based on Zipf's distribution
  totalWeight <- sum(1/(firstList[1:loopCounter] ^ expWeight))
  # now loop through the two lists, and do the comparison
  for (i in 1:loopCounter) {
    # get the similarity score for each list comparison
    overlap[i] <- (length(intersect(firstList[1:i], secondList[1:i])) / i)
    # troubleshoot the steps
    print (paste("step ", i, ": overlap: ", overlap[i], ": total weight: ", totalWeight, sep = ""))
    # even weighting of similarity scores
    rankScore <- rankScore + (overlap[i] / i ^ expWeight)
  }
  return(rankScore / totalWeight)
} 

