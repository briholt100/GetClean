getwd()
setwd("/home/brian/Projects/Coursera/GetAndClean/data/UCI HAR Dataset/")
dir()

Activities<-read.table("./activity_labels.txt",sep="")
Features<-read.table("./features.txt",sep="")

df<-read.table("./test/X_test.txt",sep="")
str(df)
mean(df$V1)
  