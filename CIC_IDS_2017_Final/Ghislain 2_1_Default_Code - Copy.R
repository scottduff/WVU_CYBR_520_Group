library(caret)
library(e1071)

set.seed(4242)

dataset <- read.csv("C:\\Users\\ajghi\\OneDrive\\Documents\\GitHub\\WVU_CYBR_520_Group_1\\CIC_IDS_2017_Final\\MachineLearningCVE\\Friday-WorkingHours-Afternoon-DDos.pcap_ISCX.csv", sep = ",")
dataset$x <- NULL

# Remove columns that total zero (0), function.
only_zeros <- function(x) {
  if(class(x) %in% c("integer", "numeric")) {
    all(x == 0, na.rm = TRUE) 
  } else { 
    FALSE
  }
}

# Apply the only_Zero function to the dataset
dataset_nozero <- dataset[ , !sapply(dataset, only_zeros)]

# Configure dataset with features selected in 1_0_Feature Selection_Code.R
importantfeatures10 <- c("Bwd.Packet.Length.Mean", "Avg.Bwd.Segment.Size", 
                         "Bwd.Packet.Length.Max", "Bwd.Packet.Length.Std", 
                         "Destination.Port", "URG.Flag.Count", 
                         "Packet.Length.Mean", "Average.Packet.Size", 
                         "Packet.Length.Std", "Min.Packet.Length", "Label")

# Dataset with selected features and features with columns with totals of zero (0).
datasetfeatures10 <- dataset_nozero[importantfeatures10]
knn3.model <- train(Label~. , data=train, method="knn3",
                   tuneLength = 10,
                   trControl = trainctrl ,
                   metric="Accuracy")
rpart.model <- train(Label~., data=train, method="rpart", tuneLength =10, trControl = trainctrl , metric="Accuracy")
install.packages("caret")
library(caret)
rpart.model <- train(Label~., data=train, method="rpart", tuneLength =10, trControl = trainctrl , metric="Accuracy")
install.packages("earth")
bagFDA.model <- train(Label~., data = train, method="bagFDA", tuneLength = 10, trControl = trainctrl , metric="Accuracy")
install.packages("mda")
library(earth)
library(mda)
bagFDA.model <- train(Label~., data = train, method="bagFDA", tuneLength = 10, trControl = trainctrl , metric="Accuracy")
set.seed(4242)
trainctrl <- trainControl(method = "cv", number = 10, verboseIter = TRUE)
bagFDA.model <- train(Label~., data = train, method="bagFDA", tuneLength = 10, trControl = trainctrl , metric="Accuracy")
trainIndex <- createDataPartition(datasetfeatures10$Label, p = 0.70, list = FALSE)
train <- datasetfeatures10[ trainIndex, ]
test <- datasetfeatures10[-trainIndex, ]
bagFDA.model <- train(Label~., data = train, method="bagFDA", tuneLength = 10, trControl = trainctrl , metric="Accuracy")
