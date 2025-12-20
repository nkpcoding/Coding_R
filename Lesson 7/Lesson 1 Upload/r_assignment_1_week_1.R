# Introduction to R
# Week 1
# Assignment by Nava Peter (211311147)

#### Information Set ####

  # 1. Variable Set

      participant_num = c(1,2,3,4,5,6) # participant number
      participant_gender = c("male", "female", "nonbinary", "male", "female", "female")
      participant_age = c(17, 32, 26, 29, 33, 27) # age of participant (between 15-40)
      has_depression = c (0, 1, 1, 0, 0, 1) # whether the participant doesn't have depression (=0) or has depression (=1)
      participant_num = c(1:6) # participant number
      genders= c("male", "female", "nonbinary") # Creates a vector of gender
      participant_gender = sample(genders,size = 6, replace = T,) # Creates a vector with participant genders
      participant_age = c(sample(range(15, 40, size= 6, replace= T))) # age of participant (between 15-40)
      has_depression = rbinom(6, 1, prob = 0.5) # whether the participant doesn't have depression (=0) or has depression (=1)
  
  # 2. Dataset Creation and Viewing
      
        df_participant= data.frame (participant_num, participant_gender, participant_age, has_depression)
        View (df_participant)
        
#### Saving the Document ####
        save(df_participant, file = "r_assignment_1_week_1.rdata")
        write.csv(df_participant, file= "r_assignment_1_week_1.csv", row.names = FALSE)
        