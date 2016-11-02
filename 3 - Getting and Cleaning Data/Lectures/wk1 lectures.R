setwd("C:/Users/jjensen/Documents/Coursera - Data Science Certificate/3 - Getting and Cleaning Data/Lectures")
library(RCurl)


fileURL <- "http://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"

# OPTION 1
x <- getURL(fileURL, ssl.verifypeer = FALSE)

opt_1 <- read.csv(textConnection(x))

# OPTION 2
opt_2 <- read.csv(file = fileURL)

# OPTION 3
download.file(fileURL, destfile = "./data/cameras.csv")

list.files("./data")
opt_3 <- read.csv(file ="./data/cameras.csv")



############
# Excel File

xlsx_fileurl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"

#download.file(xlsx_fileurl, destfile = "./data/cameras_excel.xlsx")

library(xlsx)

cameraData <- read.xlsx("./data/cameras_excel.xlsx",sheetIndex = 1,header = TRUE)
head(cameraData)

colIndex <- 2:3
rowIndex <- 1:4
cameraDataSubset <- read.xlsx("./data/cameras_excel.xlsx",sheetIndex = 1,header = TRUE,colIndex = colIndex, rowIndex = rowIndex)

# XLConnect is more flexible and comprehensive in reading subsets


################
# XML

# ex. 1
library(XML)

xml_url <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(xml_url,useInternalNodes = TRUE)

rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)

rootNode[[1]]
rootNode[[1]][[1]]

xmlSApply(rootNode,xmlValue)

xpathSApply(rootNode,"//name",xmlValue)
xpathSApply(rootNode,"//price",xmlValue)

# ex. 2

xml_url_ravens <-"http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"

doc2 <- htmlTreeParse(xml_url_ravens,useInternal = TRUE)

scores <- xpathSApply(doc2,"//li[@class='score']",xmlValue)
scores


##########
# JSON

library(jsonlite)

jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")

names(jsonData)

# data frame within a data frame
names(jsonData$owner)

jsonData$owner$login

myjson <- toJSON(iris, pretty = TRUE)
cat(myjson)

iris2 <- fromJSON(myjson)
head(iris2)

nchar("  			<ul class=sidemenu>")
45
31
7
26

#########
# data.tables

library(data.table)

DT <- data.table(x=rnorm(9),y=rep(c("a","b","c"), each=3),z=rnorm(9))

DT

DT[,list(mean(x),sum(z))]
DT[,table(y)]

# calculated columns
DT[,w:=z^2]
DT

# plyr like calculated columns
DT[,a:=x>0]
DT

DT[,b:=mean(x+w), by=a]
DT

DT[,c:=mean(x+w), by=y]
DT

set.seed(123);
DT2 <- data.table(x=sample(letters[1:3],1E5,TRUE),y=rnorm(1E5))
DT2
  
DT2[,.N,by=x]

setkey(DT2,x)
DT2['a']
