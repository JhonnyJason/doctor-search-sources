############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("datamodule")
#endregion

############################################################
import { 
    dataLoadPageSize, 
    requestProvidersURL, 
    requestStatsURL 
} from "./configmodule.js"
############################################################
import *  as S from "./statemodule.js"

############################################################
currentData = []

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

getData = (url) ->
    options =
        method: 'GET'
        mode: 'cors'
        credentials: 'include'
    
    try
        response = await fetch(url, options)
        if !response.ok then throw new Error("Response not ok - status: #{response.status}!")
        return response.json()
    catch err then throw new Error("Network Error: "+err.message)


retrieveCurrentData = (searchData) ->
    # { vpn,first_name, last_name, city, zip, isExact } = searchData
    { vpn,first_name, last_name, city, zip } = searchData

    URL = S.load("requestProvidersURL")
    if typeof URL != "string" then URL = requestURL

    try
        allData = []
        page_size = dataLoadPageSize
        
        page = 1
        receivedCount = 0
        
        loop
            requestData = { vpn,first_name, last_name, city, zip, page, page_size }
            rawData = await postRequest(URL, requestData)

            allData.push(rawData.providers)
            receivedCount += rawData.count
            
            # if rawData.count <  page_size then break
            break
            
            page++
        
        return allData.flat()
    catch err then throw err


############################################################
export getStats = ->
    URL = S.load("requestStatsURL")
    if typeof URL != "string" then URL = requestStatsURL
    stats = await getData(URL)
    return stats


export getCurrentData = -> currentData

export triggerSearch = (searchData) ->
    currentData = retrieveCurrentData(searchData)
    return

export resetData = ->
    currentData =  []
    return