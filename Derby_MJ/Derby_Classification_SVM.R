# The first time you run this code, un-comment the two next lines to install the package
#install.packages('caret')
#install.packages('rpart.plot')

# Get the needed packages
library(caret)
library(rpart)
library(rpart.plot)

# Read the data from the csv file
derby <- read.csv('D:/google-mix/WVU/MIS/CYBR 520/Labs/Lab2/DERBY5.csv' , sep = ',')

# Random seed, you may try other numbers
set.seed(42)

#Training and Testing Splitting Function
#The column "bug" is my response (dependent) variable
#I am using 70% of the data for training
trainIndex <- createDataPartition(derby$bug, p=0.70, list=FALSE)

#70% of the Spambase Data becomes "the training dataset"
Train <- derby[ trainIndex, ]

#30% of the Spambase Data becomes "the testing dataset"
Test <- derby[-trainIndex, ]


trainCtrl<-trainControl(method = "cv",number = 10, verboseIter = TRUE)

svm.model <- train(as.factor(bug)~., data=Train, method="svmRadial",tuneLength=10,trControl = trainCtrl,metric="Accuracy")

svm.predict <- predict(svm.model, Test)

Confmatrix=confusionMatrix(svm.predict, as.factor(Test$bug), mode="prec_recall")

Confmatrix

svm.model$times

