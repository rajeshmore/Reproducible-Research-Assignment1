### Loading and preprocessing the data

# Read Data 
mydataset <- read.csv("activity.csv")
#head(mydataset)
#summary(mydataset)

### What is mean total number of steps taken per day?

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

#TOTAL AND MISSING VALUES
nrow(mydataset) - 17568
sum(is.na(mydataset$steps)) -- 2304
meanstepsday <- tapply(mydataset$steps, mydataset$date, mean)

# Calculate mean steps / interval (Remove NA values)
meansteps <- tapply(mydataset$steps, mydataset$interval, mean, na.rm = TRUE)

### What is the average daily activity pattern?
# Plot line graph of average daily activity pattern
plot(row.names(meansteps), meansteps, type = "l", xlab = "5-minute interval", 
  ylab = "Steps taken, averaged across all days ", main = "Average daily activity pattern", )
# Maximum average number of steps over all days
names(which.max(meansteps))

#Total of NA values
sum(is.na(mydataset))

### Imputing missing values
# Loop thru data and replace NA with meanstep value
for (i in 1:dim(mydataset)[1]) {
  #  for (i in 1:20) {   
  #ifelse (is.na(mydataset$steps[i]) ,  print (c('X',i,(mydataset$steps[i])) ),print (c(i,(mydataset$steps[i])) ))
  ifelse (is.na(mydataset$steps[i]) ,   mydataset$steps[i] <-  mean(meansteps) ,mydataset$steps[i] <- mydataset$steps[i])
}

#Check na got removed
nrow(mydataset) 
sum(is.na(mydataset$steps)) 

#Re-calc using tapply as NA has been replaced and Plot Histogram 
newtotalsteps <- tapply(mydataset$steps, mydataset$date, sum)
hist(newtotalsteps,  xlab = "Total Steps / Day", ylab = "Frequency", main = "Total Steps taken per day - with average meanstep")
#Mean and madin 
meanvalue <- mean(newtotalsteps)
meanvalue
medianvalue <- median(newtotalsteps)
medianvalue

### Are there differences in activity patterns between weekdays and weekends?

mydataset$date <- as.Date(mydataset$date)
getdays <- weekdays(mydataset$date)
mydataset$week_weekend <- ifelse(getdays == "Saturday" | getdays == "Sunday", "Weekend", "Weekday")
mv <- aggregate(mydataset$steps, by = list(mydataset$interval, mydataset$week_weekend), mean)                                                                          
names(mv) <- c("interval", "week_weekend", "steps")
a <- xyplot( mydataset$steps ~  mydataset$interval |  mydataset$week_weekend, mv, type = "l", layout = c(1, 2), xlab = "Interval", ylab = "Number of steps")
print(a)

#mean, median, max and min of the steps across all intervals and days by Weekdays/Weekends
tapply(mv$steps, mv$week_weekend, function(x) {
  c(MINIMUM = min(x), MEAN = mean(x), MEDIAN = median(x), MAXIMUM = max(x))
})

