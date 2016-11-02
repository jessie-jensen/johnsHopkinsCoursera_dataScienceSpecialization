setwd("C:/Users/Josh/Dropbox/R/Coursera - Data Science Certificate/6 - Statistical Inference")

# Question 1
# A pharmaceutical company is interested in testing a potential blood pressure lowering medication. Their first examination considers only subjects that received the medication at baseline then two weeks later. The data are as follows (SBP in mmHg)
# Subject	Baseline	Week 2
# 1	140	132
# 2	138	135
# 3	150	151
# 4	148	146
# 5	135	130
# Consider testing the hypothesis that there was a mean reduction in blood pressure? Give the P-value for the associated two sided T test.

q1data <- read.csv("quiz4_q1.csv")

t.test(q1data$Baseline, q1data$Week.2, paired = TRUE)


# Question 2
# A sample of 9 men yielded a sample average brain volume of 1,100cc and a standard deviation of 30cc. What is the complete set of values of ??0 that a test of H0:??=??0 would fail to reject the null hypothesis in a two sided 5% Students t-test?

1100 + c(-1,1) * qt(0.975,8)*(30/sqrt(9))


# Question 3
# Researchers conducted a blind taste test of Coke versus Pepsi. Each of four people was asked which of two blinded drinks given in random order that they preferred. The data was such that 3 of the 4 people chose Coke. Assuming that this sample is representative, report a P-value for a test of the hypothesis that Coke is preferred to Pepsi using a one sided exact test.

choose(4,3)*.5^4 + choose(4,4)*.5^4

pbinom(2, size = 4, prob = .5, lower.tail = FALSE)


# Question 4
# Infection rates at a hospital above 1 infection per 100 person days at risk are believed to be too high and are used as a benchmark. A hospital that had previously been above the benchmark recently had 10 infections over the last 1,787 person days at risk. About what is the one sided P-value for the relevant test of whether the hospital is *below* the standard?

1-pbinom(10, size = 1787, prob = .01, lower.tail = FALSE)


# Question 5
# Suppose that 18 obese subjects were randomized, 9 each, to a new diet pill and a placebo. Subjects' body mass indices (BMIs) were measured at a baseline and again after having received the treatment or placebo for four weeks. The average difference from follow-up to the baseline (followup - baseline) was ???3 kg/m2 for the treated group and 1 kg/m2 for the placebo group. The corresponding standard deviations of the differences was 1.5 kg/m2 for the treatment group and 1.8 kg/m2 for the placebo group. Does the change in BMI appear to differ between the treated and placebo groups? Assuming normality of the underlying data and a common population variance, give a pvalue for a two sided t test.

(-3 - 1) + c(-1,1) * qt(0.95,16)*sqrt((1.5^2+1.8^2)/9)

(1-pt(4*(1/sqrt((1.5^2+1.8^2)/9)),16))*2


# Question 6
# Brain volumes for 9 men yielded a 90% confidence interval of 1,077 cc to 1,123 cc. Would you reject in a two sided 5% hypothesis test of H0:??=1,078?

WIDER, so no

# Question 7
# Researchers would like to conduct a study of 100 healthy adults to detect a four year mean brain volume loss of .01 mm3. Assume that the standard deviation of four year volume loss in this population is .04 mm3. About what would be the power of the study for a 5% one sided test versus a null hypothesis of no volume loss?

power.t.test(n = 100, 
             delta = .01,
             sd = .04,
             sig.level = 0.05,
             type = "one.sample",
             alternative = "one.sided")

# Question 8
# Researchers would like to conduct a study of n healthy adults to detect a four year mean brain volume loss of .01 mm3. Assume that the standard deviation of four year volume loss in this population is .04 mm3. About what would be the value of n needded for 90% power of type one error rate of 5% one sided test versus a null hypothesis of no volume loss?

power.t.test(n = NULL,
             delta = .01,
             sd = .04,
             power = .9,
             sig.level = .05,
             type = "one.sample",
             alternative = "one.sided")


power.t.test(n = 100, 
             delta = .01,
             sd = .04,
             sig.level = 0.1,
             type = "one.sample",
             alternative = "one.sided")
