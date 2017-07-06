dbc <- dbConnect(MySQL(), group = 'homeserver', dbname = 'us_tycho')

strSQL = "
    CREATE TABLE locations (
    	location_id CHAR(4) NOT NULL COLLATE 'utf8_unicode_ci',
    	name CHAR(25) NOT NULL COLLATE 'utf8_unicode_ci',
    	state CHAR(2) NOT NULL COLLATE 'utf8_unicode_ci',
    	is_state TINYINT(1) UNSIGNED NOT NULL,
    	PRIMARY KEY (location_id),
    	INDEX state (state),
        INDEX is_state (is_state)
    ) COLLATE='utf8_unicode_ci' ENGINE=MyISAM ROW_FORMAT=FIXED;
"
dbSendQuery(dbc, strSQL)

strSQL = "
    CREATE TABLE diseases (
    	disease_id TINYINT(3) UNSIGNED NOT NULL,
    	name CHAR(50) NOT NULL COLLATE 'utf8_unicode_ci',
    	PRIMARY KEY (disease_id)
    ) COLLATE='utf8_unicode_ci' ENGINE=MyISAM ROW_FORMAT=FIXED;
"
dbSendQuery(dbc, strSQL)

strSQL = "
    CREATE TABLE L1 (
    	week MEDIUMINT(6) UNSIGNED NOT NULL,
    	location_id CHAR(4) NOT NULL COLLATE 'utf8_unicode_ci',
    	disease_id TINYINT(2) UNSIGNED NOT NULL,
    	N SMALLINT(5) UNSIGNED NOT NULL,
    	r DECIMAL(5,2) UNSIGNED NOT NULL,
    	PRIMARY KEY (week, location_id, disease_id),
    	INDEX week (week),
    	INDEX location_id (location_id),
    	INDEX disease_id (disease_id)
    ) COLLATE='utf8_unicode_ci' ENGINE=MyISAM ROW_FORMAT=FIXED;
"
dbSendQuery(dbc, strSQL)

strSQL = "
    CREATE TABLE L2 (
    	week MEDIUMINT(6) UNSIGNED NOT NULL,
    	location_id CHAR(4) NOT NULL COLLATE 'utf8_unicode_ci',
    	disease_id TINYINT(2) UNSIGNED NOT NULL,
    	event TINYINT(1) UNSIGNED NOT NULL,
    	N MEDIUMINT(5) UNSIGNED NOT NULL,
    	PRIMARY KEY (week, location_id, disease_id, event),
    	INDEX week (week),
    	INDEX location_id (location_id),
    	INDEX disease_id (disease_id),
    	INDEX event (event)
    ) COLLATE='utf8_unicode_ci' ENGINE=MyISAM ROW_FORMAT=FIXED;
"
dbSendQuery(dbc, strSQL)

dbDisconnect(dbc)
