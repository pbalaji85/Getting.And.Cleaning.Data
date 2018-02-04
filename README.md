# Course Project - Getting & Cleaning data
The data for this project was downloaded from the [UCI Machine Learning
Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#)

## About the files in the dataset
The folder contains two sub-folders test and train. These two folders contain
files with the X (feature) and Y (target) information.

## Goals of the script
* Merge the test and the training data sets to create one data set
* Extract only the measurements on the mean and standard deviation for each measurement
* Use descriptive activity names to name the activities in the data set
* Appropriately label the data set with descriptive variable names
* Create a second and independent tidy data set with the average of each
variable for each activity and each subject

The script reads in the X (feature signals) and Y (target), and Subject from the
training and test datasets, and then merges them into a single DF.

Further, we also add descriptive information about the activity (found in
activitylables.txt).

The script isolates features that are either mean and standard deviation of a
measurement (Accelerometer, Gyroscope etc.).
Finally, it generates a 'tidydata' file that calculates the mean for each feature
after grouping by Activity and Subject.

The tidy file has also uploaded as tidydata.txt into this project.
