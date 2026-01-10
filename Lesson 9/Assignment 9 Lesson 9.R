#### Lesson 9 ####
# Nava Peter (211311147)
# Introduction to R

# Load CSV and Check Information

heart = read.csv("C:\\Users\\USER\\OneDrive - mail.tau.ac.il\\University\\coding\\heart.csv")
num_r= nrow(heart) # num of rows
num_c= ncol(heart) #num of columns
print(summary(heart)) # overview of the df
print(colSums(is.na(heart))) # checks if there's any na and how much there is
print(head(heart)) # gives a general overview of the information

# Create Binary Variable

heart$binary_bs = ifelse(!is.na(heart$bs) & heart$bs>=120, 1, 0)

# df division

set.seed(123)

idx_train <- sample(1:num_r, size = floor(0.7 * num_r)) # Creates a list of random values that are 70% of the data
df_training <- heart[idx_train, ] # Creates df_training
df_test <- heart[-idx_train, ] # Creates df_test

# Values calculation

n_train <- nrow(df_training) # value number calculation for df_training
n_test  <- nrow(df_test) # value number calculation for df_test
n_total <- nrow(heart) # value number calculation for the total values

print(n_train) # prints the number of values in df_training
print(n_train / n_total * 100) # prints the percentage of values in df_training

print(n_test) # prints the number of values in df_train
print(n_test / n_total * 100) # prints the percentage of values in df_test


# Logistic Regression

model = glm(
  target ~ .,
  data = df_training,
  family = binomial
) # Creates a Logistic Regression model which predicts heart attacks

#Model Calculation
print(summary(df_test)) # shows a summary of the necessary information
predict_value= predict(model, newdata= df_test, type= "response")
predict_high_or_low = ifelse(predict_value>= 0.5, 1, 0) # Codes so that high is 1 and low is 0

confusion_m= table(predicted= predict_high_or_low, df_test$target) # Creates a confusion matrix

print(confusion_m)


