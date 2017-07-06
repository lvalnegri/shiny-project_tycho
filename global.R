###################################
# Tycho Explorer - global.R
###################################

#===== LOAD PACKAGES -----------------------------------------------------------------------------------------------------------
pkg <- c(
    'Cairo', 'colourpicker', 'data.table', 'DT', 'dygraphs', 'extrafont', 'geofacet', 'ggplot2', 'ggiraph', 'ggrepel', 'ggthemes',
    'htmltools', 'leaflet', 'mapview', 'plyr', 'RColorBrewer', 'rgdal', 'RMySQL', 
    'scales', 'shiny', 'shinycssloaders', 'shinyjqui', 'shinyjs', 'shinythemes', 'shinyWidgets', 'sp', 'xts'
)
invisible( lapply(pkg, require, character.only = TRUE) )

#===== LOAD DATA ----------------------------------------------------------------------------------------------------------------
# db_conn <- suppressWarnings( dbConnect(MySQL(), group = 'homeserver-out', dbname = 'us_tycho') )
# dataset <- suppressWarnings( data.table(dbReadTable(db_conn, 'L1') ) )
# calendar <- suppressWarnings( data.table(dbReadTable(db_conn, 'calendar'), key = 'datefield' ) )
# diseases <- suppressWarnings( data.table(dbReadTable(db_conn, 'diseases'), key = 'disease_id' ) )
# locations <- suppressWarnings( data.table(dbReadTable(db_conn, 'locations'), key = 'location_id' ) )
# dbDisconnect(db_conn)
db_conn <- suppressWarnings( dbConnect(MySQL(), group = 'homeserver-out', dbname = 'common') )
# maptiles <- suppressWarnings( data.table(dbGetQuery(db_conn, 'SELECT CONCAT(provider, ".", name) AS name, url, attribution FROM maptiles WHERE require_reg = 0 ORDER BY name' ) ) )
# palettes <- suppressWarnings( data.table(dbReadTable(db_conn, 'palettes') ) )
dbDisconnect(db_conn)


#===== FUNCTIONS ----------------------------------------------------------------------------------------------------------------



#===== RECODE DATA --------------------------------------------------------------------------------------------------------------



#===== VARIABLES/LABELS ----------------------------------------------------------------------------------------------------------------



#===== STYLES ----------------------------------------------------------------------------------------------------------------


