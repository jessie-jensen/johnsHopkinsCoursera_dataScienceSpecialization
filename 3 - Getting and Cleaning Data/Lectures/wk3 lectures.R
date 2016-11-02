setwd("C:/Users/Josh/Dropbox/Coursera - Data Science Certificate/3 - Getting and Cleaning Data/Lectures")

###########
# Merging Data

# ex 1
if(!file.exists("./data")){dir.create("./data")}
fileUrl1 = "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 = "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1,destfile="./data/reviews.csv")
download.file(fileUrl2,destfile="./data/solutions.csv")
reviews = read.csv("./data/reviews.csv"); solutions <- read.csv("./data/solutions.csv")
head(reviews,2)


merged_data <- merge(reviews,solutions,by.x="solution_id",by.y="id",all=TRUE)


# ex 2
library("plyr")

df1 = data.frame(id=sample(1:10),x=rnorm(10))
df2 = data.frame(id=sample(1:10),y=rnorm(10))
df3 = data.frame(id=sample(1:10),z=rnorm(10))
dfList = list(df1,df2,df3)

df_master <- join_all(dfList)
df_master


#########
# Reshaping

# ex 1
library(reshape2)


mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars,id=c("carname","gear","cyl"),measure.vars=c("mpg","hp"))

cylData <- dcast(carMelt, cyl ~ variable, mean)
cylData

cylgearData <- dcast(carMelt, cyl + gear ~ variable, mean)
cylgearData

dcast(carMelt, cyl ~ gear + variable,mean)

# ex 2
tapply(mtcars$mpg,mtcars$cyl,mean)

# ex 3

splt <- split(mtcars$mpg, mtcars$cyl)
cylmean <- sapply(splt,mean)
cylmean

# ex 4
library(plyr)

ddply(mtcars,.(cyl),summarize,mpg=mean(mpg),hp=mean(hp))



##############################
# Creating new variables

setwd("C:/Users/jjensen/Dropbox/Coursera - Data Science Certificate/3 - Getting and Cleaning Data/Lectures")

fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/restaurants.csv")
restData <- read.csv("./data/restaurants.csv")

# sequencing
s1 <- seq(1,10,by=2) ; s1
s2 <- seq(1,10,length=3); s2
x <- c(1,3,8,25,100); seq(along = x)

# subsetting
restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)

