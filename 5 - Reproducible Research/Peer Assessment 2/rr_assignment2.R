setwd("C:/Users/jjensen/Dropbox/R/Coursera - Data Science Certificate/5 - Reproducible Research/Peer Assessment 2")

# ##############################
# Storm Data Analysis
# Author: Josh Jensen
# 
# 
# Coursera / Johns Hopkins
# Reproducible Research
# Peer Assignment 2
# 
# The events in the database start in the year 1950 and end in November 2011. In the earlier years of the database there are generally fewer events recorded, most likely due to a lack of good records. More recent years should be considered more complete.
# ##############################

# TITLE

# synopsis which describes and summarizes your analysis in at most 10 complete sentences

# Data Processing

library(readr)
library(dplyr)


storm <- read_csv("repdata-data-StormData.csv.bz2")


# Exploration
colnames(storm)

table(storm$TIME_ZONE)
table(storm$COUNTY)
table(storm$STATE)

table(storm$EVTYPE)


# Classify/clean evtype

storm$EVTYPE <- tolower(storm$EVTYPE)
evtype <- storm %>% 
  select(EVTYPE) %>%
  group_by(EVTYPE) %>%
  count(events=EVTYPE) %>%
  arrange(desc(n))


stormtypes <- c("thunderstorm|tstm","tornado","hail", "tide","avalanche|slide","blizzard","flash flood","flood|fld","wind chill","fog","smoke","drought","dust devil","dust storm","heat|warm","freeze|frost","funnel cloud","heavy rain","snow","surf","wind","hurricane|typhoon","ice","lightning","rip current","seiche","sleet","tropical","tsunami","volcanic","waterspout","wildfire","cold","winter","dry","rain|precipitation")

evtype$stormtype <- NA

for(i in 1:length(stormtypes)){
  temp <- paste0("*",stormtypes[i],"*")
  
  evtype$temp_grep <- grepl(temp,evtype$events)
  evtype$stormtype <- ifelse(is.na(evtype$stormtype)&evtype$temp_grep==TRUE,
                             stormtypes[i],
                             evtype$stormtype)
}
evtype$temp_grep <- NULL
evtype$stormtype <- ifelse(is.na(evtype$stormtype),"other",evtype$stormtype)
                           
evtype$stormtype <- gsub("\\|.*","",evtype$stormtype)

storm <- left_join(storm, evtype , by = c("EVTYPE"="events"))



# Results



# 1. Across the United States, which types of events (as indicated in the EVTYPE variable) are most harmful with respect to population health?

# storm$FATALITIES
# storm$INJURIES

# to look at:
#   most fatalities & injuries (casulties)
#     overall
#     per event
# 
#      
# panel of top x


storm_deaths <- storm %>% 
  group_by(stormtype) %>%
  summarise(deaths = sum(FATALITIES), deathsperstorm = mean(FATALITIES))


# absolute
storm_deaths %>% filter(deaths>0) %>% arrange(desc(deaths))

# per storm
storm_deaths %>% filter(deaths>0) %>% arrange(desc(deathsperstorm))




# 2. Across the United States, which types of events have the greatest economic consequences?

# storm$PROPDMG
# storm$PROPDMGEXP
table(storm$PROPDMGEXP)
storm$PROPDMGEXP <- ifelse(storm$PROPDMGEXP=="m","M",
                           ifelse(storm$PROPDMGEXP=="K","K",
                                  ifelse(storm$PROPDMGEXP=="M","M","0")))

storm$propdmg_clean <- ifelse(storm$PROPDMGEXP=="M",storm$PROPDMG*1000000,
                              ifelse(storm$PROPDMGEXP=="K",storm$PROPDMG*1000,
                                     ifelse(storm$PROPDMGEXP=="0",storm$PROPDMG,NA)))


storm_damages <- storm %>% 
  group_by(stormtype) %>%
  summarise(damages = sum(propdmg_clean), damagesperstorm = mean(propdmg_clean))


# absolute
storm_damages %>% filter(damages>0) %>% arrange(desc(damages))

# per storm
storm_damages %>% filter(damages>0) %>% arrange(desc(damagesperstorm))