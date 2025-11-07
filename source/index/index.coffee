import Modules from "./allmodules"
import domconnect from "./indexdomconnect"
domconnect.initialize()

global.allModules = Modules


############################################################
checkInstantRedirect = ->
    allCookies = document.cookie
    cookies = allCookies.split(";")
    
    passwordExists = false
    usernameExists = false
    tokenExists = false

    for cookie in cookies
        c = cookie.trim()
        if c.indexOf("password=") == 0 and c.length > 11 then passwordExists = true
        if c.indexOf("username=") == 0 and c.length > 11 then usernameExists = true
        if c.indexOf("Sustsol-Webview-Token=") == 0 and c.length > 24 then tokenExists = true
    
    # alert("cookies were: #{cookies}")
    ## redirect on no cookies
    if !tokenExists and !(passwordExists and usernameExists)
        # alert("redirect to: #{loginRedirectURL}") 
        location.href = "https://www.bilder-befunde.at/404"
    return

############################################################
appStartup = ->
    checkInstantRedirect()
    ## which modules shall be kickstarted?
    # Modules.appcoremodule.startUp()
    return

############################################################
run = ->
    promises = (m.initialize() for n,m of Modules when m.initialize?) 
    await Promise.all(promises)
    appStartup()

############################################################
run()