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
# Select bike_id and trip_id using a character vector
df_way <- batrips[, c("bike_id", "trip_id")]
df_way

#16
# Select start_station and end_station cols without a character vector
dt_way <- batrips[, .(start_station, end_station)]
dt_way

#17
# Deselect start_terminal and end_terminal columns
drop_terminal_cols <- batrips[, -c("start_terminal", "end_terminal")]
drop_terminal_cols

#18
# Calculate median duration using the j argument
median_duration <- batrips[, median(duration)]
median_duration

#19
# Get median duration after filtering
median_duration_filter <- batrips[end_station == "Market at 10th" & subscription_type == "Subscriber", median(duration)]
median_duration_filter

#20
# Compute duration of all trips
trip_duration <- batrips[, difftime(end_date,start_date, units = "min")]
head(trip_duration)

#21
# Calculate the average duration as mean_durn
mean_duration <- batrips[, .(mean_durn = mean(duration))]
mean_duration

#22
# Get the min and max duration values
min_max_duration <- batrips[, .(min(duration), max(duration))]
min_max_duration

#23
# Calculate the average duration and the date of the last ride
other_stats <- batrips[, .(mean_duration = mean(duration), 
                           last_ride = max(end_date))]
other_stats

#24
duration_stats <- batrips[start_station == "Townsend at 7th" & duration < 500, 
                          .(min_dur = min(duration), 
                            max_dur = max(duration))]
duration_stats

#25
# Plot the histogram of duration based on conditions
batrips[start_station == "Townsend at 7th" & duration < 500, hist(duration)]

#26
# Compute the mean duration for every start_station
mean_start_stn <- batrips[, .(mean_duration = mean(duration)), by = start_station]
mean_start_stn

#27
# Compute the mean duration for every start and end station
mean_station <- batrips[, .(mean_duration = mean(duration)), by = .(start_station, end_station)]
mean_station

#28
# Compute the mean duration grouped by start_station and month
mean_start_station <- batrips[, .(mean_duration = mean(duration)), by = .(start_station, month(start_date))]
mean_start_station

#29
# Compute mean of duration and total trips grouped by start and end stations
aggregate_mean_trips <- batrips[, .(mean_duration = mean(duration), 
                                    total_trips = .N), 
                                by = .(start_station, end_station)]
aggregate_mean_trips

#30
# Compute min and max duration grouped by start station, end station, and month
aggregate_min_max <- batrips[, .(min_duration = min(duration), 
                                 max_duration = max(duration)), 
                             by = .(start_station, end_station, 
                                    month(start_date))]
aggregate_min_max

#31
# Arrange the total trips grouped by start_station and end_station in decreasing order
trips_dec <- batrips[, .N, by = .(start_station, 
                                  end_station)][order(-N)]
trips_dec

#32
# Top five most popular destinations
top_5 <- batrips[, .N, by = .(end_station)][order(-N)][1:5]
top_5

#33
# Compute most popular end station for every start station
popular_end_station <- trips_dec[, .(end_station = end_station[1]), 
                                 by = .(start_station)]
popular_end_station

#34
# Find the first and last ride for each start_station
first_last <- batrips[order(start_date), 
                      .(start_date = start_date[c(1, .N)]), 
                      by = start_station]
first_last

#35

relevant_cols <- c("start_station", "end_station", 
                   "start_date", "end_date", "duration")

# Find the row corresponding to the shortest trip per month
shortest <- batrips[, .SD[which.min(duration)], 
                    by = month(start_date), 
                    .SDcols = c("start_station", "end_station","start_date", "end_date","duration")]
shortest

#36
# Find the total number of unique start stations and zip codes per month
unique_station_month <- batrips[, lapply(.SD, uniqueN), 
                                by = month(start_date), 
                                .SDcols = c("start_station", "zip_code")]
unique_station_month

#37
# Add a new column, duration_hour
batrips[, duration_hour := duration/3600]

#38
# Fix spelling in the second row of start_station using the LHS := RHS form
untidy[2, start_station := "San Francisco City Hall"]

#39
# Add new column for every start_station and end_station
batrips[, duration_mean := mean(duration), by = .(start_station, end_station)]

#40
# Calculate the mean duration for each month
batrips_new[, mean_dur := mean(duration, na.rm = TRUE), 
            by = month(start_date)]

#41
# Replace NA values in duration with the mean value of duration for that month
batrips_new[, mean_dur := mean(duration, na.rm = TRUE), 
            by = month(start_date)][is.na(duration), 
                                    duration := mean_dur]

#42
# Delete the mean_dur column by reference
batrips_new[, mean_dur := mean(duration, na.rm = TRUE), 
            by = month(start_date)][is.na(duration), 
                                    duration := mean_dur][, mean_dur := NULL]

#43
# Add columns using the LHS := RHS form
batrips[, c("mean_duration", "median_duration") := list(mean(duration), median(duration)), 
        by = start_station]

#44
# Add columns using the functional form
batrips[, `:=`(mean_duration = mean(duration),
               median_duration = median(duration)), 
        by = start_station]

#45
# Add the mean_duration column
batrips[duration > 600, mean_duration := mean(duration), by = .(start_station, end_station)]

#46
# Use read.csv() to import batrips
system.time(read.csv("batrips.csv"))

#47
# Use fread() to import batrips
system.time(fread("batrips.csv"))

#48
# Import using read.csv()
csv_file <- read.csv("sample.csv", fill = NA, quote = "", 
                     stringsAsFactors = FALSE, strip.white = TRUE, 
                     header = TRUE)
csv_file

#49
# Import using fread()
csv_file <- fread("sample.csv")
csv_file

#50
# Select "id" and "val" columns
select_columns <- fread("sample.csv", select = c("id", "val"))
select_columns

#51
# Drop the "val" column
drop_column <- fread(url, drop = "val")
drop_column

#52
# Import the file
entire_file <- fread("sample.csv")
entire_file

#53
# Import the file while avoiding the warning
only_data <- fread("sample.csv", nrows = 3)
only_data

#54
# Import only the metadata
only_metadata <- fread("sample.csv", skip = 7)
only_metadata

#55
