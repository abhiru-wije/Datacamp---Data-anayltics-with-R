#1

# What data.tables are in my R session?
tables()

# View the first six rows 
head(netflix)
head(imdb)

# Print the structure
str(netflix)
str(imdb)

#2
# Inner join netflix and imdb
merge(netflix, imdb, by = "title")

#3
# Full join netflix and imdb
merge(netflix, imdb, by = "title", all = TRUE)

#4
# Full join imdb and netflix
merge(imdb, netflix, by = "title", all = TRUE)

#5
# Left join imdb to netflix
merge(netflix, imdb, by= "title", all.x = TRUE)

#6
# Right join imdb to netflix
merge(netflix,imdb, by = "title", all.y = TRUE)

#7
# Compare to a left join of netflix to imdb
merge(imdb, netflix, by = "title", all.x = TRUE)

#8
# Identify the key for joining capitals and population
capitals_population_key <- "city"

# Left join population to capitals
capital_pop <- merge(capitals, population, by = capitals_population_key, all.x = TRUE)
capital_pop

#9
# Identify the key for joining capital_pop and area
capital_pop_area_key <- "state"

# Inner join area to capital pop
australia_stats <- merge(area, capital_pop, by = capital_pop_area_key, all.y = TRUE)

# Print the final result
australia_stats

#10
# Right join population to capitals using data.table syntax
capitals[population, on = .(city)]


#11
# Right join using merge
merge(capitals, population, by = "city", all.y = TRUE)

#12
# Inner join with the data.table syntax
capitals[population, on = .(city), nomatch = 0]

#13
# Anti-join capitals to population
population[!capitals, on = .(city)]

#14
# Anti-join capitals to area
area[!capitals, on = .(state)]

#15
# Set the keys
setkey(netflix, title)
setkey(imdb, title)

# Inner join
netflix[imdb, nomatch = 0]

#16
# Check for keys
haskey(netflix)
haskey(imdb)

# Find the key
the_key <- key(netflix)

# Set the key for the other data.table
setkeyv(imdb, the_key)

#17
# Inner join capitals to population
capitals[population, on = .(city), nomatch = 0]

#18
# Join and sum
population[capitals, on = .(city), nomatch = 0,
           j = sum(percentage)]

#19
# How many continents is each country listed in?
continents[life_exp, on = .(country), .N, 
           by = .EACHI]

#20
# What countries are listed in multiple continents?
continents[life_exp, on = .(country), .N, 
           by = .EACHI][N > 1]

#21
# Calculate average life expectancy per continent:
avg_life_expectancy <- continents[life_exp, on = .(country), 
                                  nomatch = 0][, j = mean(years), 
                                               by = .(continent)]
avg_life_expectancy

#22
# Full join
merge(guardians, students, by.x = "name", by.y = "name", all = TRUE)

#23
# Left join
merge(students, guardians, by.x = "name",by.y = "name", all.x = TRUE)

#24
# Inner join
students[guardians, on = .(name), nomatch = 0]

#25
# What are the correct join key columns?
students[guardians, on = .(guardian = name), nomatch = 0]

#26
# Right join
subjects[locations, on = c("subject", "semester")]

#27
# Structure 
str(subjects)
str(locations)

# Does semester have the same class? 
same_class <- FALSE

#28
# Fix the column class
locations[, semester := as.integer(semester)]

# Right join
subjects[locations, on = .(subject, semester)]

#29
# Identify and set the keys
join_key <- c("topic" = "subject")

# Right join
teachers[locations, on = join_key]

#30
# Inner join
capital_pop <- merge(capitals, population, on = .(city))

# Left join
merge(area, capital_pop, on = .(state = state), all.x = TRUE)


#31
# Inner join from step 1
capital_pop <- merge(capitals, population, by = "city")

# Left join with suffixes
merge(capital_pop, area, by = "state", all.x = TRUE, suffixes = c(".pop",".area"))

#32
# Convert netflix to a data.table
netflix_dt <- as.data.table(netflix, keep.rownames = "series")

# Right join
imdb[netflix_dt, on = .(title = series)]

#33

# Try an inner join
merge(heart, cardio, by = "gene", allow.cartesian = TRUE)

# Filter missing values
heart_2 <- heart[!is.na(gene)]
cardio_2 <- cardio[!is.na(gene)]

# Inner join the filtered data.tables
merge(heart_2, cardio_2, by = "gene")

#34
# Keep only the last probe for each gene
heart_3 <- unique(heart_2, by = "gene", fromLast = TRUE)
cardio_3 <- unique(cardio_2, by = "gene", fromLast = TRUE)

# Inner join
reproducible <- merge(heart_3, cardio_3, by = "gene", suffixes = c(".heart", ".cardio"))
reproducible

#35
# Concatenate case numbers from weeks 50 and 51
rbind(ebola_W50, ebola_W51)

#36
# Modify the code
rbind(ebola_W50, ebola_W51, ebola_W52, fill = TRUE)

#37
# Concatenate its data.tables
gdp_all_1 <- rbindlist(gdp)

#38
# Concatenate its data.tables
gdp_all_2 <- rbindlist(gdp, idcol = "continent")

#39
# Run this code to inspect gdp_all_2
gdp_all_2 <- rbindlist(gdp, idcol = "continent")
str(gdp_all_2)
gdp_all_2[95:105]

# Fix the problem
gdp_all_3 <- rbindlist(gdp, idcol = "continent", use.names = TRUE)
gdp_all_3

#40
# Obtain countries in both Asia and Europe
fintersect(gdp$asia, gdp$europe)

# Concatenate all data tables
gdp_all <- rbindlist(gdp)

# Find all countries that span multiple continents
gdp_all[duplicated(gdp_all)]

#41
# Get all countries in either Asia or Europe
funion(gdp$asia, gdp$europe)

# Concatenate all data tables
gdp_all <- rbindlist(gdp)

# Print all unique countries
unique(gdp_all)

#42
# Which countries are in Africa but not considered part of the middle east?
fsetdiff(gdp$africa, middle_east)

# Which countries are in Asia but not considered part of the middle east?
fsetdiff(gdp$asia, middle_east)

# Which countries are in Europe but not considered part of the middle east?
fsetdiff(gdp$europe, middle_east)

#43
# Print gdp_per_capita
gdp_per_capita

# Reshape gdp_per_capita to the long format
melt(gdp_per_capita, id.vars = "year")

#44
# Rename the new columns
melt(gdp_per_capita, id.vars = "year", 
     variable.name = "country", value.name = "gdp_pc")

#45
# Print ebola_wide
ebola_wide

# Stack Week_50 and Week_51
melt(ebola_wide, measure.vars = c("Week_50", "Week_51"), 
     variable.name = "period", value.name = "cases")

#46
# Modify the code
melt(ebola_wide, measure.vars = c("Week_50", "Week_51"), 
     variable.name = "period", value.name = "cases", 
     id.vars = "Location" )

#47
# Split the population column by year
dcast(gdp_oceania, formula = country ~ year, value.var = "population")

#48
# Split the gdp column by country
dcast(gdp_oceania, formula = year ~ country, value.var = "gdp")

#49
# Split the gdp and population columns by year
dcast(gdp_oceania, formula = country ~ year, value.var = c("gdp", "population"))

#50
# Reshape from wide to long format
wide <- dcast(gdp_oceania, formula = country ~ year, value.var = c("gdp", "population"))

# convert to a matrix
as.matrix(wide, rownames = "country")

#51
# Modify your previous code
dcast(gdp_oceania, formula =  continent + country ~ year, value.var = c("gdp", "population"))

#52
# Split gdp by industry and year
dcast(gdp_by_industry_oceania, country ~ industry + year, value.var = "gdp")
