indexdomconnect = {name: "indexdomconnect"}

############################################################
indexdomconnect.initialize = () ->
    global.gridjsFrame = document.getElementById("gridjs-frame")
    global.serversearch = document.getElementById("serversearch")
    global.serversearchVpnInput = document.getElementById("serversearch-vpn-input")
    global.serversearchFirstnameInput = document.getElementById("serversearch-firstname-input")
    global.serversearchSurenameInput = document.getElementById("serversearch-surename-input")
    global.serversearchLocationInput = document.getElementById("serversearch-location-input")
    global.serversearchPostcodeInput = document.getElementById("serversearch-postcode-input")
    global.serversearchErrorFeedback = document.getElementById("serversearch-error-feedback")
    global.serversearchButton = document.getElementById("serversearch-button")
    return
    
module.exports = indexdomconnect