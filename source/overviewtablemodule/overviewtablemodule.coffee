############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("overviewtablemodule")
#endregion

############################################################
import { Grid, html} from "gridjs"
# import dayjs from "dayjs"npm 
# import { de } from "dayjs/locales"

############################################################
import * as S from "./statemodule.js"
import * as utl from "./tableutils.js"
import * as dataModule from "./datamodule.js"

############################################################
tableObj = null
currentTableHeight = 0

############################################################
export initialize = ->
    log "initialize"         
    setDefaultState()
    setInterval(updateTableHeight, 2000)
    return

############################################################
renderTable = (dataPromise) ->
    log "renderTable"

    columns = utl.getColumnsObject()
    # data = -> dataPromise
    if Array.isArray(dataPromise) then data = dataPromise
    else data = -> dataPromise

    language = utl.getLanguageObject()

    search = false

    pagination = { limit: 50 }
    sort = { multiColumn: false }

    fixedHeader = true
    resizable = false
    autoWidth =  false
    
    gridJSOptions = { columns, data, language, search, pagination, sort, fixedHeader, resizable, autoWidth } 


    log "create Table Object and render"
    tableObj = new Grid(gridJSOptions)
    gridjsFrame.innerHTML = ""    
    tableObj.render(gridjsFrame)
    return

updateTableData = (dataPromise) ->
    log "updateTableData"

    if Array.isArray(dataPromise) then data = dataPromise
    else data = -> dataPromise

    tableObj.config.plugin.remove("pagination") # workaround to avoid Error

    log "update Data + force render..."
    tableObj.updateConfig({data})
    tableObj.forceRender()
    return

############################################################
updateTableHeight = (height) ->
    log "updateTableHeight"
    
    if !height? then height = utl.getTableHeight()
    if currentTableHeight == height then return
    currentTableHeight = height 
    height = height+"px"

    tableObj.config.plugin.remove("pagination") # workaround to avoid Error

    log "update Height + force render..."
    tableObj.updateConfig({height})
    tableObj.forceRender()
    return

############################################################
export refresh = ->
    log "refresh"
    setDefaultState()
    return 

############################################################
export setDefaultState = ->
    log "setDefaultState"

    dataPromise = dataModule.getCurrentData()

    # this is when we want to destroy the table completely
    # renderTable(dataPromise)

    # in the usual case we only want to update the table when it already exists
    if tableObj then updateTableData(dataPromise)
    else renderTable(dataPromise)
    return