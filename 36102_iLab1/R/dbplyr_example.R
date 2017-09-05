library(tidyverse)

# Database connection details
MYSQL_DB <- "nasa"
MYSQL_HOST <- "localhost"
MYSQL_PORT <- 3306
MYSQL_USER <- "nasa"
MYSQL_PASS <- "xxxxxxxx" ## Change as necessary

TABLE_NAME_PROGRAMS           <- "programs"
TABLE_NAME_ASTRONAUTS         <- "astronauts"
TABLE_NAME_MISSIONS           <- "missions"
TABLE_NAME_ROLES              <- "roles"
TABLE_NAME_ASTRONAUT_MISSIONS <- "astronaut_missions"

# Connect to the database (MYSQL* constants have been previously defined)
dbcon <- src_mysql(
    dbname = MYSQL_DB,
    host = MYSQL_HOST,
    port = MYSQL_PORT,
    user = MYSQL_USER,
    password = MYSQL_PASS)

# Create references to our database tables (TABLE_NAME_* constants are strings already defined)
programs           <- tbl(dbcon, TABLE_NAME_PROGRAMS)
astronauts         <- tbl(dbcon, TABLE_NAME_ASTRONAUTS)
missions           <- tbl(dbcon, TABLE_NAME_MISSIONS)
roles              <- tbl(dbcon, TABLE_NAME_ROLES)
astronaut_missions <- tbl(dbcon, TABLE_NAME_ASTRONAUT_MISSIONS)

str(astronauts)

show_query(astronauts)

astronauts %>%
    count() %>%
    show_query()

astronauts

glimpse(astronauts)

astronauts %>%
    count() %>%
    collect()

str(astronauts %>% collect())

multiple_missions <- astronaut_missions %>%
    inner_join(missions, by=c("mission_id" = "id"), suffix = c("_am", "_m")) %>%
    inner_join(programs, by=c("program_id" = "id"), suffix = c("_m", "_p")) %>%
    filter(name_p %in% c("Gemini", "Apollo")) %>%
    group_by(name_p, astronaut_id) %>%
    summarise(flights = n()) %>%
    ungroup() %>%
    filter(flights >= 2) %>%
    inner_join(astronauts, by=c("astronaut_id" = "id"), suffix = c("_am", "_a")) %>%
    arrange(desc(flights), name_p, surname, first_name) %>%
    select(program_name = name_p, surname, first_name, flights)

multiple_missions

multiple_missions %>%
    show_query()

astronauts %>%
    filter(grepl("^C", surname))

astronauts %>%
    collect() %>%
    filter(grepl("^C", surname))

dbplyr::translate_sql(x == 1 && (y < 2 || z > 3))

dbplyr::translate_sql(grepl("^C", surname))

dbplyr::translate_sql(surname %like% 'C%')

astronauts %>%
    filter(surname %like% 'C%')

astronauts %>%
    filter(surname %like% 'C%') %>%
    explain()
