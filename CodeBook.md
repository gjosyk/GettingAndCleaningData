---
title: "CodeBook"
output: html_document
---


Getting and Cleaning Data Course Project CodeBook

This file describes the variables, the data, and transformations performed to clean up the data.

The site that contains the data:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The actual data:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The run_analysis.R script contains the following variables:

trainXData <- training data read from /train/X_train.txt
trainYLabels <- training labels read from train/y_train.txt
trainSubjects <- training subjects read from /train/subject_train.txt
testXData <- test data read from /test/X_test.txt
testYLabels <- test labels read from /test/y_test.txt 
testSubjects <- test subjects read from test/subject_test.txt
allXData <- combined training and test Data
allYLabels <- combined training and test Labels
allSubjects <- combined training and test Subjects
features <- features data read from features.txt
meanStandardDeviation <- mean and standard deviation extracted from features
joinedData <- allXData joined with meanStandardDeviation
activity <- activity labels read from activity.txt
allColumns <- column-bound allSubjects, allYLabels and joinedData
activityLength <- length of activity
columnLength <- length of allColumns
subjectLength <- length of allSubjects

The merged data is written to the file merged_data_set.txt

The average of each variable for each activity and subject is written to the file mean_and_std_dev_data.txt
