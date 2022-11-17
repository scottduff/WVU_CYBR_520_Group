#Lab #4

#The first time you run this code, un-comment the two next lines to install the packages
install.packages('caret')
install.packages('e1071')

#load libraries
library(caret)
library(e1071)

#get data from t a local location
spambase <- read.csv('D:/google-mix/WVU/MIS/CYBR 520/Labs/Lab3/spambase.csv' , sep = ',')
set.seed(42)   


#Training and Testing Splitting Function
trainIndex <- createDataPartition(spambase$type, p=0.70, list=FALSE)

#70% of the Spambase Data becomes "the training dataset"
train <- spambase[ trainIndex, ]

#30% of the Spambase Data becomes "the testing dataset"
test <- spambase[-trainIndex, ]

# create and set the grid search
svmGrid <- expand.grid(sigma = 
           c(0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1), C = c(0.25, 0.5, 1, 2, 4, 8, 16, 32, 64, 128))


# setup cross validation
trainctrl <- trainControl(method = "cv", number = 10, verboseIter = TRUE)

# setup the SVM model
svm.model <- train(type~., data=train, method="svmRadial",
                   trControl = trainctrl, tuneGrid = svmGrid)


svm.model$times



#----------------------------Feed Forward Network ----------------------------------------
# random seed
set.seed(42)
# setup cross validation
trainctrl <- trainControl(method = "cv", number = 10, verboseIter = TRUE)

# setup neural network
nnet.model <- train(type~., data=train, method="nnet",
                    tuneLength = 10,
                    trControl = trainctrl,
                    metric="Accuracy")

# test the model using test dataset
nnet.predict <- predict(nnet.model, test)

# display the confusion matrix
confusionMatrix(nnet.predict, as.factor(test$type), mode = "prec_recall")

nnet.model$results


plot(y=nnet.model$results$Accuracy,x=nnet.model$results$decay,
     ylab="Observed Accuracy",
     xlab="Decay")

plot()
nnet.model$results

plot(nnet.model)
