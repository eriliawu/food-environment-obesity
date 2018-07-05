# School Food Environment
# fast food free zone paper

setwd("S:/Personal/hw1220/FF free zone")

### load packages ----
suppressWarnings(library(sp))
suppressWarnings(library(spatstat))
suppressWarnings(library(maptools))
suppressWarnings(library(rgeos))
suppressWarnings(library(rgdal))
suppressWarnings(library(spdep))
suppressWarnings(library(measurements)) #to convert imperial/metric units
suppressWarnings(library(readstata13)) #I wish economists didnt like stata this much

### calculate distance to nearest food outlet ----
school.all <- NULL
# loop AY 09-13 of schools and their x-y coordinates
# for each year of food sources, separate into 4 outlet types
for (i in c("09", "10", "11", "12", "13")) {
      # read school address data
      school <- read.csv("xy-coord_2009-2013.csv", stringsAsFactors=FALSE)
      school <- school[school$year==2000+as.numeric(i), ]
      school <- na.omit(school)
      school <- school[!duplicated(school), ]
      
      # convert school coords into ppp object
      coords <- ppp(school$x, school$y,
                    window=owin(xrange=c(0, max(school$x)), 
                                 yrange=c(0, max(school$y))))
      
      # read food outlet data
      food <- read.csv(paste("H:/Personal/food environment paper 1/restaurants/restaurants", i, ".csv", sep = ""), stringsAsFactors=FALSE)
      food <- na.omit(food)
      for (j in c("FFOR", "BOD", "WS", "C6P")) { #separate food outlets into 4 diff types and calculate dist to nearest of each type
            food1 <- food[food$cat2==j, ]
            food1 <- ppp(food1$x, food1$y, 
                        window=owin(xrange=c(0, max(food1$x)), 
                                    yrange=c(0, max(food1$y))))
            dist <- nncross(coords, food1)
            colnames(dist)[1] <- j
            dist$which <- NULL # see nncross help file for output
            school <- cbind(school, dist)
            #school1$year <- 2000+as.numeric(i)
      }
      write.csv(x=dist, file=paste("dist", i, ".csv", sep = ""))
      school.all <- rbind(school.all, school)
}

write.csv(school.all, file="school_nearest_food_outlet.csv")
