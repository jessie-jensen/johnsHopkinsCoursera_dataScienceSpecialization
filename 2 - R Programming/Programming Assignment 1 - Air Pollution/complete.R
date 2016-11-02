specdata <- setwd("C:/Users/Josh/Documents/R Projects/Coursera - Data Science Certificate/2 - R Programming/Programming Assignment 1 - Air Pollution/specdata")

specdata
list.files(specdata)


##### PART 2 #####


complete <- function(directory, id = 1:332) {
  #set working directory
  directory
  
  
  #read and aggregate files into a new data frame
  completecases <- NULL
  filenames <- paste(formatC(id,width = 3,flag = "0",),".csv",sep = "")
  filecount <- length(filenames)
  
  i <- 1
  while(i <= filecount){
    data_temp <- read.csv(filenames[i])
    
    data_temp_obs <- complete.cases(data_temp)
    obs_count <- nrow(data_temp[data_temp_obs,])
    
    completecases_temp <- data.frame("id" = id[i], "nobs" = obs_count)
    completecases <- rbind(completecases,completecases_temp)
    i <- i+1
  }
  completecases
}