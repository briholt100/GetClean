##########
#Issues to consider:
# Change feature/variable names?
# include all variables with term "mean|std", or should I exclude the few mentioned in FAQ
#create markdown file
#create readme
#create code book. 


########################################################################
#Obtain and download UCI HAR dataset
#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# Simply navigate to that web address, download, then unzip.  Keep track of file location
########################################################################

########################################################################
#get and set directory to "./UCI HAR Dataset"
#This script assumes linux forward slash notation
########################################################################
getwd()
###
#setwd("Insert your directory location here/UCI HAR Dataset/")


#for latitutde
#setwd("/home/brian/Projects/Coursera/GetAndClean/data/UCI HAR Dataset/")

#for dater
#setwd("/home/brian/Projects/Coursera/GetAndCleanData/data/UCI HAR Dataset")

#for windater
#setwd("C:\\Users\\Brian\\Documents\\Projects\\GetClean\\data\\UCI HAR Dataset")

########################################################################
#libraries needed; be sure these packages are first installed 
########################################################################
#install.packages("dplyr")
#install.packages("tidyr")
library("dplyr")
library("tidyr")
library("knitr")

########################################################################
#Create Table for Test Data 
########################################################################
subject_test<-read.table("./test/subject_test.txt",sep="")
X_test<-read.table("./test/X_test.txt",sep="")
Y_test<-read.table("./test/y_test.txt",sep="")
test_set<-cbind(subject_test,Y_test,X_test)

########################################################################
#Create Table for train Data 
########################################################################
subject_train<-read.table("./train/subject_train.txt",sep="")
#
#This next step may take some time to execute
#
####
#
X_train<-read.table("./train/X_train.txt",sep="")
Y_train<-read.table("./train/y_train.txt",sep="")
train_set<-cbind(subject_train,Y_train,X_train)

########################################################################
#Create "Set" Variable to differentiate train from test in final data.  This is unnecessary for final submission
########################################################################
test_set$Set<-1
train_set$Set<-0

########################################################################
#Merge test and train set, then sort by 1st column (Subject)
########################################################################
full_data<-rbind(test_set,train_set)
#dim(full_data)
full_data<-full_data[order(full_data[,1]),]

########################################################################
#Varialbes name manipulation
########################################################################
Activities<-read.table("./activity_labels.txt",sep="") #lists activities by name
Features<- read.csv("./features.txt",sep="",header=F) #561 list of features
table1<-sort(table((Features[,2])),decreasing=T) #creates table to find duplicates
#table1[table1>1] #lists duplicates; none have "mean" or "std"

########################################################################
#Rename columns
########################################################################
fullColNames<-make.names(Features[,2],unique=T)
fullColNames<-c("Subject","Activity",fullColNames,"Set")
colnames(full_data)<-fullColNames

KeptColumns<-grep("subject|activity|mean|std",fullColNames,ignore.case=T,value=F)
tidy<-full_data[,KeptColumns]

########################################################################
#Rename Activity
########################################################################
tidy$Activity<-with(tidy,
                    ifelse(tidy$Activity==1,"Walk",
                       ifelse(tidy$Activity==2,"Walk_Up",
                        ifelse(tidy$Activity==3,"Walk_Down",
                         ifelse(tidy$Activity==4,"Sit",
                          ifelse(tidy$Activity==5,"Stand","Lay")
                          )
                         )
                        )
                      )
                    )

########################################################################
#melt the data
########################################################################
long_tidy<-gather(data=tidy,Feature, value, tBodyAcc.mean...X:angle.Z.gravityMean. , na.rm = TRUE)
final<-summarize(group_by(long_tidy,Subject,Activity,Feature),mean(value))
#str(final)
final

########################################################################
#melt the data using non-dplyr methods, first wide, then narrow/long
########################################################################

#test<-aggregate(tidy[,3:88], by = c(list(tidy$Activity), list(tidy$Subject)),mean)
#test<-test[,c(2,1,3:88)] # reorders data.frame putting subject 1st
#names(test)[names(test) == 'Group.2'] <- 'Subject'
#names(test)[names(test) == 'Group.1'] <- 'Activity'

#narrowTest<-melt(test, id.vars =  c("Subject","Activity"),variable.name ="Feature")
#head(narrowTest,31)

#WideTidyTest<-dcast(narrowTest, Subject + Activity ~ Feature,mean)

########################################################################
#quick sanity check to see if this data produces same 
#data (albeit formated diffently) to that posted in FAQ by "Brandon"
#final[final$Subject==1,]
#test[test$Subject==1 ,]

########################################################################
###creating sharable file
########################################################################

#write.table(final,file = "./finalTidyData.txt",row.name=FALSE)

