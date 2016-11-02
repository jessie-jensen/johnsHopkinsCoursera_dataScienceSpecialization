# Q1

library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)
library(dplyr)

table(segmentationOriginal$Case)

training <- filter(segmentationOriginal, Case == "Train")
testing <- filter(segmentationOriginal, Case == "Test")

set.seed(125)

model_fit <- train(Class ~ .,
                   data = training,
                   method = "rpart")

library(rattle)
fancyRpartPlot(model_fit$finalModel)

# Q3

library(pgmm)
data(olive)
olive = olive[,-1]

olive$Area <- as.factor(olive$Area)
class(olive$Area)
table(olive$Area)


# Q4

library(ElemStatLearn)
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]

set.seed(13234)

colnames(trainSA)

model_fit <- train(chd ~ age + alcohol + obesity + tobacco + typea + ldl,
                   data = trainSA,
                   method = "glm",
                   family = "binomial")


p_training <- predict(model_fit, newdata = trainSA)
p_testing <- predict(model_fit, newdata = testSA)


missClass = function(values,prediction){sum(((prediction > 0.5)*1) != values)/length(values)}

missClass(trainSA$chd,p_training)
missClass(testSA$chd,p_testing)


# Q5

library(ElemStatLearn)
data(vowel.train)
data(vowel.test)

vowel.test$y <- as.factor(vowel.test$y)
vowel.train$y <- as.factor(vowel.train$y)

class(vowel.test$y)
class(vowel.train$y)

set.seed(33833)


library(randomForest)
model_fit <- randomForest(y ~ .,
                          data = vowel.train)

var_imp <- varImp(model_fit)

var_imp[order[Overall],]
