############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("backendmodule")
#endregion

############################################################
import * as S from "./statemodule.js"
import { updateHeader } from "./headermodule.js"
import { backendOptions } from "./configmodule.js"

############################################################
backendServerChoice = document.getElementById("backend-server-choice")

############################################################
export initialize = ->
    log "initialize"
    # backendServerChoice.
    backendServerChoice.addEventListener("change", backendServerChoiceChanged)
    backendServerChoice

    requestProvidersURL = S.load("requestProvidersURL")
    requestStatsURL = S.load("requestStatsURL")

    if typeof requestProvidersURL != "string"
        currentChoice = 0
    else
        backendURL = requestProvidersURL.replace("/providers", "")

        # synchronize stats Request URL if it is not a fit
        if typeof requestStatsURL == "string"
            statsBackendURL = requestStatsURL.replace("/stats", "")
            if backendURL != statsBackendURL then S.save("requestStatsURL", backendURL+"/stats")
        else S.save("requestStatsURL", backendURL+"/stats")
        
        
        currentChoice = backendOptions.indexOf(backendURL)
        if currentChoice < 0 then currentChoice = 0

    addAllBackendOption()
    selectBackendOption(currentChoice)
    return

############################################################
addAllBackendOption = ->
    log "addAllBackendOption"
    optionsHTML = ""
    for option,i in backendOptions
        optionsHTML += "<option value='#{i}'>#{option}</option>"
    backendServerChoice.innerHTML = optionsHTML
    return

selectBackendOption = (index) ->
    log "selectBackendOption #{index}"
    
    if index >= backendOptions.length 
        index = 0
        alert("index out of bound - we reset to 0!")

    backendURL = backendOptions[index]
    requestProvidersURL = backendURL + "/providers"
    requestStatsURL = backendURL + "/stats"
    backendServerChoice.value = index

    S.save("requestProvidersURL", requestProvidersURL)
    S.save("requestStatsURL", requestStatsURL)

    updateHeader()
    return

############################################################
backendServerChoiceChanged = ->
    log "backendServerChoiceChanged"
    currentChoice = backendServerChoice.value
    log currentChoice
    selectBackendOption(currentChoice)
    return