getwd()
#for Dater
setwd("/home/brian/Projects/Coursera/GetAndCleanData")

#for latitude
setwd("/home/brian/Projects/Coursera/GetAndClean")

#for dater_bridge
setwd("C:\\Users\\Brian\\Documents\\Projects\\GetClean")

if (!file.exists("data")) {
  dir.create("data")
}


download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",destfile="./data/Housing.csv")
#("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf" for variable desc
house<-read.csv("./data/Housing.csv")

table(house$VAL==24)
table(house$FES)
str(house$FES)

##Q3

if (!file.exists("data")) {
  dir.create("data")
}
fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileURL,destfile="./data/getdata-data-DATA.gov_NGAP.xlsx",mode="wb")
dateDownloaded<-date()
list.files("./data")
install.packages("openxlsx")
library(openxlsx)

colIndex<-7:15
rowIndex<-18:23
dat<-read.xlsx("./data/getdata-data-DATA.gov_NGAP.xlsx",sheet = 1, startRow=18)
dat<-dat[1:6,colIndex]
head(dat)
str(dat)

sum(as.numeric(dat$Zip)*as.numeric(dat$Ext),na.rm=T) 

##Q4
install.packages("XML")
library(XML)

doc<-xmlTreeParse("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml",useInternal=T)

rootNode<-xmlRoot(doc)
xmlName(rootNode)
names(rootNode)
rootNode[[1]][[1]][[2]]
xmlSApply(rootNode,xmlValue)


zip <- xpathSApply(doc,"//zipcode",xmlValue)
table(zip==21231)

##Q5

install.packages("data.table")
library(data.table)
download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",destfile="./data/idahoHousing.csv")
DT<-fread("./data/idahoHousing.csv")
head(DT)
system.time(rowMeans(DT)[DT$SEX==1])
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(DT[,mean(DT$pwgtp15),by=SEX])
system.time(mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(rowMeans(DT)[DT$SEX==1]); system.time(DT$SEX,mean)rowMeans(DT)[DT$SEX==2]))


sapply(split(DT$pwgtp15,DT$SEX),mean)
DT[,mean(pwgtp15),by=SEX]
mean(DT$pwgtp15,by=DT$SEX)
mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
tapply(DT$pwgtp15,DT$SEX,mean) 

