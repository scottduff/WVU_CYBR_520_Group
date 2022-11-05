library(caret)
library(e1071)

# I have this here for testing and comparison, since I know this works
spambase <- read.csv("C:\\Users\\duffa\\OneDrive\\Documents\\GitHub\\WVU_CYBR_520_Group_1\\CIC_IDS_2017_Final\\spambase.csv", sep = ",")

cicids2017 <- read.csv("C:\\Users\\duffa\\OneDrive\\Documents\\GitHub\\WVU_CYBR_520_Group_1\\CIC_IDS_2017_Final\\MachineLearningCVE\\Friday-WorkingHours-Afternoon-DDos.pcap_ISCX.csv", sep = ",")



# I have this here for testing and comparison, since I know this works
spambase$x <- NULL
cicids2017$x <- NULL

set.seed(4242)

# I have this here for testing and comparison, since I know this works
spambasetrainIndex <- createDataPartition(spambase$type, p = 0.70, list = FALSE)
spambasetrain <- spambase[ spambasetrainIndex, ]
spambasetest <- spambase[-spambasetrainIndex, ]

cicids2017trainIndex <- createDataPartition(cicids2017$Label, p = 0.70, list = FALSE)
cicids2017train <- cicids2017[ cicids2017trainIndex, ]
cicids2017test <- cicids2017[-cicids2017trainIndex, ]

trainCtrl <- trainControl(method = "cv", number = 10, verboseIter = TRUE)

# I have this here for testing and comparison, since I know this works
svm.spambaseModel <- train(type~., data = spambasetrain, method = "svmRadial", tuneLength = 10, trControl = trainCtrl, metric = "Accuracy")

svm.cicids2017Model <- train(Label~., data = cicids2017train, method = "svmRadial", tuneLength = 10, trControl = trainCtrl, metric = "Accuracy")

# This is the error Im getting
#Error in na.fail.default(list(Label = c("BENIGN", "BENIGN", "BENIGN",  : 
#                                          missing values in object