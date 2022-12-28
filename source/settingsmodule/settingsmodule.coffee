############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("settingsmodule")
#endregion

############################################################
currentlyShownSettingspage = null

############################################################
export initialize = ->
    log "initialize"
    settingsoffButton.addEventListener("click", settingsoffButtonClicked)
    
    #specific settings
    # settingsbuttonLogin.addEventListener("click", settingsbuttonLoginClicked)
    settingsbuttonBackend.addEventListener("click", settingsbuttonBackendClicked)
    
    #Implement or Remove :-)
    backButtons = document.getElementsByClassName("settingspage-backbutton")
    b.addEventListener("click", settingsBackButtonClicked) for b in backButtons
    return

############################################################
#region eventListeners
settingsoffButtonClicked = ->
    document.body.classList.remove("settings") 
    return

############################################################
settingsbuttonLoginClicked = ->
    # settingspageLogin.
    currentlyShownSettingspage = settingspageLogin
    currentlyShownSettingspage.classList.add("here")
    # document.body.classList.add("away")
    # mainframe.classList.add("zoomed-out")
    return

settingsbuttonBackendClicked = ->
    # settingspageBackend.
    currentlyShownSettingspage = settingspageBackend
    currentlyShownSettingspage.classList.add("here")
    # document.body.classList.add("away")
    # mainframe.classList.add("zoomed-out")
    return

############################################################
settingsBackButtonClicked = ->
    return unless currentlyShownSettingspage?
    currentlyShownSettingspage.classList.remove("here")
    currentlyShownSettingspage = null
    # document.body.classList.remove("away")
    # mainframe.classList.remove("zoomed-out")
    return

#endregion