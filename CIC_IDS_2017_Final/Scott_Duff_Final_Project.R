library(caret)
library(e1071)
library(ggplot2)

# I have this here for testing and comparison, since I know this works
#spambase <- read.csv("C:\\Users\\duffa\\OneDrive\\Desktop\\CYBR 520\\Final_Project\\spambase.csv", sep = ",")

cicids2017 <- read.csv("C:\\Users\\duffa\\OneDrive\\Desktop\\CYBR 520\\Final_Project\\MachineLearningCVE\\Friday-WorkingHours-Afternoon-DDos.pcap_ISCX.csv", sep = ",")


# I have this here for testing and comparison, since I know this works
#spambase$x <- NULL

cic$x <- NULL

set.seed(4242)

# I have this here for testing and comparison, since I know this works
#spamtrainIndex <- createDataPartition(spambase$type, p = 0.70, list = FALSE)
#spamtrain <- spambase[ spamtrainIndex, ]
#spamtest <- spambase[-spamtrainIndex, ]

cictrainIndex <- createDataPartition(cicids2017$Label, p = 0.70, list = FALSE)
cicids2017train <- cic[ cicids2017trainIndex, ]
cicids2017test <- cic[-cicids2017trainIndex, ]



trainCtrl <- trainControl(method = "cv", number = 10, verboseIter = TRUE)

# I have this here for testing and comparison, since I know this works
#svm.spamModel <- train(type~., data = spamtrain, method = "svmRadial", tuneLength = 10, trControl = trainCtrl, metric = "Accuracy")

svm.cicids2017Model <- train(Label~., data = cicids2017train, method = "svmRadial", tuneLength = 10, trControl = trainCtrl, metric = "Accuracy")
