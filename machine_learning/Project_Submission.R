#


library(RCurl)

#Read data

training <- read.csv("C:/Users/Godoy/Downloads/pml-training.csv", header=TRUE,
                     na.strings=c("NA", ""))


summary(training)

#First six not useful for prediction. Some containts NAS

training <- training [, -(1:6)]

#Delete columns that have NAs more than 90%
minimumrows <- nrow(training)*0.9
naspercolumn <- sapply(training, function(x) sum(is.na(x)))
training <- training[, naspercolumn < minimumrows]
#Remove Columns that are not highly variable
variation <- sapply(training, function(x) abs(sd(x)/mean(x)))
training <- training[ , -variation[-length(variation)] < 1]

inTrain <- createDataPartition(training$classe, p=0.75, list=FALSE)
training2 <- training[inTrain, ]
testing2 <- training[-inTrain, ]

require(randomForest)
set.seed(1234)

modelFit <- randomForest(classe~., data=training2, importance=TRUE)

library(caret)
confusionMatrix(predict(modelFit, newdata=testing2[, -ncol(testing2)]),
                testing2$classe)


testingfile <- read.csv("C:/Users/Godoy/Downloads/pml-testing.csv", header=TRUE,
                     na.strings=c("NA", ""))

#First six not useful for prediction. Some containts NAS

testingfile <- testingfile[, -(1:6)]

#Delete columns that have NAs more than 90%
minimumrows <- nrow(testingfile)*0.9
naspercolumn <- sapply(testingfile, function(x) sum(is.na(x)))
testingfile <- testingfile[, naspercolumn < minimumrows]
#Remove Columns that are not highly variable
variation <- sapply(testingfile, function(x) abs(sd(x)/mean(x)))
testingfile <- testingfile[ , -variation[-length(variation)] < 1]

sapply(testingfile, sd)



predictions <- predict(modelFit,newdata=testingfile)

pml_write_files = function(x){
        n = length(x)
        for(i in 1:n){
                filename = paste0("problem_id_",i,".txt")
                write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
        }
}

pml_write_files(predictions)

