rankall <- function(outcome, num = "best") {
  ## Read outcome data
  setwd("C:/Users/jjensen/Documents/Coursera - Data Science Certificate/2 - R Programming/Programming Assignment 3")
  outcome_measures <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that state and outcome are valid
  # checking state
  us_states <- read.csv("US_States.csv")
  
  # checking outcome
  valid_outcomes <- c("heart attack","heart failure","pneumonia")
  y <- 0
  for(j in 1:3) {
    if(outcome == valid_outcomes[j]) y <- 1
  }
  if(y==0) stop("invalid outcome")
  
  
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  hospitals <- data.frame(hospital = NULL,state = NULL)
  
  for(i in 1:50){
    temp_state <- us_states[i,2]
    
    source("rankhospital.R")
    temp_rankhospital <- rankhospital(temp_state,outcome,num)
    
    temp_hospitals <- data.frame(hospital = temp_rankhospital, state = temp_state)  
  
#  temp_hospitals <- data.frame(hospital = "test1", state = "test2")
    hospitals <- rbind(hospitals,temp_hospitals)
  }
  hospitals
}
# 

# rankall("heart attack", 20)
# rankall("heart attack", "best")
# rankall("heart attack", "worst")
