Getting and Cleaning Data - Johns Hopkins Bloomberg School of Public Health at Coursera - Course Project - Daniel Godoy Gómez

#readme

The run_analysis.R script was created as a Final Course Project.

In order to run directly the run_analysis.R script, you should follow these steps:
        
        1. Download and unzip the .zip file that you will find here:
        https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
        in a folder named "UCI HAR Dataset" in your computer. 
        
        2. Download the run_analysis.R script in the "UCI HAR Dataset"
        folder
        
        3. Make this folder as your working directory using R terminal
                setwd("c:filepath/UCI HAR Dataset")
                
        4. Source the script using R Terminal.
                source("run_analysis.R")

Once sourced the script, the following happens:
                
        1.Merges the training and the test sets to create one data set.
        2.Extracts only the measurements on the mean and standard deviation for each
        measurement. 
        3.Uses descriptive activity names to name the activities in the data set
        4.Appropriately labels the data set with descriptive variable names. 
        5.From the data set in step 4, creates a second, independent tidy data set
        with the average of each variable for each activity and each subject.
        
To see what changes were made to the original data set please see codebok.md


