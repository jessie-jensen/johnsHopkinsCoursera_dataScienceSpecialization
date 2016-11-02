specdata <- setwd("C:/Users/Josh/Documents/R Projects/Coursera - Data Science Certificate/2 - R Programming/Programming Assignment 1 - Air Pollution/specdata")

specdata
list.files(specdata)


##### PART 3 #####

corr <- function(directory, threshold = 0) {
  #set working directory
  directory
  
  
  #read and aggregate files into a new data frame; also create and append correlation vector
  id <- 1:332
  
  corr_vector <- NULL

  filenames <- paste(formatC(id,width = 3,flag = "0",),".csv",sep = "")
  filecount <- length(filenames)
  
  i <- 1
  while(i <= filecount){
    data_temp <- read.csv(filenames[i])
    
    data_temp_obs <- complete.cases(data_temp)
    obs_count <- nrow(data_temp[data_temp_obs,])
    
    if(obs_count > threshold){
      corr_vector <- c(corr_vector, cor(data_temp$sulfate, data_temp$nitrate, use = "pairwise.complete.obs"))
    }
    
    i <- i+1
  }
 as.vector(corr_vector)
}