#+ include=F
library(dplyr)
library(RMySQL)
setwd('D:/Sandbox/OLX_CaseStudy')
data.b2c = read.csv('_docs/b2c.csv', header=TRUE)
data.contacts = read.csv('_docs/contacts.csv', header=TRUE)
data.pay = read.csv('_docs/payments.csv', header=TRUE)
data.multAcc = read.csv('_docs/multiple-accounts.csv', header=TRUE)
data.retail = read.csv('_docs/retail.csv', header=TRUE)
data.view = read.csv('_docs/viewers.csv', header=TRUE)

#' The below code creates the connection to our MySQL database.
conn = dbConnect(RMySQL::MySQL(), 
                 host = 'localhost',
                 user='root', 
                 password='Diapox1990',
                 dbname = "olx")

#+ include=F
dbWriteTable(conn,'b2c',data.b2c)
dbWriteTable(conn,'contacts',data.contacts)
dbWriteTable(conn,'pay',data.pay)
dbWriteTable(conn,'multAcc',data.multAcc)
dbWriteTable(conn,'viewers',data.view)
dbWriteTable(conn,'retail',data.retail)

qry = 'Select * from olx.test1' 
result = dbSendQuery(conn = conn, qry)
temptbl = fetch(result,n=-1)


max(data.contacts$Number.of.Buyers.Who.Initiated.Contact.within.3.days, na.rm=TRUE)
data.contacts %>% select(Category.ID,Number.of.Buyers.Who.Initiated.Contact.within.3.days) 
attach(data.contacts)
boxplot(Number.of.Buyers.Who.Initiated.Contact.within.3.days ~ Category.ID)

rslt = kmeans(temptbl,3)
rslt$betweenss / rslt$totss * 100

kmeansSim = function (k, data){
  v= c()
  for (i in 1:k ) {
    rslt = kmeans(data,i)
    v = rbind(v,c(i,rslt$betweenss / rslt$totss))
  }
  plot(v, type='l', main = paste0('Scree Plot'), xlab='Number of K or Centers', ylab='% Sum of Squares Explained')
}

#+ echo=F
par(mar=c(4,4,3,3))
par(mfrow=c(1,4))
kmeansSim(10,temptbl[1:3])
kmeansSim(10,temptbl[1:4])
kmeansSim(10,temptbl[1:5])
kmeansSim(10,temptbl[1:6])

par(mfrow=c(1,1))
pr.rsl = prcomp(temptbl[2:6], scale=TRUE, center = TRUE)
plot(pr.rsl, type='l')


#' Bootstrap estimates
#' 

#+ include=F

library(boot)
set.seed(1)
est.fun = function (data,ind){
  x = sort(sample(data,50, replace=FALSE))
  y = ceiling(NROW(x) * 0.3)
  z = x[y]
  return(z)
}

boot(temptbl$TotalAds,est.fun,R=1000)

