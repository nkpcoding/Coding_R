#### Lesson 8 ####
# Nava Peter

# Assignment 1: Write a Code for Logical Regression

set.seed(1)

n <- 200

df <- data.frame(
  x = rnorm(n),
  x2 = factor(sample(c("control", "treatment"), n, replace = TRUE))
)

# משתנה תלוי בינארי
df$y <- rbinom(
  n,
  size = 1,
  prob = plogis(
    -0.5 + 
      1.2 * df$x + 
      ifelse(df$x2 == "treatment", 0.8, 0)
  )
)


model <- glm(
  survived ~ age + sex,
  data = df,
  family = binomial
)

