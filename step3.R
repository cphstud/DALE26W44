library(rvest)
library(httr)
library(dplyr)
library(stringr)


url="http://books.toscrape.com/"
baseurl="http://books.toscrape.com/catalogue/page-"

#fetch the content
page=read_html(url)

# how many pages?
np=page %>% html_element("li.current") %>% 
  html_text() %>% 
  #str_match("of ([0-9]+)")
  str_extract("of ([0-9]+)") %>% 
  str_extract("[0-9]+") %>% 
  as.integer()

# create urllist
targeturls=lapply(1:np, function(x) paste0(baseurl,x,".html"))

#df to collect
colldf=as.data.frame(matrix(nrow=0,ncol=5))
nv=c("title","price","rating","instock","link")
colnames(colldf)=nv

#for (target in targeturls) {
for (j in (1:3)) {
  page=read_html(targeturls[[j]])
  targeturls[[j]]
  Sys.sleep(2)
  allBooks=page %>% html_elements(css=".product_pod")
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
}
