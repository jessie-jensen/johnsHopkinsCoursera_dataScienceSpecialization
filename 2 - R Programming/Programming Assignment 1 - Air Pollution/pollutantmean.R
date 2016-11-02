specdata <- setwd("C:/Users/Josh/Documents/R Projects/Coursera - Data Science Certificate/2 - R Programming/Programming Assignment 1 - Air Pollution/specdata")

specdata
list.files(specdata)


##### PART 1 #####

pollutantmean <- function(directory, pollutant, id = 1:332){
  #set working directory
  directory
  
  #read and aggregate files into a data frame
  pollutant_data <- NULL
  filenames <- paste(formatC(id,width = 3,flag = "0",),".csv",sep = "")
  filecount <- length(filenames)
  
  i <- 1
  while(i <= filecount){
    data_temp <- read.csv(filenames[i])
    pollutant_data <- rbind(pollutant_data,data_temp)
    i <- i+1
  }
  
  
  #calculate mean of specified pollutant
  if(pollutant == "nitrate"){
    mean(pollutant_data$nitrate, na.rm = TRUE)
  }
  else if(pollutant == "sulfate"){
    mean(pollutant_data$sulfate, na.rm = TRUE)  
  }
  else {print("Error in pollutant name")}
}