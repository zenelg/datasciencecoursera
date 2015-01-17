========================================
Getting and Cleaning Data Course Project
========================================

The goal is to prepare tidy data that can be used for later analysis based on the data provided 
as part of the Human Activity Recognition Using Smartphones Dataset Version 1.0.

Procedure:
==========

We created a R script called run_analysis.R that does the following:

    Merges the training and the test sets to create one data set.
    Extracts only the measurements on the mean and standard deviation for each measurement. 
    Uses descriptive activity names to name the activities in the data set
    Appropriately labels the data set with descriptive variable names. 
    From the data set in step 4, creates a second, independent tidy data set with the average of each 
	variable for each activity and each subject
	
See the CodeBook.md file for Variables references.
	
Subject per subject_train.txt and subject_test.txt
ActCode per activity_labels.txt and first column of X_test.txt and X_train.txt
From X_test.txt and X_train.txt selected variables with names containing 'mean' and 'std'
MeansAVG is a row average of 'mean' selected variables for each Subject and ActCode
StdAVG is a row average of 'std' selected variables for each Subject and ActCode

Script Logic:

1## Load features file and cleans for special characters
2## Read Train files and bind Activity to Train DataSet
3## Appropriately labels the data set with descriptive variable names for X-train.
4## Uses descriptive activity names to name the activities in the data set
5## Changes Act Codes into readable Activity Labels
6## Read test files and bind Activity to Test DataSet
7## Appropriately labels the data set with descriptive variable names for x-test
8## Uses descriptive activity names to name the activities in the data set
9## Changes Act Codes into readable Activity Labels
10# Merges the training and the test sets to create one data set.
11# Bind train and test df
12# Extracts only the measurements on the mean and standard deviation for each measurement
13# Add Columns for mean and std 
14# From the data set in step 13, creates a second, independent tidy 
14# (cont.) data set with the average of each variable for each activity and each subject
15# Smaller data set with the calculated average of all Mean and STD columns - 2 added colums
16# txt file created with write.table() using row.name=FALSE

Outcome objects:
	TidySet_All.df
	TidySet_small.df
	TidySet_All.txt

Primary objects created and later removed:
	x_tidy_a
	x_tidy_b
	X_full
	X_test
	X_train
	XbySubjandAct
	a
	b


R Script Requirements:
======================
Libraries : dplyr
Files (ALL FILES MUST BE STORED LOCALLY IN R DEAFULT LOCATION)
	features.txt
	activity_labels.txt
	y_test.txt
	X_test.txt
	y_train.txt
	X_train.txt
	subject_test.txt
	subject_train.txt

The dataset includes the following files:
=========================================
README.md
CodeBook.md
TidySet_All.df.txt
run_analysis.R 

Source / Summary
================
getdata_projectfiles_UCI HAR Dataset.zip
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The experiments in the Human Activity Recognition Using Smartphones Dataset were carried out with a group of 30 volunteers. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
wearing a smartphone. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity 
at a constant rate of 50Hz were captured. The obtained dataset was randomly partitioned into two sets, where 70% of 
the volunteers was selected for generating the training data and 30% the test data.
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Credits :
=========

Human Activity Recognition Using Smartphones Dataset Version 1.0

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
