# Introduction to R
# Week 3
# Assignment by Nava Peter (211311147)

library(dplyr)
library(ggplot2)
library(ggdist)
library(ggpubr)

# 0. Imports Titanic Csv

titanic = read.csv("C:\\Users\\USER\\OneDrive - mail.tau.ac.il\\University\\coding\\titanic.csv") # Creates a dataframe of the Titanic upload

# 1. Information Organization- Survival
# The goal of this part is to first organiza the information we need for graph creation
titanic_summary= titanic |>
  group_by(Pclass, Sex) |> # Groups the class of the passanger and their sex
  summarise( 
    n = n(), # Calculates the N of each group
    mean_survived = mean(Survived, na.rm = TRUE), # Calculates the odds of survival for each group
    std = sd(Survived, na.rm = TRUE), # Calculates the standard deviation for each group
    se= std/sqrt(n), # Standard error
    .groups = "drop"
  )

# 2. Graph Creation

x_annot <- mean(titanic_summary$Pclass)
y_annot <- mean(titanic_summary$mean_survived)+0.3 # Point for annotation


graph1= ggplot(titanic_summary, aes(
  x = Pclass,
  y = mean_survived,
  color = Sex)) +
  geom_point(position = position_dodge(width = 0.3)) + # Creates the means +
  geom_errorbar(aes(ymin= mean_survived-se, 
        ymax= mean_survived+se),
    width = 0.15,
    position = position_dodge(width = 0.3)
  ) +
  annotate(
    "text",
    x= x_annot,
    y = y_annot,
    label = "ככל שהערך יותר גבוה, כך גבוה הסיכוי לשרוד")

  graph2= ggplot(titanic_summary, aes(
    x = factor(Pclass),
    y = mean_survived,
    color = Sex)) +
    geom_boxplot(aes(x= Pclass, color= Sex)) # Creates a Boxplot with the information
  
  graph3= ggplot(titanic_summary, aes(
    x = factor(Pclass),
    y = mean_survived,
    color = Sex)) +
  geom_violin(aes(x= Pclass, color= Sex)) # Creates a violin plo with the information
  
  graph4= ggplot(titanic_summary, aes(
    x = factor(Pclass),
    y = mean_survived,
    color = Sex)) +
  geom_col(aes(x= Pclass, color= Sex))

graph1
graph2
graph3
graph4

# 3. Graph Combination into Panels

combined= ggarrange(
  graph1, graph2, graph3, graph4,
  ncol = 2, nrow = 2,
  labels = c("Survival Errorbar (with annotations)", "Survival Violin Plot", "Survival Boxplot", "Survival Bar Plot (Personal Graph Addition)")
) # Creates a value that combines all graphs

annotate_figure(
  combined,
  top = text_grob("Titanic: Survival by Class and Sex", face = "bold", size = 14)
)

# 4. Saving as PDF and PNG

ggsave(
  filename = "r_assignment_8_graphs.png",
  plot = p,
  width = 10,
  height = 6,
  units = "in",
  dpi = 600
) # Saves as PNG

ggsave(
  filename = "r_assignment_8_graphs.pdf",
  plot = p,
  width = 10,
  height = 6,
  units = "in"
) # Saves as PDF
