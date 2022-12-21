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
        showing: 'Anzeigen'
        of: 'von'
        to: 'zu'
        results: 'Ergebnisse'
    }
    loading: 'Wird geladen...'
    noRecordsFound: 'Keine übereinstimmenden Aufzeichnungen gefunden'
    error: 'Beim Abrufen der Daten ist ein Fehler aufgetreten'
}

#endregion

## datamodel default entry
# | VPN | DaMe | Vorname | Name | Straße | Ort | Postleitzahl | Kurativer Vertrag |
stringCompare = (el1, el2) ->
    el1String = "#{el1}"
    el2String = "#{el2}"
    return el1String.localeCompare(el2String)

############################################################
#region cell formatter functions
vpnFormatter = (content, row) ->
    if content? and content.length? and content.length > 0 and content[0].id? 
        return "#{content[0].id}"
    return "-"

daMeFormatter = (content, row) ->
    if content? and content.length? and content.length > 0 and content[0].hv_uid?
        return content[0].hv_uid
    return "-"

firstnameFormatter = (content, row) ->
    if content then return content
    return "-"

nameFormatter = (content, row) ->
    if content then return content
    return "-"

streetFormatter = (content, row) ->
    if content? and content.length? and content.length > 0 and content[0].street? 
        return "#{content[0].street}"
    return "-"

locationFormatter = (content, row) ->
    if content? and content.length? and content.length > 0 and content[0].city? 
        return "#{content[0].city}"
    return "-"

postcodeFormatter = (content, row) ->
    if content? and content.length? and content.length > 0 and content[0].zip?
        return "#{content[0].zip}"
    return "-"

kurContractFormatter = (content, row) ->
    if content[0].has_curative_contract then return "Ja"
    else return "Nein"

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

    nonTableOffset = serversearchHeight + footerHeight + headHeight + outerPadding
    
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
        sort: {compare: stringCompare}
            
    }

    ############################################################
    daMeHeadObj = {
        name: "DaMe",
        id: "dame_recps",
        formatter: daMeFormatter
        sort: {compare: stringCompare}
    }

    ############################################################
    firstnameHeadObj = {
        name: "Vorname",
        id: "first_name",
        formatter: firstnameFormatter
        sort: {compare: stringCompare}
    }

    ############################################################
    nameHeadObj = {
        name: "Name",
        id: "name",
        formatter: nameFormatter
        sort: {compare: stringCompare}
    }

    ############################################################
    streetHeadObj = {
        name: "Straße",
        id: "addresses",
        formatter: streetFormatter
        sort: {compare: stringCompare}
    }

    ############################################################
    locationHeadObj = {
        name: "Ort",
        id: "addresses",
        formatter: locationFormatter
        sort: {compare: stringCompare}
    }

    ############################################################
    postcodeHeadObj = {
        name: "PLZ",
        id: "addresses",
        formatter: postcodeFormatter
        sort: {compare: stringCompare}
    }

    ############################################################
    kurContractHeadObj = {
        name: "Kur.Vertr.",
        id: "addresses",
        formatter: kurContractFormatter
        sort: {compare: stringCompare}
    }


    #endregion

    # if state == "shareToDoctor0" then return [checkboxHeadObj, indexHeadObj, screeningDateHeadObj, nameHeadObj, svnHeadObj, birthdayHeadObj, descriptionHeadObj, radiologistHeadObj, sendingDateHeadObj]

    return [vpnHeadObj, daMeHeadObj, firstnameHeadObj, nameHeadObj, streetHeadObj, locationHeadObj, postcodeHeadObj, kurContractHeadObj]

export getLanguageObject = -> deDE

#endregion
