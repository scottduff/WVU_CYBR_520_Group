library(caret)
library(e1071)

set.seed(4242)

# Configure Directory Path on a Per User Basis
dataset <- read.csv("C:\\Users\\duffa\\OneDrive\\Documents\\GitHub\\WVU_CYBR_520_Group_1\\CIC_IDS_2017_Final\\MachineLearningCVE\\Friday-WorkingHours-Afternoon-DDos.pcap_ISCX.csv", sep = ",")
dataset$x <- NULL

# Configure dataset with features selected in 1_0_Feature Selection_Code.R
importantfeatures10 <- c("Bwd.Packet.Length.Mean", "Avg.Bwd.Segment.Size", 
                         "Bwd.Packet.Length.Max", "Bwd.Packet.Length.Std", 
                         "Destination.Port", "URG.Flag.Count", 
                         "Packet.Length.Mean", "Average.Packet.Size", 
                         "Packet.Length.Std", "Min.Packet.Length", "Label")

# Dataset with selected features.
datasetfeatures10 <- dataset[importantfeatures10]

#SVM Setup and Model Creation
trainIndex <- createDataPartition(datasetfeatures10$Label, p = 0.70, list = FALSE)
train <- datasetfeatures10[ trainIndex, ]
test <- datasetfeatures10[-trainIndex, ]

trainCtrl <- trainControl(method = "cv", number = 10, verboseIter = TRUE)

svm.model <- train(Label~., data = train, method = "svmRadial", tuneLength = 10, trControl = trainCtrl, metric = "Accuracy")

svm.predict <- predict(svm.model, test)
modelpredict <- confusionMatrix(svm.predict, as.factor(test$Label), mode = "prec_recall")

modelpredict
svm.predict
svm.model$times
svm.model$results
