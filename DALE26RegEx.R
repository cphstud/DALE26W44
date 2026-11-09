library(stringr)
library(dplyr)


#indlæs
text=readRDS("carsforreg.rds")

# tilføj kolonne med antal karakterer
text$chars=12
# sortér efter chars


# hent første beskrivelse ud
textet=text[]
# udskriv til en fil
writeLines(textet,"car.txt")

# vis de første 20 characterer i raw og identificer newline
testraw=charToRaw()

# split strengen op i tokens baseret på newline
testtext=unlist(str_split())

# find alle tal
str_match_all(testtext, "\\d")
str_match_all(testtext, "\\d+")

# find alle tal med flere end 2 
r=unlist(str_match_all(testtext, "\\d{3,}"))

#Findes der et telefonnummer?
tlf=unlist(str_extract_all(testtext))

# saml all uppercasesekvenser som er længere end 3 karakterer
# 1) brug en quantifyer
myv <- unlist(str_match_all(testtext))


# words
# letters and numbers
str_match_all(testtext, "\\w+")
str_match_all(testtext, "\\W+")

# all white spaces
str_match_all(testtext, "\\s")
str_match_all(testtext, "\\S")



# 
str_match(myv, ".")
str_match(myv, ".+")
str_match(myv, "AB.*")
str_match(myv, "^[AB].+")




# find de hyppigste ord med mere end 3 karakterer
kpi=unlist(str_extract_all(testtext,""))
kpi2=sort(str_to_lower(kpi))
sort(table(kpi2), decreasing = T)


# lav det til en funktion
kpi <- function(text,ln) {
  text=testtext
  ln=4
  pattern=str_c()
  tmp=unlist(str_extract_all(text,pattern))
  tmp2=sort(str_to_lower(tmp))
  retval=sort(table(tmp2), decreasing = T)
  head(retval)
}
#føj kpilisten til dataframene


### GROUPS ######
testtext

#Findes der en adresse?
str_match(testtext, "")


pattern = '.*(\\d{3}).*(\\d{3}).*(\\d{4})'

phone_numbers = c(
  "(541) 471 3918",
  "(603)281-0308",
  "Home: 425-707-7220",
  "(814)-462-8074",
  "9704443106",
  "I don't have a phone."
)

phn=str_match(phone_numbers, pattern)
phndf=as.data.frame(phn)
