data<-read.table('EWP_seasonal2.txt',TRUE)
year<-data[,1]
win<-data[,2]
spr<-data[,3]
sum<-data[,4]
aut<-data[,5]
annual<-data[,6]

#Sorting data issues - these values did not exist
annual[251]=NaN
spr[251]=NaN
sum[251]=NaN
aut[251]=NaN
win[1]=NaN

#Question 1 - exploratory data analysis
summary(annual)
summary(win)
summary(spr)
summary(sum)
summary(aut)

sd(annual,na.rm=TRUE)
sd(win,na.rm=TRUE)
sd(spr,na.rm=TRUE)
sd(sum,na.rm=TRUE)
sd(aut,na.rm=TRUE)

var(annual,na.rm=TRUE)
var(win,na.rm=TRUE)
var(spr,na.rm=TRUE)
var(sum,na.rm=TRUE)
var(aut,na.rm=TRUE)

#All histograms have normal curves just in case,
#autumn and winter have gamma curves for question 3
stda<-sqrt(var(annual,na.rm=TRUE))
ma<-mean(annual,na.rm=TRUE)
hist(annual, breaks=10,
     prob=TRUE,
     ylim=c(0,0.004),
     xlab="Annual rainfall accumulation (mm)",
     col="plum3",
     main="Histogram of annual rainfall")
curve(dnorm(x, mean=ma, sd=stda),
      col="darkblue",lwd=2,add=TRUE,yaxt="n")
curve(dgamma(x,rate=la.est,shape=aa.est),
      col="purple",lwd=2,add=TRUE,yaxt="n")

stdw<-sqrt(var(win,na.rm=TRUE))
mw<-mean(win,na.rm=TRUE)
hist(win, breaks=20,
     prob=TRUE,
     ylim=c(0,0.007),
     xlab="Winter rainfall accumulation (mm)",
     col="coral1",
     main="Histogram of winter rainfall")
curve(dnorm(x, mean=mw, sd=stdw),
      col="darkblue",lwd=2,add=TRUE,yaxt="n")
curve(dgamma(x,rate=lw.est,shape=aw.est),
      col="purple",lwd=2,add=TRUE,yaxt="n")

stdsp<-sqrt(var(spr,na.rm=TRUE))
msp<-mean(spr,na.rm=TRUE)
hist(spr, breaks=20,
     prob=TRUE,
     ylim=c(0,0.01),
     xlab="Spring rainfall accumulation (mm)",
     col="cadetblue2",
     main="Histogram of spring rainfall")
curve(dnorm(x, mean=msp, sd=stdsp),
      col="darkblue",lwd=2,add=TRUE,yaxt="n")

stdsu<-sqrt(var(sum,na.rm=TRUE))
msu<-mean(sum,na.rm=TRUE)
hist(sum, breaks=20,
     prob=TRUE,
     ylim=c(0,0.01), 
     xlab="Summer rainfall accumulation (mm)",
     col="aquamarine2",
     main="Histogram of summer rainfall")
curve(dnorm(x, mean=msu, sd=stdsu),
      col="darkblue",lwd=2,add=TRUE,yaxt="n")

stdau<-sqrt(var(aut,na.rm=TRUE))
mau<-mean(aut,na.rm=TRUE)
hist(aut, breaks=20,
     prob=TRUE,
     ylim=c(0,0.01),
     xlab="Autumn rainfall accumulation (mm)",
     col="cornsilk2",
     main="Histogram of autumn rainfall")
curve(dnorm(x, mean=mau, sd=stdau),
      col="darkblue",lwd=2,add=TRUE,yaxt="n")
curve(dgamma(x,rate=l.est,shape=a.est),
      col="purple",lwd=2,add=TRUE,yaxt="n")

#Question 2 - are the means of summer and winter equal
#point estimate and interval estimate of means

var.test(win,sum,conf.level = 0.95)
?var.test

t.test(win,sum,var.equal=TRUE)
#standard errors for interval estimates
stdw/sqrt(250)
stdsu/sqrt(250)

#Question 3 - Use normal and gamma distributions for aut/win
#to estimate probability of extreme events again

#Testing if normal distributions
qqnorm(win,
       main="Normal Q-Q Plot (winter)")
abline(mean(win,na.rm=TRUE),sd(win,na.rm=TRUE))

qqnorm(aut,
       main="Normal Q-Q Plot (autumn)")
abline(mean(aut,na.rm=TRUE),sd(aut,na.rm=TRUE))

#Finding gamma parameters and plotting gamma/normal
#distributions with those parameters

library(stats4) ## loading package stats4

#AUTUMN
#First estimates
l.est<-mau/var(aut,na.rm=TRUE) ## lambda estimate (corresponds to rate)
a.est<-((mau)^2)/var(aut,na.rm=TRUE) ## alfa estimate
x.gam<-rgamma(251,rate=l.est,shape=a.est) 
#Improving
ll<-function(lambda,alfa) {n<-251
x<-x.gam
-n*alfa*log(lambda)+n*log(gamma(alfa))-(alfa-
                                          1)*sum(log(x))+lambda*sum(x)} ## -log-likelihood function
est<-mle(minuslog=ll, start=list(lambda=2,alfa=1))
summary(est)
#results: lambda=0.06203054 std error 0.00553348, alfa=16.57453694 std error=1.45668479

#Plot histograms with those parameters (might need)
x.gamimp<-rgamma(251,rate=0.06203054,shape=16.57453694)
hist(x.gamimp,breaks=20)
x.nor<-rnorm(251,mean=mau,sd=stdau)
hist(x.nor,breaks=20)

#Add lines to data histogram:
hist(aut, breaks=20,
     prob=TRUE,
     ylim=c(0,0.01),
     xlab="Autumn rainfall accumulation (mm)",
     col="cornsilk2",
     main="Histogram of autumn rainfall")
curve(dnorm(x, mean=mau, sd=stdau),
      col="darkblue",lwd=2,add=TRUE,yaxt="n")
curve(dgamma(x,rate=0.06203054,shape=16.57453694),
      col="purple",lwd=2,add=TRUE,yaxt="n")

#WINTER
#First estimates
lw.est<-mw/var(win,na.rm=TRUE) ## lambda estimate (corresponds to rate)
aw.est<-((mw)^2)/var(win,na.rm=TRUE) ## alfa estimate
xw.gam<-rgamma(251,rate=lw.est,shape=aw.est) 

#Improving
ll<-function(lambda,alfa) {n<-251
x<-xw.gam
-n*alfa*log(lambda)+n*log(gamma(alfa))-(alfa-
                                          1)*sum(log(x))+lambda*sum(x)} ## -log-likelihood function
estw<-mle(minuslog=ll, start=list(lambda=2,alfa=1))
summary(estw)

#Results: lambda=0.06159817 std error 0.00550508, alfa=13.95274323 std error 1.22502626

#Plotting histograms with these results, (might need)
xw.gamimp<-rgamma(251,rate=0.06159817,shape=13.95274323)
hist(xw.gamimp,breaks=20)
xw.nor<-rnorm(251,mean=mw,sd=stdw)
hist(xw.nor,breaks=20)

#Add lines to data histogram
hist(win, breaks=20,
     prob=TRUE,
     ylim=c(0,0.007),
     xlab="Winter rainfall accumulation (mm)",
     col="coral1",
     main="Histogram of winter rainfall")
curve(dnorm(x, mean=mw, sd=stdw),
      col="darkblue",lwd=2,add=TRUE,yaxt="n")
curve(dgamma(x,rate=0.06159817,shape=13.95274323),
      col="purple",lwd=2,add=TRUE,yaxt="n")

#Finding the probabilities using the parameters
#autumn
pnorm(502.7,mean=mau,sd=stdau,lower.tail=FALSE,log.p=FALSE)
pgamma(502.7,shape=16.57453694,rate=0.06203054,lower.tail=FALSE,log.p=FALSE)

#winter
pnorm(455.5,mean=mw,sd=stdw,lower.tail=FALSE,log.p=FALSE)
pgamma(455.5,shape=13.95274323,rate=0.06159817,lower.tail=FALSE,log.p=FALSE)


#annual - This is for question 6
la.est<-ma/var(annual,na.rm=TRUE) ## lambda estimate (corresponds to rate)
aa.est<-((ma)^2)/var(annual,na.rm=TRUE) ## alfa estimate
x.gam<-rgamma(251,rate=la.est,shape=aa.est) 
x.nor<-rnorm(251,mean=ma,sd=stda)



#Question 4 - are standard deviations changing over time

#calculating sd every 30 years
sd(data[1:30,6])
sd(data[31:60,6])
sd(data[61:90,6])
sd(data[91:120,6])
sd(data[121:150,6])
sd(data[151:180,6])
sd(data[181:210,6])
sd(data[211:251,6]) #bigger sample so should have smaller sd, but is bigger indicating change

#plotting sd every 30 years
sddata<-c(142.103,98.54169,127.7639,129.6598,110.47,99.97463,125.0866,200.253)
ndata<-c(1,2,3,4,5,6,7,8)
plot(ndata,sddata,
     main="Plot of standard deviation over time",
     xlab="Time period, (every 30 years, beginning 1766)",
     ylab="standard deviation",
     type="p",
     col="darkblue")

#Testing correlation of the two
cor(sddata,ndata)
qqnorm(sddata)
fit<-lm(sddata~ndata)
summary(fit)

#plotting ordered mean data
sddata2<-c(98.54169,99.97463,110.47,125.0866,127.7639,129.6598,142.103,200.253)
plot(ndata,sddata2,
     main="Plot of increasing standard deviation",
     xlab="Ordered by size",
     ylab="standard deviation",
     type="p",
     col="darkblue")

#Question 5 - autocorrelation for annual data

#plot the time series
plot(year,annual,type="l",
     main="Annual rainfall accumulation",
     xlab="Year",
     ylab="Rainfall accumulation, (mm)")

#plot mean every 30 years
mean(data[1:30,6])
mean(data[31:60,6])
mean(data[61:90,6])
mean(data[91:120,6])
mean(data[121:150,6])
mean(data[151:180,6])
mean(data[181:210,6])
mean(data[211:251,6])
meandata<-c(909,895.9,902.7,938.2,888.8,926.7,920.2,926.4)
plot(ndata,meandata,
     main="Plot of mean annual rainfall accumulation data every 30 years",
     xlab="Time, (x30 years)",
     ylab="Mean value")
abline(lsfit(meandata,ndata))

#plot autocorrelation lag 1 year 
plot(annual[1:249],annual[2:250],
     main="Autocorrelation with a time lag of 1 year",
     xlab="annual rainfall accumulation (w)/mm",
     ylab="annual rainfall accumulation (w+1)/mm")
abline(lsfit(annual[1:249],annual[2:250]),lwd=2,col=3)
cor(annual[1:249],annual[2:250])

#plot autocorrelation lag 3 years 
plot(annual[1:247],annual[4:250],
     main="Autocorrelation with a time lag of 3 years",
     xlab="annual rainfall accumulation (w)/mm",
     ylab="annual rainfall accumulation (w+3)/mm")
abline(lsfit(annual[1:247],annual[4:250]),lwd=2,col=3)
cor(annual[1:247],annual[4:250])

summary(lm(annual[1:249]~year[2:250]))
summary(lm(annual[1:247]~year[4:250]))
summary(lm(annual[1:248]~year[3:250]))
summary(lm(annual[1:244]~year[7:250]))

#Plot acf
acf(annual,lag.max=50,na.action=na.pass)

#using ols to estimate beta parameters?
ar(annual,na.action=na.omit,method="ols")
Box.test(annual,lag=20,type="Ljung-Box")

#use linear model??
lm(annual~year)


#Question 6 - probability of over 1000mm in 2017

#prove it is normally distributed
qqnorm(annual,
       main="Normal Q-Q plot for annual data")
abline(mean(annual,na.rm=TRUE),sd(annual,na.rm=TRUE))

#not sure if i need this, it is a anderson darling normality test, but proves non normaility
#because small p value. This test is not good with very large data sets.
library(nortest)
install.packages("nortest")
library(nortest)
ad.test(annual)

#shapiro-wilkes test for normality
shapiro.test(annual)

#annual histogram with normal curve over
hist(annual, breaks=10,
     prob=TRUE,
     ylim=c(0,0.004),
     xlab="Annual rainfall accumulation (mm)",
     col="plum3",
     main="Histogram of annual rainfall")
curve(dnorm(x, mean=ma, sd=stda),
      col="darkblue",lwd=2,add=TRUE,yaxt="n")

#finding probability
pnorm(1000,mean=ma,sd=stda,lower.tail=FALSE,log.p=FALSE)


#Question 7
#Is there a trend
ma <- function(x,n=5){filter(x,rep(1/n,n), sides=2)}
#annual
plot(year[1:250],annual[1:250],type="l",
     main="Annual rainfall accumulation",
     xlab="Year",
     ylab="Rainfall accumulation(mm)")
abline(lsfit(year[1:250],annual[1:250]),col=1)
lines(lowess(year[1:250],annual[1:250]),col=2)
lines(year,ma(annual),type="l",col="3")

plot(year,ma(annual),type="l")
lm(ma(annual)~year)
fit<-lm(annual[1:250]~year[1:250])
summary(fit)

#Use lowess fit to find more robust look for a trend - says in practical
fit<-lowess(year[1:250],annual[1:250])
fit$x
fit$y
plot(year[1:250],fit$y,
     main="Low pass smoothed annual rainfall accumulation",
     xlab="Year",
     ylab="Rainfall accumulation (mm)")

ndata2<-c(1:251)
lm(annual~ndata2)

#winter
plot(year[2:251],win[2:251],type="l",
     main="Winter rainfall accumulation",
     xlab="Year",
     ylab="Rainfall accumulation(mm)")
abline(lsfit(year[2:251],win[2:251]),col=1)
lines(lowess(year[2:251],win[2:251]),col=2)
lines(year,ma(win),type="l",col="3")

plot(year,ma(win),type="l")
lm(ma(win)~year)
fit<-lm(win[1:250]~year[1:250])
summary(fit)

#Use lowess fit to find more robust look for a trend - says in practical
fitw<-lowess(win[2:251],win[2:251])
fitw$x
fitw$y
plot(year[1:250],fitw$y,
     main="Low pass smoothed winter rainfall accumulation",
     xlab="Year",
     ylab="Rainfall accumulation (mm)")

ndata2<-c(1:251)
lm(win~ndata2)

#Spring
plot(year[1:250],spr[1:250],type="l",
     main="Spring rainfall accumulation",
     xlab="Year",
     ylab="Rainfall accumulation(mm)")
abline(lsfit(year[1:250],spr[1:250]),col=1)
lines(lowess(year[1:250],spr[1:250]),col=2)
lines(year,ma(spr),type="l",col="3")

plot(year,ma(spr),type="l")
lm(ma(spr)~year)
fit<-lm(spr[1:250]~year[1:250])
summary(fit)

#Use lowess fit to find more robust look for a trend - says in practical
fitsp<-lowess(year[1:250],spr[1:250])
fitsp$x
fitsp$y
plot(year[1:250],fitsp$y,
     main="Low pass smoothed spring rainfall accumulation",
     xlab="Year",
     ylab="Rainfall accumulation (mm)")

ndata2<-c(1:251)
lm(spr~ndata2)

#SUMMER
plot(year[1:250],sum[1:250],type="l",
     main="Summer rainfall accumulation",
     xlab="Year",
     ylab="Rainfall accumulation(mm)")
abline(lsfit(year[1:250],sum[1:250]),col=1)
lines(lowess(year[1:250],sum[1:250]),col=2)
lines(year,ma(sum),type="l",col="3")

plot(year,ma(sum),type="l")
lm(ma(sum)~year)
fit<-lm(sum[1:250]~year[1:250])
summary(fit)

#Use lowess fit to find more robust look for a trend - says in practical
fitsu<-lowess(year[1:250],sum[1:250])
fitsu$x
fitsu$y
plot(year[1:250],fitsu$y,
     main="Low pass smoothed summer rainfall accumulation",
     xlab="Year",
     ylab="Rainfall accumulation (mm)")

ndata2<-c(1:251)
lm(sum~ndata2)

#AUTUMN
plot(year[1:250],aut[1:250],type="l",
     main="Autumn rainfall accumulation",
     xlab="Year",
     ylab="Rainfall accumulation(mm)")
abline(lsfit(year[1:250],aut[1:250]),col=1)
lines(lowess(year[1:250],aut[1:250]),col=2)
lines(year,ma(aut),type="l",col="3")

plot(year,ma(aut),type="l")
lm(ma(aut)~year)
fit<-lm(aut[1:250]~year[1:250])
summary(fit)
fit<-lm(aut[175:250]~year[175:250])
summary(fit)
#Use lowess fit to find more robust look for a trend - says in practical
fitau<-lowess(year[1:250],aut[1:250])
fitau$x
fitau$y
plot(year[1:250],fitau$y,
     main="Low pass smoothed autumn rainfall accumulation",
     xlab="Year",
     ylab="Rainfall accumulation (mm)")

ndata2<-c(1:251)
lm(aut~ndata2)

#Question 8

14/246

list<-c(1767,1772,1809,1875,1876,1877,1878,1879,1880,1922,1965,1979,1998,1999)
plot(year[1:250],annual[1:250],type="l",
     main="Annual rainfall accumulation",
     xlab="Year",
     ylab="Rainfall accumulation(mm)",
     col="3")
abline(v=1767)
abline(v=1772)
abline(v=1809)
abline(v=1875)
abline(v=1876)
abline(v=1877)
abline(v=1878)
abline(v=1879)
abline(v=1880)
abline(v=1922)
abline(v=1965)
abline(v=1979)
abline(v=1998)
abline(v=1999)

#Question 9 
cor_for<-cor(win,annual,use="complete.obs")
cor_for
fit_for<-lm(annual~win)
summary(fit_for)


##############################################
#Daniell method of smoothing
k=kernel("daniell",4)
k1=kernel("daniell",c(4,4))
spec.pgram(annual[1:250],k,taper=0,log="no")
spec.pgram(annual[1:250],k1,taper=0,log="no")

#Lecture method of smoothing
spectrum(annual[1:250])
abline(v=1/7.4,lty="dotted")
abline(v=1/2.7,lty="dotted")
abline(v=1/2.05,lty="dotted")

#spectrum(annual[1:250],spans=c(5))
spectrum(annual[1:250],spans=c(10))
abline(v=1/2.86,lty="dotted")
abline(v=1/2.97,lty="dotted")
abline(v=1/2.4,lty="dotted")
abline(v=1/3.3,lty="dotted")
#spectrum(annual[1:250],spans=c(12))
#spectrum(annual[1:250],spans=c(14))
