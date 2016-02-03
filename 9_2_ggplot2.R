## ----echo=FALSE----------------------------------------------------------
opts_chunk$set(cache.path = './cache/Graphics2',
               fig.path   = './figure/Graphics2')

## ----message=FALSE, fig.width=5, fig.height=2.5--------------------------
library(ggplot2)
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width)) +
  geom_point() +
  facet_grid( . ~ Species )

## ----message=FALSE, fig.width=5, fig.height=2.5--------------------------
library(reshape) # for the dataset 'tips'
data(tips)
head(tips)

## ----message=FALSE, fig.width=5, fig.height=2.5--------------------------
ggplot(tips, aes(x = total_bill, y = tip / total_bill )) +
  geom_point()

## ----message=FALSE, fig.width=5, fig.height=2.5--------------------------
ggplot(tips, aes(x = total_bill, y = tip / total_bill )) +
  geom_point() +
  facet_grid( sex ~ day )

## ----message=FALSE, fig.width=5, fig.height=2.5--------------------------
ggplot(tips, aes(x = total_bill, y = tip / total_bill )) +
  geom_point() +
  facet_wrap( ~ day )

## ----message=FALSE, fig.width=5, fig.height=2.5--------------------------
ggplot(tips, aes(x = total_bill, y = tip / total_bill )) +
  geom_point() +
  facet_grid( sex ~ day, scales="free_y" )

## ----message=FALSE, fig.height=2.5---------------------------------------
library(Lock5Data)
ggplot(ACS, aes(x=Age, y=Income)) +
  geom_point()

## ------------------------------------------------------------------------
library(MASS)
library(dplyr)
birthwt <- birthwt %>% mutate(
  race  = factor(race,  labels=c('White','Black','Other')),
  smoke = factor(smoke, labels=c('No Smoke', 'Smoke'))

## ----message=FALSE, fig.width=5, fig.height=2.5--------------------------
# load the data
data(ChickWeight)

## ----message=FALSE, fig.width=5, fig.height=6, eval=FALSE, echo=FALSE----
## ggplot(ChickWeight, aes(x=Time, y=weight, color=Diet)) +
##   geom_point() +
##   facet_wrap( ~ Chick )

