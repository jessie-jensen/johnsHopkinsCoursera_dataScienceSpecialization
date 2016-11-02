### Creating decision trees

library(ggplot2)
library(caret)

data(iris)
names(iris)

table(iris$Species)

inTrain <- createDataPartition(y=iris$Species,
                               p=0.7, list=FALSE)

training <- iris[inTrain,]
testing <- iris[-inTrain,]
dim(training); dim(testing)

qplot(Petal.Width,Sepal.Width,colour=Species,data=training)

# training model
model_fit <- train(Species ~ ., 
                   method = "rpart",
                   data = training)

# view model
model_fit$finalModel

# plot model
plot(model_fit$finalModel, uniform=TRUE, main="Classification Tree")
text(model_fit$finalModel, use.n = TRUE, all = TRUE, cex = .8)

# WWAAAAAYYYYY better plot
library(rattle)
fancyRpartPlot(model_fit$finalModel)


# predicting
predict(model_fit, newdata = testing)
confusionMatrix(testing$Species, predict(model_fit, newdata = testing))




#
### Bagging
#

library(ElemStatLearn); data(ozone,package="ElemStatLearn")
ozone <- ozone[order(ozone$ozone),]
head(ozone)

ll <- matrix(NA,nrow=10,ncol=155)
for(i in 1:10){
  ss <- sample(1:dim(ozone)[1],replace=T)
  ozone0 <- ozone[ss,]; ozone0 <- ozone0[order(ozone0$ozone),]
  loess0 <- loess(temperature ~ ozone,data=ozone0,span=0.2)
  ll[i,] <- predict(loess0,newdata=data.frame(ozone=1:155))
}

plot(ozone$ozone,ozone$temperature,pch=19,cex=0.5)
for(i in 1:10){lines(1:155,ll[i,],col="grey",lwd=2)}
lines(1:155,apply(ll,2,mean),col="red",lwd=2)



# advanced bagging in caret
predictors = data.frame(ozone=ozone$ozone)
temperature = ozone$temperature
treebag <- bag(predictors, temperature, B = 10,
               bagControl = bagControl(fit = ctreeBag$fit,
                                       predict = ctreeBag$pred,
                                       aggregate = ctreeBag$aggregate))

plot(ozone$ozone,temperature,col='lightgrey',pch=19)
points(ozone$ozone,predict(treebag$fits[[1]]$fit,predictors),pch=19,col="red")
points(ozone$ozone,predict(treebag,predictors),pch=19,col="blue")



#
### Random Forest
#

library(caret)
library(ggplot2)

data(iris)

inTrain <- createDataPartition(y=iris$Species,
                               p=0.7, list=FALSE)
training <- iris[inTrain,]
testing <- iris[-inTrain,]

model_fit <- train(Species ~ .,
                   data = training,
                   method = "rf",
                   prox = TRUE)

model_fit

getTree(model_fit$finalModel, k=2)

irisP <- classCenter(training[,c(3,4)], training$Species, model_fit$finalModel$prox)
irisP <- as.data.frame(irisP); irisP$Species <- rownames(irisP)
p <- qplot(Petal.Width, Petal.Length, col=Species,data=training)
p + geom_point(aes(x=Petal.Width,y=Petal.Length,col=Species),size=5,shape=4,data=irisP)

pred <- predict(model_fit,testing)
testing$predRight <- pred==testing$Species
table(pred,testing$Species)


#
### Boosting
#
library(ISLR); data(Wage); library(ggplot2); library(caret);
Wage <- subset(Wage,select=-c(logwage))
inTrain <- createDataPartition(y=Wage$wage,
                               p=0.7, list=FALSE)
training <- Wage[inTrain,]; testing <- Wage[-inTrain,]

model_fit <- train(wage ~ .,
                   method="gbm",
                   data=training,
                   verbose=FALSE)

model_fit

