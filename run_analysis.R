## to tidy data on 
library(dplyr)

#colect feature text for column na
dtfeature <- read.table("./UCI HAR Dataset/features.txt",header = FALSE)

# collect test data from folder
dttest <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE,col.names = dtfeature[,2] )
dttestlbl <- read.table("./UCI HAR Dataset/test/Y_test.txt",header = FALSE,col.names = ("activity"))
dttestsubject <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE,col.names = ("subject"))

# collect train data from folder
dttrain <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE, col.names = dtfeature[,2])
dttrainlbl <- read.table("./UCI HAR Dataset/train/Y_train.txt",header = FALSE,col.names = ("activity"))
dttrainsubject <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE,col.names = ("subject"))

# collecct trainig pattern 
dtactivity <-  read.table("./UCI HAR Dataset/activity_labels.txt",header = FALSE, col.names = c("activitynnumber","activitynames"))

# merging test data with activitynames and subjects  
dt1test = cbind(dttestsubject,dttestlbl,dttest)
dt1train = cbind(dttrainsubject,dttrainlbl,dttrain)

# 1 & 4 merged data set 
dt = rbind(dt1test,dt1train)

# 2 only measurments with mean or std
dt2 = dt[,grep("mean()|std()",colnames(dt))]

# 3 replace activity names with the 
dt3 = dt
dt3$activity = dtactivity[dt3$activity,2]

# 5 create tidy data set
dt4 = dt %>% group_by(activity,subject) %>% summarise_each(funs(mean)) 

