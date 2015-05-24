===============================================================================
##Code Book
===============================================================================

This Code Book is for the data set saved in Samsung_Accel_TidyData.txt. This is a tidy data set that has been derived from the raw data set 
Human Activity Recognition Using Smartphones Dataset Version 1.0.



###Variables
* subject_id: Integer variables that identifies the subject of the test data. there are 30 subjects.
* activity_desc: Factor variable that identifies which activity was conducted. There are 6 levels: WALKING
, WALKING_UPSTAIRS
, WALKING_DOWNSTAIRS
, SITTING, STANDING
, and LAYING
.
* feature: Factor variable which contains the signals variables from the tests, filtered to just the mean and standard deviation tests.
* m: Numeric variable that with the mean calculated on observations of each subject_id, activity_desc, and feature combination.
* sd: Numeric variable that with the standard deviation calculated on observations of each subject_id, activity_desc, and feature combination.



###Study Design

* Download the raw data zip file into a temp file.
* Unzip raw data files and load activity_labels.txt, features.txt, subject_train.txt, X_train.txt, y_train.txt, subject_test.txt, X_test.txt, and y_test.txt.
* Load each text file into a data frame.
* Unlink the temp file after data has been extracted.
* Merge 3 training and 3 test data sets into 3 data sets, binding on the rows.
* Add column names to 3 merged data frames.
* Combine the 3 merge variables into 1 data frame.
* Merge activity_labels to the activity numbers in merge.y. This is to give the activities descriptive names.
* Gather the column names that are variables into a single column.
* Rename the "V2" column fo the raw.activity_labels to "activity_desc".
* Drop the "activity_id" column.
* Filter to include only records with "mean" or "std" in the feature.
* Group by the "subject_id", "activity_desc", and "feature" columns.
* Summarise on the grouped columns and calculate mean and standard deviation.
* Write the tidy set to a text file.

