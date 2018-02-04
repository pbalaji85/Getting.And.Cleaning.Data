library(dplyr)
library(tidyr)

setwd('~Getting.And.Cleaning.Data/UCI HAR Dataset/')

## Read in the training features dataset
x_train <- read.table(file = 'train/X_train.txt')

## Read in the test features dataset
x_test <- read.table(file = 'test/X_test.txt')

## Merge the test and training feature datasets together
feat <- rbind(x_train,x_test)

## Read in the file with all of the feature names
feat_names <- read.table(file='features.txt')

##################################################################################################
## Format the feature names to make them more readable - This will require multiple gsub calls
feat_names$V2 <- gsub("()","",feat_names$V2,fixed=T)
feat_names$V2 <- gsub("-","",feat_names$V2)
feat_names$V2 <- gsub("BodyBody", "Body",feat_names$V2)

#################################################################################################

## Read in the target values for training set
y_train <- read.table(file = 'train/y_train.txt')

## Read in the target values for the test set
y_test <- read.table(file = 'test/Y_test.txt')

## Merge the training and test target values together 
target <- rbind(y_train,y_test)
## Add column names to the target dataset. The column names are abbreviates to 'target' for training feature
colnames(target) <- "target"

#######################################################################################
## Read in the information about Subject (both training and test)
train_subject <- read.table(file = 'train/subject_train.txt')

test_subject <- read.table(file = 'test/subject_test.txt')

## Merge the training and test subject information together
subject <- rbind(train_subject,test_subject)
colnames(subject) <- 'Subject'

final <- cbind(feat,target,subject)
colnames(final) <- feat_names$V2
## Extract the mean for each of the measurements (except the target variable)
ExtractMeanSd <- grep('*.mean.*|*.std.*',feat_names$V2)
ResultMeanSd <- final[,ExtractMeanSd]
ResultMeanSd <- cbind(ResultMeanSd,Target=final$target,Subject=final$Subject)

## Convert final into a tibble
ResultMeanSd <- tbl_df(ResultMeanSd)

## Add descriptive activity labels for the activities in the dataset
## I'm using the mutate function in the dplyr package for this.

ResultMeanSd <- mutate(ResultMeanSd, 
                Activity = ifelse( target %in% 6, "Laying",ifelse( target == 5, "Standing", ifelse(target == 4, "Sitting", 
                      ifelse(target == 3, "Walking_Downstairs",ifelse(target == 2, "Walking_Upstairs", "Walking"))))))

## Group the dataframe by Activity and Subject
grouped <- group_by(ResultMeanSd, Activity, Subject)

## Calculate the mean for all the features grouped by Activity and Subject
result <- summarize_all(grouped, funs(mean))

## Finally export the table
write.table(result,'tidydata.txt',sep="\t", row.names = F, quote = F)
                                                            