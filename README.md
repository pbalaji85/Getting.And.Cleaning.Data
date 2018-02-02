# Course Project - Getting & Cleaning data
The data for this project was downloaded from the [UCI Machine Learning
Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#)

## About the files in the dataset
The folder contains two sub-folders test and train. These two folders contain
files with the X (feature) and Y (target) information.

The script reads in the X (feature signals) and Y (target) from the training and
test datasets, and then merges them into a single file.

Further, we also add descriptive information about the activity (found in
  activitylables.txt).

The script also isolates the mean and standard deviation for the measurements
and finally generates a tidy file that calculates the mean for each feature
after grouping by Activity and Subject.

The tidy file has also uploaded as tidy.txt into this project.
