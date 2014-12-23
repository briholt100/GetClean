###Other student 's run analysis



packages <- c('data.table', 'magrittr')
sapply(packages, require, character.only=TRUE)
fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
# Check if data already exists; if not, download it.
if (!file.exists('UCI HAR Dataset')) {
if(!file.exists('hars-dataset.zip')) {
download.file(fileUrl, 'hars-dataset.zip', method='wget')
}
unzip('hars-dataset.zip')
}
# Constructs a sed stream to normalize the spaces in the files.
# THIS IS A SIMPLE EXAMPLE JUST FOR THE ASSIGNMENT, BE CAREFUL IF YOU DECIDE
# TO USE IT.
# Args:
# pattern: a regex pattern to match filenames
# x: list of files to be searched using the pattern defined above
# Return:
# Sed string to parse and transform the text
sed <- function(pattern, x) {
x[grepl(pattern, x)] %>% # search the files vector
paste("'", ., "'", sep='') %>% # quote the paths
paste(., collapse=' ') %>% # collapse into a single string
paste("sed -e 's/ */ /g' -e 's/^ //'", .) # append the sed command
}
# 1. Merges the training and the test sets to create one data set.
files <- list.files(getwd(), recursive = TRUE)
# Read datasets
dtData <- sed('.*X_.*', files) %>% fread(.)
dtActivities <- sed('.*\\/y_.*', files) %>% fread(.)
dtSubjects <- sed('.*subject.*', files) %>% fread(.)
setnames(dtActivities, names(dtActivities), 'activity')
setnames(dtSubjects, names(dtSubjects), 'subject')
dtSubjects <- cbind(dtSubjects, dtActivities)
# 2. Extracts only the measurements on the mean and standard deviation for each
# measurement.
features <- fread("UCI HAR Dataset/features.txt")
setnames(features, names(features), c('activity', 'name'))
featuresBol <-features$name %>% grepl('mean\\(\\)|std\\(\\)', .)
features[featuresBol]$name <- features[featuresBol]$name %>%
sapply(gsub, pattern='\\(\\)', replacement='')
# Remove unnecessary measurements and bind the data
dtData <- dtData[, featuresBol, with=FALSE]
dt <- cbind(dtSubjects, dtData)
setkey(dt, activity)
# 3. Uses descriptive activity names to name the activities in the data set
labels <- fread("UCI HAR Dataset/activity_labels.txt")
setnames(labels, names(labels), c('activity', 'name'))
dt <- dt[labels][, activity:=factor(name, ordered=FALSE)][, name:=NULL]
setkey(dt, subject, activity)
# 4. Appropriately labels the data set with descriptive variable names.
setnames(dt, names(dt), c('subject', 'activity', features$name[featuresBol]) %>% as.vector)
# 5. From the data set in step 4, creates a second, independent tidy data set with
# the average of each variable for each activity and each subject.
tidy <- dt[, lapply(.SD, mean, na.rm=TRUE), by=.(subject, activity)]
# Write data to a .txt file
fPath = file.path(getwd(), 'assessment2_data.txt')
write.table(tidy, fPath, row.names=FALSE)