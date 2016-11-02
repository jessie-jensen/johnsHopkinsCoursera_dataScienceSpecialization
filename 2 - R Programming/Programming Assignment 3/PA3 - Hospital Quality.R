#############################################
##                                         ##
##  Project 3 - Hospital Quality           ##
##                                         ##
#############################################


setwd("C:/Users/Josh/Documents/R Projects/Coursera - Data Science Certificate/2 - R Programming/Programming Assignment 3")

### PART 1 ###

# outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
# 
# head(outcome)
# 
# nrow(outcome)
# ncol(outcome)
# 
# outcome[, 11] <- as.numeric(outcome[, 11])
# hist(outcome[, 11])


### PART 2 ###

# function called best that take two arguments: the 2-character abbreviated name of a state and an
# outcome name. The function reads the outcome-of-care-measures.csv file and returns a character vector
# with the name of the hospital that has the best (i.e. lowest) 30-day mortality for the specified outcome
# in that state.
#outcomes can be one of heart attack, heart failure, or pneumonia


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
  
  
  i <- 1
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


best("WA","XX")
best("XX","heart attack")

best("TX","heart attack")
best("TX","heart failure")
best("MD","heart attack")
best("MD","pneumonia")


###  PART 3  ###


rankhospital <- function(state, outcome, num = "best") {
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


rankhospital("MD", "heart attack", "best")
rankhospital("MD", "heart attack", "worst")
rankhospital("MD", "heart attack", 4)
rankhospital("MD", "pneumonia", "best")
rankhospital("MD", "heart failure", "worst")
rankhospital("MD", "heart failure", 4)


rankhospital("TX", "heart failure", 4)
rankhospital("MD", "heart attack", "worst")
rankhospital("MN", "heart attack", 5000)



###  PART 4  ###

rankall <- function(outcome, num = "best") {
  ## Read outcome data
  setwd("C:/Users/Josh/Documents/R Projects/Coursera - Data Science Certificate/2 - R Programming/Programming Assignment 3")
  outcome_measures <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that state and outcome are valid
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
  
  
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  hospitals <- data.frame(hospital = NULL,state = NULL)

  for(i in 1:50){
    temp_state <- us_states[i,2]
    
    source("rankhospital.R")
    temp_rankhospital <- rankhospital(temp_state,outcome,num)
    
    temp_hospitals <- data.frame(hospital = temp_rankhospital, state = temp_state)   
    hospitals <- rbind(hospitals,temp_hospitals)
  }
  hostpitals
}