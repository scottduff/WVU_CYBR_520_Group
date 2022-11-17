

library(datasets)
install.packages('ggplot2')
data(iris)

head(iris)

summary(iris)

library(ggplot2)

irissepalplot <- ggplot(data=iris, aes(x = Sepal.Length, y = Sepal.Width)) + geom_point(aes(color=Species, shape=Species)) 

irissepalplot


irissepalplot <- ggplot(data=iris, aes(x = Petal.Length, y = Petal.Width)) + geom_point(aes(color=Species, shape=Species)) 
irissepalplot

spambase <- read.csv('./filename.csv' , sep = ',')
