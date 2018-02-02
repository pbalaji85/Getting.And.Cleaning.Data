library(dplyr)
library(tidyr)

setwd('~Coursera/UCI HAR Dataset/')

## Read in the training features dataset
x_train <- read.table(file = 'train/X_train.txt')

## Read in the test features dataset
x_test <- read.table(file = 'test/X_test.txt')

## Merge the test and training feature datasets together
feat <- rbind(x_train,x_test)

## Read in the file with all of the feature names
feat_names <- read.table(file='features.txt')

## Format the feature names to make them more readable - This will require multiple gsub calls
feat_names$V2 <- gsub("()","",feat_names$V2,fixed=T)
feat_names$V2 <- gsub("-","",feat_names$V2)

## Now that we have formatted the feature names, let us ensure that they are are all unique values
if (length(unique(feat_names$V2)!=length(feat_names$V2))) {
  print("The feature names are not unique!")
} else {
  print("The feature names are all unique")
}

## It appears as if the feature names are non-unique. Let us rename the features with the generic name feat1 to feat561 
## Assign the feature names to the features
colnames(feat) <- paste("feat",seq(1:length(feat_names$V2)),sep = "")

## Read in the target values for training set
y_train <- read.table(file = 'train/y_train.txt')

## Read in the target values for the test set
y_test <- read.table(file = 'test/Y_test.txt')

## Merge the training and test target values together 
target <- rbind(y_train,y_test)
## Add column names to the target dataset. The column names are abbreviates to 'target' for training feature
colnames(target) <- "target"

## Read in the information about Subject (both training and test)
train_subject <- read.table(file = 'train/subject_train.txt')

test_subject <- read.table(file = 'test/subject_test.txt')

## Merge the training and test subject information together
subject <- rbind(train_subject,test_subject)
colnames(subject) <- 'Subject'

final <- cbind(feat,target,subject)

## Extract the mean for each of the measurements (except the target variable)
ExtractMeanSd <- grep('*.mean.*|*.std.*',feat_names$V2)
ResultMeanSd <- final[,ExtractMeanSd]

## Convert final into a tibble
final <- tbl_df(final)

## Add descriptive activity labels for the activities in the dataset
## I'm using the mutate function in the dplyr package for this.

final <- mutate(final, 
                Activity = ifelse( target %in% 6, "Laying",ifelse( target == 5, "Standing", ifelse(target == 4, "Sitting", 
                      ifelse(target == 3, "Walking_Downstairs",ifelse(target == 2, "Walking_Upstairs", "Walking"))))))

## Group the dataframe by Activity and Subject
final_grouped <- group_by(final, Activity, Subject)

## Calculate the mean for all the features grouped by Activity and Subject
result <- summarize_all(final_grouped, funs(mean))

                                                            