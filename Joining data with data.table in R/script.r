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
