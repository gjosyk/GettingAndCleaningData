# 1 -  Merge the training and the test sets to create one data set
setwd("C:\\education\\DataScience\\Getting_and_Cleaning_Data\\UCI HAR Dataset\\")
trainXData <- read.table("./train/X_train.txt")
trainYLabel <- read.table("./train/y_train.txt")
trainSubject <- read.table("./train/subject_train.txt")
testXData <- read.table("./test/X_test.txt")
testYLabel <- read.table("./test/y_test.txt")  
testSubject <- read.table("./test/subject_test.txt")
rbindXData <- rbind(trainXData, testXData)
rbindYLabel <- rbind(trainYLabel, testYLabel)
rbindSubject <- rbind(trainSubject, testSubject)

# 2 -  Extract only the measurements on the mean and standard deviation for each measurement
features <- read.table("features.txt")
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
joinedData <- rbindXData[, meanStdIndices]
# Clean names
names(joinedData) <- gsub("\\(\\)", "", features[meanStdIndices, 2])
names(joinedData) <- gsub("-", "", names(joinedData))

# 3 - Use descriptive activity names to name the activities in the data set
activity <- read.table("activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[rbindYLabel[, 1], 2]
rbindYLabel[, 1] <- activityLabel
names(rbindYLabel) <- "activity"

# 4 - Appropriately label the data set with descriptive activity nanes
names(rbindSubject) <- "subject"
cbindData <- cbind(rbindSubject, rbindYLabel, joinedData)
write.table(cbindData, "merged_data_set.txt")

# 5 - Create a second, independent tidy data set with the avrage of each variable for each activity and each subject 
activityLength <- dim(activity)[1]
columnLength <- dim(cbindData)[2]
subjectLength <- length(table(rbindSubject)) 
result <- matrix(NA, nrow=subjectLength*activityLength, ncol=columnLength) 
result <- as.data.frame(result)
colnames(result) <- colnames(cbindData)
row <- 1
for(i in 1:subjectLength) {
  for(j in 1:activityLength) {
    result[row, 1] <- sort(unique(rbindSubject)[, 1])[i]
    result[row, 2] <- activity[j, 2]
    bool1 <- i == cbindData$subject
    bool2 <- activity[j, 2] == cbindData$activity
    result[row, 3:columnLength] <- colMeans(cbindData[bool1&bool2, 3:columnLength])
    row <- row + 1
  }
}
write.table(result, "mean_and_std_dev_data.txt")
