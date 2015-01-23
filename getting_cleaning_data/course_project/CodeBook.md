---
title: "Codebook"
author: "DanielGodoy"
date: "Thursday, January 22, 2015"
output: html_document
---

The script uses the Human Activity Recognition Using Smartphones Dataset created by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto at Smartlab - Non Linear Complex Systems Laboratory. A full description is available at the site where the data was obtained: 
        
        http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 
        
        https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
        
The data suffered the following modifications in order to create a tidy data set

####WHILE CREATING THE MERGED DATA FRAME

1) Only the measurements on the mean and standard deviation for each measurement were taken into account. This was made by only including measuremets that have "mean", "Mean" or "std" on their name.

2)Special characters (underscores, brackets and commas) were removed from the name of each measurement that was taken into account. Hence making the names descriptive and R friendly.

As a result, the following 86 measurements were taken into account: 
        
             
         [1] "tBodyAccmeanX"                     "tBodyAccmeanY"                    
         [3] "tBodyAccmeanZ"                     "tBodyAccstdX"                     
         [5] "tBodyAccstdY"                      "tBodyAccstdZ"                     
         [7] "tGravityAccmeanX"                  "tGravityAccmeanY"                 
         [9] "tGravityAccmeanZ"                  "tGravityAccstdX"                  
        [11] "tGravityAccstdY"                   "tGravityAccstdZ"                  
        [13] "tBodyAccJerkmeanX"                 "tBodyAccJerkmeanY"                
        [15] "tBodyAccJerkmeanZ"                 "tBodyAccJerkstdX"                 
        [17] "tBodyAccJerkstdY"                  "tBodyAccJerkstdZ"                 
        [19] "tBodyGyromeanX"                    "tBodyGyromeanY"                   
        [21] "tBodyGyromeanZ"                    "tBodyGyrostdX"                    
        [23] "tBodyGyrostdY"                     "tBodyGyrostdZ"                    
        [25] "tBodyGyroJerkmeanX"                "tBodyGyroJerkmeanY"               
        [27] "tBodyGyroJerkmeanZ"                "tBodyGyroJerkstdX"                
        [29] "tBodyGyroJerkstdY"                 "tBodyGyroJerkstdZ"                
        [31] "tBodyAccMagmean"                   "tBodyAccMagstd"                   
        [33] "tGravityAccMagmean"                "tGravityAccMagstd"                
        [35] "tBodyAccJerkMagmean"               "tBodyAccJerkMagstd"               
        [37] "tBodyGyroMagmean"                  "tBodyGyroMagstd"                  
        [39] "tBodyGyroJerkMagmean"              "tBodyGyroJerkMagstd"              
        [41] "fBodyAccmeanX"                     "fBodyAccmeanY"                    
        [43] "fBodyAccmeanZ"                     "fBodyAccstdX"                     
        [45] "fBodyAccstdY"                      "fBodyAccstdZ"                     
        [47] "fBodyAccmeanFreqX"                 "fBodyAccmeanFreqY"                
        [49] "fBodyAccmeanFreqZ"                 "fBodyAccJerkmeanX"                
        [51] "fBodyAccJerkmeanY"                 "fBodyAccJerkmeanZ"                
        [53] "fBodyAccJerkstdX"                  "fBodyAccJerkstdY"                 
        [55] "fBodyAccJerkstdZ"                  "fBodyAccJerkmeanFreqX"            
        [57] "fBodyAccJerkmeanFreqY"             "fBodyAccJerkmeanFreqZ"            
        [59] "fBodyGyromeanX"                    "fBodyGyromeanY"                   
        [61] "fBodyGyromeanZ"                    "fBodyGyrostdX"                    
        [63] "fBodyGyrostdY"                     "fBodyGyrostdZ"                    
        [65] "fBodyGyromeanFreqX"                "fBodyGyromeanFreqY"               
        [67] "fBodyGyromeanFreqZ"                "fBodyAccMagmean"                  
        [69] "fBodyAccMagstd"                    "fBodyAccMagmeanFreq"              
        [71] "fBodyBodyAccJerkMagmean"           "fBodyBodyAccJerkMagstd"           
        [73] "fBodyBodyAccJerkMagmeanFreq"       "fBodyBodyGyroMagmean"             
        [75] "fBodyBodyGyroMagstd"               "fBodyBodyGyroMagmeanFreq"         
        [77] "fBodyBodyGyroJerkMagmean"          "fBodyBodyGyroJerkMagstd"          
        [79] "fBodyBodyGyroJerkMagmeanFreq"      "angletBodyAccMeangravity"         
        [81] "angletBodyAccJerkMeangravityMean"  "angletBodyGyroMeangravityMean"    
        [83] "angletBodyGyroJerkMeangravityMean" "angleXgravityMean"                
        [85] "angleYgravityMean"                 "angleZgravityMean"    
        
Take into account that measurements are normalised and so unitlless.

3) activities were described (and converted to lowecase) in the merged data set according to the descriptions found in activity_labels.txt. 

The data frame looks like:

          subject     actv tBodyAccmeanX tBodyAccmeanY tBodyAccmeanZ tBodyAccstdX tBodyAccstdY tBodyAccstdZ
        1       2 standing     0.2571778   -0.02328523   -0.01465376   -0.9384040   -0.9200908   -0.6676833
        2       2 standing     0.2860267   -0.01316336   -0.11908252   -0.9754147   -0.9674579   -0.9449582
        3       2 standing     0.2754848   -0.02605042   -0.11815167   -0.9938190   -0.9699255   -0.9627480
        4       2 standing     0.2702982   -0.03261387   -0.11752018   -0.9947428   -0.9732676   -0.9670907
        5       2 standing     0.2748330   -0.02784779   -0.12952716   -0.9938525   -0.9674455   -0.9782950
        6       2 standing     0.2792199   -0.01862040   -0.11390197   -0.9944552   -0.9704169   -0.9653163

with 10299 observations and 88 variables (subject + actv + 86 measurements)


####WHILE CREATING THE TIDY DATA SET


1) From the data set created before, a second data set were created with the average of each variable for each activity and each subject.

The tidy set looks like:

        
          subject   actv tBodyAccmeanX tBodyAccmeanY tBodyAccmeanZ tBodyAccstdX tBodyAccstdY tBodyAccstdZ
        1       1 laying     0.2215982   -0.04051395    -0.1132036   -0.9280565   -0.8368274   -0.8260614
        2       2 laying     0.2813734   -0.01815874    -0.1072456   -0.9740595   -0.9802774   -0.9842333
        3       3 laying     0.2755169   -0.01895568    -0.1013005   -0.9827766   -0.9620575   -0.9636910
        4       4 laying     0.2635592   -0.01500318    -0.1106882   -0.9541937   -0.9417140   -0.9626673
        5       5 laying     0.2783343   -0.01830421    -0.1079376   -0.9659345   -0.9692956   -0.9685625
        6       6 laying     0.2486565   -0.01025292    -0.1331196   -0.9340494   -0.9246448   -0.9252161
        
with 180 observations and 88 variables (subject + actv + 86 measurements)





