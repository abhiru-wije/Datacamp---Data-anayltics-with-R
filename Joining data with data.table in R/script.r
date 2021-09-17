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
