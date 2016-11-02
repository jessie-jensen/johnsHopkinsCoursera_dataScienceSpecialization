setwd("C:/Users/jjensen/Documents/Coursera - Data Science Certificate/3 - Getting and Cleaning Data/Quiz 3")

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

download.file(fileURL,"data.csv")

library(data.table)

housing <- fread("data.csv")

agri