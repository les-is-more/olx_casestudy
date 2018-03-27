library(knitr)
library(rmarkdown)

setwd('D:/Sandbox/OLX_CaseStudy/codes')
rmarkdown::render('analysis.R', output_file = 'olx.pdf', output_dir = '.')

