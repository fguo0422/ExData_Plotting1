# course project 1 for Exploreer Analysis 

#libraries used in this project 
library('dplyr')

#download and unzip files to the working directory
setwd("H:/Trainings/coursera/DataScience_2021/ExplorerAnalysis")
#download file from website 
download.file(url='https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip',
                     destfile = 'power.zip')
unzip('power.zip')

#read 5 sample rows, get column names and classes for full dataset read-in 
sample <- read.table("household_power_consumption.txt",header = TRUE,nrows = 5, sep = ";")
classes <-sapply(sample,class)

#read in hw required data, once the last date read in is after 2007/02/01, stop 
for ( i in seq(10000,1000000, 10000)) {
       print(i)
        power <- read.table("household_power_consumption.txt",header = TRUE, sep = ";",
                            colClasses=classes,na.strings='?',nrows = i,
                            strip.white = TRUE,blank.lines.skip = TRUE ) 
        
        LastDateReadIn <- tail(power,1)$Date
        print(LastDateReadIn)
        if (as.Date(LastDateReadIn,format="%d/%m/%Y") >as.Date('01/02/2007',format="%d/%m/%Y")) {
                print("enough data for hw")
                power$Date <- as.Date(power$Date,format="%d/%m/%Y" )
              break  
        }  
}


power_hw <- power[power$Date %in% as.Date(c('1/2/2007','2/2/2007'),format="%d/%m/%Y"),]

dim(power_hw)
power_hw$Time <-strptime(paste(power_hw$Date, power_hw$Time, sep=' '),format='%Y-%m-%d %H:%M:%S')
head(power_hw$Time)


#plot1 histogram for global active power
png(filename='plot1.png', width=480, height=480, units='px')
plot.new()
with(power_hw, hist(Global_active_power,col = 'red',main='Global Active Power',xlab='Global Active Power(kilowatts)') )
dev.off()



