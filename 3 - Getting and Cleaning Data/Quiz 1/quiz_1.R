setwd("C:/Users/jjensen/Documents/Coursera - Data Science Certificate/3 - Getting and Cleaning Data/Quiz 1")


fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileurl, destfile = "housing.csv")

list.files()

housing <- read.csv("housing.csv")
housing

table(housing$VAL[housing$VAL==24])

housing$FES



############


fileurl_2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileurl_2, destfile = "natural_gas.xlsx")

list.files()


# Read rows 18-23 and columns 7-15 into R and assign the result to a variable called:
library(xlsx)

dat <- read.xlsx("natural_gas.xlsx",sheetIndex = 1,colIndex = 7:15, rowIndex = 18:23)

sum(dat$Zip*dat$Ext,na.rm=T) 



# Read the XML data on Baltimore restaurants from here
library(XML)
library(RCurl)

fileurl_3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
fileurl_3_curl <- getURL(fileurl_3, ssl.verifypeer = FALSE)
doc <- xmlParse(fileurl_3_curl, useInternalNodes = TRUE)
rootNode <- xmlRoot(doc)

xmlName(rootNode[[1]])

names(rootNode[[1]])

doc
head(rootNode[[1]])

zip <- xpathSApply(rootNode[[1]],"//zipcode",xmlValue)

table(zip[zip=="21231"])


###### TEST ###########

# f <- "http://www.w3schools.com/xml/simple.xml"
# doc <- xmlParse(f, useInternalNodes = T)
# doc
# 
# rn <- xmlRoot(doc)
# 
# xmlName(rn)
# names(rn)
# 
# xpathSApply(rn,"//name",xmlValue)



######### 5 ##########

fileurl_5 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileurl_5, destfile = "commnunities.csv")

library(data.table)

DT <- fread("commnunities.csv")

a <- system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
b <- system.time(mean(DT$pwgtp15,by=DT$SEX))

# DT[,mean(pwgtp15),by=SEX]
# tapply(DT$pwgtp15,DT$SEX,mean)
)