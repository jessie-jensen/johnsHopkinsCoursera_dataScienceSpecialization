setwd("C:/Users/Josh/Dropbox/R/Coursera - Data Science Certificate/5 - Reproducible Research/Peer Assessment 1")


library(dplyr)
library(knitr)

activity <- read.csv("activity.csv")

activity_nona <- activity %>% 
  filter(!is.na(steps))

# I. What is mean total number of steps taken per day?
# 1. Calculate the total number of steps taken per day

dailysteps <- activity_nona %>%
  group_by(date) %>%
  summarize(dailysteps=sum(steps))
dailysteps
  
# 2. Make a histogram of the total number of steps taken each day

hist(dailysteps$dailysteps)

# 3. Calculate and report the mean and median of the total number of steps taken per day

mean(dailysteps$dailysteps)
median(dailysteps$dailysteps)


# II. What is the average daily activity pattern?
# 1. Make a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis)

intervalsteps <- activity_nona %>%
  group_by(interval) %>%
  summarize(avgsteps=mean(steps))
intervalsteps

plot(intervalsteps$interval,intervalsteps$avgsteps, type = "l")

     
# 2. Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?

intervalsteps %>% filter(avgsteps==max(avgsteps))


# III. Imputing missing values
# 1. Calculate and report the total number of missing values in the dataset (i.e. the total number of rows with NAs)
activity %>% filter(is.na(steps)) %>% summarize(length(date))


# 2. Devise a strategy for filling in all of the missing values in the dataset. The strategy does not need to be sophisticated. For example, you could use the mean/median for that day, or the mean for that 5-minute interval, etc.

## Will use the mean of the 5-minute intervals


# 3. Create a new dataset that is equal to the original dataset but with the missing data filled in.
activity_imputed <- activity %>% left_join(intervalsteps, by = "interval")

activity_imputed$steps <- ifelse(is.na(activity_imputed$steps),activity_imputed$avgsteps,activity_imputed$steps)
activity_imputed$avgsteps <- NULL

activity_imputed

# 4. Make a histogram of the total number of steps taken each day and Calculate and report the mean and median total number of steps taken per day. Do these values differ from the estimates from the first part of the assignment? What is the impact of imputing missing data on the estimates of the total daily number of steps?

hist(activity_imputed$steps)
## Values differ substantially. The histogram is now skewed toward the low end values that were imputed.


# IV. Are there differences in activity patterns between weekdays and weekends?
# 1. Create a new factor variable in the dataset with two levels - "weekday" and "weekend" indicating whether a given date is a weekday or weekend day.

activity_imputed$weekday <- weekdays(as.Date(activity_imputed$date))

activity_imputed$daytype <- ifelse(grepl("(Saturday|Sunday)",activity_imputed$weekday),"weekend","weekday")
# test
# table(activity_inputed$daytype,activity_inputed$weekday)
 

# 2. Make a panel plot containing a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all weekday days or weekend days (y-axis). See the README file in the GitHub repository to see an example of what this plot should look like using simulated data.

intervalsteps_imputed <- activity_imputed %>%
  group_by(interval,daytype) %>%
  summarize(avgsteps=mean(steps))

colors <- c("blue","red")

plot(intervalsteps_imputed$interval,intervalsteps_imputed$avgsteps, type="n")
temp <- filter(intervalsteps_imputed, daytype=="weekend")
lines(temp$interval,temp$avgsteps, type="l", col=colors[1])
temp <- filter(intervalsteps_imputed, daytype=="weekday")
lines(temp$interval,temp$avgsteps, type="l", col=colors[2])
legend("topleft", c("weekend","weekday"), lty = 1, col=colors)

