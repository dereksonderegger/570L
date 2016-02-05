## ----echo=FALSE----------------------------------------------------------
opts_chunk$set(cache.path = './cache/DataManipulation/',
               fig.path   = './figure/DataManipulation/')

## ------------------------------------------------------------------------
# use the iris data set which has both numerical and categorical variables
data( iris )
str(iris)    # recall what columns we have 

# display the summary for each column
summary( iris )

## ------------------------------------------------------------------------
# make up some data
grades <- data.frame(
  l.name = c('Cox', 'Dorian', 'Kelso', 'Turk'),
  Exam1 = c(93, 89, 80, 70),
  Exam2 = c(98, 70, 82, 85),
  Final = c(96, 85, 81, 92) )

## ------------------------------------------------------------------------
# Because I can't take the mean of the last names column,
# remove the name column
scores <- grades[,-1]
scores

# Summarize each column by calculating the mean.
apply( scores,      # what object do I want to apply the function to
       MARGIN=2,    # rows = 1, columns = 2, (same order as [rows, cols]
       FUN=mean     # what function do we want to apply     
     )

## ------------------------------------------------------------------------
apply( scores,      # what object do I want to apply the function to
       MARGIN=1,    # rows = 1, columns = 2, (same order as [rows, cols]
       FUN=mean     # what function do we want to apply
     )

## ------------------------------------------------------------------------
average <- apply( 
  scores,      # what object do I want to apply the function to
  MARGIN=1,    # rows = 1, columns = 2, (same order as [rows, cols]
  FUN=mean     # what function do we want to apply
)
grades <- cbind( grades, average )
grades

## ----message=FALSE-------------------------------------------------------
library(dplyr)
str(mtcars)

## ------------------------------------------------------------------------
small <- mtcars %>% select( mpg, cyl, disp, hp )  # these two commands are 
small <- mtcars %>% select( mpg:hp )              # equivalent
str(small)

## ------------------------------------------------------------------------
# recall what the grades are
grades

## ----message=FALSE, warning=FALSE----------------------------------------
# select students with Final grades greater than 90
grades %>% filter(Final > 90)

## ------------------------------------------------------------------------
# select students with Final grades above 90 and
# average score also above 90
grades %>% filter(Final > 90, average > 90)

# we could also use an "and" condition
grades %>% filter(Final > 90 & average > 90)

## ------------------------------------------------------------------------
# grab the first 2 rows
grades %>% slice(1:2)

## ------------------------------------------------------------------------
grades %>% arrange(l.name)

## ------------------------------------------------------------------------
grades %>% arrange(desc(Final))

## ------------------------------------------------------------------------
# make some data
dd <- data.frame(
  Trt = factor(c("High", "Med", "High", "Low"),        
               levels = c("Low", "Med", "High")),
  y = c(8, 3, 9, 9),      
  z = c(1, 1, 1, 2)) 
dd
# arrange the rows first by treatment, and then by y (y in descending order)
dd %>% arrange(Trt, desc(y))

## ------------------------------------------------------------------------
grades$average <- (grades$Exam1 + grades$Exam2 + grades$Final) / 3

## ------------------------------------------------------------------------
grades %>% mutate( average = (Exam1 + Exam2 + Final)/3 )

## ------------------------------------------------------------------------
grades %>% mutate( average = (Exam1 + Exam2 + Final)/3,
                   grade = cut(average, c(0,60,70,80,90,100), c('F','D','C','B','A')) )

## ------------------------------------------------------------------------
# calculate the mean of exam 1
summarise( grades, mean.E1=mean(Exam1))

## ------------------------------------------------------------------------
# calculate the mean of each of the exams
grades %>% summarise( mean.E1=mean(Exam1), stddev.E1=sd(Exam2) )

## ------------------------------------------------------------------------
# calculate the mean and stddev of each column
grades %>% summarise_each( funs(mean, sd) )

## ------------------------------------------------------------------------
data(warpbreaks)
str(warpbreaks)

## ------------------------------------------------------------------------
# what variable(s) shall we group one
grouped.warpbreaks <- warpbreaks %>% group_by( wool, tension)

# n() is a function that returns how many rows are in the 
# currently selected sub-dataframe
summarise(grouped.warpbreaks, n = n() ) 

## ------------------------------------------------------------------------
warpbreaks %>% group_by(wool, tension) %>%
  summarise( n           = n(),             # I added some formatting to tell the
             mean.breaks = mean(breaks),    # reader I am calculating several
             sd.breaks   = sd(breaks)       # statistics.
) 

## ------------------------------------------------------------------------
temp <- warpbreaks %>% 
   group_by(wool, tension) %>%
   mutate(resid = breaks - mean(breaks))
head( temp )  # show the first couple of rows of the result

## ------------------------------------------------------------------------
# input the initial data
race.results <- data.frame(
  name=c('Bob', 'Jeff', 'Rachel', 'Bonnie', 'Derek', 'April','Elise','David'),
  time=c(21.23, 19.51, 19.82, 23.45, 20.23, 24.22, 28.83, 15.73),
  gender=c('M','M','F','F','M','F','F','M')
)

# how should I group?
grouped.results <- race.results %>% group_by( gender)

# calculate the rankings using the rank() function
temp.df1 <- grouped.results %>% mutate( place = rank(time) )

# arrange the rows based on gender and then place
temp.df2 <- temp.df1 %>% arrange( gender, place )

## ------------------------------------------------------------------------
# output the result
temp.df2

## ------------------------------------------------------------------------
arrange( 
  mutate(
    group_by( 
      race.results,         # using race.results
      gender),              # group by gender     
    place = rank( time )),  # mutate to calculate the place column
  gender, place)            # arrange the result by gender and place

## ------------------------------------------------------------------------
race.results %>%                   # what data frame am I interested in
  group_by(gender) %>%             # break things by gender
  mutate(place=rank(time)) %>%     # calculate the placings within each gender
  arrange(gender, place)           # arrange the result by gender and place

## ------------------------------------------------------------------------
race.results %>%                   # what data frame am I interested in
  group_by(gender) %>%             # break things by gender
  mutate(place=rank(time)) %>%     # calculate the placings within each gender
  filter( place <= 3 ) %>%         # only get the top 3 finishers within each gender
  arrange(gender, place)           # arrange the result by gender and place

## ------------------------------------------------------------------------
data(ChickWeight)

## ------------------------------------------------------------------------
Body <- read.csv('http://www.openintro.org/stat/data/bdims.csv')

## ------------------------------------------------------------------------
# Define a continuous vector to convert to a factor
x <- 1:10

# divide range of x into three groups of equal length
cut(x, breaks=3)

# divide x into four groups, where I specify all 5 break points
cut(x, breaks = c(0, 2.5, 5.0, 7.5, 10))

# divide x into 3 groups, but give them a nicer
# set of group names
cut(x, breaks=3, labels=c('Low','Medium','High'))

