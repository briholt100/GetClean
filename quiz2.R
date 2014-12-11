getwd()
setwd("/home/brian/Projects/Coursera/GetAndCleanData/")
library(httr)
library(httpuv)
library(jsonlite)
library(sqldf)
oauth_endpoints("github")
myapp = oauth_app("github",
                  key="406d792236c59dcf6de8",secret="9b8afab5451a061597f06034fcbeeb7ea4d47a58")
sig = sign_oauth1.0(myapp,
                    token = "26fdc7c6c65a116fb715e337bc0f79a1e17d19a1",
                    #token_secret = "270159fac5e3452e2482de38980913ce88a45e6c"
)

homeTL = GET("https://api.github.com/users/jtleek/repos", sig)

#https://api.github.com/users/jtleek/repos


###FROM HADLEY

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. Register an application at https://github.com/settings/applications
#    Insert your values below - if secret is omitted, it will look it up in
#    the GITHUB_CONSUMER_SECRET environmental variable.
#
#    Use http://localhost:1410 as the callback url
myapp <- oauth_app("github", key="406d792236c59dcf6de8",secret="9b8afab5451a061597f06034fcbeeb7ea4d47a58")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

1# 4. Use API
gtoken <- config(token = "1ffceceecae7fdf2a71619dbaedf2e502c83681b")
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
content(req)

# OR:
req <- with_config(gtoken, GET("https://api.github.com/users/jtleek/repos"))
stop_for_status(req)
content(req)
json1 = content(req)
json2 = jsonlite::fromJSON(toJSON(json1))

str(json2)
json2[json2$name=="datasharing",]

jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
json2[json2$name=="datasharing",]






##Q2
library(sqldf)

acs<-read.csv("./data/getdata-data-ss06pid.csv")

q2a<-(acs$pwgtp1[acs$AGEP < 50])
length(acs$AGEP)

q2<-sqldf("select pwgtp1 from acs where AGEP < 50")
sum(q2 -q2a)

#Q3
sqldf("select distinct AGEP from acs")


#Q4
#How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page: 

library(XML)
url <- "http://biostat.jhsph.edu/~jleek/contact.html "
html <- htmlTreeParse(url, useInternalNodes=T)


library(httr); html2 = GET(url)
content2 = content(html2,as="text")
parsedHtml = htmlParse(content2,asText=TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)

con = url("http://biostat.jhsph.edu/~jleek/contact.html ")
htmlCode = readLines(con)
close(con)
nchar(htmlCode[c(10,20,30,100)])


#Q5

#.for?

dir("./data")
sst<-(read.fwf("./data/getdata-wksst8110.for",widths=
                 c(-1,10,-4,4,4,-5,4,4,-5,4,4,-5,4,4),skip=4)) #columns divided by 5 spaces, 1 space in last
head(sst)
sum(sst$V4)
