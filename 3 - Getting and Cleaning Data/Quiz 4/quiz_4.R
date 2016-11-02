setwd("C:/Users/Josh/Dropbox/Coursera - Data Science Certificate/3 - Getting and Cleaning Data/Quiz 4")


#1
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileurl,"survey_data.csv")
survey_data <- read.csv("survey_data.csv")



WGTPsplit <- strsplit(names(survey_data),"wgtp")
WGTPsplit[123]


#2
fileurl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileurl2,"gdp_data.csv")
gdp_data <- read.csv("gdp_data.csv",skip = 5,header = FALSE,col.names = c("countrycode","rank","BLANK","country","gdp",2,2,3,4,5), nrows = 190)


gdp_data$gdp <- gsub(",","",gdp_data$gdp)
mean(as.numeric(gdp_data$gdp))

#3
grep("^United",gdp_data$country)

#4
fileurl3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileurl3,"ed_data.csv")
ed_data <- read.csv("ed_data.csv")

country_data <- merge(gdp_data,ed_data,by.x = "countrycode",by.y = "CountryCode")

names(country_data)
grep("June",country_data)
head(country_data)

grep("June", country_data$Special.Notes, value = TRUE)
grep("Fiscal year end: June", country_data$Special.Notes, value = TRUE)

#5
library(quantmod)

amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes <- index(amzn)

sampleTimes

table(year(sampleTimes))
table(year(sampleTimes),weekdays(sampleTimes))