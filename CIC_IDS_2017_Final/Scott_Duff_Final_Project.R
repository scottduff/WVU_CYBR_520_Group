library(caret)
library(e1071)

set.seed(4242)

dataset <- read.csv("C:\\Users\\duffa\\OneDrive\\Documents\\GitHub\\WVU_CYBR_520_Group_1\\CIC_IDS_2017_Final\\MachineLearningCVE\\Friday-WorkingHours-Afternoon-DDos.pcap_ISCX.csv", sep = ",")
dataset$x <- NULL

# Selects Columns that total Zero.
only_zeros <- function(x) {
  if(class(x) %in% c("integer", "numeric")) {
    all(x == 0, na.rm = TRUE) 
  } else { 
    FALSE
  }
}

# Removes columns that total Zero
dataset_nozero <- dataset[ , !sapply(dataset, only_zeros)]
dataset_backup <- dataset[ , !sapply(dataset, only_zeros)]

#write.csv(dataset_nozero,"C:\\Users\\duffa\\Documents\\export.csv", row.names = FALSE)

dataset_nozero[dataset_nozero =='BENIGN'] <- as.numeric(0)              
dataset_nozero[dataset_nozero =='DDoS'] <- as.numeric(1)                 
dataset_nozero$Label = as.numeric(dataset_nozero$Label)                    
str(dataset_nozero)

correlationMatrix <- cor(dataset_nozero[,1:69])

print(correlationMatrix)
print(correlationMatrix[69,])

visCorMatrix1 <- corrplot(cor(dataset_nozero))
visCorMatrix2 <-ggcorrplot(cor(dataset_nozero))
visCorMatrix2

highlyCorrelated <- findCorrelation(correlationMatrix, cutoff=0.5, 
                                    verbose = FALSE, names = TRUE )

print(highlyCorrelated)

set.seed(4242)

control <- trainControl(method="repeatedcv", number=10, repeats=3)

model <- train(as.factor(Label)~., data=dataset_nozero, method="lvq", 
               preProcess="scale", trControl=control)
