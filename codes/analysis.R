

#+ include=F
library(dplyr)
library(xlsx)
library(RMySQL)
setwd('D:/Sandbox/OLX_CaseStudy')
data.b2c = read.csv('_docs/b2c.csv', header=TRUE)
data.contacts = read.csv('_docs/contacts.csv', header=TRUE)
data.pay = read.csv('_docs/payments.csv', header=TRUE)
data.multAcc = read.csv('_docs/multiple-accounts.csv', header=TRUE)


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

qry = "Select * from temptbl1"
rsl = dbSendQuery(conn, qry)
temp = dbFetch(rsl,n=-1)
?sapply



