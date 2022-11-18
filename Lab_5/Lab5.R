#Lab #5
#Code is publicly available @ https://machinelearningmastery.com/feature-selection-with-the-caret-r-package/


#The first time you run this code, un-comment the two next lines to install the packages
#install.packages('caret')
#install.packages('e1071')
#install.packages("randomForest")
#install.packages('mlbench')
#install.packages('Hmisc')
#install.packages('corrplot')
#install.packages('ggcorrplot')
#install.packages('https://cran.r-project.org/src/contrib/Archive/randomForest/', repos=NULL, type="source") 


#load libraries
library(caret)
library(e1071)
library(mlbench)
library(caret)
library(randomForest)
library(Hmisc)
library(corrplot)
library(ggcorrplot)

set.seed(7)
dataset <- read.csv('C:\\Users\\duffa\\OneDrive\\Desktop\\CYBR 520\\labs\\lab 5\\spambase.csv' , sep = ',')
dataset$x <- NULL

questionsixdataset <- read.csv('C:\\Users\\duffa\\OneDrive\\Desktop\\CYBR 520\\labs\\lab 5\\spambase.csv' , sep = ',')
questioneightdataset <- read.csv('C:\\Users\\duffa\\OneDrive\\Desktop\\CYBR 520\\labs\\lab 5\\spambase.csv' , sep = ',')
spambase <- read.csv('C:\\Users\\duffa\\OneDrive\\Desktop\\CYBR 520\\labs\\lab 5\\spambase.csv' , sep = ',')

questionsixvariables <- c("charExclamation", "your", "num000", "remove", 
                          "charDollar", "you", "free", "business", "hp", 
                          "capitalTotal", "our", "receive", "hpl", "over", 
                          "order", "money", "capitalLong", "internet", 
                          "email", "all", "type")

questioneightvariables <- c("capitalLong", "report", "order", "num1999", 
                            "charHash", "type")

questionsixselectedfeatures <- questionsixdataset[questionsixvariables]
questioneightselectedfeatures <- questioneightdataset[questioneightvariables]


dataset[dataset =='nonspam'] <- as.numeric(0)              
dataset[dataset =='spam'] <- as.numeric(1)                 
dataset$type = as.numeric(dataset$type)                    
str(dataset)

correlationMatrix <- cor(dataset[,1:58])

print(correlationMatrix)
print(correlationMatrix[58,])

visCorMatrix1 <- corrplot(cor(dataset))
visCorMatrix2 <-ggcorrplot(cor(dataset))
visCorMatrix2

#Learning Vector Quantization Learning (LVQ)
highlyCorrelated <- findCorrelation(correlationMatrix, cutoff=0.5, 
                                    verbose = FALSE, names = TRUE )

print(highlyCorrelated)
set.seed(7)

control <- trainControl(method="repeatedcv", number=10, repeats=3)

model <- train(as.factor(type)~., data=dataset, method="lvq", 
               preProcess="scale", trControl=control)

importance <- varImp(model, scale=FALSE)

print(importance)
plot(importance)

#Recursive Feature Elimination (RFE)
set.seed(7)

control <- rfeControl(functions=rfFuncs, method="cv", number=10)

results <- rfe(dataset[,1:56], dataset[,57], sizes=c(1:56), rfeControl=control)

print(results)

predictors(results)

plot(results, type=c("g", "o"))

rfimportance <- varImp(results, scale=FALSE)

print(rfimportance)

# Question 6, Selected Features
set.seed(42)

sixtrainIndex <- createDataPartition(questionsixselectedfeatures$type, p = 0.70, 
                                     list = FALSE)

sixtrain <- questionsixselectedfeatures[ sixtrainIndex, ]
sixtest <- questionsixselectedfeatures[-sixtrainIndex, ]

sixtrainCtrl <- trainControl(method = "cv", number = 10, verboseIter = TRUE)

sixsvm.model <- train(type~., data = sixtrain, method = "svmRadial", 
                      tuneLength = 10, trControl = sixtrainCtrl, 
                      metric = "Accuracy")

sixsvm.predict <- predict(sixsvm.model, sixtest)

sixmodelpredict <- confusionMatrix(sixsvm.predict, as.factor(sixtest$type), 
                                   mode = "prec_recall")
sixmodelpredict

# Question 8, Selected Features
set.seed(42)

eighttrainIndex <- createDataPartition(questioneightselectedfeatures$type, 
                                       p = 0.70, list = FALSE)

eighttrain <- questioneightselectedfeatures[ eighttrainIndex, ]
eighttest <- questioneightselectedfeatures[-eighttrainIndex, ]

eighttrainCtrl <- trainControl(method = "cv", number = 10, verboseIter = TRUE)

eightsvm.model <- train(type~., data = eighttrain, method = "svmRadial", 
                        tuneLength = 10, trControl = sixtrainCtrl, 
                        metric = "Accuracy")

eightsvm.predict <- predict(eightsvm.model, eighttest)

eightmodelpredict <- confusionMatrix(eightsvm.predict, 
                                     as.factor(eighttest$type), 
                                     mode = "prec_recall")
eightmodelpredict

# Spambase Full Dataset
set.seed(42)
trainIndex <- createDataPartition(spambase$type, p = 0.70, list = FALSE)

train <- spambase[ trainIndex, ]
test <- spambase[-trainIndex, ]

trainCtrl <- trainControl(method = "cv", number = 10, verboseIter = TRUE)

svm.model <- train(type~., data = train, method = "svmRadial", tuneLength = 10, 
                   trControl = trainCtrl, metric = "Accuracy")
svm.predict <- predict(svm.model, test)

modelpredict <- confusionMatrix(svm.predict, as.factor(test$type), 
                                mode = "prec_recall")

modelpredict
