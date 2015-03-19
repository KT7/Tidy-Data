The following contains a description of the variables in the output tidy data set.

"subject" -is a variable with values 1-30 that uniquely identifies a subject in the experiment (unitless).

"activity" -is a variable that describes that activity being performed by the corresponding subject. Its values are "WALKING," "WALKING_UPSTAIRS," "WALKING_DOWNSTAIRS," "SITTING," "STANDING," and "LAYING." These are associated with the numbers 1-6, respectively, in previous steps of the code. 

The remaining variables represent average values for each unique combination of subject and activity (30 subjects, 6 activities = 180 such combinations) of the mean and standard deviation measurements contained in the variables below. In other words, for multiple values of mean or standard deviation measurements on one of the variables below from a fixed subject and fixed activity are averaged in the tidy data set.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

