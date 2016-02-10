## load dply package  
library(dplyr)

#colect feature text for column names
dtfeature <- read.table("./UCI HAR Dataset/features.txt",header = FALSE)

# collect test data from folder
dttest <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
# rename column with the names extracted from feature.txt
colnames(dttest) = as.character(dtfeature[,2]) 
dttestlbl <- read.table("./UCI HAR Dataset/test/Y_test.txt",header = FALSE,col.names = ("activity"))
dttestsubject <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE,col.names = ("subject"))

# collect train data from folder
dttrain <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
# rename column with the names extracted from feature.txt
colnames(dttrain) =  as.character(dtfeature[,2])
dttrainlbl <- read.table("./UCI HAR Dataset/train/Y_train.txt",header = FALSE,col.names = ("activity"))
dttrainsubject <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE,col.names = ("subject"))

# collecct trainig pattern 
dtactivity <-  read.table("./UCI HAR Dataset/activity_labels.txt",header = FALSE, col.names = c("activitynumber","activitynames"))

# merging test data with activitynames and subjects to create a new table 
dt1test = cbind(dttestsubject,dttestlbl,dttest)
# merging train data with activitynames and subjects to create a new table
dt1train = cbind(dttrainsubject,dttrainlbl,dttrain)

# Ans1 : merging test and train data set to create single table 
dt = rbind(dt1test,dt1train)

# Ans2 :  measurments with mean() & std() are extracted and activity and subject column are appended to create new table 
dt2 = cbind(subject =dt[,1], activity=dt[,2],dt[,grep("mean\\(\\)|std\\(\\)",colnames(dt))])

# Ans3 : replace activity names with the description  
dt3 = dt2
dt3$activity = as.character(dtactivity[dt3$activity,2])

# Ans4 : label varible names with decsriptive names  
names(dt4)<-gsub("std()", "SD", names(dt4))
names(dt4)<-gsub("mean()", "MEAN", names(dt4))
names(dt4)<-gsub("^t", "time", names(dt4))
names(dt4)<-gsub("^f", "frequency", names(dt4))
names(dt4)<-gsub("Acc", "Accelerometer", names(dt4))
names(dt4)<-gsub("Gyro", "Gyroscope", names(dt4))
names(dt4)<-gsub("Mag", "Magnitude", names(dt4))
names(dt4)<-gsub("BodyBody", "Body", names(dt4))

# Ans5 : create tidy data set with the average of earch activity and subject 
dt4 = dt3 %>% group_by(activity,subject) %>% summarise_each(funs(mean)) 
