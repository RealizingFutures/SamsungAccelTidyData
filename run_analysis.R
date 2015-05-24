## This script takes a set of raw data and transforms it into a tidy data set

## Load packages
library(dplyr)
library(tidyr)

## Download the raw data zip file into a temp file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp)

## Unzip raw data files and load them into variables
raw.activity_labels <- 
        read.table(unz(temp, "UCI HAR Dataset/activity_labels.txt"))
raw.features <- 
        read.table(unz(temp, "UCI HAR Dataset/features.txt"))
raw.subject_train <- 
        read.table(unz(temp, "UCI HAR Dataset/train/subject_train.txt"))
raw.X_train <- 
        read.table(unz(temp, "UCI HAR Dataset/train/X_train.txt"))
raw.y_train <- 
        read.table(unz(temp, "UCI HAR Dataset/train/y_train.txt"))
raw.subject_test <- 
        read.table(unz(temp, "UCI HAR Dataset/test/subject_test.txt"))
raw.X_test <- 
        read.table(unz(temp, "UCI HAR Dataset/test/X_test.txt"))
raw.y_test <- 
        read.table(unz(temp, "UCI HAR Dataset/test/y_test.txt"))

## Unlink the temp file after data has been extracted
unlink(temp)

## Merge training and test data sets into 3 data sets, binding on the rows
merge.subject <- rbind(raw.subject_train,raw.subject_test) 
merge.X <- rbind(raw.X_train,raw.X_test) 
merge.y <- rbind(raw.y_train,raw.y_test) 

## Add column names to merged variables
names(merge.X) <- raw.features[,2]
names(merge.y) <- "activity_id"
names(merge.subject) <- "subject_id"

## Combine the 3 merge variables into 1 data frame
merge.combined <- cbind(merge.subject,merge.y,merge.X)

## Merge activity_labels to the activity numbers in merge.y
## This is to give the activities descriptive names
merge.all <- suppressWarnings(merge(merge.combined, raw.activity_labels, 
                   by.x = "activity_id", by.y = "V1"))

## Gather the column names that are variables into a single column
## Rename the "V2" column fo the raw.activity_labels to "activity_desc"
## Drop the "activity_id" column
## Filter to include only records with "mean" or "std" in the feature
tidy.all <- merge.all %>% 
        gather(feature, measurement, -subject_id, -activity_id, -V2) %>% 
        rename(activity_desc = V2) %>% 
        select(-activity_id) %>% 
        filter(grepl("mean|std",feature,ignore.case=TRUE)) 

## Group by the "subject_id", "activity_desc", and "feature" columns
## Summarise on the grouped columns and calculate mean and standard deviation
tidy.summary <- tidy.all %>% group_by(subject_id, activity_desc, feature) %>%
        summarise(m = mean(measurement), sd = sd(measurement))
 
## Write the tidy set to a text file
write.table(tidy.summary, "Samsung_Accel_TidyData.txt", row.names = FALSE)


