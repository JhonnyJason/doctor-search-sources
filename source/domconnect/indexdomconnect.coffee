indexdomconnect = {name: "indexdomconnect"}

############################################################
indexdomconnect.initialize = () ->
    global.gridjsFrame = document.getElementById("gridjs-frame")
    global.serversearch = document.getElementById("serversearch")
    global.serversearchVpnInput = document.getElementById("serversearch-vpn-input")
    global.serversearchFirstnameInput = document.getElementById("serversearch-firstname-input")
    global.serversearchSurenameInput = document.getElementById("serversearch-surename-input")
    global.serversearchPostcodeInput = document.getElementById("serversearch-postcode-input")
    global.serversearchLocationInput = document.getElementById("serversearch-location-input")
    global.serversearchExpertiseInput = document.getElementById("serversearch-expertise-input")
    global.serversearchErrorFeedback = document.getElementById("serversearch-error-feedback")
    global.resetButton = document.getElementById("reset-button")
    global.serversearchButton = document.getElementById("serversearch-button")
    global.settingsoffButton = document.getElementById("settingsoff-button")
    global.settingsbuttonBackend = document.getElementById("settingsbutton-backend")
    global.header = document.getElementById("header")
    global.settingsButton = document.getElementById("settings-button")
    global.settingspageBackend = document.getElementById("settingspage-backend")
    return
    
module.exports = indexdomconnect