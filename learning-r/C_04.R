# Vectors, Matrices, and Arrays
# This is the source file for all the examples, questions, and exercises from Chapter 4.
## Chapter Run-through: 1

# Sequencing numbers through :
8.5:4.5

# creating vectors from scratch:
vector("numeric", 5)
vector("complex", 4)
vector("logical", 3)
vector("character", 7)
vector("list", 5)

# You can also create them directly
numeric(5)
complex(4)
logical(3)
character(7)
# But not list

# Creating sequences:
seq.int(3,12)
seq.int(3,12,2)
seq(3,12,2)

# Vectors have lengths, which is the count of elements in the vector
length(1:5)
sn <- c("shee", "three", "two")
length(sn)
nchar(sn)

# You can name elements in a vector
c(apple = 1, banana = 2, egg = 3, 4)
x <- 1:4
names(x) <- c("apple", "banana", "egg", "")
x
names(x)

# Indexing accesses a subset of a vector's elements, and is done through []
x <- (1:5) ^ 2
x
x[c(1, 3, 5)]
x[c(-2, -4)]
x[c(TRUE, FALSE, TRUE, FALSE, TRUE)]
# You can get the element ID of elements matching specific conditions using which
which(x > 10)
which.min(x)
which.max(x)
# need a multi-level reference to get the values themselves
x[which.min(x)]
x[which.max(x)]

# Doing Arithmetic on Vectors
x(1:5) + 1
(1:5) + 1
1:5 + 1:15

# you can do repeated vectors really easily
# A simple version loops the numbers
rep(1:5, 3)
# Another version repeats the numbers
rep(1:5, each = 3)
# times lets you specify how many times each element is repeated
rep(1:5, times = 1:5)
rep(1:5, times = 5:1)
# length.out creates a loop that ends in the middle
rep(1:5, length.out = 7)
# and apparently you can combine them!
rep(1:5, times = 3, length.out = 12)

# Arrays
# Arrays hold multidimensional rectangular data
# Matrices are two-dimensional arrays

# Create an array by specifying values, dimensions, then names
(three_d_array <- array(1:24,
                        dim = c(4, 3, 2),
                        dimnames = list(
                          c("one", "two", "three", "four"),
                          c("uno", "dos", "tres"),
                          c("cinco", "seis")
                          )
                        ))

# create a matrix by specifying values, number of rows, and names:
(a_matrix <- matrix(1:12,
                    nrow = 4,
                    dimnames = list(
                      c("one", "two", "three", "four"),
                      c("uno", "dos", "tres")
                      )
                    ))

(b_matrix <- matrix(1:12,
                    nrow = 4,
                    byrow = TRUE,
                    dimnames = list(
                      c("one", "two", "three", "four"),
                      c("uno", "dos", "tres")
                    )
))

dim(a_matrix)
dim(b_matrix)

nrow(a_matrix)
ncol(a_matrix)

# You can get the names easily enough
rownames(a_matrix)
colnames(a_matrix)
rownames(b_matrix)
colnames(b_matrix)

class(rownames(a_matrix))
typeof(rownames(a_matrix))
# You can also pick out a particular one
rownames(a_matrix)[2]

# You can get a whole row by specifying it:
a_matrix[1, ]
a_matrix[2, ]

# And a whole column the same way
a_matrix[, 3]

# the c function converts matrices to vectors before concatenating them
c(a_matrix, b_matrix)

# cbind and rbind bind the matrices together
cbind(a_matrix, b_matrix)
rbind(a_matrix, b_matrix)

# cbind and rbind are a way to merge data frames!
testdfr <- as.data.frame(cbind(a_matrix, b_matrix))
class(testdfr)

seq.int(0:1, 0.25)
