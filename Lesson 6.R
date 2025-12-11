# Introduction to R
# Week 5
# Assignment by Nava Peter (211311147)

## A. For Loops ##

# Round Parentheses () tells us what values the loop goes over
# Inside {} we write what we want the loop to do
# Example: "for (i in 1:5) { print(i) }"

#1.  Write a For loop that prints values from 1 to 10

num_i= 1 # Sets an index nuber

for (num_i in 1:10) { # A loop that prints out 1-10
  print(num_i)
}
# For automatically goes over every value that is listed

# Explain what this does
for (i in seq(1, 10)) { # Goes over every i in the sequence given (1-10)
  print(i) # Prints i
}

# Explain what this does
for (i in seq(0, 100, by = 10)) { # Goes with i in a sequence from 0-100, with a hump of 10 each time
  print(i) # Prints i
}

# Explain what this does
nums <- c(-20, 500, 32, 400) # Says nums is now equal to the following list in the order
sum_val <- 0 # The sum of the numbers (which is now equal to 0)

for (i in nums) { # i is equal to every value in nums
  sum_val <- sum_val + i # The value of i is added to the current sum there is
}

print(sum_val) # Prints out the overall sum

# Explain this as well

words <- c("you", "are", "a", "star", "that", "learns", "R") # Makes a vector of words called "words"

for (w in words) { # labels each individual word in the list as "w", and goes through the list
  print(w) # Prints out each word
}

# For Loop that Reads Documents

files_names <- dir("data")   # Creates a variable that is called "files_names" that gets its information from the data in the computer directory
df <- data.frame()           #  creates an empty dataframe called df

for (f in files_names) { # Creates a variable called f that represents the name of an individual document in the file we transported
  temp <- read.csv(paste0("data/", f))   # reads every document and saves it under the temp variable
  df <- rbind(df, temp)                  # adds to the current dataframe the temp document that was read
}

# This For Loop reads every document in a file and transforms it into a part of a dataframe, before moving onto the next data


##Errors in Functions##
rm(list = ls())
x1 = 2
x2 = 3
Multiplication(x1, x2)
Multiplication <- function(x1, x2) {
  x3 = 1000
  browser()     # עצירה
  y = x1 * x3
  return(y)
}


Multiplication(x1, x2)
