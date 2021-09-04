#one
# Use the suffix argument to replace .x and .y suffixes
parts %>% 
  inner_join(part_categories, by = c("part_cat_id" = "id"), suffix = c("_part", "_category"))

#two
# Combine the parts and inventory_parts tables
parts %>%
  inner_join(inventory_parts, by = c("part_num", "part_num"))

#three
# Combine the parts and inventory_parts tables
inventory_parts %>%
  inner_join(parts, by = c("part_num", "part_num"))

#four
sets %>%
  # Add inventories using an inner join 
  inner_join(inventories, by = "set_num") %>%
  # Add inventory_parts using an inner join 
  inner_join(inventory_parts, by = c("id" = "inventory_id"))

#five
# Count the number of colors and sort
sets %>%
  inner_join(inventories, by = "set_num") %>%
  inner_join(inventory_parts, by = c("id" = "inventory_id")) %>%
  inner_join(colors, by = c("color_id" = "id"), suffix = c("_set", "_color")) %>%
  count(name_color, sort = TRUE)

#six
# Aggregate Millennium Falcon for the total quantity in each part
millennium_falcon_colors <- millennium_falcon %>%
  group_by(color_id) %>%
  summarize(total_quantity = sum(quantity))

# Aggregate Star Destroyer for the total quantity in each part
star_destroyer_colors <- star_destroyer %>%
  group_by(color_id) %>%
  summarize(total_quantity = sum(quantity))

# Left join the Millennium Falcon colors to the Star Destroyer colors
millennium_falcon_colors %>%
  left_join(star_destroyer_colors, by = c("color_id"), suffix = c("_falcon", "_star_destroyer"))

#seven

inventory_version_1 <- inventories %>%
  filter(version == 1)

# Join versions to sets
sets %>%
  left_join(inventory_version_1, by = c("set_num"))  %>%
  # Filter for where version is na
  filter(is.na(version))

#eight
parts %>%
  count(part_cat_id) %>%
  right_join(part_categories, by = c("part_cat_id" = "id")) %>%
  # Filter for NA
  filter(is.na(n) )

#nine
parts %>%
  count(part_cat_id) %>%
  right_join(part_categories, by = c("part_cat_id" = "id")) %>%
  # Use replace_na to replace missing values in the n column
  replace_na(list(n=0))

#ten
themes %>% 
  # Inner join the themes table
  inner_join(themes, by = c("id" = "parent_id"), suffix = c("_parent", "_child")) %>% 
  # Filter for the "Harry Potter" parent name 
  filter(name_parent == "Harry Potter")

#eleven

# Join themes to itself again to find the grandchild relationships
themes %>% 
  inner_join(themes, by = c("id" = "parent_id"), suffix = c("_parent", "_child")) %>%
  inner_join(themes, by = c("id_child"= "parent_id"), suffix = c("_parent", "_grandchild"))

#twelwe

# Start with inventory_parts_joined table
inventory_parts_joined %>%
  # Combine with the sets table 
  inner_join(sets, by = "set_num") %>%
  # Combine with the themes table
  inner_join(themes, by = c("theme_id" = "id"), suffix = c("_set", "_theme"))

#thirteen
# Count the part number and color id, weight by quantity
batman %>%
  count(part_num, color_id, wt = quantity)
star_wars %>%
  count(part_num, color_id, wt = quantity)

#fourteen

batman_parts %>%
  # Combine the star_wars_parts table 
  full_join(star_wars_parts, by = c("part_num", "color_id"), suffix = c("_batman", "_star_wars")) %>%
  # Replace NAs with 0s in the n_batman and n_star_wars columns 
  replace_na(list(n_batman = 0, n_star_wars = 0))

#fifteen
parts_joined %>%
  # Sort the number of star wars pieces in descending order 
  arrange(desc(n_star_wars)) %>%
  # Join the colors table to the parts_joined table
  inner_join(colors, by = c("color_id" = "id")) %>%
  # Join the parts table to the previous join 
  inner_join(parts, by = "part_num", suffix = c("_color", "_part") )

#sixteen
# Filter the batwing set for parts that are also in the batmobile set
batwing %>%
  semi_join(batmobile, by = "part_num")

# Filter the batwing set for parts that aren't in the batmobile set
batwing %>%
  anti_join(batmobile, by = "part_num")

#seventeen
# Use inventory_parts to find colors included in at least one set
colors %>%
  semi_join(inventory_parts, by = c("id"  = "color_id"))

#eighteen
# Use filter() to extract version 1 
version_1_inventories <- inventories %>%
  filter(version == 1)
# Use anti_join() to find which set is missing a version 1
sets %>%
  anti_join(version_1_inventories, by = "set_num")

#ninghteen
batman_colors <- inventory_parts_themes %>%
  # Filter the inventory_parts_themes table for the Batman theme
  filter(name_theme == "Batman") %>%
  group_by(color_id) %>%
  summarize(total = sum(quantity)) %>%
  # Add a fraction column of the total divided by the sum of the total 
  mutate(fraction = total/ sum(total))

# Filter and aggregate the Star Wars set data; add a fraction column
star_wars_colors <- inventory_parts_themes %>%
  filter(name_theme == "Star Wars") %>%
  group_by(color_id) %>%
  summarise(total = sum(quantity)) %>%
  mutate(fraction = total / sum(total))

#twenty
batman_colors %>%
  full_join(star_wars_colors, by = "color_id", suffix = c("_batman", "_star_wars")) %>%
  replace_na(list(total_batman = 0, total_star_wars = 0)) %>%
  inner_join(colors, by = c("color_id" = "id")) %>%
  # Create the difference and total columns
  mutate(difference = fraction_batman - fraction_star_wars,
         total = total_batman + total_star_wars) %>%
  # Filter for totals greater than 200
  filter(total >= 200)

#twentyone
# Create a bar plot using colors_joined and the name and difference columns
ggplot(colors_joined, aes(name, difference, fill = name)) +
  geom_col() +
  coord_flip() +
  scale_fill_manual(values = color_palette, guide = FALSE) +
  labs(y = "Difference: Batman - Star Wars")

#twentytwo
# Replace the NAs in the tag_name column
questions %>%
  left_join(question_tags, by = c("id" = "question_id")) %>%
  left_join(tags, by = c("tag_id" = "id")) %>%
  replace_na(list(tag_name = "only-r"))

#twentythree
questions_with_tags %>%
  # Group by tag_name
  group_by(tag_name) %>%
  # Get mean score and num_questions
  summarize(score = mean(score),
            num_questions = n()) %>%
  # Sort num_questions in descending order
  arrange(desc(num_questions))

#twentyfour
# Using a join, filter for tags that are never on an R question
tags %>%
  anti_join(question_tags, by = c("id" = "tag_id"))

#25
questions %>%
  # Inner join questions and answers with proper suffixes
  inner_join(answers, by = c("id" = "question_id"), suffix = c("_question", "_answer")) %>%
  # Subtract creation_date_question from creation_date_answer to create gap
  mutate(gap = as.integer(creation_date_answer - creation_date_question))

#26
questions %>%
  # Inner join questions and answers with proper suffixes
  inner_join(answers, by = c("id" = "question_id"), suffix = c("_question", "_answer")) %>%
  # Subtract creation_date_question from creation_date_answer to create gap
  mutate(gap = as.integer(creation_date_answer - creation_date_question))

#27
question_answer_counts %>%
  # Join the question_tags tables
  inner_join(question_tags, by = c("id" = "question_id") ) %>%	
  # Join the tags table
  inner_join(tags, by = c("tag_id"="id"))

#28
tagged_answers %>%
  # Aggregate by tag_name
  group_by(tag_name) %>%
  # Summarize questions and average_answers
  summarize(questions = n(),
            average_answers = mean(n)) %>%
  # Sort the questions in descending order
  arrange(desc(questions))

#29
# Inner join the question_tags and tags tables with the questions table
questions %>%
  inner_join(question_tags, by = c("id" = "question_id")) %>%
  inner_join(tags, by = c("tag_id" = "id"))

# Inner join the question_tags and tags tables with the answers table
answers %>%
  inner_join(question_tags, by = "question_id") %>%
  inner_join(tags, by = c("tag_id" = "id"))

#30
# Combine the two tables into posts_with_tags
posts_with_tags <- bind_rows(questions_with_tags %>% mutate(type = "question"),
                             answers_with_tags %>% mutate(type = "answer"))


# Add a year column, then count by type, year, and tag_name
posts_with_tags %>%
  mutate(year = year(creation_date)) %>%
  count(type,year,tag_name)

#31
# Filter for the dplyr and ggplot2 tag names 
by_type_year_tag_filtered <- by_type_year_tag %>%
  filter(tag_name %in% c("dplyr", "ggplot2"))

# Create a line plot faceted by the tag name 
ggplot(by_type_year_tag_filtered, aes(year, n, color = type)) +
  geom_line() +
  facet_wrap(~ tag_name)

#32

