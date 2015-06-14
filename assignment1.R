
# Read Data 
mydataset <- read.csv("activity.csv")
#head(mydataset)
#summary(mydataset)

#Get total steps ber day - using tapply
totstepsbydate <- tapply(mydataset$steps, mydataset$date, sum)

#Plot histogram
hist(totstepsbydate,  xlab = "Steps Per Day", ylab = "Interval", main = "Steps per day")

#remove na values
totstepsbydate <- totstepsbydate[!is.na(totstepsbydate)]

#Mean and madin 
meanvalue <- mean(totstepsbydate)
meanvalue
medianvalue <- median(totstepsbydate)
medianvalue

# Calculate mean steps / interval (Remove NA values)
meansteps <- tapply(mydataset$steps, mydataset$interval, mean,na.rm = TRUE)

# Plot line graph of average daily activity pattern
plot(row.names(meansteps), meansteps, type = "l", xlab = "5-minute interval", 
     ylab = "Steps taken, averaged across all days ", main = "Average daily activity pattern", 
     )
# Maximum average number of steps over all days
names(which.max(meansteps))

#Total of NA values
sum(is.na(mydataset))

#Replace NA values with mean 
#rep(mean(mydataset$steps, na.rm=TRUE), times=length(which(is.na(mydataset))))

# Loop thru data and replace NA with meanstep value
for (i in 1:dim(mydataset)[1]) {
#  for (i in 1:20) {   
    #ifelse (is.na(mydataset$steps[i]) ,  print (c('X',i,(mydataset$steps[i])) ),print (c(i,(mydataset$steps[i])) ))
    ifelse (is.na(mydataset$steps[i]) ,   mydataset$steps[i] <- meansteps[i] ,NA)
  }

sum(is.na(mydataset))
sum(mydataset$steps)

#Re-calc using tapply as NA has been replaced and Plot Histogram 
newtotalsteps <- tapply(mydataset$steps, mydataset$date, sum)
hist(newtotalsteps,  xlab = "Total Steps / Day", ylab = "Frequency", main = "Total Steps taken per day - with average meanstep")

#Mean and madin 
meanvalue <- mean(newtotalsteps)
meanvalue
medianvalue <- median(newtotalsteps)
medianvalue
 
