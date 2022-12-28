############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("backendmodule")
#endregion

############################################################
import * as S from "./statemodule.js"
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

    if typeof requestProvidersURL != "string"
        currentChoice = 0
    else
        backendURL = requestProvidersURL.replace("/providers", "")
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
    backendServerChoice.value = index
    S.save("requestProvidersURL", requestProvidersURL)
    return


############################################################
backendServerChoiceChanged = ->
    log "backendServerChoiceChanged"
    currentChoice = backendServerChoice.value
    log currentChoice
    selectBackendOption(currentChoice)
    return