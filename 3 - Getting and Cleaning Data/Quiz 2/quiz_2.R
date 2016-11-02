setwd("C:/Users/jjensen/Documents/Coursera - Data Science Certificate/3 - Getting and Cleaning Data/Quiz 2")

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"

download.file(fileurl,"data.for")

q5_data <- read.fwf(file="data.for",skip=4,widths=c(12, 7,4, 9,4, 9,4, 9,4))
q5_data

sum(q5_data[,4]) 


q5_data[,9]

