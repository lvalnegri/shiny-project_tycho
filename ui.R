###########################
# Tycho Explorer - ui.R
###########################

shinyUI(fluidPage(
    
# PREAMBLE -------------------------------------------------------------------------------------------------------------------
    theme = shinytheme('united'), inverse = TRUE,
#    includeJqueryUI(), No need with new version ?
    useShinyjs(),
#    includeCSS('styles.css'),
    tags$head(tags$link(rel="shortcut icon", href="favicon.ico")),
    titlePanel('Tycho Explorer'),
    
# SIDEBAR PANEL -------------------------------------------------------------------------------------------------------------------
	sidebarPanel(

	    # GEOGRAPHY -------------------------------------------------------------------------------------------------------------------


		
		
		
		
		width = 2

	),

# MAIN PANEL --------------------------------------------------------------------------------------------------------------------
    mainPanel(
        
        tabPanel('heatmap', icon = icon('equalizer', lib = 'glyphicon'), 
            htmlOutput('out_hmx'), withSpinner( ggiraphOutput('out_hmp') )
        ),
        
        tabPanel('maps', icon = icon('globe', lib = 'glyphicon'), 
            htmlOutput('out_mpx'), withSpinner( leafletOutput('out_map', width = '100%', height = 800) )
        ),
        
        tabPanel('barplot', icon = icon('bar-chart'), 
            htmlOutput('out_brx'), withSpinner( ggiraphOutput('out_brp') )
        ), 
        
        tabPanel('boxplot', icon = icon('object-align-vertical', lib = 'glyphicon'), 
            htmlOutput('out_bxx'), withSpinner( ggiraphOutput('out_bxp') )
        )
            
    )
	
# END ---------------------------------------------------------------------------------------------------------------------------
))
