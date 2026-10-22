library(httr)
library(dplyr)
library(jsonlite)


# 1) Set research goal
# Visuel sammenligning af solskinstimer på skagen og gedser i 2025


# 2) Retrieve data
# Find url for skagen på DMI's frontend vha udviklerværktøjet
url="http://www.dmi.dk/skagen"

# hent skagen ind i R
rawskagen=GET(url)
# tjek statuskoden

# hent indhold som text
rawskagentext=rawskagen

# Lav json til list og undersøg forskellen på flatten
skagenjs <- fromJSON(rawskagentext, flatten = F)
skagenjs <- fromJSON(rawskagentext, flatten = T)


# find dataframes i listerne
skagendf <- skagenjs$features

# 3) Check data
library(skimr)
skim(skagendf)
# numeriske plot hist
hist(skagendf$values)
# kategori - nominal / ordinal 
# date - 
# sammenhæng num/date plot 
plot(skagendf$date,skagendf$values)


###### FORBEDRING AF PLOTS VHA AGGREGERING #######
### aggregér pr dag og plot
# lav dato om til tekst
# lav en ny variabel - day - som man kan gruppere på
skagendf$day=as.character(skagendf$timestamp)

# find et regulært udtryk som fjerner alt efter mellemrummet
# 2026-01-02 09:00:00 bliver til 2026-01-02
skagendf$day=str_remove(skagendf$day, " ")

skagendf <-  skagendf |> group_by() |> mutate(daysum=sum()) |> ungroup()
skagendfDay <- skagendf |> select() |> unique()

### aggregér pr måned ud fra samme ide og plot
# lav dato om til tekst
# lav en ny variabel - month - som man kan gruppere på
# 2026-01-02 bliver til 2026-01
skagendfDay <-  skagendfDay |> group_by() |> mutate(monthsum=sum()) |> ungroup()


### aggregér pr uge ved hjælp af lubridate og plot
skagendfDay$week <- lubridate::week()


##### LAV FUNKTION TIL GENTAGELSER #######
## flyt relevant kode ind i funktionen

getSunFromStationid <- function(stationid) {
  sundf=NULL
  return(sundf)
}

getSunGroupFromStationid <- function(stationid,aggfactor) {
  sunaggdf=NULL
  return(sunaggdf)
}

esbjergSun <- getSunFromStationid("123123")
esbjergSunWeek <- getSunGroupFromStationid("123123","week")

