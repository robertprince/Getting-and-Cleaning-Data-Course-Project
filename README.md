# Getting-and-Cleaning-Data-Course-Project
Getting and Cleaning Data Course Project


This is the course project for the Getting and Cleaning Data Coursera course. The R script, run_analysis.R, does the following:

* Assumes that the dataset has been downloaded and exist in the "UCI HAR Dataset" subfolder of the working directory
* Load the feature and activity info
* Loads the test datasets ("subject_test.txt", "X_test.txt" and "y_test.txt") and column combines them
* Loads the training datasets ("subject_train.txt", "X_train.txt" and "y_train.txt") and column combines them
* Row combines the test and training datasets
* Converts the activity and subject columns into factors
* Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.

The end result is shown in the file tidy_data.txt.