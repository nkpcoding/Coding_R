#### Lesson 8 ####
# Nava Peter

# A. Assignment 1- Creates a Graph on a Ratsif Variable
library(ggplot2)
ratzif <- data.frame (
  seq_100 = seq (from= 0, to= 100, by= 1)
  )
ggplot(ratzif, aes(x = seq_100)) +
  geom_point(color = "blue") +
  xlim(0, 100) +
  xlab("X Value") +
  theme_minimal()

# B. Assignment 2- Ratzif 0-100 with GGDist
library(ggdist)
# Already created ratzif in A so won't create it again
ggplot(ratzif, aes(x= seq_100))+
  xlim(0, 100)+
  stat_dotsinterval(
    point_interval = mean_qi,
    width = c(0.5, 0.95),
    dotsize = 1,
    color= "purple") +
  xlab("X Value (from 0 to 100)") +
  ylab ("Y Value (from 0 to 100)")+
  theme_minimal()

# C1.Write Code in GGPlot Which Will Present the Results
set.seed(123)

n_per_cell <- 30

gender <- factor(rep(c("female", "male"), each = 2 * n_per_cell))
group  <- factor(rep(rep(c("control", "treatment"), each = n_per_cell), times = 2))

# משתנה תלוי רציף (למשל ציון), עם אפקטים קטנים לדוגמה
y <- rnorm(4 * n_per_cell, mean = 50, sd = 10) +
  ifelse(gender == "male", 3, 0) +
  ifelse(group == "treatment", 5, 0) +
  ifelse(gender == "male" & group == "treatment", 2, 0)

df <- data.frame(gender, group, y)

library(dplyr)

df_summary <- df |>
  group_by(gender, group) |>
  summarise(
    mean_y = mean(y),
    sd_y   = sd(y),
    n      = n(),
    .groups = "drop"
  )

library(ggplot2)

ggplot(df_summary, aes(x= gender, y= mean_y, color = group))+
  geom_point()+
  theme_minimal()

# C2.
set.seed(1)
n <- 30
df <- data.frame(
  gender = factor(rep(c("female","male"), each = 2*n)),
  group  = factor(rep(rep(c("control","treatment"), each = n), times = 2))
) |>
  dplyr::mutate(y = rnorm(dplyr::n(), 50, 10) + ifelse(gender=="male", 3, 0) + ifelse(group=="treatment", 5, 0))

df_summary <- df |>
  dplyr::group_by(gender, group) |>
  dplyr::summarise(mean_y = mean(y), sd_y = sd(y), .groups="drop")

library(ggplot2)

ggplot(df_summary, ggplot2::aes(gender, mean_y, color = group)) +
  geom_point(position = position_dodge(0.3)) +
  geom_errorbar(ggplot2::aes(ymin = mean_y - sd_y, ymax = mean_y + sd_y),
      position = ggplot2::position_dodge(0.3), width = 0.2) +
  theme_minimal() +
  geom_point(data = df, aes(x= gender, y= y, color= group), position= position_dodge(0.3)) 


# D. Write GGErrorPlot for the Following Code

library(ggpubr)

set.seed(1)

df <- data.frame(
  gender = factor(rep(c("female", "male"), each = 40)),
  group  = factor(rep(rep(c("control", "treatment"), each = 20), times = 2))
)

df$y <- rnorm(
  n = nrow(df),
  mean = 50 +
    ifelse(df$group == "treatment", 5, 0) +
    ifelse(df$gender == "male", 3, 0),
  sd = 10
)

library(ggplot2)
library(ggdist)

ggerrorplot(
  df, 
  x= gender, 
  y= y, 
  color = group
)

# E. Annotations
library(dplyr)
library(ggplot2)

set.seed(1)

df <- data.frame(
  gender = factor(rep(c("female", "male"), each = 40)),
  group  = factor(rep(rep(c("control", "treatment"), each = 20), times = 2))
)

df$y <- rnorm(
  n = nrow(df),
  mean = 50 +
    ifelse(df$group == "treatment", 5, 0) +
    ifelse(df$gender == "male", 3, 0),
  sd = 10
)

df_summary <- df |>
  group_by(gender, group) |>
  summarise(
    mean_y = mean(y),
    sd_y   = sd(y),
    .groups = "drop"
  )

p <- ggplot(df_summary, aes(x = gender, y = mean_y, color = group, group = group)) +
  geom_point(position = position_dodge(width = 0.3), size = 3) +
  geom_errorbar(
    aes(ymin = mean_y - sd_y, ymax = mean_y + sd_y),
    width = 0.15,
    position = position_dodge(width = 0.3)
  ) +
  annotate(
    "text",
    x = 1.5,
    y = max(df_summary$mean_y + df_summary$sd_y) + 2,
    label = "בממוצע, קבוצת treatment גבוהה מקבוצת control",
    vjust= 0
  ) +
  theme_minimal()

# F. Faceting


  