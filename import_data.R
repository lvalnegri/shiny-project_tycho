library(data.table)
library(RMySQL)

### LEVEL TWO
dt <- fread(
        'D:/cloud/OneDrive/data/US/project_tycho/project_tycho_lev2.csv',
        select = c('epi_week', 'state', 'loc', 'loc_type', 'disease', 'event', 'number'),
        col.names = c('week', 'state', 'location', 'is_state', 'disease', 'event', 'N'),
        key = 'week'
)
# delete states not actually part of US (apart from Puerto Rico)
dt <- dt[!(state %in% c('AS', 'GU', 'MP', 'PT', 'VI'))]
# remove records with missing counts
dt <- dt[N > 0]
# the file has different start/end dates for some weeks, which have been excluded from the query, so I sum N over all variables
dt <- dt[, .(N = sum(N)), setdiff(names(dt), 'N')]
# recode "is_state" and "event"
dt[, `:=`(is_state = as.numeric(is_state == 'STATE'), event = as.numeric(event == 'DEATHS') )]
# create unique state of New York
ny <- dt[state == 'NY' & is_state == 1]
ny[, location := 'NEW YORK']
ny <- ny[, .(N = sum(N)), setdiff(names(ny), 'N')]
dt <- dt[!(state == 'NY' & is_state == 1)]
dt <- rbindlist(list(dt, ny))
# rename city of New York
dt[location == 'NEW YORK' & is_state == 0, location := 'NEW YORK CITY']
# create table for diseases
dt[, disease := factor(disease)]
diseases <- unique(dt[, .(disease_id = as.numeric(disease), name = disease)])[order(disease_id)]
dt[, disease_id := as.numeric(disease)]
dt[, disease := NULL]
# create locations with unique id (0 == state)
locations <- unique(dt[, .(name = location, state, is_state)])[order(state, -is_state, name)]
locations[, id := 0:.N, state]
locations[, location_id := paste0(state, ifelse(id < 10, '0', ''), id)]
locations[, id := NULL]
# replace state, location, is_state with location_id
setkeyv(dt, c('location', 'state', 'is_state'))
setkeyv(locations, c('name', 'state', 'is_state'))
dt <- locations[dt]
dt <- dt[, 4:8][order(week, location_id, disease_id, event)]
# save tables
dbc <- dbConnect(MySQL(), group = 'homeserver', dbname = 'us_tycho')
dbWriteTable(dbc, 'diseases', diseases, append = TRUE, row.names = FALSE)
dbWriteTable(dbc, 'locations', locations, append = TRUE, row.names = FALSE)
dbWriteTable(dbc, 'L2', dt, append = TRUE, row.names = FALSE)
dbDisconnect(dbc)

### LEVEL ONE
dt <- fread(
        'D:/cloud/OneDrive/data/US/project_tycho/project_tycho_lev1.csv',
        na.strings = '\\N',
        col.names = c('week', 'state', 'location', 'is_state', 'disease', 'N', 'r'),
        key = 'week'
)
# remove records with missing counts
dt <- dt[N > 0]
# recode "is_state" 
dt[, `:=`(is_state = as.numeric(is_state == 'STATE') )]
# rename city of New York
dt[location == 'NEW YORK' & is_state == 0, location := 'NEW YORK CITY']
# change name to a couple of diseases, then replace disease name with its id
dt[disease == 'PERTUSSIS', disease := 'WHOOPING COUGH [PERTUSSIS]']
dt[disease == 'POLIO', disease := 'POLIOMYELITIS']
setkey(diseases, 'name')
setkey(dt, 'disease')
dt <- diseases[dt][, name := NULL]
# replace state, location, is_state with its location_id
setkeyv(dt, c('location', 'state', 'is_state'))
dt <- locations[dt]
dt <- dt[, 4:8][order(week, location_id, disease_id)]
# save table
dbc <- dbConnect(MySQL(), group = 'homeserver', dbname = 'us_tycho')
dbWriteTable(dbc, 'L1', dt, append = TRUE, row.names = FALSE)
dbDisconnect(dbc)

# clean and exit
rm(list = ls())
gc()
