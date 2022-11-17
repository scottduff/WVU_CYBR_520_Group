#Lab #5
#Code is publicly available @ https://machinelearningmastery.com/feature-selection-with-the-caret-r-package/


#The first time you run this code, un-comment the two next lines to install the packages
install.packages('caret')
install.packages('e1071')
install.packages("randomForest")
install.packages('mlbench')
install.packages('Hmisc')
install.packages('corrplot')
install.packages('ggcorrplot')
install.packages('https://cran.r-project.org/src/contrib/Archive/randomForest/', repos=NULL, type="source") 


#load libraries
library(caret)
library(e1071)
library(mlbench)
library(caret)
library(randomForest)
library(Hmisc)
library(corrplot)
library(ggcorrplot)

# ensure the results are repeatable
set.seed(7)
# Get attributes that are highly correlated

# Read the data from the csv file
# DERBY dataset with 33 columns
dataset <- read.csv('./DERBY5.csv' , sep = ',')

# load the data
# calculate correlation matrix
# See library https://www.rdocumentation.org/packages/caret/versions/6.0-93/topics/findCorrelation
dataset$x <- NULL
correlationMatrix <- cor(dataset[,1:33])
# summarize the correlation matrix
print(correlationMatrix)


#%%%%%%%%%%%%%%%%%%%%%%%%%%% un-comment lines 43-47when using spambase dataset %%%%%%%%%%%%%%%%%%%%%%%%%
# change type to numerical (0 for nonspam and 1 for spam)
dataset[dataset =='nonspam'] <- as.numeric(0)              
dataset[dataset =='spam'] <- as.numeric(1)                 
dataset$type = as.numeric(dataset$type)                    
str(dataset)
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#get correlation matrix - representation 1
visCorMatrix1 <- corrplot(cor(dataset))

#get correlation matrix - representation 2
visCorMatrix2<-ggcorrplot(cor(dataset))

visCorMatrix2

# find attributes that are highly corrected (ideally >0.75)
highlyCorrelated <- findCorrelation(correlationMatrix, cutoff=0.5,verbose = FALSE,names = TRUE )
# print highly correlated attributes
print(highlyCorrelated)

# ensure results are repeatable
set.seed(7)
# prepare training scheme
control <- trainControl(method="repeatedcv", number=10, repeats=3)
# train the model
model <- train(as.factor(type)~., data=dataset, method="lvq", preProcess="scale", trControl=control)
# estimate variable importance
# This will take a minute
importance <- varImp(model, scale=FALSE)
# summarize importance
# This will take a minute
print(importance)
# plot importance
plot(importance)

#Recursive Feature Elimination (RFE) ---------------------------------
# ensure the results are repeatable
set.seed(7)
# load the library
library(mlbench)
library(caret)
# load the data
# define the control using a random forest selection function
# This will take a moment.FYI.
control <- rfeControl(functions=rfFuncs, method="cv", number=10)

# run the RFE algorithm
results <- rfe(dataset[,1:31], dataset[,32], sizes=c(1:31), rfeControl=control)

# summarize the results
# this will take a hot minute
print(results)
# list the chosen features
predictors(results)
# plot the results
plot(results, type=c("g", "o"))



