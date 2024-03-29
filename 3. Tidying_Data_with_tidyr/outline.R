# extract  Extract one column into multiple columns.
# extract_numeric	Extract numeric component of variable.
# gather	Gather columns into key-value pairs.
# separate	Separate one column into multiple columns.
# spread	Spread a key-value pair across multiple columns.
# spread_	Standard-evaluation version of 'spread'.
# unite	Unite multiple columns into one.

library(tidyr)
library(dplyr)

# column headers are values, not variable names

?gather
gather(students, sex, count, -grade)

# multiple variables are stored in one column


# variables are stored in both rows and columns

students3 %>%
  gather(class, grade, class1:class5, na.rm = TRUE) %>%
  print

# res2 <- students3 %>%
#   gather(class, grade, class1:class5, na.rm = TRUE) %>%
#   mutate(class = extract_numeric(class)) %>%
#   select(name, class, test, grade) %>%
#   arrange(name, class)

# res2 %>% spread(test, grade)

students3 %>%
  gather(class, grade, class1:class5, na.rm = TRUE) %>%
  spread(test, grade) %>%
  print

students3 %>%
  gather(class, grade, class1:class5, na.rm = TRUE) %>%
  spread(test, grade) %>%
  mutate(class = extract_numeric(class)) %>%
  print


# multiple types of observational units are stored in the same table

students4

student_info <- students4 %>%
  select(id, name, sex) %>%
  unique() %>%
  print

gradebook <- students4 %>%
  select(id, class, midterm, final) %>%
  print

# a single observational unit is stored in multiple tables

passed <- passed %>%
  mutate(status = "passed")
failed <- failed %>%
  mutate(status = "failed")

rbind_list(passed, failed) %>%
  arrange(desc(status), name, class)

# real data examples

sat1 <- select(sat, -contains("total"))
sat1 <- gather(sat1, column, count, -score_range)
sat1 <- separate(sat1, column, c("part", "sex"))
sat1

by_part <- group_by(sat1, part, sex)
sat2 <- mutate(by_part,
               total = sum(count),
               prop = count / total)


arrange(sat1, desc(count))

sat %>%
  gather("column", "count", -score_range) %>%
  separate(column, c("part", "sex")) %>%
  print
	
	
sat %>%
  select(-contains("total")) %>%
  gather(column, count, -score_range) %>%
  separate(column, c("part", "sex")) %>%
  group_by(part, sex) %>%
  mutate(total = sum(count),
         prop = count / total
  ) %>% print