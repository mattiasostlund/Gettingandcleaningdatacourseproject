# Gettingandcleaningdatacourseproject
Assignment: Getting and Cleaning Data Course Project
==================================================================
Assignment: Getting and Cleaning Data Course Project
Version 1.0
==================================================================
Made by: Mattias Östlund
Date: 2016-05-01
==================================================================

This assignment is about:
 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement.
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive variable names.
 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


Data used in this assignment is downloaded here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A more detailed description of the data i available here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


Files:
======================================

* Readme.md : This file describing overall about the assignment and files included. And describes the script in R
* run_analysis.R : The script in R that creates the tidy data file in step 5 above
* codebook.txt : Describes the variables in the tidy data set created in step 5 above and stored in file: group_of_subject_activity.txt
* group_of_subject_activity.txt: The tidy data set


Instructions to create tidy data in step 5 above:
======================================

1. Create a working directory folder
2. Download run_analysis.R to your working directory folder
3. Open up the script in e.g RStudio and set the path to your working directory
4. Download data files from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip to your folder 
5. Unzip the file 
6. Run the script


Alternative step 4 and step 5: In the script there is some code on row 20-23 that could be run that automatically download the files and unzip them
 
Description of R script
======================================

The script is divided in several parts

* SET UP
Here is the packages needed loaded and you set your working directory to be using

An extra code included that can download and unzip the original data is available

* Preparation of Activity and Features
Here will the script load in the activity label names that will be attached to the data set

Features will be loaded and filter out the mean and std variables that should be used in the tidy data set

* Reading and preparing Train/Test data set
Starts by loading subjects for train/test
The loads activities for train/test and add label names. to make it more descriptive
Then load the results for train/test and filter out variables in features for mean and std

Add subject + activities + results to same data frame, df_train/df_test.

remove data frames not needed

* Final: 
Join train and test data frames
Group by subject and activity
Calculate average for selected variables for mean and std

Clean up: remove data frames not needed

Store the result data set in the file, group_of_subject_activity.txt.

======================================
END OF README
======================================


