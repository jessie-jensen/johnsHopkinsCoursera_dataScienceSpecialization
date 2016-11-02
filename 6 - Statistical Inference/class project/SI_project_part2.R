# 1. Load the ToothGrowth data and perform some basic exploratory data analyses 
# 2. Provide a basic summary of the data.
# 3. Use confidence intervals and/or hypothesis tests to compare tooth growth by supp and dose. (Only use the techniques from class, even if there's other approaches worth considering)
# 4. State your conclusions and the assumptions needed for your conclusions. 


#
### 1. Load the ToothGrowth data and perform some basic exploratory data analyses 
#

# Load dataset
toothgrowth <- data.frame(ToothGrowth)

# View data
View(toothgrowth)
# Table of Number of Observations by supp and dose
table(toothgrowth$supp,toothgrowth$dose)
# Summary of len
summary(toothgrowth$len)



#
### 2. Provide a basic summary of the data
#

# Table of len means by supp and dose
means <- tapply(toothgrowth$len, list(toothgrowth$supp, toothgrowth$dose), FUN = mean)
round(means,2)
# Table of len standard deviations by supp and dose
stdevs <- tapply(toothgrowth$len, list(toothgrowth$supp, toothgrowth$dose), FUN = sd)
round(stdevs,2)



#
### 3. Compare tooth growth by supp and dose
#

# Compute 95% confidence interval using Student T distribution with 9 d.f. 
ul_95 <- means + qt(0.975,9)*(stdevs/sqrt(10))
ll_95 <- means - qt(0.975,9)*(stdevs/sqrt(10))

# Lower limits
round(ll_95,2)
# Upper limits
round(ul_95,2)
