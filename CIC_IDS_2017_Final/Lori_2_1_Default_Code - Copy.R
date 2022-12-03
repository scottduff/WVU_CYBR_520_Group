install.packages('caret')
install.packages('rpart.plot')
library(caret)
library(e1071)
library(rpart)
library(rpart.plot)
set.seed(4242) 

Dataset <- read.csv("C:\\Users\\lsine\\OneDrive\\Desktop\\Friday-WorkingHours-Afternoon-DDos.pcap_ISCX.csv", sep = ",")
dataset$x <- NULL

# Remove columns that total zero (0), function
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
datasetfeatures10 <- dataset[importantfeatures10]

trainIndex <- createDataPartition(datasetfeatures10$Label, p=0.70, list = FALSE)

Train <- datasetfeatures10[ trainIndex, ]
Test <- datasetfeatures10[-trainIndex, ]

treemodel <- rpart(datasetfeatures10, data = Train)
treeplot <- rpart.plot(treemodel)
treemodel$variable.importance

Prediction <- predict(treemodel, Test, type = 'prob')
Prediction
Confmatrix <- table(Test$type, Prediction)

treemodel <- train(Label~., data = train, method = "RF", tuneLength = 10, trControl = trainCtrl, metric = "Accuracy")

