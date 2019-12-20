library(dplyr)
library(magrittr)
#First we read in all the data
a <- fread("C:\\Users\\u576u1\\Downloads\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\train\\X_train.txt")
b <- fread("C:\\Users\\u576u1\\Downloads\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\train\\y_train.txt")
c <- fread("C:\\Users\\u576u1\\Downloads\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\train\\subject_train.txt")
a2 <- fread("C:\\Users\\u576u1\\Downloads\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\X_test.txt")
b2 <- fread("C:\\Users\\u576u1\\Downloads\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\y_test.txt")
c2 <- fread("C:\\Users\\u576u1\\Downloads\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\subject_test.txt")
fnames <- fread("C:\\Users\\u576u1\\Downloads\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\features.txt")
activities <- fread("C:\\Users\\u576u1\\Downloads\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\activity_labels.txt")

#Next I give proper names the the activity and subject columns to distinguish them when I join
names(c) <- "Subject"
names(c2) <- "Subject"
b <- left_join(b,activities)
b2 <- left_join(b2,activities)
names(b) <- c("Activity_Index", "Activity_Name")
names(b2) <- c("Activity_Index", "Activity_Name")
names(a) <- fnames$V2
names(a2) <- fnames$V2

#Drop all but mean and std measurements
a <- a[,c(1:6, 41:46, 81:86, 121:126, 161:166,201,202,214,215,227,228,240,241,253,254,
           266:271,345:350,424:429, 503,504,516,517,529,530,542,543)]
a2 <- a2[,c(1:6, 41:46, 81:86, 121:126, 161:166,201,202,214,215,227,228,240,241,253,254,
          266:271,345:350,424:429, 503,504,516,517,529,530,542,543)]


#Next I add the activity and subject indicator to the data
train <- cbind(c,b,a)
test <- cbind(c2,b2,a2)

#Now I join the test and train datasets together
data <- rbind(train,test)

#Clean up the environment
rm(a,b,c,a2,b2,c2,train,test, fnames, activities)

AvgByParticipant <- data[,-c("Activity_Index","Activity_Name")] %>% group_by(Subject) %>% summarise_all(mean)
AvgByActivity <- data[,-c("Subject")] %>% group_by(Activity_Name) %>% summarise_all(mean)
