# Q1

library(ElemStatLearn)
data(vowel.train)
data(vowel.test) 

set.seed(33833)

library(caret)

vowel.train$y <- as.factor(vowel.train$y)

model_fit_rf <- train(y ~ .,
                      data = vowel.train,
                      method = "rf")

confusionMatrix(as.factor(vowel.test$y), predict(model_fit_rf, newdata = vowel.test))



model_fit_gbm <- train(y ~ .,
                    data = vowel.train,
                    method = "gbm",
                    verbose = FALSE)

confusionMatrix(as.factor(vowel.test$y), predict(model_fit_gbm, newdata = vowel.test))



# Q2
# Load the Alzheimer's data using the following commands


library(caret)
library(gbm)
set.seed(3433)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]


# Set the seed to 62433 and predict diagnosis with all the other variables using a random forest ("rf"), boosted trees ("gbm") and linear discriminant analysis ("lda") model. Stack the predictions together using random forests ("rf"). What is the resulting accuracy on the test set? Is it better or worse than each of the individual predictions?
set.seed(62433)




# Question 3
# Load the concrete data with the commands:
  set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]
# Set the seed to 233 and fit a lasso model to predict Compressive Strength. Which variable is the last coefficient to be set to zero as the penalty increases? (Hint: it may be useful to look up ?plot.enet).

set.seed(233)

model_fit <- train(CompressiveStrength ~.,
                   data = training,
                   method = "lasso")


plot.enet(model_fit$finalModel)



# Question 4
# Load the data on the number of visitors to the instructors blog from here: 
#   https://d396qusza40orc.cloudfront.net/predmachlearn/gaData.csv
# 
# Using the commands:
#   
#   library(lubridate)  # For year() function below
# dat = read.csv("~/Desktop/gaData.csv")
# training = dat[year(dat$date) < 2012,]
# testing = dat[(year(dat$date)) > 2011,]
# tstrain = ts(training$visitsTumblr)
# Fit a model using the bats() function in the forecast package to the training time series. Then forecast this model for the remaining time points. For how many of the testing points is the true value within the 95% prediction interval bounds?


# Question 5
# Load the concrete data with the commands:
set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]
# Set the seed to 325 and fit a support vector machine using the e1071 package to predict Compressive Strength using the default settings. Predict on the testing set. What is the RMSE?

set.seed(325)

library(e1071)

model_fit <- svm(CompressiveStrength ~ .,
                 data = training)

model_predict <- predict(model_fit,testing)

RMSE(model_predict, testing$CompressiveStrength)
