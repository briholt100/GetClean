getwd()
setwd("/home/brian/Projects/Coursera/GetAndCleanData/")
library(httr)
library(httpuv)
library(jsonlite)
library(sqldf)
oauth_endpoints("github")
myapp = oauth_app("github",
                  key="406d792236c59dcf6de8",secret="ee20531a35f9641f99af2f3fb68fe5a1778dc1f6")
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
myapp <- oauth_app("github", key="7e5a097f25bc9170c7e0",secret="270159fac5e3452e2482de38980913ce88a45e6c") #registered application

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = "ee20531a35f9641f99af2f3fb68fe5a1778dc1f6")
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
json2[json2$name=="datasharing", "created_at"]
json2[9]





##Q2
library(sqldf)
acs<-read.csv("./data/getdata_data_ss06pid.csv")


q2a<-(acs$pwgtp1[acs$AGEP < 50])
length(acs$AGEP)

q2<-sqldf("select pwgtp1 from acs where AGEP < 50")
sum(q2 -q2a)

#Q3
sqldf("select distinct AGEP from acs") - unique(acs$AGEP)

#Q4
#How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page: 

library(XML)
url <- "http://biostat.jhsph.edu/~jleek/contact.html "
html <- htmlTreeParse(url, useInternalNodes=T)


library(httr); 
html2 = GET(url)
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
sst<-(read.fwf("./data/getdata_wksst8110.for",widths=
                 c(-1,10,-4,4,4,-5,4,4,-5,4,4,-5,4,4),skip=4)) #columns divided by 5 spaces, 1 space in last
head(sst)
sum(sst$V4)




"
Question 1
Register an application with the Github API here https://github.com/settings/applications. Access the API to get information on your instructors repositories (hint: this is the url you want "https://api.github.com/users/jtleek/repos"). Use this data to find the time that the datasharing repo was created. What time was it created? This tutorial may be useful (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). You may also need to run the code in the base R package and not R studio.
Your Answer   	Score 	Explanation
2012-06-20T18:39:06Z 			
2014-01-04T21:06:44Z 			
2013-11-07T13:25:07Z 	Correct 	3.00 	
2014-02-06T16:13:11Z 			
Total 		3.00 / 3.00 	
Question 2
The sqldf package allows for execution of SQL commands on R data frames. We will use the sqldf package to practice the queries we might send with the dbSendQuery command in RMySQL. Download the American Community Survey data and load it into an R object called

acs



https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv

Which of the following commands will select only the data for the probability weights pwgtp1 with ages less than 50?
Your Answer 		Score 	Explanation
sqldf("select * from acs where AGEP $$\lt$$ 50 and pwgtp1") 			
sqldf("select * from acs") 			
sqldf("select pwgtp1 from acs where AGEP $$\lt$$ 50") 	Correct 	3.00 	
sqldf("select * from acs where AGEP $$\lt$$ 50") 			
Total 		3.00 / 3.00 	
Question 3
Using the same data frame you created in the previous problem, what is the equivalent function to unique(acs$AGEP)
Your Answer 		Score 	Explanation
sqldf("select unique AGEP from acs") 			
sqldf("select AGEP where unique from acs") 			
sqldf("select distinct AGEP from acs") 	Correct 	3.00 	
sqldf("select distinct pwgtp1 from acs") 			
Total 		3.00 / 3.00 	
Question 4
How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page:

http://biostat.jhsph.edu/~jleek/contact.html

(Hint: the nchar() function in R may be helpful)
Your Answer 		Score 	Explanation
43 99 8 6 			
45 31 7 25 	Correct 	3.00 	
45 92 7 2 			
43 99 7 25 			
45 0 2 2 			
45 31 2 25 			
45 31 7 31 			
Total 		3.00 / 3.00 	
Question 5
Read this data set into R and report the sum of the numbers in the fourth of the nine columns.

https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for

Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for

(Hint this is a fixed width file format)
Your Answer 		Score 	Explanation
101.83 			
35824.9 			
222243.1 			
36.5 			
32426.7 	Correct 	3.00 	
28893.3 			
Total 		3.00 / 3.00"