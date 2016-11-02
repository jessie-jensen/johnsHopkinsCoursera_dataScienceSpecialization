### 5. Variance

# variance of a die roll
d6 <- 1:6

# e(x)
e_x <- (1/length(d6))*sum(d6)
# e(x^2)
e_x2 <- (1/length(d6))*sum(d6^2)
# v(x)=e(x^2)-e(x)^2
v_x <- e_x2 - e_x^2

# variance
v_x
var(d6)*((length(d6)-1)/length(d6))
# standard deviation
sqrt(v_x)
sqrt(var(d6)*((length(d6)-1)/length(d6)))


## Distributions with increasing variance

library(ggplot2)
xvals <- seq(-10, 10, by = .01)
dat <- data.frame(
  y = c(
    dnorm(xvals, mean = 0, sd = 1),
    dnorm(xvals, mean = 0, sd = 2),
    dnorm(xvals, mean = 0, sd = 3),
    dnorm(xvals, mean = 0, sd = 4)
  ),
  x = rep(xvals, 4),
  factor = factor(rep(1 : 4, rep(length(xvals), 4)))
)
ggplot(dat, aes(x = x, y = y, color = factor)) + geom_line(size = 2)

## Simulation experiment
# Simulating from a population with variance 1

nosim <- 10000; 
dat <- data.frame(
  x = c(apply(matrix(rnorm(nosim * 10), nosim), 1, var),
        apply(matrix(rnorm(nosim * 20), nosim), 1, var),
        apply(matrix(rnorm(nosim * 30), nosim), 1, var)),
  n = factor(rep(c("10", "20", "30"), c(nosim, nosim, nosim))) 
)
ggplot(dat, aes(x = x, fill = n)) + geom_density(size = 2, alpha = .2) + geom_vline(xintercept = 1, size = 2) 


# simulate standard error of normal distribution
nosim <- 1000
n <- 10
sd(
  apply(
    matrix(rnorm(nosim*n)
           ,nosim)
    ,1,mean)
  )

1/sqrt(n)


# ex 
library(UsingR)
data(father.son)
x <- father.son$sheight
n <- length(x)

hist(x)