############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("datamodule")
#endregion

############################################################
import { dataLoadPageSize, requestURL } from "./configmodule.js"

############################################################
currentData = []

############################################################
export initialize = ->
    log "initialize"
    #Implement or Remove :-)
    return

############################################################
postRequest = (url, data) ->
    options =
        method: 'POST'
        mode: 'cors'
        credentials: 'include'
    
        body: JSON.stringify(data)
        headers:
            'Content-Type': 'application/json'

    try
        response = await fetch(url, options)
        if !response.ok then throw new Error("Response not ok - status: #{response.status}!")
        return response.json()
    catch err then throw new Error("Network Error: "+err.message)


retrieveCurrentData = (searchData) ->
    { vpn,first_name, last_name, city, zip, isExact } = searchData

    try
        allData = []
        page_size = dataLoadPageSize
        
        page = 1
        receivedCount = 0
        
        loop
            requestData = { vpn,first_name, last_name, city, zip, page, page_size }
            rawData = await postRequest(requestURL, requestData)

            allData.push(rawData.providers)
            receivedCount += rawData.count
            
            if rawData.count <  page_size then break
            
            page++
        
        return allData.flat()
    catch err



############################################################
export getCurrentData = -> currentData

export triggerSearch = (searchData) ->
    currentData = retrieveCurrentData(searchData)
    return
