---
title: "Machine Learning Course Project"
author: "by Daniel Godoy"
---

**This document contains the course project for the Machine Learning Course of the**
**Johns Hopkins' Data Science Specialization at Coursera.**

## 1. Background
Using devices such as Jawbone Up, Nike FuelBand, and Fitbit it is now possible to
collect a large amount of data about personal activity relatively inexpensively.
These type of devices are part of the quantified self movement – a group of enthusiasts
who take measurements about themselves regularly to improve their health, to find
patterns in their behavior, or because they are tech geeks. One thing that people
regularly do is quantify how much of a particular activity they do, but they rarely
quantify how well they do it. In this project, the goal is to use data from
accelerometers on the belt, forearm, arm, and dumbell of 6 participants. They were
asked to perform barbell lifts correctly and incorrectly in 5 different ways. More
information is available from the website here: http://groupware.les.inf.puc-rio.br/har
(see the section on the Weight Lifting Exercise Dataset). 

### 1.1. Data
The training data for this project are available here: 

https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv

The test data are available here: 

https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv

The data for this project come from this source: http://groupware.les.inf.puc-rio.br/har.

## 2. Assignment
In order to complete the assignment, the followung steps were taken.

* Load the data
* Clean the data
* Prepare and Perform a Random Forest Model
* Predict resuls of the testing dataset

### 2.1. Load the data
The files were downloaded from the links provided before. The data was loaded into
two different datasets: *trainingfile* and *testingfile*.

```{r, echo=FALSE, warning=FALSE}
trainingfileroute <- "C:/Users/Godoy/Downloads/pml-training.csv"
testingfileroute <- "C:/Users/Godoy/Downloads/pml-testing.csv"
```

```{r, echo=TRUE, warning=FALSE}
trainingfile <- read.csv(trainingfileroute, header=TRUE,
                     na.strings=c("NA", ""))
testingfile <- read.csv(testingfileroute, header=TRUE,
                     na.strings=c("NA", ""))
```

### 2.2. Clean the data
In order to prepare a good model, I removed data that may not contribute to the
robustness of the model. First, I removed columns that contained more than 90%
of NAs. Then, I removed data that does not vary significantly. Every process is
explained below:

#### 2.2.1. Removing NAs
After a quick inspection of the dataset, I noticed two things:

* There are identification variables that do not add value to the model.
* There are some variables that contain mainly NAs

##### Identification Variables
The first six variables of the dataset correspond to variables that identify
the subject and the time. Since these variables are used as information variables,
i removed them.

```{r, echo=TRUE, warning=FAlSE}
#Delete columns of the training file that containes more than 90% of NAs
minimumrows <- nrow(trainingfile)*0.9
naspercolumn <- sapply(trainingfile, function(x) sum(is.na(x)))
trainingfile <- trainingfile[, naspercolumn < minimumrows]

#Delete columns of the testing file that contains more than 90% of NAs

#First six not useful for prediction. Some containts NAS

testingfile <- testingfile[, -(1:6)]

#Delete columns that have NAs more than 90%
minimumrows <- nrow(testingfile)*0.9
naspercolumn <- sapply(testingfile, function(x) sum(is.na(x)))
testingfile <- testingfile[, naspercolumn < minimumrows]
```

varaibles that contained an
important amount of NAs. Since these variables may not add much value to a model, 
I decided to remove them. The removal is performe to the *trainingfile* and the
*testingfile*


```{r, echo=TRUE, warning=FAlSE}
#Delete columns of the training file that containes more than 90% of NAs
minimumrows <- nrow(trainingfile)*0.9
naspercolumn <- sapply(trainingfile, function(x) sum(is.na(x)))
trainingfile <- trainingfile[, naspercolumn < minimumrows]

#Delete columns of the testing file that contains more than 90% of NAs

#First six not useful for prediction. Some containts NAS

testingfile <- testingfile[, -(1:6)]

#Delete columns that have NAs more than 90%
minimumrows <- nrow(testingfile)*0.9
naspercolumn <- sapply(testingfile, function(x) sum(is.na(x)))
testingfile <- testingfile[, naspercolumn < minimumrows]
```


