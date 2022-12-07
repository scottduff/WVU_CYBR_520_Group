#install.packages("caTools")
install.packages("naivebayes")

#library(caret)
#library(e1071)
#library(caTools)

set.seed(4242)

dataset <- read.csv("C:\\Users\\Brian\\Documents\\GitHub\\WVU_CYBR_520_Group_1\\CIC_IDS_2017_Final\\MachineLearningCVE\\Friday-WorkingHours-Afternoon-DDos.pcap_ISCX.csv", sep = ",")
dataset$x <- NULL

# Remove columns that total zero (0), function.
only_zeros <- function(x) {if(class(x) %in% c("integer", "numeric")) {
    all(x == 0, na.rm = TRUE) } else {FALSE}}

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

set.seed(4242)

#Training and Testing Splitting Function
trainIndex <- createDataPartition(datasetfeatures10$Label, p=0.70, list = FALSE)

#70% of the datasetfeatures10 Data becomes "the training dataset"
train <- datasetfeatures10[trainIndex, ]

#30% of the datasetfeatures10 data becomes "the testing dataset"
test <- datasetfeatures10[-trainIndex, ]

trainCtrl <- trainControl(method = "cv", number = 10, verboseIter = TRUE)

nb.model <-train(Label~., data = train, method = "naive_bayes", tuneLength = 10, trControl = trainCtrl, metric = "Accuracy", verbose = FALSE)

nb.predict <-predict(nb.model, test)

modelpredict <-confusionMatrix(nb.predict, as.factor(test$Label), mode = "prec_recall")

modelpredict

nb.predict
nb.model$times
nb.model$results
