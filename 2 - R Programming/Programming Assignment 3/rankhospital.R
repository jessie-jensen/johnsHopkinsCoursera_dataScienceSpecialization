rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data ##
  setwd("C:/Users/jjensen/Documents/Coursera - Data Science Certificate/2 - R Programming/Programming Assignment 3")
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
  
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  outcome_state <- data.frame(subset(outcome_measures, outcome_measures$State==state))
  
  # heart attack
  if(outcome=="heart attack"){
    outcome_state[, 11] <- as.numeric(outcome_state[, 11])
    
    rank_state <- outcome_state[order(outcome_state[,11],outcome_state[,2],na.last = NA),]
    
    if(num == "best") {
      rank_state[1,2]
    }
    else if(num == "worst") { 
      worst <- subset(outcome_state, outcome_state[,11]==max(outcome_state[,11],na.rm = TRUE))
      worst[1,2]
    }
    else {
      rank_state[num,2]
    }    
  }
  # heart failure
  else if(outcome=="heart failure"){
    outcome_state[, 17] <- as.numeric(outcome_state[, 17])
    
    rank_state <- outcome_state[order(outcome_state[,17],outcome_state[,2],na.last = NA),]
    
    if(num == "best") {
      rank_state[1,2]
    }
    else if(num == "worst") { 
      worst <- subset(outcome_state, outcome_state[,17]==max(outcome_state[,17],na.rm = TRUE))
      worst[1,2]
    }
    else {
      rank_state[num,2]
    }    
  }
  # pneumonia
  else if(outcome=="pneumonia"){
    outcome_state[, 23] <- as.numeric(outcome_state[, 23])
    
    rank_state <- outcome_state[order(outcome_state[,23],outcome_state[,2],na.last = NA),]
    
    if(num == "best") {
      rank_state[1,2]
    }
    else if(num == "worst") { 
      worst <- subset(outcome_state, outcome_state[,23]==max(outcome_state[,23],na.rm = TRUE))
      worst[1,2]
    }
    else {
      rank_state[num,2]
    }    
  }
}