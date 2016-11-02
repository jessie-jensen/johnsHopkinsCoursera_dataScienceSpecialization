setwd("C:/Users/Josh/Dropbox/Coursera - Data Science Certificate/3 - Getting and Cleaning Data/Lectures")

###########
# Editing Text Data

# ex1 - removing periods
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/cameras_text.csv")
cameraData <- read.csv("./data/cameras_text.csv")
names(cameraData)


tolower(names(cameraData))

splitNames <- strsplit(names(cameraData),"\\.")
splitNames[[6]]
splitNames

firstElement <- function(x){x[1]}
sapply(splitNames,firstElement)

# ex2 - sub in text
fileUrl1 <- "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 <- "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1,destfile="./data/reviews2.csv")
download.file(fileUrl2,destfile="./data/solutions2.csv")
reviews <- read.csv("./data/reviews2.csv"); solutions <- read.csv("./data/solutions2.csv")
head(reviews,2)
head(solutions,2)

# removing underscores
names(reviews)
sub("_","",names(reviews))

testName <- "this_is_a_test"
sub("_","",testName)
gsub("_","",testName)


# ex3 - searching in text strings
grep("Alameda",cameraData$intersection) # returns row numbers
grep("Alameda",cameraData$intersection, value = TRUE) # returns values

table(grepl("Alameda",cameraData$intersection))

cameraData2 <- cameraData[!grepl("Alameda",cameraData$intersection),] # removing obs with "Alameda"

grep("JeffStreet",cameraData$intersection)
length(grep("JeffStreet",cameraData$intersection))


# stringr
library(stringr)
nchar("Jeffrey Leek")
substr("Jeffrey Leek",1,7)
paste("Jeffrey","Leek")
paste0("Jeffrey","Leek")
str_trim("Jeff         ")


### Working with dates
d1 = date()
d1
class(d1)

d2 = Sys.Date()
d2
class(d2)

###
# %d = day as number (0-31)

# %a = abbreviated weekday
# %A = unabbreviated weekday

# %m = month (00-12)

# %b = abbreviated month
# %B = unabbrevidated month

# %y = 2 digit year
# %Y = four digit year
###
format(d2,"%a %b %d")

x = c("1jan1960", "2jan1960", "31mar1960", "30jul1960"); z = as.Date(x, "%d%b%Y")
z
z[1]-z[2]
as.numeric(z[1]-z[2])

weekdays(d2)
months(d2)
julian(d2)

# lubridate

library(lubridate)

ymd("20140108")
mdy("08/04/2013")
dmy("08/04/2013")

ymd_hms("2011-08-03 10:15:03")
ymd_hms("2011-08-03 10:15:03",tz="Pacific/Auckland")   

Sys.timezone()

x = dmy(c("1jan2013", "2jan2013", "31mar2013", "30jul2013"))
wday(x[1])
wday(x[1],label=TRUE)
