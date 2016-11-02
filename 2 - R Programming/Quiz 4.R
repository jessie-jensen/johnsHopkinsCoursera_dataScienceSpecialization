set.seed(1)
rpois(5, 2)


########

set.seed(1)
rnorm(3,0,1)
rnorm(3,0,1)

set.seed(1)
rnorm(3,0,1)

##############


set.seed(10)
x <- rep(0:1, each = 5)
e <- rnorm(10, 0, 20)
y <- 0.5 + 2 * x + e

?rep
x
e
y


###################


set.seed(10)
x <- rbinom(100,1,.5)
e <- rnorm(100, 0, 2)
y <- 0.5 + 2 * x + e

summary(y)
plot(x,y)


#############


library(datasets)
Rprof()
fit <- lm(y ~ x1 + x2)
Rprof(NULL)

