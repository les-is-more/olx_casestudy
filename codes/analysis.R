#' ---
#' title: "OLX Case Study"
#' author: "Lester Cajegas"
#' date: "March 20, 2018"
#' output: 
#'   pdf_document:
#'   latex_engine: pdflatex
#' fig_caption: yes
#' ---
  
#' ###OLX Case Study
#' This document presents the analysis made and insights gathered for the sample data
#' given by OLX as part of its hiring process.
#' 
#' We will breakdown the output by question for easier understanding.
#' 

#' Show how we can prioritize which users should the Sales team approach first.
#'    * Using MS Excel Formulas (bottom-up approach)
#'     * Using VBA or pseudocode (bottom-up approach) to write the classification inside MS Excel
#' Show how we can bucket the classification of users based on the business they bring to OLX.
#' 

#+ echo=F, fig.cap = "Simulation of k-mean centers, compared through plots"

kmeansSim = function (k, data){
  v= c()
  for (i in 1:k ) {
    rslt = kmeans(data,i)
    v = rbind(v,c(i,rslt$betweenss / rslt$totss))
  }
  plot(v, type='l', xlab='Number of K or Centers', ylab='% Sum of Squares Explained')
}

par(mar=c(4,4,3,3))
par(mfrow=c(1,4))
kmeansSim(10,temptbl[1:3])
kmeansSim(10,temptbl[1:4])
kmeansSim(10,temptbl[1:5])
kmeansSim(10,temptbl[1:6])