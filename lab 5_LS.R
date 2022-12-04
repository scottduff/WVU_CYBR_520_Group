install.packages('caret')
install.packages('rpart.plot')
install.packages('hmisc')
install.packages('Hmisc')
install.packages('ggcorrplot')
install.packages('randomForest')
install.packages("corrplot")

library(caret)
library(rpart)
library(rpart.plot)
library('Hmisc')
library('ggcorrplot')
library('e1071')
library('corrplot')
library('ggcorrplot')

dataset <- read.csv('c:/users/lsine/onedrive/desktop/DERBY5.csv' , sep = ',')

dataset$x <- NULL

set.seed (42)
questionsixdataset <- read.csv('c:/users/lsine/onedrive/desktop/DERBY5.csv' , sep = ',')
questioneightdataset <- read.csv('c:/users/lsine/onedrive/desktop/DERBY5.csv' , sep = ',')
questionsixvariables <- c("wmc", "dit", "noc", "cbo", "rfc", "Icom",
                          "ca", "ce", "npm", "Icom3","Ioc",
                          "moa",cam","ic","cbm", "amc")
questioneightvariables <- c("cc", "max_cc", "sum_locp", "max_locm",
                            "no_rev","sum_chrn")
dataset[dataset=='nonspam'] <- as.numeric(0)
dataset[dataset =='spam'] <- as.numeric(1)
dataset$type = as.numeric(dataset$type)
str(dataset)
correlationMatrix <- cor(dataset[,1:33])
print(correlationMatrix)
trainIndex <- createDataPartition(DERBY5$type, p=0.70, list = FALSE)
Train <- DERBY5[ TrainIndex ]
Test <- DERBY5[-trainIndex, ]
treemodel <- rpart(type~., data = Train)
treeplot <- rpart.plot(treemodel)
treeplot <- rpart.plot(treemodel, compress = 1, varlen = 5, tweak = 1.2, digits = 2)
treemodel$variable.importance
prediction <- predict(treemodel, Test, type = 'class')
prediction
confmatrix <- table(Test$type, Prediction)
confmatrix <- table(Test$type, prediction)
confmatrix
svm.predict <- predict(svm.model, test)
confusionMatrix(svm,.predict, as.factor(test$type), mode = "prec_recall")

