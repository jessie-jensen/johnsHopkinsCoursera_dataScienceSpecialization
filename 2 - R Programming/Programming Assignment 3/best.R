best <- function(state, outcome) {
  ## Read outcome data ##
  setwd("C:/Users/Josh/Documents/R Projects/Coursera - Data Science Certificate/2 - R Programming/Programming Assignment 3")
  outcome_measures <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that state and outcome are valid ##
  
  # checking state
  us_states <- read.csv("US_States.csv")
  x <- 0
  for(i in 1:50) {
    if(state == us_states[i,2])  x <- 1  
  }
  if(x==0) stop("invalid state")
  
  # checking outcome
  valid_outcomes <- c("heart attack","heart failure","pneumonia")
  y <- 0
  for(j in 1:3) {
    if(outcome == valid_outcomes[j]) y <- 1
  }
  if(y==0) stop("invalid outcome")
  
  ## Return hospital name in that state with lowest 30-day death rate
  
  outcome_state <- subset(outcome_measures, outcome_measures$State==state)
  
  
  if(outcome=="heart attack"){
    outcome_state[, 11] <- as.numeric(outcome_state[, 11])
    best_state <- subset(outcome_state, outcome_state[,11]==min(outcome_state[,11],na.rm = TRUE))
    best_state[1,2]
  }
  else if(outcome=="heart failure"){
    outcome_state[, 17] <- as.numeric(outcome_state[, 17])
    best_state <- subset(outcome_state, outcome_state[,17]==min(outcome_state[,17],na.rm = TRUE))
    best_state[1,2]
  }
  else if(outcome=="pneumonia"){
    outcome_state[, 23] <- as.numeric(outcome_state[, 23])
    best_state <- subset(outcome_state, outcome_state[,23]==min(outcome_state[,23],na.rm = TRUE))
    best_state[1,2]
  }
}