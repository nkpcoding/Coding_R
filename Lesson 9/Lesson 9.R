#### Lesson 9 ####
# Nava Peter

# Assignment 1: Write a Code for Logical Regression

set.seed(1)

n <- 200

df <- data.frame(
  x1 = rnorm(n),
  x2 = factor(sample(c("man", "woman"), n, replace = TRUE))
)

# משתנה תלוי בינארי
df$y <- rbinom(
  n,
  size = 1,
  prob = plogis(
    -0.5 + 
      1.2 * df$x1 + 
      ifelse(df$x2 == "man", 0.8, 0)
  )
)


model = glm(
  y ~ x1+ x2,
  data = df,
  family = binomial
)

df$predict_prob= predict(
  object= model,
  newdata= df,
  type= "response"
)

df$z0_or_1 = ifelse(df$predict_prob >= 0.5, 1, 0)