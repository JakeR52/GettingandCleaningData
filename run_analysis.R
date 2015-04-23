## load data.table library
library(data.table)
## load dplyr library
library(dplyr)

## get into the proper folder for the data
setwd("C:/Users/Jake/Documents/UCI HAR Dataset")
##enter the 'test' folder
setwd("test")
##"read the 'test' data into a data frame"
dftest<-read.table("x_test.txt")
## move bakc up to the top directory for the data set
setwd("C:/Users/Jake/Documents/UCI HAR Dataset")
## enter the 'train' directory
setwd("train")
## read the 'train dataset into a data frame
dftrain<-read.table("x_train.txt")
## combine the 2 datasets in a single data frame
dftotal<- bind_rows(dftest,dftrain)
##move back up to the main dataset directory
setwd("C:/Users/Jake/Documents/UCI HAR Dataset")
## read the features into a data frame
features<- read.table("features.txt")
## use the features data frame to rename the columns of the combined data frame of 'train' and 'test' data
colnames(dftotal)<-features[,2]

dftbl<-tbl_df(dftotal)
## create data table with means and std columns
dftbl2<-data.table(dftbl)
dftblreduced<-select(dftbl2,contains("mean()"), contains("std()"))
## convert reduced to a data.table
dftblfinal<-data.table(dftblreduced)

## create data frame with the subjects from the 'test' folder 
setwd("test")
sub_test<-read.table("subject_test.txt")
## create data frame with the subjects from the 'train' folder 
setwd("C:/Users/Jake/Documents/UCI HAR Dataset")
setwd("train")
sub_train<-read.table("subject_train.txt")
sub_testdt<-data.table(sub_test)
sub_traindt<-data.table(sub_train)
## combine the 'test' and 'train' subjects into a single DT
sub_total<-bind_rows(sub_testdt,sub_traindt)
setnames(sub_total,"V1","Subjects")


## create data frame with the exercises from the 'train' folder 
setwd("C:/Users/Jake/Documents/UCI HAR Dataset")
setwd("train")
sub_exe_train<-read.table("y_train.txt")
sub_exe_traindt<-data.table(sub_exe_train)
## create data frame with the exericises from the 'test' folder 
setwd("C:/Users/Jake/Documents/UCI HAR Dataset")
setwd("test")
sub_exe_test<-read.table("y_test.txt")
sub_exe_testdt<-data.table(sub_exe_test)

sub_exe_total<-bind_rows(sub_exe_testdt,sub_exe_traindt)
setnames(sub_exe_total,"V1","Exercises")
# convert exercise numbers to activity descriptions
sub_exe_total$Exercises[sub_exe_total$Exercises == '1']<- "Walking"
sub_exe_total$Exercises[sub_exe_total$Exercises == '2']<- "Walking Upstairs"
sub_exe_total$Exercises[sub_exe_total$Exercises == '3']<- "Walking Downstairs"
sub_exe_total$Exercises[sub_exe_total$Exercises == '4']<- "Sitting"
sub_exe_total$Exercises[sub_exe_total$Exercises == '5']<- "Standing"
sub_exe_total$Exercises[sub_exe_total$Exercises == '6']<- "Laying"




# insert the subjects DT and exercises DT as columns at the start of the project DT
finaltable<-bind_cols(sub_total,sub_exe_total,dftblfinal)
finaltable<-data.table(finaltable)

##sort by subject and then exercise

FT_sorted<-finaltable[order(finaltable$Subjects,finaltable$Exercises),]

## rename columns with descriptive names

## read in CSV with new descriptive names
newnames2<- read.csv("namesFTfinal.csv")$x
newnames2<-as.character(newnames2)

## create character vector of old names

oldnames3<-names(FT_sorted)
setnames(FT_sorted,old = oldnames3, new = newnames2)

##Names of columns should be changed at this point

## create tidy data for step 5 in Project instructions
##("From the data set in step 4, creates a second, independent 
##tidy data set with the average of each variable for each activity and each subject.")

## averages by Exercise for Each individual

alt_summary_final<-group_by(FT_sorted,Subjects,Exercises)%>%summarise_each(funs(mean))

alt_summary_final




