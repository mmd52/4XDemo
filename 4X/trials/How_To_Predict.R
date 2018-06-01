dat<-read.csv('trial.csv',header=TRUE)

View(head(dat))

plot(dat$Salary~dat$Age)

slr<-lm(Salary~.,data=dat)

summary(slr)

Age=c(27,67)
Car=c('Yes','No')
df = data.frame(Age,Car)

predict(slr,df)
