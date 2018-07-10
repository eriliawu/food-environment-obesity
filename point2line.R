# calcualte the distance from building centroid to the nearest street network

### load all packages ----
suppressWarnings(library(sp)) #gDistance
suppressWarnings(library(maptools)) #readShapeLines; read shapefiles
suppressWarnings(library(rgeos)) #gDistance

### loop in 5 years of computation
school.all <- NULL
for (i in c("09", "10", "11", "12", "13")) {
      # read school points
      school <- read.csv("schools.csv")
      school <- school[school$year==2000+as.numeric(i), ]
      school <- na.omit(school)
      school <- school[!duplicated(school), ]
      colnames(school)[4:5] <- c("x", "y")
      # read coordinates as SP objects
      coords <- school[, c(4:5)]
      coords <- SpatialPoints(coords)
            
      # read street network as lines
      streets <- readShapeLines(paste("Lion_20", i, "_base.shp", sep = ""))

      # gDistance to produce nearest distance matrix
      dist <- gDistance(coords, streets, byid=TRUE)
      
      # cleaning up
      dist <- t(dist) #transpose
      dist <- as.data.frame(dist)
      dist$bldgToSt <- apply(dist[ , ], 1, min) #get row min
      n <- dim(dist)[2] #index the last column of data frame
      dist <- dist[, n] #only keep row min
      school <- cbind(school, dist)
      school.all <- rbind(school.all, school)
}

write.csv(school.all, "school_bldg_to_street.csv")
