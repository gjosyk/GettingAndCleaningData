---
title: "README.md"
output: html_document
---


Getting and Cleaning Data Course Project

This readme file describes how the script "run_analysis.R" works.

1.  Extract the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2.  Set the working directory so that the extracted data and the run_analysis.R script are both in the current working directory.
3.  Open RStudio and type "source("run_analysis.R")" to load the script
4.  After running the script, there will be two newly created files in the current working directory:
      a.  merged_data_set.txt - contains the merged data set
      b.  mean_and_std_dev_data.txt - contains the average of each variable for each activity and each subject

