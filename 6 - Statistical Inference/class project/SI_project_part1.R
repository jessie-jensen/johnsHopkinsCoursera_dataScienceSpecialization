###########
#
### PART 1
#
###########

# The exponential distribution can be simulated in R with rexp(n, lambda) where lambda is the rate parameter. 
# The mean of exponential distribution is 1/lambda and the standard deviation is also 1/lambda. Set lambda = 0.2 for all of the simulations. 
# You will investigate the distribution of averages of 40 exponentials. 
# Note that you will need to do a thousand simulations.


# Illustrate via simulation and associated explanatory text the properties of the distribution of the mean of 40 exponentials.  You should:
#   1. Show the sample mean and compare it to the theoretical mean of the distribution.
#   2. Show how variable the sample is (via variance) and compare it to the theoretical variance of the distribution.
#   3. Show that the distribution is approximately normal.

# Example: 
# 1000 random uniforms
hist(runif(1000))
# distribution of 1000 averages of 40 random uniforms
mns = NULL
for (i in 1 : 1000) mns = c(mns, mean(runif(40)))
hist(mns)


#
### 1. Sample Mean versus Theoretical Mean
#

# Set parameters
n <- 40
lambda <- 0.2
nosim <- 1000

# Store Theoretical Values
theoretical_mean <- 1/lambda
theoretical_sd <- 1/lambda


## Run simulation on sample means
sample_means <- NULL
for(i in 1:nosim){
  sample_means <- c(sample_means, mean(rexp(n,lambda)))
}


## Compare distribution of sample means to theoretical means

# Mean of sample means
mean(sample_means)
# Theoretical mean
theoretical_mean

# Plot
barplot(c(mean(sample_means),theoretical_mean),
        names.arg = c("Mean of the Sample Means","Theoretical Mean"),
        ylim = c(0,7),
        main = "Comparing Sample & Theoretical Means")



#
### 2. Sample Variance versus Theoretical Variance
#

# Variance of Sample Means
var(sample_means)
# Theoretical Variance
theoretical_sd^2/n

# Plot
barplot(c(var(sample_means),theoretical_sd^2/n),
        names.arg = c("Sample Variance","Theoretical Variance"),
        ylim = 0:1,
        main = "Comparing Sample & Theoretical Variances")



#
### 3. Show that the distribution is approximately normal
#

# Plot histogram and normal distribution
plot.new()
hist(sample_means, 
     breaks = (0:20)/2,
     freq = FALSE,
     col = "grey",
     main = "Histogram of Sample Means for Exponential Distribution",
     sub = "Lambda = .2 ; Theoretical Distribution & Mean in red")
abline(v = theoretical_mean, col = "red")
#abline(v = mean(sample_means), col = "blue")
curve(dnorm(x, mean = theoretical_mean, sd = theoretical_sd/sqrt(n))
      ,0,10, add = TRUE, col = "red")


hist(sample_means,xlab ="Sample Mean", main = paste("Histogram of" , "Sample Means"))
abline(v = mean(sample_means), col = "blue", lwd = 2)
rug(1/lambda, col = "red", lwd = 2)


