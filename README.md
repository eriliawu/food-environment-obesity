# food-environment-obesity
## note
I'm trained as an economist with a focus on quantitative analyses. Programming skills are just a tool I picked up along the way to facilitate my research, which is to say I'm (obviously and unfortunately) not a computer scientist, and my codes could (definitely) use some more efficiency here and there. It took me a while to figure out looping the 200-something lines of codes into the script I ended up with, so everything is still very much a learning process, as well as a reminder to myself to always look for a more efficient solution, instead of settling for the easiest route.

## conceptual framework and how it works
This particular project aims to find associations between school-age students' weight outcomes (i.e. the likelihood of being overweight or obese) and their nearby food environment (what's the nearest food outlet and how many food outlets are accessible within a certain distance).
### point to point distance from a student to the nearest food outlet
Using `nncross` function in R package `spatstat` to calculate euclidean distance between points, with food environment and childhood obesity project as an example. I have data on students and food outlets (restaurants, supermarkets, corner stores, etc.), both of which are considered spatial points. First use the `ppp` function to convert x-y coordinates into `ppp` objects, you have your two sets of spatial points, then apply `nncross` to calcualte the distance from one student to his/her nearest food outlet.
### point to line distance from a student's home (as the centroid of the building) to the nearest street grid (as a line)
This is part of the second phase of the analyses as I switch from euclidean distance to street network distance. For most part of the street network computation, once you have all the street grid mapped out, ArcGIS provides an argueably time-consuming but solid solution, which gives you the distance that one would travel on the street grids from one point to another (i.e. the steps you take from inside the building to the street are not included). Usually the computation stops here and we move on to attach the distance measures to individual students for statistical analyses, but as I look at summary stats and regressions results, it became obvious that some students live in big building (think public housing buildings) and the distance from their buildings the the street network is too big to be ignored.

Now I can keep using `nncross`, and convert the street grid to `psp` objects then following the same routine, but surprisingly the `as.psp` function was taking much longer than I expected (think how dense the street network is in NYC, duh...), so I switch to use the `gDistance` function in `rgeos` package with help from `maptools` package to read shapefiles into spatial lines.

## data sources
There are several data sources involved:
1) students' home addresses geocoded into x-y coordinates. This is confidential data that I cannot publish on this site, but in essence, any geo points will do;
2) restaurants of all types. In New York City, Department of Health and Mental Hygiene (NYC DOHMH) maintains a [restaurant grading program](https://data.cityofnewyork.us/Health/DOHMH-New-York-City-Restaurant-Inspection-Results/43nn-pn8j) that mandates every restaurant in all five boroughs be inspected at least once every year. The inspectors not only examines the overall conditions of a restaurant, but also records the services offered, the type of venue, the cuisine and address , among other things;
3) food retailers of all types. In New York State, Department of Agriculture inspects every [food retailer](https://data.ny.gov/Economic-Development/Retail-Food-Store-Inspections-Current-Ratings/d6dy-3h7r) at least once every 18 months. The inspectors not only hand out a grade, but also record the address and number of square footage of each store, such as a supermarket, a pharmacy and a corner store;
4) street grid: NYC Department of City Planning (NYC DCP) documents current and archive city [street network](https://www1.nyc.gov/site/planning/data-maps/open-data/dwn-lion.page) data in shapefiles. 

Both the restaurant grading data from NYC DOHMH and food retailer data from NYS Dept of Agriculture are from open source and regularly maintained by the two departments, respectively. To get archive data (which record stores that have closed in the past), you can submit a FOIL restaurant.
