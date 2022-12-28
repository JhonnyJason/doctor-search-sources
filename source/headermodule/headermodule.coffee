############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("headermodule")
#endregion

############################################################
export initialize = ->
    log "initialize"
    settingsButton.addEventListener("click", settingsButtonClicked)
    return

settingsButtonClicked = ->
    log "settingsButtonClicked"
    settingsButton.classList.add("on")
    document.body.classList.add("settings")
    return