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





#q1
download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",destfile="./data/idahoHousing.csv")

idaho<-read.csv("./data/idahoHousing.csv")
names(idaho)

head(idaho)
strsplit(names(idaho),"wgtp")


#q2
download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",destfile="./data/gdp.csv")
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
gdp<-read.csv("./data/gdp.csv",skip=4,nrows=190
              ,col.names=c("CountryCode","Ranking","v3","Country","dollars","v6","v7","v8","v9","v10")
              )

summary(gdp)

gdp<-gdp[,c(1:2,4:5)]
str(gdp)

mean(as.numeric(gsub(",","" ,gdp$dollars)))




#q3
grep("^United",gdp$Country[-c(99,186)]), 2





#q4
download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",destfile="./data/edu.csv")
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
edu<-read.csv("./data/edu.csv",header=T)
str(edu)
summary(edu)


summary(edu[,c(grep("late",names(edu),ignore.case=T))])


table(edu[,31] %in% gdp[,"Country"])
table(edu[,1] %in% gdp[,1])
table( gdp[,1] %in% edu[,1])
head(gdp)

df<-merge(edu,gdp,by.x="CountryCode", by.y="CountryCode")
names(df)
text = c("june","FY")
df[grep("june",df[,10],ignore.case=T),c(10)]
df[grep("FY",df[,10],ignore.case=F),c(10)]

df[grep(text,df[,10],ignore.case=T),c(10)]




#q5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 

length(grep("2012",sampleTimes))

dates<-grep("2012",sampleTimes,value=T)

length(dates[wday(dates)==2])

