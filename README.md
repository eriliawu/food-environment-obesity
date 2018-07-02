# food-environment-obesity
## purpose
Using `nncross` function in R to calculate euclidean distance between points, with food environment and childhood obesity project as an example. This particular project aims to find associations between school-age students' weight outcomes (i.e. the likelihood of being overweight or obese) and their nearby food environment (what's the nearest food outlet and how many food outlets are accessible within a certain distance).

## data sources
There are several data sources involved:
1) students' home addresses geocoded into x-y coordinates. This is confidential data that I cannot publish on this site, but in essence, any geo points will do;
2) restaurants of all types. In New York City, Department of Health and Mental Hygiene maintains a [restaurant grading program](https://data.cityofnewyork.us/Health/DOHMH-New-York-City-Restaurant-Inspection-Results/43nn-pn8j) that mandates every restaurant in all five boroughs be inspected at least once every year. The inspectors not only examines the overall conditions of a restaurant, but also records the services offered, the type of venue, the cuisine and address , among other things;
3) food retailers of all types. In New York State, Department of Agriculture inspects every [food retailer](https://data.ny.gov/Economic-Development/Retail-Food-Store-Inspections-Current-Ratings/d6dy-3h7r) at least once every 18 months. The inspectors not only hand out a grade, but also record the address and number of square footage of each store, such as a supermarket, a pharmacy and a corner store.

Both the restaurant grading data from DOHMH and food retailer data from NYS Dept of Agriculture are from open source regularly maintained by NYC DOHMH and NYS Dept of Agriculture.
