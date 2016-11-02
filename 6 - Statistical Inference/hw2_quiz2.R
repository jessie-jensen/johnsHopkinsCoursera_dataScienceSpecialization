

#### Homework

# 4
pnorm(93,100,10)


# 5
# use bayes
sens <- .93
spec <- .88
prev <- .05

bayes <- function(sens, spec, prev){
  (spec*(1-prev))/
  (spec*(1-prev) + (1-sens)*prev)
}

bayes(sens,spec,prev)

#6
qnorm(.95,100,10)

#7
qnorm(.95,100,sqrt(100/50))

#8
(choose(6,5)+choose(6,6))/2^6

1-pbinom(4,size = 6,prob = .5)


#9
pnorm(.51,.5,sqrt((1/12)/100), lower.tail = FALSE)

#11
var(1:6)/10
mean((1 : 6 - 3.5)^2 / 10)

#12
ppois(20, lambda = 16.5*2)


### Quiz 2

#2
# Suppose that diastolic blood pressures (DBPs) for men aged 35-44 are normally distributed with a mean of 80 (mm Hg) and a standard deviation of 10. About what is the probability that a random 35-44 year old has a DBP less than 70?
pnorm(70,80,10)

#3
# Brain volume for adult women is normally distributed with a mean of about 1,100 cc for women with a standard deviation of 75 cc. What brain volume represents the 95th percentile?
qnorm(.95,1100,75)

#4
# Refer to the previous question. Brain volume for adult women is about 1,100 cc for women with a standard deviation of 75 cc. Consider the sample mean of 100 random adult women from this population. What is the 95th percentile of the distribution of that sample mean?
qnorm(.95,1100,sqrt(75^2/100))

#5
# You flip a fair coin 5 times, about what's the probability of getting 4 or 5 heads?
(choose(5,5)+choose(5,4))/2^5

1-pbinom(3,size = 5,prob = .5)

#6
# The respiratory disturbance index (RDI), a measure of sleep disturbance, for a specific population has a mean of 15 (sleep events per hour) and a standard deviation of 10. They are not normally distributed. Give your best estimate of the probability that a sample mean RDI of 100 people is between 14 and 16 events per hour?

# Even though the underlying distribution is not normally distributed, the central limit theorem says that its sample means are.

pnorm(16,15,sqrt(10^2/100)) - pnorm(14,15,sqrt(10^2/100))


#7
# Consider a standard uniform density. The mean for this density is .5 and the variance is 1 / 12. You sample 1,000 observations from this distribution and take the sample mean, what value would you expect it to be near?
.5

#8
# The number of people showing up at a bus stop is assumed to be Poisson with a mean of 5 people per hour. You watch the bus stop for 3 hours. About what's the probability of viewing 10 or fewer people?
ppois(10, lambda = 3*5)
