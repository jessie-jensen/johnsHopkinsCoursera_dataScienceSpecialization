#### Machine Learning Week 2

# initial demonstration
library(caret); library(kernlab); data(spam)
inTrain <- createDataPartition(y=spam$type,
                               p=0.75, list=FALSE)
training <- spam[inTrain,]
testing <- spam[-inTrain,]

set.seed(32343)

modelFit <- train(type ~ .,data=training, method="glm")
modelFit

modelFit$finalModel

predictions <- predict(modelFit, newdata = testing)
predictions

confusionMatrix(predictions, testing$type)


# Further information
# Caret tutorials:
#   http://www.edii.uclm.es/~useR-2013/Tutorials/kuhn/user_caret_2up.pdf
#   http://cran.r-project.org/web/packages/caret/vignettes/caret.pdf
# A paper introducing the caret package
#   http://www.jstatsoft.org/v28/i05/paper


#
### Data slicing
#

library(caret); library(kernlab); data(spam)
inTrain <- createDataPartition(y=spam$type,
                               p=0.75, list=FALSE)
training <- spam[inTrain,]
testing <- spam[-inTrain,]


# K-Folds
set.seed(32323)
folds <- createFolds(y=spam$type,k=10,
                     list=TRUE,returnTrain=FALSE)
sapply(folds,length)
folds
folds[[1]][1:10]


# random resampling, note that this has replacement
set.seed(32323)
folds <- createResample(y=spam$type,times=10,
                        list=TRUE)
sapply(folds,length)
folds[[1]][1:20]


# time slices
set.seed(32323)
tme <- 1:1000
folds <- createTimeSlices(y=tme,initialWindow=20,
                          horizon=10)
names(folds)

length(folds)
length(folds$train)
length(folds$train$Training001)

length(folds$test)
length(folds$test$Testing001)


#
### Training
#

library(caret); library(kernlab); data(spam)
inTrain <- createDataPartition(y=spam$type,
                               p=0.75, list=FALSE)
training <- spam[inTrain,]
testing <- spam[-inTrain,]
modelFit <- train(type ~.,data=training, method="glm")
modelFit

args(train.default)
args(trainControl)


p <- predict(modelFit, newdata = testing)
confusionMatrix(p, testing$type)


### Metric options
# Continous outcomes:
#   RMSE = Root mean squared error
#   RSquared = R2 from regression models
# 
# Categorical outcomes:
#   Accuracy = Fraction correct
#   Kappa = A measure of concordance

### trainControl resampling
# method
#   boot = bootstrapping
#   boot632 = bootstrapping with adjustment
#   cv = cross validation
#   repeatedcv = repeated cross validation
#   LOOCV = leave one out cross validation
# 
# number
#   For boot/cross validation
#   Number of subsamples to take
# 
# repeats
#   Number of times to repeate subsampling
#   If big this can slow things down



#
### Plotting Predictors
#

library(ISLR)
library(ggplot2)
library(caret)

data(Wage)
summary(Wage)


inTrain <- createDataPartition(y=Wage$wage,
                               p=0.7, list=FALSE)
training <- Wage[inTrain,]
testing <- Wage[-inTrain,]

featurePlot(x = training[,c("age","education","jobclass")],
            y = training$wage,
            plot = "pairs")

pairs(training[,c("age","maritl","race","education","jobclass","wage")])

qplot(age, wage, colour = jobclass, data = training)

qq <- qplot(age, wage, colour = education, data = training)
qq + geom_smooth(method='lm')


# Making factors from numeric data
library(Hmisc)
cut_wage <- cut2(training$wage, g=3)
table(cut_wage)

qplot(cut_wage, age, data = training, fill = cut_wage, geom = "boxplot")

qplot(cut_wage, age, data = training, fill = cut_wage, geom = c("boxplot","jitter"))


t1 <- table(cut_wage,training$jobclass)
t1

prop.table(t1,1)

t1/nrow(training)


qplot(wage, color = education, data = training, geom = "density")


factors <- colnames(x)
metrics <- colnames(y)

for factors
  for metric
    qplot(metrics[i], color = factors[i], data = training, geom = "density")




#
### Preprocessing
#

library(caret); library(kernlab); data(spam)
inTrain <- createDataPartition(y=spam$type,
                               p=0.75, list=FALSE)
training <- spam[inTrain,]
testing <- spam[-inTrain,]
hist(training$capitalAve,main="",xlab="ave. capital run length")

mean(training$capitalAve)
sd(training$capitalAve)

#standardizing a variable
training$capitalAve_s <- (training$capitalAve - mean(training$capitalAve))/sd(training$capitalAve)
mean(training$capitalAve_s)
sd(training$capitalAve_s)

# note that you will need to using training mean and sd on the testing set
testing$capitalAve_s <- (testing$capitalAve - mean(training$capitalAve))/sd(training$capitalAve)

# also can use caret
preObj <- preProcess(training[,-58],method=c("center","scale"))
trainCapAveS <- predict(preObj,training[,-58])$capitalAve
mean(trainCapAveS)
sd(trainCapAveS)

testCapAveS <- predict(preObj,testing[,-58])$capitalAve


set.seed(32343)
modelFit <- train(type ~.,data=training,
                  preProcess=c("center","scale"),method="glm")
modelFit


# standardizing via box-cox
preObj <- preProcess(training[,-58],method=c("BoxCox"))
trainCapAveS <- predict(preObj,training[,-58])$capitalAve
par(mfrow=c(1,2)); hist(trainCapAveS); qqnorm(trainCapAveS)



### imputing data
set.seed(13343)

# Make some values NA
training$capAve <- training$capitalAve
selectNA <- rbinom(dim(training)[1],size=1,prob=0.05)==1
training$capAve[selectNA] <- NA

# Impute and standardize
preObj <- preProcess(training[,-58],method="knnImpute")
capAve <- predict(preObj,training[,-58])$capAve


# Standardize true values
capAveTruth <- training$capitalAve
capAveTruth <- (capAveTruth-mean(capAveTruth))/sd(capAveTruth)


quantile(capAve - capAveTruth)
quantile((capAve - capAveTruth)[selectNA])
quantile((capAve - capAveTruth)[!selectNA])

# more info go here: http://topepo.github.io/caret/preprocess.html





#
### Preprocessing with Principle Components Analysis
#

library(caret); library(kernlab); data(spam)

set.seed(221)
inTrain <- createDataPartition(y=spam$type,
                               p=0.75, list=FALSE)
training <- spam[inTrain,]
testing <- spam[-inTrain,]

# find correlated values
M <- abs(cor(training[,-58]))
diag(M) <- 0
which(M > 0.8,arr.ind=T)

# plot the highly correlated values
plot(spam$num415,spam$num857)
plot(spam[,34],spam[,32])

# you could rotate the plot
X <- 0.71*training$num415 + 0.71*training$num857
Y <- 0.71*training$num415 - 0.71*training$num857
plot(X,Y)

# using principle components
smallSpam <- spam[,c(34,32)]
prComp <- prcomp(smallSpam)

head(prComp$x)
plot(prComp$x[,1],prComp$x[,2])

prComp$sdev
prComp$rotation
pca_df <- as.data.frame(prComp$x)

# now apply PCA to the entire set
typeColor <- ((spam$type=="spam")*1 + 1)
pca_spam <- prcomp(log10(spam[,-58]+1))
plot(pca_spam$x[,1],pca_spam$x[,2],col=typeColor,xlab="PC1",ylab="PC2")

pca_df2 <- as.data.frame(pca_spam$x)

# applying PCA in caret
caret_pca_spam <- preProcess(log10(spam[,-58]+1),
                             method = "pca",
                             pcaComp = 2) #will override thresh; can instead use thresh

p_caret_pca_spam <- predict(caret_pca_spam, log10(spam[,-58]+1))

plot(p_caret_pca_spam[,1], p_caret_pca_spam[,2], col = typeColor)



### Using PCA in the full predicitive flow

## caret flow
## preProcess >> predict pca >> train to fit model >> predict test pca >> predict on test data (use confusion matrix)

# training
pca_train <- preProcess(log10(training[,-58]+1),
                        method="pca",
                        #pcaComp=8)
                        thresh = .95)
                        
p_pca_train <- predict(pca_train, log10(training[,-58]+1))

model_fit <- train(training$type ~ .,
                  method="glm",
                  data=p_pca_train)

confusionMatrix(training$type, predict(model_fit, p_pca_train))

# testing
p_pca_test <- predict(pca_train, log10(testing[,-58]+1))

#predict(model_fit, p_pca_test)
confusionMatrix(testing$type, predict(model_fit, p_pca_test))
