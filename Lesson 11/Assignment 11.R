#### Assignment 10 ####
# Nava Peter (211311147)
# Introduction to R

# Reads the CSV

exam_anxiety= read.csv("C:\\Users\\USER\\OneDrive - mail.tau.ac.il\\University\\coding\\r\\Exam_Anxiety.csv")

# General CSV Overview

print(head(exam_anxiety)) # Prints the head of the CSV
summary(exam_anxiety) # Prints a general summary of the CSV

# Checks NaN
ifelse (sum(is.na(exam_anxiety))!=0,
        (
          print("There is NaN") &
            exam_anxiety= drop_na(exam_anxiety)),
        print("There is no NaN"))

# Part 1: Graphic Presentation of the CSV

library(ggplot2)
library(ggdist)

ggplot(
  data = exam_anxiety,
  aes(x= anxiety_rating, y= exam_score) +
    geom_point(
      aes(x= anxiety_rating),
      xlim(min(exam_anxiety$anxiety_rating), max(exam_anxiety$anxiety_rating)),
      xlab("Anxiety Rating"))+
    geom_point(aes(x= exam_score), xlab("Exam Scores"), xlim(min(exam_anxiety$anxiety_rating), max(exam_anxiety$anxiety_rating))+
                 facet_grid(~variable.names())
               +
                 title("Anxiety Levels") +
                 theme_minimal()
    )
)

# Part 2: Gender Effect

# Graph 1: Gender on Anxiety Levels
y= exam_anxiety$anxiety_rating
x1= exam_anxiety$gender

gender_effect= lm(y ~ x1) # Regression between gender levels and anxiety ratings
summary(gender_effect) # summarizes the effect of gender on anxiety

# Graph 2: Gender and Treatment on Anxiety Levels
x2= exam_anxiety$treatment
gender_treatment_effect= lm(y ~ x1 + x2 + x1*x2)
summary(gender_treatment_effect)

# Graph 3: Gender and Treatment with No Interaction

x1_graph_3 = exam_anxiety$time_studying
treatment_prep_effect= lm(y~ x1_graph_3 + x2)
summary(treatment_prep_effect)

# Part 3: Prediction

# Creating Train and Test Models
idx_train <- seq(1, 90, 1)
df_train <- df[idx_train, ]
df_test  <- df[-idx_train, ]

# Creating the df_train model
grade_model <- lm(exam_anxiety$exam_score ~ exam_anxiety$time_studying, data = df_train)
summary(grade_model)

# Predicting with the df_train model
exam_anxiety$predict_grade_from_91= predict(grade_model, newdata= df_test)

# Graphic Presentation
ggplot(exam_anxiety, aes(x= predict_grade_from_91, y= exam_score)) +
  geom_errorbar()
