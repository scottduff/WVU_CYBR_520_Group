library(caret)
library(e1071)

set.seed(4242)

cicids2017 <- read.csv("C:\\Users\\duffa\\OneDrive\\Documents\\GitHub\\WVU_CYBR_520_Group_1\\CIC_IDS_2017_Final\\MachineLearningCVE\\Friday-WorkingHours-Afternoon-DDos.pcap_ISCX.csv", sep = ",")
cicids2017$x <- NULL

# Selects Columns that total Zero.
only_zeros <- function(x) {
  if(class(x) %in% c("integer", "numeric")) {
    all(x == 0, na.rm = TRUE) 
  } else { 
    FALSE
  }
}

# Removes columns that total Zero
cicids2017RemoveZeroCol <- cicids2017[ , !sapply(cicids2017, only_zeros)]

write.csv(cicids2017RemoveZeroCol,"C:\\Users\\duffa\\Documents\\export.csv", row.names = FALSE)


# The results of this command
# table(cicids2017RemoveZeroCol$Label)
# BENIGN   DDoS 
# 97718    128027 


#cicids2017trainIndex <- createDataPartition(cicids2017$Label, p = 0.70, list = FALSE)
#cicids2017train <- cicids2017[ cicids2017trainIndex, ]
#cicids2017test <- cicids2017[-cicids2017trainIndex, ]

#trainCtrl <- trainControl(method = "cv", number = 10, verboseIter = TRUE)


#svm.cicids2017Model <- train(Label~., data = cicids2017train, method = "svmRadial", tuneLength = 10, trControl = trainCtrl, metric = "Accuracy")

