############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("headermodule")
#endregion

############################################################
import { getStats } from "./datamodule.js"

############################################################
headerTitle = document.getElementById("header-title")

############################################################
titleText = ""

############################################################
export initialize = ->
    log "initialize"
    settingsButton.addEventListener("click", settingsButtonClicked)
    titleText = headerTitle.textContent
    try 
        stats = await getStats()
        log titleText
        log stats.releaseDate
        releaseDate = new Date(stats.releaseDate)
        month = releaseDate.getMonth + 1
        year = releaseDate.getFullYear()
        titleText += month+"/"+year
    catch err then log "Could not request stats for header!"
    return

settingsButtonClicked = ->
    log "settingsButtonClicked"
    settingsButton.classList.add("on")
    document.body.classList.add("settings")
    return