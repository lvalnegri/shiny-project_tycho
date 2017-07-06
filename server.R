##############################
# Tycho Explorer - server.R
##############################

shinyServer(function(input, output){

# TOGGLES -----------------------------------------------------------------------------------------------------------------------
    onclick('tgl_lev', toggle(id = 'hdn_hsp_geo', anim = TRUE) )  # levels
    onclick('tgl_geo', toggle(id = 'hdn_hsp_tmp', anim = TRUE) )  # geography
    onclick('tgl_dis', toggle(id = 'hdn_hsp_mtc', anim = TRUE) )  # disease
    onclick('tgl_opt', toggle(id = 'hdn_hsp_opt', anim = TRUE) )  # options


    
    
    
    
    
})