
import { addModulesToDebug } from "thingy-debug"

############################################################
export modulesToDebug = {

    backendmodule: true
    # configmodule: true
    datamodule: true
    headermodule: true
    # overviewtablemodule: true
    # tableutils: true
    # serversearchmodule: true

}

addModulesToDebug(modulesToDebug)