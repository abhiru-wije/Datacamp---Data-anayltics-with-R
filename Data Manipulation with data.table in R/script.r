#1
# Load data.table
library(data.table)

# Create the data.table X 
X <- data.table(id = c("a", "b", "c"), value = c(0.5, 1.0, 1.5))

# View X
X

#2
# Filter rows 10 through 20
rows_10_20 <- batrips[10:20,]
rows_10_20

#3
# Filter the 1st, 6th and 10th rows
rows_1_6_10 <- batrips[c(1,6,10)]
rows_1_6_10

#4
# Select all rows except the first two
not_first_two <- batrips[-(1:2)]
not_first_two

#5
# Select all rows except 1 through 5 and 10 through 15
exclude_some <- batrips[!c(1:5,10:15)]
exclude_some

#6
# Select all rows except the first and last
not_first_last <- batrips[!c(1,.N)]
not_first_last

#7
# Filter all rows where start_station is "MLK Library"
trips_mlk <- batrips[start_station == "MLK Library"]
trips_mlk

#8
# Filter all rows where start_station is "MLK Library" AND duration > 1600
trips_mlk_1600 <- batrips[start_station == "MLK Library" & duration > 1600]
trips_mlk_1600

#9
# Filter all rows where start_station is "Ryland Park" AND subscription_type is not "Customer"
ryland_park_subscribers <- batrips[start_station == "Ryland Park" & subscription_type != "Customer"]
ryland_park_subscribers

#10
# Filter all rows where end_station contains "Market"
any_markets <- batrips[end_station %like% "Market"]
any_markets

#11
# Filter all rows where end_station ends with "Market" 
end_markets <- batrips[end_station %like% "Market$"]
end_markets

#12
# Filter all rows where trip_id is 588841, 139560, or 139562
filter_trip_ids <- batrips[trip_id %in% c(588841,139560,139562)]
filter_trip_ids

#13
# Filter all rows where duration is between [5000, 6000]
duration_5k_6k <- batrips[duration %between% c(5000,6000)]
duration_5k_6k

#14
# Filter all rows with specific start stations
two_stations <- batrips[start_station %chin% c("San Francisco City Hall", "Embarcadero at Sansome")]
two_stations

#15
