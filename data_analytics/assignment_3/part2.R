outcome <- read.csv("outcome-of-care-measures.csv", colClasses="character")
outcome[,11]<- as.numeric(outcome[,11])
outcome[,17]<- as.numeric(outcome[,17])
outcome[,23]<- as.numeric(outcome[,23])
par(mfrow=c(3,1))
m <- mean(outcome[,11])
#hist(outcome[,11],main=paste("Heart Attack  (X=",mean(outcome[,11],na.rm=TRUE),")"),xlab="30-day Death Rate",xlim=range(outcome[,11],outcome[,17],outcome[,23],na.rm=TRUE))

hist(outcome[,11],main=substitute(expression(Heart ~ Attack ~ bar(X) ~ m),list(m = 1)),xlab="30-day Death Rate",xlim=range(outcome[,11],outcome[,17],outcome[,23],na.rm=TRUE))
abline(v=mean(outcome[,11],na.rm=TRUE))

hist(outcome[,17],main=paste("Heart Failure  (X=",mean(outcome[,17],na.rm=TRUE),")"),xlab="30-day Death Rate",xlim=range(outcome[,11],outcome[,17],outcome[,23],na.rm=TRUE))
abline(v=mean(outcome[,17],na.rm=TRUE))

#hist(outcome[,23],main=paste("Pneumonia  (bar(X)=",mean(outcome[,23],na.rm=TRUE),")"),xlab="30-day Death Rate",xlim=range(outcome[,11],outcome[,17],outcome[,23],na.rm=TRUE))
hist(outcome[,23],main=expression(Pneumonia ~ bar(X) ~ mean(outcome[,23])),xlab="30-day Death Rate",xlim=range(outcome[,11],outcome[,17],outcome[,23],na.rm=TRUE))

abline(v=mean(outcome[,23],na.rm=TRUE))
