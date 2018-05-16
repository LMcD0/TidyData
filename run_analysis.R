tidyquiz <- function(){
    ## all files should be placed in a folder called "UCI HAR Dataset" off of the project folder
    library(dplyr)
    library(tidyr)
    
    
    ## pull files in
    features <-read.table("./UCI HAR Dataset/features.txt",  header = FALSE)
    activitylbl<-read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)
    
    trainx <-read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
    trainy <-read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
    trainsubject <-read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
    
    testx <-read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
    testy <-read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
    testsubject <-read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
    
    
    ## add column to X to determine datasource
    
    trainx <- mutate(trainx, datasource = "train")
    testx <- mutate(testx, datasource = "test")
    
    ##combine test and  train files
    combinedx <- rbind(trainx,testx)
    combinedy <- rbind(trainy,testy)
    combinedsubject <- rbind(trainsubject,testsubject)
    
    ## clean feature data to make clean column names
    features[[2]]<-sub("\\)", "", features[[2]])
    ##features[[2]]<-sub("\\)", "", features[[2]])
    features[[2]]<-sub("\\(", "", features[[2]])
    features[[2]]<-sub("\\-", "", features[[2]])
    ##features$V2<-sub("\\-", "", features$V2)
    
    activitylbl <- mutate(activitylbl, V2 = tolower(V2))
    
    colnames(combinedx) <- as.character(features[[2]])
    
    colnames(combinedx)[562] <-"datasource"
    
    ##filter only mean and std data
    
    ##remove formatted to duplicate colmun names - Not Mean or Std values!
    combinedx <-combinedx[ , !duplicated(colnames(combinedx))]
    
    combinedx <-select(combinedx, datasource, contains("mean"), contains("std"))
    
    ##combine Train files
    combinedxy<-cbind(combinedy,combinedx)
    colnames(combinedxy)[1]<-"activity"
    combinedxys<-cbind(combinedsubject,combinedxy)
    colnames(combinedxys)[1]<-"subject"
    
    ##write.csv(combinedxys, "test.csv")
    
    ## gather the data for X, Y, Z axis
    
    ##<<X>>
    onlyx <- select(combinedxys, subject, activity, datasource, contains("-X")) 
        
        onlyx <- onlyx %>%
            gather(measurement,value, -subject, -activity, -datasource) %>%
            mutate(axis = "X")
    
    ## there is one set of XYZ columns, anglezgravitymean,  that has their axis in the middle.
        ##this code lines up the format with everything else
    xangle <- select(combinedxys, subject, activity, datasource,contains("anglex"))    
    xangle<- mutate(xangle, measurement = "anglegravitymean", axis ="X")    
    colnames(xangle)[4] <-"value"
    
    ##write.csv(xangle, "test.csv")
    xangle <-select(xangle, subject, activity, datasource, measurement, value, axis)
    
    ##<<Y>>
    onlyy <- select(combinedxys,subject, activity, datasource,contains("-Y")) 
    
    onlyy <- onlyy %>%
            gather(measurement,value, -subject, -activity, -datasource) %>%
            mutate(axis = "Y")
    
    ##anglezgravitymean fix
    yangle <- select(combinedxys, subject, activity, datasource,contains("angley"))    
    yangle<- mutate(yangle, measurement = "anglegravitymean", axis ="Y")    
    colnames(yangle)[4] <-"value"
    yangle <-select(yangle, subject, activity, datasource, measurement, value, axis)
    
    ##<<Z>>
    onlyz <- select(combinedxys,subject, activity, datasource, contains("-Z")) 
   
    onlyz <-onlyz %>%
            gather(measurement,value, -subject, -activity, -datasource) %>%
            mutate(axis = "Z")
   
    ##anglezgravitymean fix
    zangle <- select(combinedxys, subject, activity, datasource,contains("anglez"))    
    zangle<- mutate(zangle, measurement = "anglegravitymean", axis ="Z")    
    colnames(zangle)[4] <-"value"
    zangle <-select(zangle, subject, activity, datasource, measurement, value, axis)
     
    
    ##combine x y z 
    tidy <- rbind(onlyx, onlyy, onlyz)
    tidy$measurement <- substr(tidy$measurement, 1, nchar(tidy$measurement)-2)
    ## add non standard angle calculations to final data
    tidy <-rbind(tidy,xangle, yangle,zangle)
    
    ##give activity a meaningful value
    tidy <- mutate(tidy, activity = activitylbl[[2]][as.numeric(activity)])
    
        
    ## gather non axis numbers
    
    xyzcol <- grepl("[XYZ]$", colnames(combinedxys))
    onlyna <- combinedxys[!xyzcol]
    
    ##exclude anglezgravitymean values
    xyzcol <- grepl("^angle", colnames(onlyna))
    
    onlyna <- onlyna[!xyzcol]
    onlyna <- gather(onlyna, measurement,value, -subject, -activity, -datasource)
    onlyna <- mutate(onlyna, activity = activitylbl[[2]][as.numeric(activity)])
    
    ##<<<Averages>>>
    
    ##XYZ Data
    tidyavg <-tidy%>%
      group_by(subject,activity, measurement) %>%
      summarise(avgvalue = mean(value))
    
    ##NonXYZ
    onlynaavg <-onlyna %>%
        group_by(subject,activity, measurement) %>%
        summarise(avgvalue = mean(value))
    
    
    ##output
    write.csv(tidy, "axismeasurments.csv")
    write.csv(onlyna,"nonaxismeasurements.csv")
    write.table(tidyavg, "axisaverages.txt", row.names =FALSE)
    write.table(onlynaavg, "nonaxisaverages.txt", row.names = FALSE)
}
    