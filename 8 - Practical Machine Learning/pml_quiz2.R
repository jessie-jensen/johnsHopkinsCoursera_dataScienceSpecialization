## Question 1

library(AppliedPredictiveModeling)
library(caret)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)

table(diagnosis)



testIndex = createDataPartition(diagnosis, p = 0.50,list=FALSE)
training = adData[-testIndex,]
testing = adData[testIndex,]



trainIndex = createDataPartition(diagnosis,p=0.5,list=FALSE)
training = adData[trainIndex,]
testing = adData[trainIndex,]


adData = data.frame(diagnosis,predictors)
train = createDataPartition(diagnosis, p = 0.50,list=FALSE)
test = createDataPartition(diagnosis, p = 0.50,list=FALSE)


adData = data.frame(diagnosis,predictors)
trainIndex = createDataPartition(diagnosis, p = 0.50)
training = adData[trainIndex,]
testing = adData[-trainIndex,]



##############

## Question 2

library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]

hist(log(mixtures$Superplasticizer))
hist(training$Superplasticizer)
hist(testing$Superplasticizer)


##############

## Question 3

library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

preProcess(training[,grepl("IL",names(training))],
           method = "pca",
           thresh = .8)

predictors[,grepl("IL",names(predictors))]


### testing folds
folds <- createFolds(adData$diagnosis, k = 3)
training <- adData[-folds$Fold1,]
testing <- adData[folds$Fold1,]


##############

## Question 4

library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]


pca_proc <- preProcess(training[,grepl("IL",names(training))],
           method = "pca",
           thresh = .8)
predict(pca_proc)
pca <- train(training$type ~ .,method="glm",data=trainPC)

nonpca <- train(training$diagnosis ~ .,
            data=training[,grepl("IL",names(training))],
            method="glm")


confusionMatrix(testing$diagnosis,predict(nonpca,testing))
confusionMatrix(testing$diagnosis,predict(pca,testing))


pca <- train(training$diagnosis ~ .,
            data=training[,grepl("IL",names(training))],
            preProcess(training[,grepl("IL",names(training))],
                       method = "pca",
                       thresh = .8),
            method="glm")
confusionMatrix(testing$diagnosis,predict(t2,testing))

