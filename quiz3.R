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
gdp<-read.csv("./data/gdp.csv",skip=4,nrows=190,col.names=c("CountryCode","Ranking","v3","Country","dollars","v6","v7","v8","v9","v10"))
gdp<-gdp[,c(1:2,4:5)]
str(gdp)

download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",destfile="./data/edu.csv")
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
edu<-read.csv("./data/edu.csv",header=T)
str(edu)
names(edu)
table(edu$"Income.Group")
sort(gdp$CountryCode)
names(gdp)
sort(intersect(gdp[,3],edu[,31]))

table(edu[,31] %in% gdp[,"Country"])
table(edu[,1] %in% gdp[,1])
table( gdp[,1] %in% edu[,1])
head(gdp)

df<-merge(edu,gdp,by.x="CountryCode", by.y="CountryCode")
names(df)
df<-df[order(df[,32],decreasing=T),]
head(df,13)

#q4

tapply(df$Ranking,df$Income.Group,mean)

#q5

df$GdpGroups<-cut(df$Ranking,breaks=quantile(df$Ranking,probs=seq(0,1,.2)))
head(df)
table(df$GdpGroups)
table(df$GdpGroups,df$Income.Group)

"how many are lower middle income but amount top 38 ranking?"
df[df$Ranking < 39 & df$Income.Group == "Lower middle income",31]
