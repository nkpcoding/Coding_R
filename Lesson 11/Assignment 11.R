#### Assignment 11 ####
# Nava Peter (211311147)
# Introduction to R

# Creating fake information

library(dplyr)

df_exam_grade= data.frame()
df_exam_grade <- df_exam_grade |>
  # creating the variables with a slope
  mutate(study_time = rnorm(200, mean= 4, sd= 2)) |>
  mutate(test_anxiety = rnorm(200, mean= 100, sd= 50)) |>
  mutate(sleep_quality= rnorm(200, mean = 50, sd= 50)) |>
  # Creating variables without a slope
  mutate(dominant_hand= rbinom(200,size = 1, prob = 0.5)) |>
  mutate(factor(music_preference= sample(c("rock", "pop", "country"), size = 200, replace = T), levels = c("rock", "pop", "country"))) |>
  mutate(screen_time_weekend= pmax(0, rnorm(200, mean = 4, sd= 2)))

# Adding noise for every grade
noise = rnorm(200, mean = 10, sd= 5)

# Creating Coefficients and Exam Score
b1= lm(exam_grade~ study_time, data= df_exam_grade)
b2= lm(exam_grade~test_anxiety, data = df_exam_grade)
b3= lm(exam_grade~sleep quality, data= df_exam_grade)
exam_score = [b1!=0 & b2!=0 & b3!= 0]b0+b1*study_time+b2*test_anxiety+b3*sleep_quality+noise
df_exam_grade= df_exam_grade |>
  mutate("exam score"= exam_score)

# Creating models
model_1= lm(exam_score~study_time, data= df_exam_grade)
model_2= lm(exam_score~ study_time + test_anxiety + sleep_quality, data = df_exam_grade)
model_3= lm(exam_score~ study_time + test_anxiety + sleep_quality + dominant_hand + music_preference + screen_time_weekend, data = df_exam_grade)
models= data.frame(model_1, model_2, model_3)

# Calculating model information
r_squared= c(summary(model_1)$r.squared, summary(model_2)$r.squared, summary(model_3)$r.squared)
r_adjusted= c(summary(model_1)$adj.r.squared, summary(model_2)$adj.r.squared, summary(model_3)$adj.r.squared)
AIC_all= c(AIC(model_1), AIC(model_2), AIC(model_3))
statistics= data.frame(r_squared, r_adjusted, AIC_all)

# Creating the graphic presentation
library(ggplot2)
ggplot(data = statistics, aes(x= models, y= statistics))+
  geom_bar(aes(x= models, y= r_squared),
           labs("R Squared Estimations"),
           xlab("Models"),
           ylab("R Squared")) +
  geom_bar(aes(x= models, y= r_adjusted),
           labs("Adjusted R Calculations"),
           xlab("Models"),
           ylab("R Squared"))+
  geom_bar(aes(x= models, y= AIC_all),
           labs("AIC Calculations"),
           xlab("Models"),
           ylab("AIC"))

# Train/Test and Prediction
idx_train <- sample(seq_len(nrow(df_exam_grade), size= floor(0.8 * nrow(df_exam_grade))))
df_train <- df[idx_train]
df_test <- df[-idx_train]

# Adjusts the models to the training data
models = models |>
  model_1= model_1= lm(exam_score~study_time, data= df_train) |>
  model_2= lm(exam_score~ study_time + test_anxiety + sleep_quality, data = df_train) |>
  model_3= lm(exam_score~ study_time + test_anxiety + sleep_quality + dominant_hand + music_preference + screen_time_weekend, data = df_train)
summary(models)

# Predicts the Test data

pred_train = predict(models, new_data= df_train)
pred_test= predict(models, new_data= df_test)

# Calculates SSE and MSE
sse_train = sum((df_train$y- pred_train)^ 2)
mse_train = mean((df_train$y - pred_train)^2)

sse_test= sum((df_test$y - pred_test)^2)
mse_test= mean((df_test$y-pred_test)^2)

mse_train
mse_test

pred_quality= data.frame(mse_train, mse_test)

# Creates a bar graph of the prediction quality
ggplot(data = pred_quality, aes(x= models, y= pred_quality)) +
  geom_bar(aes(x= models, y= pred_quality),
           labs("Prediction Quality on Models"),
           xlab("Models"),
           ylab("Prediction Quality"))




  