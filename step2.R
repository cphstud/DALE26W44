library(rvest)
library(httr)
library(dplyr)
library(stringr)


url="http://books.toscrape.com/"

#fetch the content
page=read_html(url)

# get all books in a list
allBooks=page %>% html_elements(css=".product_pod")


# try one book
testbook=allBooks[[1]]

# titel
title=testbook %>% html_elements("h3") %>% 
  html_elements("a") %>% 
  html_attr("title")
# price
price=testbook %>% html_element(".price_color") %>% 
  html_text()

# rating
rating=testbook %>% 
  #html_elements("[class^='star']") %>% 
  #html_elements(".star-rating.One") %>% 
  html_elements(".star-rating") %>% 
  html_attr("class") %>% 
  str_extract("[a-zA-Z]+$")

# in-stock
instock=testbook %>% html_elements(".instock.availability") %>% 
  html_element("i") %>% html_attr("class")

# link to ressource
link = testbook %>% html_elements("a") %>% html_attr("href") 
link=link[[1]]

# colldataframe
colldf=as.data.frame(matrix(nrow=0,ncol=5))
nv=c("title","price","rating","instock","link")
colnames(colldf)=nv
# put this in a loop
for (i in (1:length(allBooks))) {
  testbook=allBooks[[i]]
  # titel
  title=testbook %>% html_elements("h3") %>% 
    html_elements("a") %>% 
    html_attr("title")
  # price
  price=testbook %>% html_element(".price_color") %>% 
    html_text()
  
  # rating
  rating=testbook %>% 
    #html_elements("[class^='star']") %>% 
    #html_elements(".star-rating.One") %>% 
    html_elements(".star-rating") %>% 
    html_attr("class") %>% 
    str_extract("[a-zA-Z]+$")
  
  # in-stock
  instock=testbook %>% html_elements(".instock.availability") %>% 
    html_element("i") %>% html_attr("class")
  
  # link to ressource
  link = testbook %>% html_elements("a") %>% html_attr("href") 
  link=link[[1]]
  tmplist=list(
    title=title,
    price=price,
    rating=rating,
    instock=instock,
    link=link
  )
  colldf=rbind(colldf,tmplist)
}
