# GettingandCleaningData
---
This is the readme file for my class project for the getting and cleaning data class offered by Coursera.

The code to complete the requried analysis for this project can be seen in the run_analysis.R file in my GettingandCleaningData repository(https://github.com/JakeR52/GettingandCleaningData)

For the code to run properly, the project data set must be downloaded and extracted to your working directory.  The data set can be found onlione here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The requirements for this project can be seen below:

    You should create one R script called run_analysis.R that does the following. 

    Merges the training and the test sets to create one data set.
    Extracts only the measurements on the mean and standard deviation for each measurement. 
    Uses descriptive activity names to name the activities in the data set
    Appropriately labels the data set with descriptive variable names. 

    From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each      activity and each subject.
    
A basic description and explanations of steps for the code are as follows"

load the required libraries(data.table and dplyr)

change your cwd to the UCI HAR Dataset folder

enter the 'test' folder

read the 'test' data into a data frame

move back up to the UCI HAR Dataset folder

enter the 'train' directory

read the 'train' dataset into a data frame

combine the 2 datasets in a single data frame

move back up to the UCI HAR Dataset folder

read the features.txt into a data frame

use the features data frame to rename the columns of the combined data frame of 'train' and 'test' data

create data table with columns that contain either mean() or sdt()

convert reduced this to a data.table

create data frame with the subject_test.txt from the 'test' folder 

create data frame with the subject_train.txt from the 'train' folder 

convert these 2 data frames to data.tables and combine into a single data.table

create data frame with the exercises from the 'train' folder using y_train.txt 

convert this data frame to a data.table

create data frame with the exercises from the 'test' folder using y_test.txt

convert this data frame to a data.table

chagne the exercise names to actual exercises from the numerical symbols currently in the data table(1 -> Walking, etc)

insert the subjects DT and exercises DT as columns at the start of the project DT

sort by subject and then exercise

Create data frame with current column names to be changed into descriptive names

rename columns with descriptive names

read in CSV with new descriptive names

create character vector of old names

Names of columns should be changed at this point

create tidy data for step 5 in Project instructions
("From the data set in step 4, creates a second, independent 
tidy data set with the average of each variable for each activity and each subject.")

averages by Exercise for Each individual

the final output of the tidy data set for step 5 is named alt_summary_final and written to a txt file with write.table() using row.name = FALSE.
final data set can be seen here:https://s3.amazonaws.com/coursera-uploads/user-f552016487ea50dfd347886a/973500/asst-3/64fbcd70ea0411e4ad21530945cf8ea4.txt






