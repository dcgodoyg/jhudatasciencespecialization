#Install Caret Package
install.packages("caret")
install.packages('e1071', dependencies=TRUE)
install.packages("kernlab")
#Caret package provides an unified 
library(caret)
library(kernlab)

#DATA SPLITTING
#Subset of a data just for training and subset just for testing
data(spam)
inTrain <- createDataPartition(y=spam$type, p=0.75, list=FALSE)

training <- spam[inTrain,]
testing <- spam[-inTrain,]

#FIT A MODEL

modelFit <- train(type ~., data=training, method="glm")
modelFit

modelFit$finalModel

confusionMatrix(prediction, testing$type)

#DATA SLICING

#k fold

folds <- createFolds(y=spam$type, k=10, list=TRUE, returnTrain=TRUE)
sapply(folds, length)

#resampling

folds <- createResample(y=spam$type, times=10, list=TRUE)
sapply(folds, length)

#Time Slices
tme <- 1:1000
folds <- createTimeSlices(y=tme, initialWindow=20, horizon=10)

#Plotting predictors
install.packages("ISLR")
library(ISLR)
library(ggplot2)

data(Wage)
summary(Wage)


inTrain <- createDataPartition(y=Wage$wage,
                               p=0.7, list=FALSE)
training <- Wage[inTrain,]
testing <- Wage[-inTrain,]

dim(training); dim(testing)

featurePlot(x=training[, c("age", "education", "jobclass")],
            y=training$wage,
            plot="pairs")
                
qplot(age, wage, data=training)

qplot(age, wage, colour=jobclass, data=training)
qq <- qplot(age, wage, colour=education, data=training)
qq + geom_smooth(method='lm', formula=y~x)

install.packages('Hmisc')
library(Hmisc)
cutWage <- cut2(training$wage, g=3)
table(cutWage)

p1 <- qplot(cutWage, age, data=training, fill=cutWage, geom=c('boxplot', 'jitter'))
p1

t1 <- table(cutWage, training$jobclass)
t1

prop.table(t1, 1)

qplot(wage, colour=education, data=training, geom='density')

#DONT USE THE TEST SET FOR EXPLORATION

#PREPROCESSING
#Variable very skewed
hist(training$capitalAve, main="", xlab="ave. capital run length")
#do preprocessing son models dont GET TRICKED

#First way STANDARIZE> Take variable values substract mean then divide bt SD

trainCapAve <- training$capitalAve
trainCapAveS <- (trainCapAve - mean(trainCapAve))/sd(trainCapAve)
mean(trainCapAveS)
sd(trainCapAveS)

#Standarizing the test set. we MUST USE THE SAME VALUES USED IN THE TRAINING SET
testCapAve <- testing$capitalAve
testCapAveS <- (testCapAve - mean(trainCapAve))/sd(trainCapAve)
mean(testCapAveS)
sd(testCapAveS)

#Use preprocess function
pre0bj <- preProcess(training[,-58], method=c("center", "scale"))
traincCapAveS <- predict(pre0bj, training[,-58])$capitalAve
mean(trainCapAveS)
sd(trainCapAveS)
#More on slides

#Preprocessing as an argument for the train function
modelFit <- train(type ~., data=training, preProcess=c("center", "scale"),
                  method="glm")

#Other kind of transformation
#BoxCox transforms that take continous data and try to make them look like normal data
pre0bj <- preProcess(training[,-58], method=c("BoxCox"))
trainCapAveS <- predict(pre0bj, training[,-58])$capitalAve
par(mfrow=c(1, 2)); hist(trainCapAveS); qqnorm(trainCapAveS)

#Standarizing - Imputing Data
install.packages("RANN")
library(RANN)
#Make some values NA for the sake of the example

training$capAve <- training$capitalAve
selectNA <- rbinom(dim(training)[1], size=1, prob=0.05)==1
training$capAve[selectNA] <- NA
                   
#Impute and standarize
pre0bj <- preProcess(training[,-58], method="knnImpute")
capAve <- predict(pre0bj, training[,-58])$capAve

#Standarize true values
capAveTruth <- training$capitalAve
capAveTruth <- (capAveTruth-mean(capAveTruth))/sd(capAveTruth)


#COVARIATE CREATION
#sometimes called predictos or features

library(ISLR); library(caret); data(Wage)
inTrain <- createDataPartition(y=Wage$wage,
                               p=0.7, list=FALSE)
training <-Wage[inTrain, ]; testing <-Wage[-inTrain,]

#Turn qualitative variables into dummy variables

table(training$jobclass)
dummies <- dummyVars(wage ~ jobclass, data=training)
head(predict(dummies, newdata=training))

#Removing zero covariates

nsv <- nearZeroVar(training, saveMetrics=TRUE)
nsv
#NZV=TRUE not much useful

library(splines)
bsBasis <- bs(training$age, df=3)
bsBasis

#Principal Component Analysis. Sometimes variables are highly correlated.
#Most useful for linear/type models
#Watch out for outliers (transform first (with logs/box coxs)

M <- abs(cor(training[,-58]))
diag(M) <- 0
which(M > 0.8, arr.ind=TRUE)

names(spam)[c(34, 32)]
plot(spam[,34], spam[,32])


smallSpam <- spam[, c(34, 32)]
prComp <- prcomp(smallSpam)
plot(prComp$x[,1], prComp$x[, 2])

prComp$rotation

#pca
typeColor <- ((spam$type =="spam")*1 + 1)
prComp <- prcomp(log10(spam[, -58] + 1))
plot(prComp$x[,1], prComp$x[,2], col=typeColor, xlab="PC1", ylab="PC2")

#PCA with Caret
preProc <- preProcess(log10(spam[,-58]+1), method="pca", pcaComp=2)
spamPC <- predict(preProc, log10(spam[,-58]+1))
plot(spamPC[,1], spamPC[,2], col=typeColor)

preProc <- preProcess(log10(spam[,-58]+1), method="pca", pcaComp=2)
trainPC <- predict(preProc, log10(training[,-58]+1))
modelFit <- train(training$type ~., method="glm", data=trainPC)

testPC <- predict(preProc, log10(testing[,-58]+1))
confusionMatrix(testing$type, predict(modelFit, testPC))

#PREDICTING WITH REGRESSION

#PREDICTING WITH TREES
#If you have a bunch of variables you want to use to predict an outcome, 
#you can split the data based on the variables into different groups

#Start with all variables in one grup
#Find bst variable that best separete putcome
#Divide te data into two groups ("leaves") on that spli ("node")
#Within each split, find the best variable/split that sepate the outcomes
#Continue until te groups are too small or sufficinetly pure

data(iris); library(ggplot2)

names(iris)

table(iris$Species)

inTrain <- createDataPartition(y=iris$Species,
                               p=0.7, list=FALSE)
training <- iris[inTrain, ]
testing <- iris[-inTrain, ]

qplot(Petal.Width, Sepal.Width, colour=Species, data=training)

modFit <-train(Species ~., method="rpart", data=training)
print(modFit$finalModel)
plot(modFit$finalModel, uniform=TRUE,
     main="Classification tree")
text(modFit$finalModel, use.n=TRUE, all=TRUE, cex=.8)

library(rattle)
fancyRpartPlot(modFit$finalModel)

#BAGGING




#RANDOM FORESTS

#Bootstrap samples ... We take a resample of our observed data in our
#trainign data set and then rebuild classification or regressiont trees
#on each of bootstraped samples

#At each split, we also bootstrap the variables. Only a subset of variables
#are taken into account. We vote our averaged trees.

data(iris)
library(ggplot2)
modFit <- createDataPartition(y=iris$Species, p=0.7, list=FALSE)
training <- iris[inTrain, ]
testing <- iris[-inTrain, ]

library(caret)
modFit <-train(Species~ .,data=training, method="rf", prox=TRUE)
modFit

getTree(modFit$finalModel, k=2)

irisP <- classCenter(training[ ,c(3,4)], training$Species, modFit$finalModel$prox)
irisP <- as.data.frame(irisP)
irisP$Species <- rownames(irisP)

p <- qplot(Petal.Width, Petal.Length, col=Species, data=training)
p + geom_point(aes(x=Petal.Width, y=Petal.Length, col=Species), size=5, shape=4, data=irisP)
p

#Predict new values
pred <- predict(modFit, testing)
testing$predRight <- pred == testing$Species
table(pred, testing$Species)

qplot(Petal.Width, Petal.Length, colour=predRight, data=testing, main="newdata Predictions")

#BOOSTING

#Take lots of possible weak predictors
#Weight them and add them up
#Get a Stronger predictor

library(ISLR); data(Wage); library(ggplot2); library(caret)
#Removes the predictor
Wage <- subset(Wage, select=-c(logwage))
inTraing <- createDataPartition(y=Wage$wage,
                                p=0.7, list=FALSE)
training <- Wage[inTrain, ]; testing <- Wage[-inTrain, ]

modFit = train(wage~., method="gbm", data=training, verbose=FALSE)
print(modFit)

qplot(predict(modFit, testing), wage, data=testing)

#MODEL BASED PREDICTION

#Assume data follow a probabilisitc model
#Use Bayes theorem to identify optimal classifiers


