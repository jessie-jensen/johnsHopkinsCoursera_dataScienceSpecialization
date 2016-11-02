#### Machine Learning Week 1


## Machine learning process
## question >> input data >> features >> algorithm >> parameters >> evaluation


## Spam example

library(kernlab)
data("spam")

plot(density(spam$your[spam$type=="nonspam"]),
     col="blue",main="",xlab="Frequency of 'your'")
lines(density(spam$your[spam$type=="spam"]),col="red")
abline(v=0.5,col="black")


prediction <- ifelse(spam$your > 0.5,"spam","nonspam")
table(prediction,spam$type)/length(spam$type)


### In sample vs. out of sample errors (overfitting)

library(kernlab); data(spam); set.seed(333)
smallSpam <- spam[sample(dim(spam)[1],size=10),]
spamLabel <- (smallSpam$type=="spam")*1 + 1
plot(smallSpam$capitalAve,col=spamLabel)


# perfect / overfitted rule
rule1 <- function(x){
  prediction <- rep(NA,length(x))
  prediction[x > 2.7] <- "spam"
  prediction[x < 2.40] <- "nonspam"
  prediction[(x >= 2.40 & x <= 2.45)] <- "spam"
  prediction[(x > 2.45 & x <= 2.70)] <- "nonspam"
  return(prediction)
}
table(rule1(smallSpam$capitalAve),smallSpam$type)

# generalized rule
rule2 <- function(x){
  prediction <- rep(NA,length(x))
  prediction[x > 2.8] <- "spam"
  prediction[x <= 2.8] <- "nonspam"
  return(prediction)
}
table(rule2(smallSpam$capitalAve),smallSpam$type)


# against test data
table(rule1(spam$capitalAve),spam$type)
sum(rule1(spam$capitalAve)==spam$type)


table(rule2(spam$capitalAve),spam$type)
sum(rule2(spam$capitalAve)==spam$type)


# Data have two parts:
# - Signal
# - Noise


# Ways to cross validate
# Random subsampling 
  # (must be done without replacement)
# K-fold
  # --> larger k = less bias, more variance
  # --> smaller k = more bias, less variance
# Leave one out


