data<-read.table('conc_min.csv',TRUE,sep=",")
data
day<-data[,1]
obmintemp<-data[,2]
fcmintemp<-data[,3]

summary(obmintemp)
summary(fcmintemp)
sd(obmintemp,na.rm=TRUE)
sd(fcmintemp)
var(obmintemp,na.rm=TRUE)
var(fcmintemp)

m<-mean(obmintemp,na.rm=TRUE)
std<-sqrt(var(obmintemp,na.rm=TRUE))
m1<-mean(fcmintemp)
std1<-sqrt(var(fcmintemp))

hist(obmintemp,
     prob=TRUE,
     main="Histogram of observed minimum temperature",
     xlab="Temperature, (degrees celcius)",
     col="orange",
     las=1)
curve(dnorm(x, mean=m, sd=std),
      col="darkblue",lwd=2,add=TRUE,yaxt="n")


hist(fcmintemp,
     prob=TRUE,
     main="Histogram of forecast minimum temperature",
     xlab="Temperature, (degrees celcius)",
     col="pink",
     las=1)
curve(dnorm(x, mean=m1, sd=std1),
      col="darkblue",lwd=2,add=TRUE,yaxt="n")

#for a students t test:
t.test(obmintemp,fcmintemp,var.equal=TRUE)

#for an f test:
var.test(obmintemp,fcmintemp,conf.level = 0.9)
?var.test
#for welchs t test:
t.test(obmintemp,fcmintemp,alternative="two.sided",var.equal=FALSE)

#correlation:
cor(obmintemp,fcmintemp,use="complete.obs")
    #method=c("spearman"))
cor.test(obmintemp,fcmintemp,use="complete.obs")
?cor
fit<-lm(fcmintemp~obmintemp)#not sure if i can use as lin reg means one depends on other
summary(fit)
plot(obmintemp,fcmintemp,
     main="Scattergraph of observed minimum temperature and forcast minimum temperature",
     xlab="Observed min temperature, (degrees celcius)",
     ylab="Forecast min temperature, (degrees celcius)",
     col="blue",
     las=1)
abline(lm(fcmintemp~obmintemp), col="darkred")

residuals(fit)
qqnorm(residuals(fit))
qqnorm(obmintemp,
       main="Normal Q-Q plot for observed data")
qqnorm(fcmintemp,
       main="Normal Q-Q plot for forecast data")
obmintemp-fcmintemp

error<-obmintemp-fcmintemp
rmse <- function(error)
{
  sqrt(mean(error^2,na.rm=TRUE))
}

rmse(error)

#turned pair into na values from this point
fcmintemp[140]=NA

obmintemp[1]=3.9

lowobtemp<-(obmintemp<=0)
highobtemp<-obmintemp>0
lowfctemp<-fcmintemp<=0
highfctemp<-fcmintemp>0

aa<-lowobtemp&lowfctemp
a<-length(which((aa==TRUE)))
bb<-highobtemp&lowfctemp
b<-length(which((bb==TRUE)))
cc<-lowobtemp&highfctemp
c<-length(which((cc==TRUE)))
dd<-highobtemp&highfctemp
d<-length(which((dd==TRUE)))

length(which((lowobtemp==TRUE)))
length(which((highobtemp==TRUE)))
length(which((lowfctemp==TRUE)))
length(which((highfctemp==TRUE)))
58+305
a
b
c
d
proba<-a/364
probb<-b/364
probc<-c/364
probd<-d/364

#skill scores and measures of accuracy
phi<-((a*d)-(b*c))/sqrt((a+b)*(c+d)*(a+c)*(b+d))
pod<-a/(a+c)
far<-b/(a+b)
csi<-a/(a+b+c)
accuracy<-(a+d)/(a+b+c+d)
bias<-(a+b)/(a+c)
pofd<-b/(b+d)
heidke<-(2*((a*d)-(b*c)))/((a+b)*(c+d)*(a+c)*(b+d))
hk<-((a*d)-(b*c))/((b+d)*(a+c))
clayton<-((a*d)-(b*c))/((a+b)*(c+d))
aref<-((a+b)*(a+c))/364
ets<-(a-aref)/(a+b+c-aref)



phi
pod
far
csi
accuracy
bias
pofd
heidke
hk
clayton
ets

#PERSISTENCE

data2<-read.table('new.txt')
persistence<-data2[,1]

obmintemp[1]=NA

lowpertemp<-persistence<=0
highpertemp<-persistence>0

aa2<-lowobtemp&lowpertemp
a2<-length(which((aa2==TRUE)))
bb2<-highobtemp&lowpertemp
b2<-length(which((bb2==TRUE)))
cc2<-lowobtemp&highpertemp
c2<-length(which((cc2==TRUE)))
dd2<-highobtemp&highpertemp
d2<-276

length(which((lowobtemp==TRUE)))
length(which((highobtemp==TRUE)))
length(which((lowpertemp==TRUE)))
length(which((highpertemp==TRUE)))

phi2<-((a2*d2)-(b2*c2))/sqrt((a2+b2)*(c2+d2)*(a2+c2)*(b2+d2))
pod2<-a2/(a2+c2)
far2<-b2/(a2+b2)
csi2<-a2/(a2+b2+c2)
accuracy2<-(a2+d2)/(a2+b2+c2+d2)
bias2<-(a2+b2)/(a2+c2)
pofd2<-b2/(b2+d2)
heidke2<-(2*((a2*d2)-(b2*c2)))/((a2+b2)*(c2+d2)*(a2+c2)*(b2+d2))
hk2<-((a2*d2)-(b2*c2))/((b2+d2)*(a2+c2))
clayton2<-((a2*d2)-(b2*c2))/((a2+b2)*(c2+d2))
aref2<-((a2+b2)*(a2+c2))/363
ets2<-(a2-aref2)/(a2+b2+c2-aref2)



phi2
pod2
far2
csi2
accuracy2
bias2
pofd2
heidke2
hk2
clayton2
ets2

#CLIMATE

problow<-59/364
#problow<-length(which((lowobtemp==TRUE)))/364
climate<-sample(c(0,1),365,replace=TRUE,prob=c(1-problow,problow))
climate
climate[140]=NA

lowclimtemp<-climate==1
highclimtemp<-climate==0

aa3<-lowobtemp&lowclimtemp
a3<-length(which((aa3==TRUE)))+1
bb3<-highobtemp&lowclimtemp
b3<-length(which((bb3==TRUE)))
cc3<-lowobtemp&highclimtemp
c3<-length(which((cc3==TRUE)))
dd3<-highobtemp&highclimtemp
d3<-length(which((dd3==TRUE)))

length(which((lowclimtemp==TRUE)))
length(which((highclimtemp==TRUE)))

a3
b3
c3
d3

phi3<-((a3*d3)-(b3*c3))/sqrt((a3+b3)*(c3+d3)*(a3+c3)*(b3+d3))
pod3<-a3/(a3+c3)
far3<-b3/(a3+b3)
csi3<-a3/(a3+b3+c3)
accuracy3<-(a3+d3)/(a3+b3+c3+d3)
bias3<-(a3+b3)/(a3+c3)
pofd3<-b3/(b3+d3)
heidke3<-(2*((a3*d3)-(b3*c3)))/((a3+b3)*(c3+d3)*(a3+c3)*(b3+d3))
hk3<-((a3*d3)-(b3*c3))/((b3+d3)*(a3+c3))
clayton3<-((a3*d3)-(b3*c3))/((a3+b3)*(c3+d3))
aref3<-((a3+b3)*(a3+c3))/364
ets3<-(a3-aref3)/(a3+b3+c3-aref3)

phi3
pod3
far3
csi3
accuracy3
bias3
pofd3
heidke3
hk3
clayton3
ets3

skillscore1<-(34-31)/(59-31) #compare forecast to persistence
skillscore2<-(34-12)/(59-12) #compare forecast to climatology


