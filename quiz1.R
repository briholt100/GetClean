library(ggplot2)
getwd()
#for Dater
setwd("/home/brian/Projects/Coursera/GetAndCleanData")

#for latitude
setwd("/home/brian/Projects/Coursera/GetAndClean")

#for dater_bridge
setwd("C:\\Users\\Brian\\Documents\\Projects\\GetClean")

#for campus
setwd("I:\\My Data Sources\\mooc\\GetCleanData")


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
fileURL<-"http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
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
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",destfile="./data/idahoHousing.csv")
DT<-fread("./data/idahoHousing.csv")
head(DT)

A<-replicate(1000,system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))[1])
B<-replicate(1000,system.time(DT[,mean(pwgtp15),by=SEX])[1])
C<-replicate(1000,system.time(mean(DT$pwgtp15,by=DT$SEX))[1])
D<-replicate(1000,system.time(tapply(DT$pwgtp15,DT$SEX,mean))[1])
E<-replicate(1000,system.time(c(mean(DT[DT$SEX==1,]$pwgtp15), mean(DT[DT$SEX==2,]$pwgtp15)))[1])
F<-replicate(1000,system.time(c(rowMeans(DT)[DT$SEX==1], rowMeans(DT)[DT$SEX==2]))[1])



race=c(A,B,C,D,E,F)
par(mfrow=c(3,2))
for(i in 1:length(race)){plot(race[i])}
par(mfrow=c(1,1))

A_av = cumsum(A) / seq_along(A)
B_av = cumsum(B) / seq_along(B)
C_av = cumsum(C) / seq_along(C)
D_av = cumsum(D) / seq_along(D)
E_av = cumsum(E) / seq_along(E)
F_av = cumsum(F) / seq_along(F)

topY = max(A_av, B_av, C_av, D_av, E_av, F_av) #making sure the y axis is the right height
lowY = min(A_av, B_av, C_av, D_av, E_av, F_av) #making sure the y axis is the right height

topY = max(A_av, B_av, D_av, F_av) #making sure the y axis is the right height
lowY = min(A_av, B_av, D_av,  F_av) #making sure the y axis is the right height
par(mfrow=c(1,2))
plot(A_av, type="l", col=1, ylim=c(lowY,topY), xlab="distance", ylab="average time")
lines(B_av, col=2)
lines(C_av, col=3)
lines(D_av, col=4)
lines(E_av, col=5)
#lines(F_av, col=6)
legend("topright",legend=c("A","B","C","D","E","F"),lty=c(1,1,1,1,1,1),col=c(1,2,3,4,5,6)) # gives the legend lines the correct color and width



horseRace<-data.table(cbind(A_av,
                      B_av,
                      C_av,
                      D_av,
                      E_av,
                      F_av)
                    )
tail(horseRace)

graph<-ggplot(horseRace,aes(y=A_av,x=seq_along(A_av),color=1))
graph+geom_line()+
  geom_line(aes(y=B_av,x=seq_along(B_av),color=2))+
  geom_line(aes(y=C_av,x=seq_along(C_av),color=3))+
  geom_line(aes(y=D_av,x=seq_along(D_av),color=4))+
  geom_line(aes(y=E_av,x=seq_along(E_av),color=5))
