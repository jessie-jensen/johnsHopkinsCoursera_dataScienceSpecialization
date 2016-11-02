### 2. Probability

## PDFs
x <- c(-.5, 0,1,1,1.5)
y <- c(0,0,2,0,0)
plot(x,y,lwd = 3,frame = FALSE, type = "l")

# finding probability of x=.75
1/2*(1.5*.75)
# CDF
pbeta(.75, 2,1)


# Distribution Functions in R
# help(Distributions)
# "d"  returns the height of the probability density function
# "p"	returns the cumulative density function
# "q"	returns the inverse cumulative density function (quantiles)
#   "r"	returns randomly generated numbers




### Estimated value

x <- 1:4
p <- x/sum(x)
temp <- rbind(x, p)
rownames(temp) <- c("X", "Prob")
temp

sum(x*p)

# ## Simulation experiment
# Simulating normals with mean 0 and variance 1 versus averages
# of 10 normals from the same population

library(ggplot2)
nosim <- 10000; n <- 10
dat <- data.frame(
  x = c(rnorm(nosim), apply(matrix(rnorm(nosim * n), nosim), 1, mean)),
  what = factor(rep(c("Obs", "Mean"), c(nosim, nosim))) 
)
ggplot(dat, aes(x = x, fill = what)) + geom_density(size = 2, alpha = .2); 



# ## Simulation experiment
## Averages of x die rolls

dat <- data.frame(
  x = c(sample(1 : 6, nosim, replace = TRUE),
        apply(matrix(sample(1 : 6, nosim * 2, replace = TRUE), 
                     nosim), 1, mean),
        apply(matrix(sample(1 : 6, nosim * 3, replace = TRUE), 
                     nosim), 1, mean),
        apply(matrix(sample(1 : 6, nosim * 4, replace = TRUE), 
                     nosim), 1, mean)
  ),
  size = factor(rep(1 : 4, rep(nosim, 4))))
g <- ggplot(dat, aes(x = x, fill = size)) + geom_histogram(alpha = .20, binwidth=.25, colour = "black") 
g + facet_grid(. ~ size)





pnorm(93,100,10)

