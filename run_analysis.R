## You should create one R script called run_analysis.R that does the following## 1.	Merges the training and the test sets to create one data set.
## 2.	Extracts only the measurements on the mean and standard deviation for each measurement.
## 3.	Uses descriptive activity names to name the activities in the data set
## 4.	Appropriately labels the data set with descriptive variable names. 
## 5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# packages used for this script:
library(dplyr)
library(reshape2)

## 1.	Merges the training and the test sets to create one data set.

features = read.table("./UCI HAR Dataset/features.txt", header=FALSE, as.is=TRUE, col.names=c("ID", "Name"))  # read features text file

activities = read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE, as.is=TRUE, col.names=c("ID", "Name"))  # read activity labels text file
activities[,2] <- as.character(activities[,2])

subject_testdata = read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE, as.is=TRUE, col.names=c("subject"))  # read subject test text file
X_testdata = read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE, col.names=features$Name)  # read X test text file
y_testdata = read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE, as.is=TRUE, col.names=c("activity"))  # read y test text file

testdata <- cbind(subject_testdata, y_testdata, X_testdata) # column combine the three  files

subject_traindata = read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE, as.is=TRUE, col.names=c("subject"))  # read subject train text file
X_traindata = read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE, col.names=features$Name)  # read X train text file
y_traindata = read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE, as.is=TRUE, col.names=c("activity"))  # read y train text file

traindata <- cbind(subject_traindata, y_traindata, X_traindata) # column combine the three  files

totaldata <- rbind(testdata, traindata) # row combine the two  files


## 2.	Extracts only the measurements on the mean and standard deviation for each measurement.

totaldata <- select(totaldata, contains("subject"), contains("activity"), contains("mean"), contains("std"))


## 3.	Uses descriptive activity names to name the activities in the data set

totaldata$activity <- factor(totaldata$activity, levels = activities[,1], labels = activities[,2])

totaldata$subject <- as.factor(totaldata$subject)



## 4.	Appropriately labels the data set with descriptive variable names. 

# Done previously

## 5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


totaldata.melted <- melt(totaldata, id = c("subject", "activity"))
totaldata.mean <- dcast(totaldata.melted, subject + activity ~ variable, mean)


write.table(totaldata.mean, file = "./tidy_data.txt", row.name=FALSE)
