## Coursera getting and cleaning data course project

## Requirements for this script to work correctly:
## 1. That dataset directory should be unzipped in the working directory, 
##    maintaining the directory structure
## 2. Package "dplyr" should be installed

## Checking if data exists in the working directory. If not, the script downloads the data
if (!file.exists("UCI HAR Dataset")){
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl, "./getdata_projectfiles_UCI HAR Dataset.zip")
    unzip("getdata_projectfiles_UCI HAR Dataset.zip")
} 


## Checking if pacakge "dplyr" is installed. If not, then installing it
if (!"dplyr" %in% rownames(installed.packages())){
    install.packages("dplyr")
}

## Reading the text files constituting test data

sub_test <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt")
x_test <- read.table(".\\UCI HAR Dataset\\test\\X_test.txt")
y_test <- read.table(".\\UCI HAR Dataset\\test\\y_test.txt")

## Reading the variable names

features <- read.table(".\\UCI HAR Dataset\\features.txt")

## Adding descriptive column names to the test data

colnames(sub_test) <- "Volunteer_ID"
colnames(y_test) <- "Activity_ID"
colnames(x_test) <- make.names(features$V2, unique = TRUE)

## Creating the test data

test <- cbind(sub_test, y_test, x_test)

## Removing constituents to free up the memory

rm(list = c("sub_test", "x_test", "y_test"))

## Reading the text files constituting train data

sub_train <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt")
x_train <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt")
y_train <- read.table(".\\UCI HAR Dataset\\train\\y_train.txt")

## Adding descriptive column names to the train data

colnames(sub_train) <- "Volunteer_ID"
colnames(y_train) <- "Activity_ID"
colnames(x_train) <- make.names(features$V2, unique = TRUE)

## Creating the test data

train <- cbind(sub_train, y_train, x_train)

## Removing constituents to free up the memory

rm(list = c("sub_train", "x_train", "y_train", "features"))

## Creating full data by combining test and train data

data_full <- rbind(test, train)

## Removing individual data to free up the memory

rm(list = c("test", "train"))

## Loading 'dplyr' package

library(dplyr)

## Selecting only the columns having mean or standard deviation
## First step is to select all columns having word mean or std
## Secondly, removing columns having words "Freq" or "angle" as those are not required


data_req <- data_full %>%
            select(Volunteer_ID, Activity_ID, contains("mean"), contains("std")) %>%
            select(-contains("Freq"), -contains("angle"))

## Deleting older data which is not required to free up the memory

rm("data_full")

## Reading activity labels

act_label <- read.table(".\\UCI HAR Dataset\\activity_labels.txt")

## Replacing Activity ID with the descriptive name for each activity

data_req <- data_req %>%
            merge(act_label, by.x = "Activity_ID", by.y = "V1") %>%
            select(-Activity_ID) %>%
            rename(Activity = V2) %>%
            select(Volunteer_ID, Activity, everything())

## Removing Activity labels

rm("act_label")

## Adding more descriptive column names

colnames(data_req) <- c("Volunteer_ID", "Activity", "Mean_tBodyAcc_X", "Mean_tBodyAcc_Y", 
                        "Mean_tBodyAcc_Z", "Mean_tGravityAcc_X", "Mean_tGravityAcc_Y", "Mean_tGravityAcc_Z",
                        "Mean_tBodyAccJerk_X", "Mean_tBodyAccJerk_Y", "Mean_tBodyAccJerk_Z", 
                        "Mean_tBodyGyro_X", "Mean_tBodyGyro_Y", "Mean_tBodyGyro_Z", "Mean_tBodyGyroJerk_X",
                        "Mean_tBodyGyroJerk_Y", "Mean_tBodyGyroJerk_Z", "Mean_tBodyAccMag", 
                        "Mean_tGravityAccMag", "Mean_tBodyAccJerkMag", "Mean_tBodyGyroMag", 
                        "Mean_tBodyGyroJerkMag", "Mean_fBodyAcc_X", "Mean_fBodyAcc_Y", "Mean_fBodyAcc_Z", 	
                        "Mean_fBodyAccJerk_X", "Mean_fBodyAccJerk_Y", "Mean_fBodyAccJerk_Z", 
                        "Mean_fBodyGyro_X", "Mean_fBodyGyro_Y", "Mean_fBodyGyro_Z", "Mean_fBodyAccMag", 
                        "Mean_fBodyBodyAccJerkMag", "Mean_fBodyBodyGyroMag", "Mean_fBodyBodyGyroJerkMag", 	
                        "StdDev_tBodyAcc_X", "StdDev_tBodyAcc_Y", "StdDev_tBodyAcc_Z", 
                        "StdDev_tGravityAcc_X", "StdDev_tGravityAcc_Y", "StdDev_tGravityAcc_Z", 
                        "StdDev_tBodyAccJerk_X", "StdDev_tBodyAccJerk_Y", "StdDev_tBodyAccJerk_Z", 	
                        "StdDev_tBodyGyro_X", "StdDev_tBodyGyro_Y", "StdDev_tBodyGyro_Z", 
                        "StdDev_tBodyGyroJerk_X", "StdDev_tBodyGyroJerk_Y", "StdDev_tBodyGyroJerk_Z", 
                        "StdDev_tBodyAccMag", "StdDev_tGravityAccMag", "StdDev_tBodyAccJerkMag", 	
                        "StdDev_tBodyGyroMag", "StdDev_tBodyGyroJerkMag", "StdDev_fBodyAcc_X", 	
                        "StdDev_fBodyAcc_Y", "StdDev_fBodyAcc_Z", "StdDev_fBodyAccJerk_X", 	
                        "StdDev_fBodyAccJerk_Y", "StdDev_fBodyAccJerk_Z", "StdDev_fBodyGyro_X", 
                        "StdDev_fBodyGyro_Y", "StdDev_fBodyGyro_Z", "StdDev_fBodyAccMag", 
                        "StdDev_fBodyBodyAccJerkMag", "StdDev_fBodyBodyGyroMag", 
                        "StdDev_fBodyBodyGyroJerkMag")

## Grouping the data by volunteer ID and Activity type

data_req <- group_by(data_req, Volunteer_ID, Activity)
 
## Creating summarised data with mean of each variable for each volunteer and activity combination

data_summarised <- summarise_each(data_req, funs(mean))

## Printing the summarised data to console

View(data_summarised)

## Writing the summarised data to a text file in working directory

write.table(data_summarised, "summarised_data.txt", row.name=FALSE)
