#### Lesson 10 ####
# Nava Peter

# 1. Creating noise

# Noise equation
X= seq(1, 100, 1)
noise= rnorm(100, mean = 0, sd= 5)
equation = -0.5 + 1.2 * X
y= equation + noise

# Checking what happens to R^2
model = lm(
  y ~ X
)

summary(model)


# 2. Test and Train Models
set.seed(123)

# A. Creates Train and Test
# סימולציה: רגרסיה ליניארית עם שני מנבאים (ללא פולינומים)
n <- 200
df <- data.frame(
  x1 = rnorm(n),
  x2 = rnorm(n)
)

noise <- rnorm(n, mean = 0, sd = 5)
df$y <- 10 + 2*df$x1 - 1*df$x2 + noise

# חלוקה אקראית ל-Train/Test
idx_train <- sample(seq_len(nrow(df)), size = floor(0.8 * nrow(df)))
df_train <- df[idx_train, ]
df_test  <- df[-idx_train, ]

# התאמת מודל: חשוב ש-data יהיה df_train (לא df!)
model <- lm(y ~ x1 + x2, data = df_train)
summary(model)

# B. Creating MSE

# ניבוי על סט האימון והסט המבחן
pred_train <- predict(model, newdata = df_train)
pred_test  <- predict(model, newdata = df_test)

# חישוב SSE ו-MSE
sse_train <- sum((df_train$y - pred_train)^2)
mse_train <- mean((df_train$y - pred_train)^2)

sse_test <- sum((df_test$y - pred_test)^2)
mse_test <- mean((df_test$y - pred_test)^2)

mse_train
mse_test

