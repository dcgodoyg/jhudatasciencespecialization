#Libraries required for this script
library(data.table)
library(stringr)

#The files used in this script can be found on:
#http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

#This script assumes you have already downloaded and unzipped
#the .zip in your working directory. Once the folder has been
#created, we set this folder as the working directory
setwd("UCI HAR Dataset")


#STEP1: Merges the training and the test sets to create one data set.

#read test files and create variables
subject_test <- read.table("test/subject_test.txt")
X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")

#read train files and create variables
subject_train <- read.table("train/subject_train.txt")
X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")

#bind by row the train and test dataset. Attention! Must be in the
#same orer: test + train for each case
data <- rbind(X_test, X_train)
subject <- rbind(subject_test, subject_train)
activity <- rbind(y_test, y_train)


#STEP2: Extracts only the measurements on the mean and standard deviation for each measurement.

#read an prepare data
features <- read.table("features.txt")
features <- as.character((features[ , 2]))

#get the index of the rows that contain either mean or std in a vector
#Note that could be either Mean or mean
containmean <- which(str_detect(features, "[Mm]ean"))
containstd <- which(str_detect(features, "std"))

#append vector and sort, so indexes will be sorted by ascending order
finalselection <- sort(append(containmean, containstd))


#STEP3: Uses descriptive activity names to name the activities in the data set

#read and prepare data
activity_labels <- read.table("activity_labels.txt")
#get activity vector (sepecified in STEP 1) and assign
#descriptive names in lower case from activity_labels
activities <- tolower(activity_labels[activity[, 1], 2])


#STEP4: Appropriately labels the data set with descriptive variable names. 

#remove special characters from features titles
features <- gsub("\\(|\\)|\\,|\\-", "", features)

#merge columns and create merged dataset
#NOTE that "data[ , finalselection]" subset the columns
#where Mean/mean and std are present.
merged_data <- cbind(subject, activities, data[, finalselection])
colnames(merged_data) <- c("subject", "actv", features[finalselection])

#check the data
head(merged_data)

#export data
write.csv(merged_data, "merged_data.csv")

#STEP5:From the data set in step 4, creates a second, independent tidy data set with the #average of each variable for each activity and each subject.

#use function aggregate tu calculate average of each
#variable for each activity and each subject
tidy_data <-aggregate(. ~subject + actv, merged_data, mean)

#check the data
head(tidy_data)

#export data
write.csv(tidy_data, "tidy_data.csv")

#END
#measurements are normalised and so unitlless.

