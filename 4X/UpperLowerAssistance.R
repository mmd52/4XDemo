Salary<-c(100,150,350,250,270,450,650)
Age<-c(25,27,30,32,35,37,39)
a<-data.frame(Salary,Age)
a

model<-lm(Salary~Age,data=a)
summary(model)


Age<-c(31)
b<-data.frame(Age)

predict(model,b)-sqrt(deviance(model)/df.residual(model))
#upper
280.6039+(1*96.87)
# Lower
280.6039-(1*96.87)
