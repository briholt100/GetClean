getwd()
#for latitutde
setwd("/home/brian/Projects/Coursera/GetAndClean/data/UCI HAR Dataset/")
dir()

#for dater
setwd("/home/brian/Projects/Coursera/GetAndCleanData/data/UCI HAR Dataset")

Activities<-read.table("./activity_labels.txt",sep="")
Features<- read.csv("./features.txt",sep="")
Features[,2]
table1<-sort(table((Features[,2])))
table1[table1>1]

grep("mean|std",Features,ignore.case=T,value=T)
grep("std",Features,ignore.case=T,value=T)

########
######
#Create Table for Test Data 

subject_test<-read.table("./test/subject_test.txt",sep="")
X_test<-read.table("./test/X_test.txt",sep="")
Y_test<-read.table("./test/y_test.txt",sep="")
test_set<-cbind(subject_test,Y_test,X_test)

######
#Create Table for train Data 

subject_train<-read.table("./train/subject_train.txt",sep="")
X_train<-read.table("./train/X_train.txt",sep="")
Y_train<-read.table("./train/y_train.txt",sep="")
train_set<-cbind(subject_train,Y_train,X_train)

######
#Create "Set" Variable to differentiate train from test in final data
test_set$Set<-1
train_set$Set<-0

###Merge test and train set, then sort by 1st column (subject)
full_data<-rbind(test_set,train_set)
dim(full_data)
full_data<-full_data[order(full_data[,1]),]

#next step, make column names, then tapply accros subject and activity.

#####
#Rename columns