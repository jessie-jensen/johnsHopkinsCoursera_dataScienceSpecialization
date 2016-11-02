setwd("C:/Users/Josh/Documents/R Projects/Coursera - Data Science Certificate/3 - Getting and Cleaning Data")

library(reshape2)

#############
# Objectives of script
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each ACTIVITY and each SUBJECT.
#############

###
# 1. -> Reading and merging data into a master data set
###

#list.files(path.expand("./UCI HAR Dataset/test"), all.files = TRUE, recursive = TRUE, full.names = TRUE)

## Read in label files as data frames

activities <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("id","Activity"))
features <- read.table("./UCI HAR Dataset/features.txt")
  # activities <- fread("./UCI HAR Dataset/activity_labels.txt")
  # features <- fread("./UCI HAR Dataset/features.txt")


## Read in "Test" data. Create "test_data" data frame.

X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
colnames(X_test) <- features$V2

y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "activity_id")

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")

test_data <- cbind(subject_test,y_test,X_test)


## Read in "Train" data. Create "train_data" data frame.

X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
colnames(X_train) <- features$V2

y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "activity_id")

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "Subject")

train_data <- cbind(subject_train,y_train,X_train)


## Bind/merge train and test data sets into master set

master_data <- rbind(train_data,test_data)



###
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
###

variables <- colnames(master_data)

subset_variables <- subset(variables, grepl("((mean|std)..(.X|.Y|.Z)?|Subject|activity_id)$",variables))

temp_data <- subset(master_data,select = subset_variables)
# head(temp_data)
# colnames(temp_data)



###
# 3. Uses descriptive activity names to name the activities in the data set
###

temp_data <- merge(activities,temp_data,by.y = "activity_id",by.x = "id",all.y = TRUE)
clean_data <- subset(temp_data, select = -c(id))

###
# 4. Appropriately labels the data set with descriptive variable names. 
###
# Done during processing.



###
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each ACTIVITY and each SUBJECT.
###

# melt data
melt_data <- melt(clean_data, id.vars = c("Activity","Subject"))

# create tidy data set of means by "Activity" and "Subject"
tidy_data <- dcast(melt_data, Activity + Subject ~ variable,mean)

# write tidy data as a txt
write.table(tidy_data,file = "tidy_data.txt", row.names = FALSE, col.names = TRUE)
