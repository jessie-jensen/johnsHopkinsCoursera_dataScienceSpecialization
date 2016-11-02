setwd("C:/Users/Josh/Dropbox/Coursera - Data Science Certificate/3 - Getting and Cleaning Data/Quiz 3")

# q1

housing <- read.csv("data.csv")

# AGS = 6 ; ACR = 3

agricultureLogical <- housing$ACR==3 & housing$AGS==6

which(agricultureLogical)


## q2

library(jpeg)

imageurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"

jeff_image <- readJPEG("getdata-jeff.jpg",native = TRUE)
jeff_image
quantile(jeff_image, probs = seq(0,1,.1))


## q3

gdp_data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
ed_data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

gdp_data <- read.csv("GDP.csv",header = FALSE,skip = 5,col.names = c("CountryCode","Rank","blank","Country","GDP"))
ed_data <- read.csv(ed_data_url)

# match_data <- match(gdp_data$CountryCode,ed_data$CountryCode)
# match_data <- subset(match_data, !is.na(match_data))
# match_data
# count(match_data)
# match_data[13]

gdp_data <- gdp_data[(gdp_data$Rank!=""),]
gdp_data <- gdp_data[(gdp_data$CountryCode!=""),]
gdp_data <- subset(gdp_data,select = -blank)
gdp_data$Rank <- as.numeric(as.character(gdp_data$Rank))


country_data <- merge(gdp_data,ed_data,by = "CountryCode",all = FALSE)

country_data <- country_data[order(country_data$Rank,decreasing = TRUE),]

nrow(country_data)
country_data[13,1:4]

## q4 

tapply(country_data$Rank,country_data$Income.Group,mean)

## q5

breakpoints <- seq(1,190,190/5)
breakpoints

country_data[(country_data$Rank <= 38 & country_data$Income.Group =="Lower middle income"),1:6]

