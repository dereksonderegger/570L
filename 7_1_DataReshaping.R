## ----echo=FALSE----------------------------------------------------------
opts_chunk$set(cache.path =  './cache/ReshapingData/',
               fig.path   = './figure/ReshapingData/')

## ------------------------------------------------------------------------
grade.book <- rbind(
  data.frame(name='Alison',  HW.1=8, HW.2=5, HW.3=8),
  data.frame(name='Brandon', HW.1=5, HW.2=3, HW.3=6),
  data.frame(name='Charles', HW.1=9, HW.2=7, HW.3=9))
grade.book

## ------------------------------------------------------------------------
library(tidyr)
# first we gather the score columns into columns we'll name Assesment and Score
tidy.scores <- grade.book %>% gather( key=Assessement, value=Score, HW.1:HW.3 )
tidy.scores

## ------------------------------------------------------------------------
# first we gather the score columns into columns we'll name Assesment and Score
tidy.scores %>% spread( key=Assessement, value=Score )

## ------------------------------------------------------------------------
FlagTemp <-  read.csv(
  'https://github.com/dereksonderegger/STA_570L_Book/raw/master/data/FlagMaxTemp.csv',
   header=TRUE, sep=',')

