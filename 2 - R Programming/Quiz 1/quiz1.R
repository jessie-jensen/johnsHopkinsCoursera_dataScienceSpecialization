x <- c(1,3, 5)
y <- c(3, 2, 10)

rbind(x, y)

x <- list(2, "a", "b", TRUE)
x
x[[3]]

x <- 1:4
y <- 2:3

x
y
x + y

x <- c(17, 14, 4, 5, 13, 12, 10)

x[x>=10] <- 4
x

setwd("C:/Users/Josh/Documents/R Projects/Coursera - Data Science Certificate/2 - R Programming/Quiz 1")
quiz1 <- read.csv("hw1_data.csv",header=TRUE)

quiz1

colnames(quiz1)

quiz1[[1:2]]
row(quiz1)

head(quiz1,2)
nrow(quiz1)
tail(quiz1,2)

quiz1[47,]
quiz1$Ozone[47]
summary(quiz1$Ozone)

quiz1$Ozone
BADozone <- is.na(quiz1$Ozone)
BADozone


mean(quiz1$Ozone[!BADozone])
mean(quiz1$Ozone)
mean(quiz1$Ozone[!is.na(quiz1$Ozone)])

?data.frame
summary(quiz1[quiz1$Ozone>31,quiz1$Temp>90,])
quiz1
BAD <- is.na(quiz1)
BAD
quiz1[!BAD]

quiz1.df <- data.frame(quiz1)
quiz1.df
quiz1.df_high <- subset(quiz1.df, quiz1.df$Ozone > 31 & quiz1.df$Temp > 90)
quiz1.df_high

quiz1.df[quiz1.df$Ozone > 31,]

mean(quiz1.df_high$Solar.R)

summary(quiz1.df[quiz1.df$Month == 5,])

quiz1.df_mo6 <- subset(quiz1.df, Month == 6)
quiz1.df_mo6

mean(quiz1.df_mo6$Temp)
