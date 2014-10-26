## read the features
features<-read.table("./features.txt")

## read the training data
xtrain<-read.table("./X_train.txt")
ytrain<-read.table("./y_train.txt")
subjecttrain<-read.table("./subject_train.txt")

## read the test data
xtest<-read.table("./X_test.txt")
ytest<-read.table("./y_test.txt")
subjecttest<-read.table("./subject_test.txt")

## get the names of the features
featureNames<-features$V2

## assign the names of the features to the training and test features data - #4
colnames(xtrain)<-featureNames
colnames(xtest)<-featureNames

#### merge the training and test features and activity data - #1
featuresTotal<-rbind(xtrain, xtest)
activityTotal<-rbind(ytrain, ytest)
subjectTotal<-rbind(subjecttrain, subjecttest)
## assign the column name to subjectTotal
colnames(subjectTotal)[1]<-c("Subject")

#### Collect all the features related to mean values - #2
allMeans<-featuresTotal[,grep("mean", featureNames)]

#### Collect all the features related to standard deviation values - #2
allSd<-featuresTotal[,grep("std", featureNames)]

#### read the activity list
activityNames<-read.table("./activity_labels.txt")

#### provide descriptive names for the activities - #3
activityTotal$V1<-activityNames[match(activityTotal[, 1], activityNames$V1), 2]
## assign the column name to activityTotal
colnames(activityTotal)[1]<-c("Activity")

#### Create Average of each variable, per subject, per activity - #5
## Merge the mean and std deviation dataframes
allMeanSd<-cbind(allMeans, allSd)

## Merge the Subject, Activity and the 'features for mean and SD' columns
allData<-cbind(subjectTotal, activityTotal, allMeanSd)

allDataMelt<-melt(allData, id=c("Subject", "Activity"), measure.vars=c(colnames(allData)[3:81]))

## independent tidy data set with the average of each variable for each activity and each subject
allAverages<-dcast(allDataMelt, Subject+Activity ~ variable, mean)

## Provide descriptive names to all the means and standard deviation columns captured - #4
colnames(allAverages)[3:81]<-c("Body Accelaration Mean X", "Body Accelaration Mean Y", "Body Accelaration Mean Z", "Gravity Accelaration Mean X", "Gravity Accelaration Mean Y", "Gravity Accelaration Mean Z", "Body Accelaration Jerk Mean X", "Body Accelaration Jerk Mean Y", "Body Accelaration Jerk Mean Z", "Body Angular Velocity Mean X", "Body Angular Velocity Mean Y", "Body Angular Velocity Mean Z", "Body Angular Velocity Jerk Mean X", "Body Angular Velocity Jerk Mean Y", "Body Angular Velocity Jerk Mean Z", "Body Accelaration Magnitude Mean X", "Body Accelaration Magnitude Mean Y", "Body Accelaration Magnitude Mean Z", "Body Angular Velocity Magnitude Mean", "Body Angular Velocity Jerk Magnitude  Mean", "Body Accelaration Mean X", "Body Accelaration Mean Y", "Body Accelaration Mean Z", "Body Accelaration Frequency Mean X", "Body Accelaration Frequency Mean Y", "Body Accelaration Frequency Mean Z", "Body Accelaration Jerk Mean X", "Body Accelaration Jerk Mean Y", "Body Accelaration Jerk Mean Z", "Body Accelaration Jerk Frequency Mean X", "Body Accelaration Jerk Frequency Mean Y", "Body Accelaration Jerk Frequency Mean Z", "Body Angular Velocity Mean X", "Body Angular Velocity Mean Y", "Body Angular Velocity Mean Z", "Body Angular Velocity Frequency Mean X", "Body Angular Velocity Frequency Mean Y", "Body Angular Velocity Frequency Mean Z", "Body Accelaration Magnitude Mean", "Body Accelaration Magnitude Frquency Mean", "Body Body Accelaration Jerk Mean", "Body Body Accelaration Jerk Frequency Mean", "Body Body Angular Velocity Magnitude Mean", "Body Body Angular Velocity Magnitude Frequency Mean", "Body Body Angular Velocity Jerk Magnitude Mean", "Body Body Angular Velocity Jerk Magnitude Frequency Mean", "Body Accelaration Std. Deviation X", "Body Accelaration Std. Deviation Y", "Body Accelaration Std. Deviation Z", "Body Gravity Acc Std. Deviation X", "Body Gravity Acc Std. Deviation Y", "Body Gravity Acc Std. Deviation Z", "Body Gravity Acc Jerk Std. Deviation X", "Body Gravity Acc Jerk Std. Deviation Y", "Body Gravity Acc jerk Std. Deviation Z", "Body Angular Velocity Std. Deviation X", "Body Angular Velocity Std. Deviation Y", "Body Angular Velocity Std. Deviation Z", "Body Angular Velocity Jerk Std. Deviation X", "Body Angular Velocity Jerk Std. Deviation Y", "Body Angular Velocity Jerk Std. Deviation Z", "Body Accelaration Magnitude Std. Deviation", "Body Gravity Acc Magnitude Std. Deviation", "Body Accelaration Jerk Magnitude Std. Deviation", "Body Angular Velocity Magnitude Std. Deviation", "Body Angular Velocity Jerk Magnitude Std. Deviation", "Body Accelaration Frequency Std. Deviation X", "Body Accelaration Frequency Std. Deviation Y", "Body Accelaration Frequency Std. Deviation Z", "Body Accelaration Jerk Frequency Std. Deviation X", "Body Accelaration Jerk Frequency Std. Deviation Y", "Body Accelaration Jerk Frequency Std. Deviation Z", "Body Angular Velocity Frequency Std. Deviation X", "Body Angular Velocity Frequency Std. Deviation Y", "Body Angular Velocity Frequency Std. Deviation Z", "Body Accelaration Frequency Magnitude Std. Deviation", "Body Body Accelaration Jerk Magnitude Std. Deviation", "Body Body Angular Velocity Magnitude Std. Deviation", "Body Body Angular Velocity Jerk Magnitude Std. Deviation")

## Write the tidy data
write.table(allAverages, file="./tidyData.txt", sep=" ", row.name=F)