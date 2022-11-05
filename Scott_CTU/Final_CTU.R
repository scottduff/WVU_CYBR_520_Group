library(caret)
library(e1071)
library(ggplot2)
library(lattice)
library(kernlab)
library(Matrix)
library(rpart)
library(rpart.plot)

ctuCore <- read.csv("C:\\CTU13\\CTU-13-binetflow\\scenarios_1.csv", sep = ",")

set.seed(42)

trainIndex <- createDataPartition(ctuCore$Malicious, p = 0.70, list = FALSE)

train <- ctuCore[ trainIndex, ]
test <- ctuCore[-trainIndex, ]

trainData <- model.matrix(train)

trainCtrl <- trainControl(method = "cv", number = 10, verboseIter = TRUE)

ctuCore.model <- train(type~., data = train, method = "glm", tuneLength = 10, trControl = trainCtrl, metric = "Accuracy")

treemodel <- rpart(type~., data = train)
