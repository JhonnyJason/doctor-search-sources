############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("serversearchmodule")
#endregion

############################################################
import { triggerSearch } from "./datamodule.js"
import { refresh } from "./overviewtablemodule.js"

############################################################
export initialize = ->
    log "initialize"
    serversearchButton.addEventListener("click", searchButtonClicked)
    return

############################################################
searchButtonClicked = (evnt) ->
    log "searchButtonClicked"
    vpn = serversearchVpnInput.value
    first_name = serversearchFirstnameInput.value
    last_name = serversearchSurenameInput.value
    city = serversearchLocationInput.value
    zip = serversearchPostcodeInput.value
    isExact = serversearchExactInput.checked
    searchData = { vpn, first_name, last_name, city, zip, isExact }
    olog searchData

    triggerSearch(searchData)
    refresh()
    return
