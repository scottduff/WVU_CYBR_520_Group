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

# find attributes that are highly corrected (ideally >0.75)
highlyCorrelated <- findCorrelation(correlationMatrix, cutoff=0.5,verbose = FALSE,names = TRUE )
print(highlyCorrelated)

set.seed(7)
control <- trainControl(method="repeatedcv", number=10, repeats=3)
model <- train(as.factor(type)~., data=dataset, method="lvq", preProcess="scale", trControl=control)

importance <- varImp(model, scale=FALSE)
print(importance)
plot(importance)

#Recursive Feature Elimination (RFE)

set.seed(7)
control <- rfeControl(functions=rfFuncs, method="cv", number=10)
#results <- rfe(dataset[,1:31], dataset[,32], sizes=c(1:31), rfeControl=control)
results <- rfe(dataset[,1:56], dataset[,57], sizes=c(1:56), rfeControl=control)


print(results)
predictors(results)
plot(results, type=c("g", "o"))

rfimportance <- varImp(results, scale=FALSE)
print(rfimportance)


