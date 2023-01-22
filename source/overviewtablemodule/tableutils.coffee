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
    if content then return html("<div style='max-width: 200px;'>#{content}</div>")
    return ""

streetFormatter = (content, row) ->
    if content? and content.length? and content.length > 0
        streets = content.map((el) -> el.street)
        streetsHTML = "<div style='min-width: 300px;>#{streets.join("<br>")}</div>"
        return html(streetsHTML)
    return ""

locationFormatter = (content, row) ->
    if content? and content.length? and content.length > 0 
        cities = content.map((el) -> el.city)
        citiesHTML = cities.join("<br>")
        return html(citiesHTML)
    return ""

postcodeFormatter = (content, row) ->
    if content? and content.length? and content.length > 0
        zipcodes = content.map((el) -> el.zip)
        zipHTML = zipcodes.join("<br>")
        return html(zipHTML)
    return ""

kurContractFormatter = (content, row) ->
    if content? and content.length? and content.length > 0
        kurContracts = content.map((el) -> if el.has_curative_contract then "Ja" else "Nein")
        kurContractsHTML = kurContracts.join("<br>")
        return html(kurContractsHTML)
    return "Nein"
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
        autoWidth: true,
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
        style: { 'white-space': 'nowrap' },
        formatter: streetFormatter
        sort: {compare: streetCompare}
    }

    ############################################################
    locationHeadObj = {
        name: "Ort",
        id: "addresses",
        autoWidth: true,
        formatter: locationFormatter
        sort: {compare: locationCompare}
    }

    ############################################################
    postcodeHeadObj = {
        name: "PLZ",
        id: "addresses",
        autoWidth: true,
        formatter: postcodeFormatter
        sort: {compare: postcodeCompare}
    }

    ############################################################
    kurContractHeadObj = {
        name: "Kur.V.",
        id: "addresses",
        autoWidth: true,
        formatter: kurContractFormatter
        sort: {compare: kurContractCompare}
    }


    #endregion

    # if state == "shareToDoctor0" then return [checkboxHeadObj, indexHeadObj, screeningDateHeadObj, nameHeadObj, svnHeadObj, birthdayHeadObj, descriptionHeadObj, radiologistHeadObj, sendingDateHeadObj]

    return [vpnHeadObj, daMeHeadObj, firstnameHeadObj, nameHeadObj, streetHeadObj, locationHeadObj, postcodeHeadObj, kurContractHeadObj]

export getLanguageObject = -> deDE

#endregion
