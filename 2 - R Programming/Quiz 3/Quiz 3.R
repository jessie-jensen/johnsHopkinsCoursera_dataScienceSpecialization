library(datasets)
data(iris)
?iris

summary(iris)

#mean(iris$Sepal.Length)

mean(iris$Sepal.Length[iris$Species == "virginica"])

#colMeans(iris[,1:4])
#rowMeans(iris[, 1:4])
#apply(iris, 1, mean)
?apply

apply(iris[,1:4],2,mean)


##############

library(datasets)
data(mtcars)
?mtcars

summary(mtcars)

tapply(mtcars$mpg,mtcars$cyl,mean)

with(mtcars, tapply(mpg, cyl, mean))

# lapply(mtcars, mean)
# tapply(mtcars$cyl, mtcars$mpg, mean)
# mean(mtcars$mpg, mtcars$cyl)

mean_hp <- with(mtcars,tapply(hp,cyl,mean))

abs(mean(mtcars$hp[mtcars$cyl==4])-mean(mtcars$hp[mtcars$cyl==8]))

debug(ls)
ls
