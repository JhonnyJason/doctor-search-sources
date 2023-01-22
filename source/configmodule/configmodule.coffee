export requestProvidersURL = "https://extern.bilder-befunde.at/radmint-api/api/v1/docvz/providers" #extern demo
export requestStatsURL = "https://extern.bilder-befunde.at/radmint-api/api/v1/docvz/stats" #extern demo

export requestRoute = "/providers"
export backendOptions = [
    "https://extern.bilder-befunde.at/radmint-api/api/v1/docvz"
    "https://www.bilder-befunde.at/radmint-api/api/v1/docvz"
    # "https://extern.bilder-befunde.at/radmint/api/v1"
    # "https://www.bilder-befunde.at/radmint/api/v1"
    "https://localhost/radmint-api/api/v1/docvz"
    "http://localhost/radmint-api/api/v1/docvz"
]

export dataLoadPageSize = 1000