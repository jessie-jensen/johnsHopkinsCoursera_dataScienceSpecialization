setwd("C:/Users/Josh/Dropbox/Coursera - Data Science Certificate/3 - Getting and Cleaning Data/Project/Evaluations")

#1 
fileurl1 <- "https://s3.amazonaws.com/coursera-uploads/user-ee3b1304d9255484afc6749a/973498/asst-3/21955970b37c11e49c735b880a47722d.txt"

download.file(fileurl1, destfile = "./1.txt")

tidy1 <- read.table("1.txt",header = TRUE)

#2 
fileurl2 <- "https://s3.amazonaws.com/coursera-uploads/user-80b131b81e415d88af7e18b6/973498/asst-3/520a98c0b1e911e499aaa302279744ce.txt"

download.file(fileurl2, destfile = "./2.txt")

tidy2 <- read.table("2.txt",header = TRUE)

#3 
fileurl3 <- "https://s3.amazonaws.com/coursera-uploads/user-31822f5985a6c25b1e3dd573/973498/asst-3/313d05a0aed411e4ab03dbc777650410.txt"

download.file(fileurl3, destfile = "./3.txt")

tidy3 <- read.table("3.txt",header = TRUE)