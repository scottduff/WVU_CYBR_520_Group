#install.packages('caret')
#install.packages('rpart.plot')
library(caret)
library(rpart)
library(rpart.plot)

spambase <- read.csv('D:/google-mix/WVU/MIS/CYBR 520/Labs/Lab2/spambase.csv' , sep = ',')

spambase$x <- NULL   

set.seed(42)

#Training and Testing Splitting Function
trainIndex <- createDataPartition(spambase$type, p=0.70, list=FALSE)

#70% of the Spambase Data becomes "the training dataset"
Train <- spambase[ trainIndex, ]

#30% of the Spambase Data becomes "the testing dataset"
Test <- spambase[-trainIndex, ]

#Build the Decision Tree model
treemodel <- rpart(type~., data = Train)

#Visualize the treemodel
treeplot <- rpart.plot(treemodel)

#fit into screen
treeplot <- rpart.plot(treemodel, compress = 1, varlen = 5, tweak = 1.2, digits = 2)

#View importance of features
treemodel$variable.importance

Prediction <- predict(treemodel, Test, type = 'class')  

Prediction

#Get the confusion matrix
Confmatrix <- table(Test$type, Prediction)


Confmatrix 


#One way of getting the Accuracy of the model
Acc <- (sum(diag(Confmatrix)) / sum(Confmatrix)*100)
Acc

#You may even extract single values from eh confusion matrix to calculate try other performance metrics
TN=Confmatrix[1]
FN=Confmatrix[2]
FP=Confmatrix[3]
TP=Confmatrix[4]

Accuracy <- (TP+TN)/sum(Confmatrix)*100
Precision <- (TP/ (TP+FP))*100
Recall <- (TP/(TP+FN))*100
omFPR <- (1-(FP/(FP+TN)))*100
Fscore <- 2*(Precision*Recall)/(Precision+Recall)
Gscore <- 2*Recall*(omFPR)/(Recall+omFPR)

Accuracy
Precision
Recall
omFPR
Fscore
Gscore

