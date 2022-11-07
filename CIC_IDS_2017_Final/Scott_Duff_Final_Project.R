library(caret)
library(e1071)

set.seed(4242)

cicids2017 <- read.csv("C:\\Users\\duffa\\OneDrive\\Documents\\GitHub\\WVU_CYBR_520_Group_1\\CIC_IDS_2017_Final\\MachineLearningCVE\\Friday-WorkingHours-Afternoon-DDos.pcap_ISCX.csv", sep = ",")
cicids2017$x <- NULL

i <- (colSums(cicids2017, na.rm=T) != 0)
cicids2017_Reduced <- cicids2017[, i]







#cicids2017trainIndex <- createDataPartition(cicids2017$Label, p = 0.70, list = FALSE)
#cicids2017train <- cicids2017[ cicids2017trainIndex, ]
#cicids2017test <- cicids2017[-cicids2017trainIndex, ]

#trainCtrl <- trainControl(method = "cv", number = 10, verboseIter = TRUE)


#svm.cicids2017Model <- train(Label~., data = cicids2017train, method = "svmRadial", tuneLength = 10, trControl = trainCtrl, metric = "Accuracy")

