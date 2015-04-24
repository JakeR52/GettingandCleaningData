## need some libraries

## load data.table library
library(data.table)
## load dplyr library
library(dplyr)

##Check to see if the data exists, if it doesn;t then download it and unzip the files intot the working directory
datadir<-"UCI HAR DAtaset"
if (!file.exists(datadir)){
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","UCI_HAR_Dataset.zip")
        unzip("UCI_HAR_Dataset.zip")
}else {
        setwd("UCI HAR Dataset")
}



##"read the 'test' data from the 'test' subdirectory into a data frame"
dftest<-read.table("test/x_test.txt")

## read the 'train dataset from the 'train' subdirectory into a data frame
dftrain<-read.table("train/x_train.txt")
## combine the 2 datasets in a single data frame
dftotal<- bind_rows(dftest,dftrain)


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

sub_test<-read.table("test/subject_test.txt")
## create data frame with the subjects from the 'train' folder 

sub_train<-read.table("train/subject_train.txt")
sub_testdt<-data.table(sub_test)
sub_traindt<-data.table(sub_train)
## combine the 'test' and 'train' subjects into a single DT
sub_total<-bind_rows(sub_testdt,sub_traindt)
setnames(sub_total,"V1","Subjects")


## create data frame with the exercises from the 'train' folder 

sub_exe_train<-read.table("train/y_train.txt")
sub_exe_traindt<-data.table(sub_exe_train)
## create data frame with the exericises from the 'test' folder 

sub_exe_test<-read.table("test/y_test.txt")
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


##Create data frame with current column names to be changed into descriptive names
namesFT<- names(FT_sorted)

write.csv(namesFT, "namesFT.csv", row.names=FALSE)

## descriptive names were created and saved back into a CSV file using notepad++ and save as "namesFTfinal.csv"



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




