data<-read.table('christmas.dat',FALSE)
data

year<-data[,1]
snowday<-data[,2]
precip<-data[,3]
mintemp<-data[,4]

summary(snowday)
summary(precip)
summary(mintemp)

m<-mean(mintemp)
sd(precip)
sd(mintemp)
std<-sqrt(var(mintemp))


hist(mintemp, prob=TRUE,
     ylim=c(0,0.09),
     xlab="Minimum temperature (degrees celcius)",
     main="Histogram of minimum daily temperature")
curve(dnorm(x, mean=m, sd=std),
      col="darkblue",lwd=2,add=TRUE,yaxt="n")


precip[27]=NaN
precip[29]=NaN
precip[30]=NaN
summary(precip[1:118])
#summary for every 10 years of precipitation data
summary(data[1:118,3])
summary(data[119:225,3])
summary(data[226:333,3])
summary(data[334:440,3])
summary(data[441:528,3])
#summary for every 10 years of min temp data
summary(data[1:118,4])
summary(data[119:225,4])
summary(data[226:333,4])
summary(data[334:440,4])
summary(data[441:528,4])
#summary for every 10 years of snow day data
summary(data[1:118,2])
summary(data[119:225,2])
summary(data[226:333,2])
summary(data[334:440,2])
summary(data[441:528,2])

#Days where there is precipitation
yprecip<-precip[precip>0]

#Days where the minimum temperature is below 0
freezingtemp<-mintemp[mintemp<0]

#Days that are snow days
#ysnow<-snowday[snowday==1]
#Days that have precipitation and are snow days
#pands<-(precip>0)&(snowday==1)

#Days that have precipitation and min temp below zero
precandcold<-(precip>0)&(mintemp<0)
count0<-length(which(precandcold==TRUE))

#Probability of min temp below zero given that there is precipitation
Prob1<-count0/151
Prob1

#Probability of precipitation given that the min temp is below zero
Prob2<-count0/282
Prob2

precip[27]=NaN
precip[29]=NaN
precip[30]=NaN
summary(precip)
sd(precip,na.rm=TRUE)
hist(precip,
     xlim=c(0,30),
     xlab="precipitation amount (mm)",
     main="Histogram of precipitation amount")



