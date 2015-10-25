
labels <- read.table("./features.txt",sep="",stringsAsFactors=FALSE)
data1 <- read.table("./test/X_test.txt",header=FALSE,sep="",stringsAsFactors=FALSE)
names(data1) <- labels$V2
activity1 <- read.table("./test/y_test.txt",header=FALSE,sep="",stringsAsFactors=FALSE)
data1 <- data.frame(activity = activity1$V1,data1,stringsAsFactors=FALSE)
subject1 <- read.table("./test/subject_test.txt",header=FALSE,sep="",stringsAsFactors=FALSE)
data1 <- data.frame(subject = subject1$V1,data1,stringsAsFactors=FALSE)

data2 <- read.table("./train/X_train.txt",header=FALSE,sep="",stringsAsFactors=FALSE)
names(data2) <- labels$V2
activity2 <- read.table("./train/y_train.txt",header=FALSE,sep="",stringsAsFactors=FALSE)
data2 <- data.frame(activity = activity2$V1,data2,stringsAsFactors=FALSE)
subject2 <- read.table("./train/subject_train.txt",header=FALSE,sep="",stringsAsFactors=FALSE)
data2 <- data.frame(subject = subject2$V1,data2,stringsAsFactors=FALSE)

data <- rbind(data1, data2)

if1 <- grepl("mean()",labels$V2,fixed=TRUE)
if2 <- grepl("std()",labels$V2,fixed=TRUE)
if0 <- if1 + if2
if0 <- c(1,1,if0)
data <- rbind(data,if0)
data <- data[,c(data[10300,]==1)]
a <- data[1:10299,]

dataF <- data.frame(data[1:2],activityName = data$activityName <- 0,data[3:68],stringsAsFactors=FALSE)
dataF$activityName[dataF$activity==1]<-"walking"
dataF$activityName[dataF$activity==2]<-"walking_upstairs"
dataF$activityName[dataF$activity==3]<-"walking_downstairs"
dataF$activityName[dataF$activity==4]<-"sitting"
dataF$activityName[dataF$activity==5]<-"standing"
dataF$activityName[dataF$activity==6]<-"laying"

library(dplyr)
final_table <- dataF %>% group_by(subject,activityName) %>% summarise_each(funs(mean))
final_table