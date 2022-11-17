#Lab #3

#The first time you run this code, un-comment the two next lines to install the packages
#install.packages('caret')
#install.packages('e1071')

#load libraries
library(caret)
library(e1071)

getwd()

# set working directory to my Lab3 directory
setwd("D:/google-mix/WVU/MIS/CYBR 520/Labs/Lab3")

#get data from t a local location
spambase <- read.csv('./spambase.csv' , sep = ',')
set.seed(42)   


#Training and Testing Splitting Function
trainIndex <- createDataPartition(spambase$type, p=0.70, list=FALSE)

#70% of the Spambase Data becomes "the training dataset"
train <- spambase[ trainIndex, ]

#30% of the Spambase Data becomes "the testing dataset"
test <- spambase[-trainIndex, ]

set.seed(42)
trainctrl <- trainControl(method = "cv", number = 10, verboseIter = TRUE)

#Build the SVM supervised ML  classifier
svm.model <- train(type~., data=train, method="svmRadial",
                   tuneLength = 10,
                   trControl = trainctrl,
                   metric="Accuracy")




#See how long it took to run the model
svm.model$times

#View the values of different classification performance metrics when using different C values
svm.model$results


#Set the SVM classifier to predict the observations in the testing portion of the data 
svm.predict <- predict(svm.model, test)

#Show the results of the classification
confusionMatrix(svm.predict, as.factor(test$type), mode = "prec_recall")

svm.model$results

class(svm.model$results)


plot(y=svm.model$results$Accuracy,x=svm.model$results$C,
     ylab="Observed Accuracy",
     xlab="Cost Parameter")



plot(svm.model)

#-----------------------------------KNN-----------------------------------------

#Build the SVM supervised ML  classifier
knn.model <- train(type~., data=train, method="knn",
                   tuneLength = 10,
                   trControl = trainctrl,
                   metric="Accuracy")




#See how long it took to run the model
knn.model$times

#View the values of different classification performance metrics when using different C values
knn.model$results


#Set the SVM classifier to predict the observations in the testing portion of the data 
knn.predict <- predict(knn.model, test)

#Show the results of the classification
confusionMatrix(knn.predict, as.factor(test$type), mode = "prec_recall")

knn.model$results

class(knn.model$results)


plot(x=knn.model$results$Accuracy,y=knn.model$results$k,
     xlab="Observed Accuracy",
     ylab="Neighbour")


plot(knn.model)
