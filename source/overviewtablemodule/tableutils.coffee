############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("tableutils")
#endregion

############################################################
import { Grid, html} from "gridjs"

############################################################
#region germanLanguage
deDE = {
    search: {
        placeholder: 'Suche...'
    }
    sort: {
        sortAsc: 'Spalte aufsteigend sortieren'
        sortDesc: 'Spalte absteigend sortieren'
    }
    pagination: {
        previous: 'Vorherige'
        next: 'Nächste'
        navigate: (page, pages) -> "Seite #{page} von #{pages}"
        page: (page) -> "Seite #{page}"
        showing: ' '
        of: 'von'
        to: '-'
        results: 'Daten'
    }
    loading: 'Wird geladen...'
    noRecordsFound: 'Keine übereinstimmenden Aufzeichnungen gefunden'
    error: 'Beim Abrufen der Daten ist ein Fehler aufgetreten'
}

#endregion

## datamodel default entry
# | VPN | DaMe | Vorname | Name | Straße | Ort | Postleitzahl | Kurativer Vertrag |

############################################################
#region cell formatter functions
vpnFormatter = (content, row) ->
    if content? and content.length? and content.length > 0 and content[0].id? 
        return "#{content[0].id}"
    return ""

daMeFormatter = (content, row) ->
    if content? and content.length? and content.length > 0 and content[0].hv_uid?
        return content[0].hv_uid
    return ""

firstnameFormatter = (content, row) ->
    if content then return content
    return ""

nameFormatter = (content, row) ->
    if content then return content
    return ""

streetFormatter = (content, row) ->
    if content? and content.length? and content.length > 0 and content[0].street? 
        return "#{content[0].street}"
    return ""

locationFormatter = (content, row) ->
    if content? and content.length? and content.length > 0 and content[0].city? 
        return "#{content[0].city}"
    return ""

postcodeFormatter = (content, row) ->
    if content? and content.length? and content.length > 0 and content[0].zip?
        return "#{content[0].zip}"
    return ""

kurContractFormatter = (content, row) ->
    if content[0].has_curative_contract then return "Ja"
    else return "Nein"

#endregion

############################################################
#region compare functions
localCompareOptions = {sensitivity: "base", numeric: true}

############################################################
stringCompare = (el1, el2) ->
    el1String = "#{el1}"
    if !el1String then el1String = "zzzzzzzzzzzzzzzz"
    el2String = "#{el2}"
    if !el2String then el2String = "zzzzzzzzzzzzzzzz"
    return el1String.localeCompare(el2String, "de", localCompareOptions)

############################################################
vpnCompare = (el1, el2) ->
    el1String = vpnFormatter(el1)
    el2String = vpnFormatter(el2)
    return stringCompare(el1String, el2String)    

daMeCompare = (el1, el2) ->
    el1String = daMeFormatter(el1)
    el2String = daMeFormatter(el2)
    return stringCompare(el1String, el2String)    

firstnameCompare = (el1, el2) ->
    el1String = firstnameFormatter(el1)
    el2String = firstnameFormatter(el2)
    return stringCompare(el1String, el2String)    

nameCompare = (el1, el2) ->
    el1String = nameFormatter(el1)
    el2String = nameFormatter(el2)
    return stringCompare(el1String, el2String)    

streetCompare = (el1, el2) ->
    el1String = streetFormatter(el1)
    el2String = streetFormatter(el2)
    return stringCompare(el1String, el2String)    

locationCompare = (el1, el2) ->
    el1String = locationFormatter(el1)
    el2String = locationFormatter(el2)
    return stringCompare(el1String, el2String)    

postcodeCompare = (el1, el2) ->
    el1String = postcodeFormatter(el1)
    el2String = postcodeFormatter(el2)
    return stringCompare(el1String, el2String)    

kurContractCompare = (el1, el2) ->
    el1String = kurContractFormatter(el1)
    el2String = kurContractFormatter(el2)
    return stringCompare(el1String, el2String)    
#endregion

############################################################
#region exportedFunctions
export getTableHeight = ->
    # log "getTableHeight"

    # gridJSHead = document.getElementsByClassName("gridjs-thead")[0]
    if gridJSHead? then headHeight = gridJSHead.offsetHeight
    else headHeight = 0
    
    gridJSFooter = document.getElementsByClassName("gridjs-footer")[0]
    if gridJSFooter? then footerHeight = gridJSFooter.offsetHeight
    else footerHeight = 0

    fullHeight = window.innerHeight
    fullWidth = window.innerWidth
    
    outerPadding = 5
    serversearchHeight = serversearch.offsetHeight
    headerHeight = header.offsetHeight
    nonTableOffset = headerHeight + serversearchHeight + footerHeight + headHeight + outerPadding
    
    tableHeight = fullHeight - nonTableOffset
    # olog {tableHeight, fullHeight, nonTableOffset, approvalHeight}

    # return tableHeight
    return tableHeight

############################################################
export getColumnsObject = ->

    ############################################################
    #region columnHeadObjects

    # indexHeadObj = {
    #     name: "",
    #     id: "index",
    #     sort: false,
    #     hidden: true
    # }

    ############################################################
    vpnHeadObj = {
        name: "VPN",
        id: "contracts",
        formatter: vpnFormatter
        sort: {compare: vpnCompare}
            
    }

    ############################################################
    daMeHeadObj = {
        name: "DaMe",
        id: "dame_recps",
        formatter: daMeFormatter
        sort: {compare: daMeCompare}
    }

    ############################################################
    firstnameHeadObj = {
        name: "Vorname",
        id: "first_name",
        formatter: firstnameFormatter
        sort: {compare: firstnameCompare}
    }

    ############################################################
    nameHeadObj = {
        name: "Name",
        id: "name",
        formatter: nameFormatter
        sort: {compare: nameCompare}
    }

    ############################################################
    streetHeadObj = {
        name: "Straße",
        id: "addresses",
        formatter: streetFormatter
        sort: {compare: streetCompare}
    }

    ############################################################
    locationHeadObj = {
        name: "Ort",
        id: "addresses",
        formatter: locationFormatter
        sort: {compare: locationCompare}
    }

    ############################################################
    postcodeHeadObj = {
        name: "PLZ",
        id: "addresses",
        formatter: postcodeFormatter
        sort: {compare: postcodeCompare}
    }

    ############################################################
    kurContractHeadObj = {
        name: "Kur.Vertr.",
        id: "addresses",
        formatter: kurContractFormatter
        sort: {compare: kurContractCompare}
    }


    #endregion

    # if state == "shareToDoctor0" then return [checkboxHeadObj, indexHeadObj, screeningDateHeadObj, nameHeadObj, svnHeadObj, birthdayHeadObj, descriptionHeadObj, radiologistHeadObj, sendingDateHeadObj]

    return [vpnHeadObj, daMeHeadObj, firstnameHeadObj, nameHeadObj, streetHeadObj, locationHeadObj, postcodeHeadObj, kurContractHeadObj]

export getLanguageObject = -> deDE

#endregion
