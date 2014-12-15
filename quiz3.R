getwd()
#for Dater
setwd("/home/brian/Projects/Coursera/GetAndCleanData")

#for latitude
setwd("/home/brian/Projects/Coursera/GetAndClean")

#for dater_bridge
setwd("C:\\Users\\Brian\\Documents\\Projects\\GetClean")

#for campus
setwd("I:\\My Data Sources\\mooc\\GetCleanData")


if (!file.exists("data")) {  dir.create("data")}

download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",destfile="./data/Housing.csv")
#("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf" for variable desc
house<-read.csv("./data/Housing.csv")