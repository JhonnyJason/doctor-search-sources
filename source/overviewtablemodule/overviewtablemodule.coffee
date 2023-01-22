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
    data = -> dataPromise
    language = utl.getLanguageObject()
    # search = true
    search = false

    pagination = { limit: 50 }
    sort = { multiColumn: false }

    fixedHeader = true
    resizable = false
    autoWidth =  true
    
    style = 
        table:
            height: "#{utl.getTableHeight()}px"
            width: "100%"
            'white-space': "nowrap"

    gridJSOptions = { columns, data, language, search, pagination, sort, fixedHeader, resizable, autoWidth, style }

    if tableObj?
        tableObj = null
        gridjsFrame.innerHTML = ""  
        tableObj = new Grid(gridJSOptions)
        tableObj.render(gridjsFrame).forceRender()
        # this does not work here - it seems the Old State still remains in the GridJS singleton thus a render here does not refresh the table at all
    else
        tableObj = new Grid(gridJSOptions)
        gridjsFrame.innerHTML = ""    
        tableObj.render(gridjsFrame)
    return

updateTableData = (dataPromise) ->
    # log "updateTableData"
    columns = utl.getColumnsObject()
    data = -> dataPromise
    language = utl.getLanguageObject()

    # searchInput = document.getElementsByClassName("gridjs-search-input")[0]
    # if searchInput? then searchValue = searchInput.value
    # log searchValue
    # search =
    #     enabled: true
    #     keyword: searchValue
    search = false

    tableObj.updateConfig({columns, data, language, search})
    tableObj.forceRender()
    return

############################################################
updateTableHeight = (height) ->
    if !height? then height = utl.getTableHeight()
    if currentTableHeight == height then return
    currentTableHeight = height 
    height = height+"px"

    #preserve input value if we have
    # searchInput = document.getElementsByClassName("gridjs-search-input")[0]
    # if searchInput? 
    #     searchValue = searchInput.value
    #     log searchValue
    #     search =
    #         enabled: true
    #         keyword: searchValue
    # else search = false
    search = false
        
    tableObj.updateConfig({height, search})
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