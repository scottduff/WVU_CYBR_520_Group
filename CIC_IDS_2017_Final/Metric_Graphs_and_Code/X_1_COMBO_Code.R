library(caret)
library(e1071)
library(class)
library(rpart)


set.seed(4242)

dataset <- read.csv("C:\\Users\\duffa\\OneDrive\\Documents\\GitHub\\WVU_CYBR_520_Group_1\\CIC_IDS_2017_Final\\MachineLearningCVE\\Friday-WorkingHours-Afternoon-DDos.pcap_ISCX.csv", sep = ",")
dataset$x <- NULL

# Remove columns that total zero (0), function.
only_zeros <- function(x) {
  if(class(x) %in% c("integer", "numeric")) {
    all(x == 0, na.rm = TRUE) 
  } else { 
    FALSE
  }
}

# Apply the only_Zero function to the dataset.
dataset_nozero <- dataset[ , !sapply(dataset, only_zeros)]

# Configure dataset with features selected in 1_0_Feature Selection_Code.R
importantfeatures10 <- c("Bwd.Packet.Length.Mean", "Avg.Bwd.Segment.Size", 
                         "Bwd.Packet.Length.Max", "Bwd.Packet.Length.Std", 
                         "Destination.Port", "URG.Flag.Count", 
                         "Packet.Length.Mean", "Average.Packet.Size", 
                         "Packet.Length.Std", "Min.Packet.Length", "Label")

# Dataset with selected features and features with columns with totals of zero (0).
datasetfeatures10 <- dataset_nozero[importantfeatures10]

#SVM Setup and Model Creation
trainIndex <- createDataPartition(datasetfeatures10$Label, p = 0.70, list = FALSE)
train <- datasetfeatures10[ trainIndex, ]
test <- datasetfeatures10[-trainIndex, ]

trainCtrl <- trainControl(method = "cv", number = 10, verboseIter = TRUE)

svm.model <- train(Label~., data = train, method = "svmRadial", tuneLength = 10, trControl = trainCtrl, metric = "Accuracy")

svm.predict <- predict(svm.model, test)
svm.modelpredict <- confusionMatrix(svm.predict, as.factor(test$Label), mode = "prec_recall")

svm.modelpredict
svm.predict
svm.model$times
svm.model$results

rf.model <- train(Label~., data = train, method = "rf", tuneLength = 10, trControl = trainCtrl, metric = "Accuracy")

rf.predict <- predict(rf.model, test)
rf.modelpredict <- confusionMatrix(rf.predict, as.factor(test$Label), mode = "prec_recall")

rf.modelpredict
rf.predict
rf.model$times
rf.model$results

#bagFDA.model <- train(Label~., data = train, method = "bagFDA", tuneLength = 10, trControl = trainCtrl, metric = "Accuracy")

bagFDA.predict <- predict(bagFDA.model, test)
bagFDA.modelpredict <- confusionMatrix(bagFDA.predict, as.factor(test$Label), mode = "prec_recall")

bagFDA.modelpredict
bagFDA.predict
bagFDA.model$times
bagFDA.model$results

#gbm.model <- train(Label~., data = train, method = "gbm", tuneLength = 10, trControl = trainCtrl, metric = "Accuracy")

gbm.predict <- predict(gbm.model, test)
gbm.modelpredict <- confusionMatrix(gbm.predict, as.factor(test$Label), mode = "prec_recall")

gbm.modelpredict
gbm.predict
gbm.model$times
gbm.model$results

#nb.model <- train(Label~., data = train, method = "naive_bayes", tuneLength = 10, trControl = trainCtrl, metric = "Accuracy")

nb.predict <- predict(nb.model, test)
nb.modelpredict <- confusionMatrix(nb.predict, as.factor(test$Label), mode = "prec_recall")

nb.modelpredict
nb.predict
nb.model$times
nb.model$results$Accuracy

# Accuracy Precision Recall F1
svm.modelpredict
rf.modelpredict
gbm.modelpredict
bagFDA.modelpredict
nb.modelpredict

boxplot(svm.modelpredict$byClass[5], rf.modelpredict$byClass[5], gbm.modelpredict$byClass[5], bagFDA.modelpredict$byClass[5], nb.modelpredict$byClass[5], col = c("blue", "red", "green", "pink", "orange"), 
        names = c("svmRadial", "rf", "gbm", "bagFDA", "nb"), 
        border  = c("blue", "red", "green", "pink", "orange"), ylab = "Precision", main = "Precision Comparison")

boxplot(svm.modelpredict$byClass[6], rf.modelpredict$byClass[6], gbm.modelpredict$byClass[6], bagFDA.modelpredict$byClass[6], nb.modelpredict$byClass[6], col = c("blue", "red", "green", "pink", "orange"), 
        names = c("svmRadial", "rf", "gbm", "bagFDA", "nb"), 
        border  = c("blue", "red", "green", "pink", "orange"), ylab = "Recall", main = "Recall Comparison")

boxplot(svm.modelpredict$byClass[7], rf.modelpredict$byClass[7], gbm.modelpredict$byClass[7], bagFDA.modelpredict$byClass[7], nb.modelpredict$byClass[7], col = c("blue", "red", "green", "pink", "orange"), 
        names = c("svmRadial7", "rf7", "gbm7", "bagFDA7", "nb7"), 
        border  = c("blue", "red", "green", "pink", "orange"), ylab = "F1 Score", main = "F1 Score Comparison")

boxplot(svm.model$results$Accuracy, rf.model$results$Accuracy, gbm.model$results$Accuracy, bagFDA.model$results$Accuracy, nb.model$results$Accuracy, col = c("blue", "red", "green", "pink", "orange"), 
        names = c("svmRadial7", "rf7", "gbm7", "bagFDA7", "nb7"), 
        border  = c("blue", "red", "green", "pink", "orange"), ylab = "Accuracy", main = "Accuracy Comparison")

boxplot(svm.model$times$everything[3], rf.model$times$everything[3], gbm.model$times$everything[3], bagFDA.model$times$everything[3], nb.model$times$everything[3], col = c("blue", "red", "green", "pink", "orange"), 
        names = c("svmRadial", "rf", "gbm", "bagFDA", "nb"), 
        border  = c("blue", "red", "green", "pink", "orange"), ylab = "Elapsed Time", main = "Elapsed Time Comparison")




