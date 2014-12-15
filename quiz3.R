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
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
idaho<-read.csv("./data/idahoHousing.csv")

idaho[which(idaho$ACR==3 & idaho$AGS == 6),c("ACR","AGS")]
idaho$agricultureLogical<-(c(idaho$ACR==3 & idaho$AGS == 6))
which(idaho$agricultureLogical)

idaho[order(idaho$NP),]


#q2
library("jpeg")

download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg",destfile="./data/leek.jpg")
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
leekPhoto<-readJPEG("./data/leek.jpg",native =T)
quantile(leekPhoto,probs=seq(0,1,.1))


#q3
download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",destfile="./data/gdp.csv")
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
gdp<-read.csv("./data/gdp.csv")

download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",destfile="./data/edu.csv")
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
edu<-read.csv("./data/edu.csv")

head(gdp)
names(edu)

table(edu[,31] %in% gdp[,"X.2"])
table(edu[,1] %in% gdp[,1])
head(gdp)
df<-merge(edu,gdp,by.y="X.2", by.x="Short.Name")
names(df)
df[order(df[,33],decreasing=T),]
