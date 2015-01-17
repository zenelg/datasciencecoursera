## This script merges the training and the test sets for measurements on the 
## mean and standard deviation and writes to a tidy data set with the average 
## of each variable for each activity and each subject.
##
## Requires that getdata_projectfiles_UCI HAR Dataset are stored in your 
## default directory

print("This script merges the training and the test sets for measurements on") 
print("the mean and standard deviation and writes to a tidy data set with")
print("the average of each variable for each activity and each subject.")

print("Requires that getdata_projectfiles_UCI HAR Dataset are stored in your") 
print("default directory"); getwd()
print("Requires a call to dplyr library") 
print("PLEASE READ ReadMe.Md and CodeBook.Md in GitHub depo on project submission")

cat ("Press [enter] to continue -- Laps Time ~40sec")
line <- readline()

# Load features file and cleans for special characters
print("Load features file and cleans for special characters")
features_raw = read.table("features.txt")
features_raw$V2 <- gsub(")", "", features_raw$V2)
features_raw$V2 <- gsub("\\(", "", features_raw$V2)
features_raw$V2 <- gsub(" ", "", features_raw$V2)
features_raw$V2 <- gsub(",", "-", features_raw$V2) 

# Read Train files and bind Activity to Train DataSet
print("24-30 secs ... Read Train files and bind Activity to Train DataSet")
y_train_raw = read.table("y_train.txt")
X_train_raw = read.table("X_train.txt")
subject_train_raw = read.table("subject_train.txt")

# Step 4: Appropriately labels the data set with descriptive variable names for X-train.
print("labels the data set with descriptive variable names for X-train.")
names(X_train_raw) <- features_raw$V2
X_train <- cbind(subject_train_raw,y_train_raw,X_train_raw) #Adds Subject and Activity
names(X_train)[1] <- "Subject"
names(X_train)[2] <- "ActCode"

# Step -3 : Uses descriptive activity names to name the activities in the data set
# Changes Act Codes into readable Activity Labels
print("activity names and act codes are added")
activity_labels <- read.table("activity_labels.txt")
X_train$ActCode[X_train$ActCode == 1] <- "WALKING"
X_train$ActCode[X_train$ActCode == 2] <- "WALKING_UPSTAIRS"
X_train$ActCode[X_train$ActCode == 3] <- "WALKING_DOWNSTAIRS"
X_train$ActCode[X_train$ActCode == 4] <- "SITTING"
X_train$ActCode[X_train$ActCode == 5] <- "STANDING"
X_train$ActCode[X_train$ActCode == 6] <- "LAYING"

# Read test files and bind Activity to Test DataSet
print("5-10 secs .... Read test files and bind Activity to Test DataSet")
y_test_raw = read.table("y_test.txt")
X_test_raw = read.table("X_test.txt")
subject_test_raw = read.table("subject_test.txt")

# Step 4: Appropriately labels the data set with descriptive variable names for x-test
print("labels the data set with descriptive variable names for x-test")
names(X_test_raw) <- features_raw$V2
X_test <- cbind(subject_test_raw,y_test_raw,X_test_raw)
names(X_test)[1] <- "Subject"
names(X_test)[2] <- "ActCode"

# Step -3 : Uses descriptive activity names to name the activities in the data set
# Changes Act Codes into readable Activity Labels
print("activity names and act codes are added")
X_test$ActCode[X_test$ActCode == 1] <- "WALKING"
X_test$ActCode[X_test$ActCode == 2] <- "WALKING_UPSTAIRS"
X_test$ActCode[X_test$ActCode == 3] <- "WALKING_DOWNSTAIRS"
X_test$ActCode[X_test$ActCode == 4] <- "SITTING"
X_test$ActCode[X_test$ActCode == 5] <- "STANDING"
X_test$ActCode[X_test$ActCode == 6] <- "LAYING"

# Step 1 : Merges the training and the test sets to create one data set.
# Bind train and test df
print("Merges the training and the test sets")
X_full <- rbind(X_train, X_test)

# Step 2 -Extracts only the measurements on the mean and standard deviation 
# for each measurement. 
# Add Columns for mean and std 
print("Extracts the measurements on the mean and standard deviation ")
a <- grep("mean", features_raw$V2)
b <- grep("std", features_raw$V2)
x_tidy_a <- X_full[, a+2]
x_tidy_a$MeansAVG <- rowMeans(x_tidy_a)
x_tidy_b <- X_full[, b+2]
x_tidy_b$StdAVG <- rowMeans(x_tidy_b)
X_tidy <- cbind(X_full[,1:2],x_tidy_a,x_tidy_b)
names(X_tidy)[1] <- "Subject"
names(X_tidy)[2] <- "ActCode"

# Step 5 : From the data set in step 4, creates a second, independent tidy 
# data set with the average of each variable for each activity and each subject
# as a txt file created with write.table() using row.name=FALSE
print("Creates tidy data set")
library(dplyr)
XbySubjandAct <- group_by(X_tidy, Subject, ActCode)
# Smaller data set with the calculated average of all Mean and STD columns - 2 added colums
TidySet_Small.df <- summarize(XbySubjandAct, MeanofMeans = mean(MeansAVG), 
          MeanodSTD = mean(StdAVG))
TidySet_All.df <- summarise_each(XbySubjandAct, funs(mean))

rm(X_tidy); rm(features_raw); rm(activity_labels); rm(x_tidy_a)
rm(x_tidy_b); rm(X_full); rm(y_test_raw); rm(X_test_raw)
rm(y_train_raw); rm(X_train_raw); rm(X_test); rm(X_train); rm(XbySubjandAct)
rm(subject_test_raw); rm(subject_train_raw); rm(a); rm(b)

write.table(TidySet_All.df, "TidySet_All.df.txt", sep="\t", row.name=FALSE)
print("PLEASE READ ReadMe.Md and CodeBook.Md in GitHub depo on project submission")
