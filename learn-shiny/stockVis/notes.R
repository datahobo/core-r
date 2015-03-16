# reactive expressions allow you to limit what gets re-run during a reaction.
# use the reactive function
## saves its result the first time you run it
## the next time it's called, it checks to see if it needs to be updated,
## and only updates if it needs it

## isolate prevents automatic reactions
## Objects that call a reactive value wrapped in isolate won't respond when
## the reactive value changes
