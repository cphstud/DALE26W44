library(chromote)
library(rvest)
library(dplyr)
library(logr)


# init log
log_open(file_name = "carlog")

# init chromote
options(chromote.headless = FALSE)
b <- ChromoteSession$new()
#b$close()
#b$parent$close()

# find startlink
baseurl="https://www.bilbasen.dk/brugt/bil?page="
carname=readRDS("carnames.rds")
cardf=as.data.frame(matrix(data="",nrow = 0,ncol = 2))
colnames(cardf)=carname

for (i in (1:limit)) {
  #build url
  url=paste0(baseurl,i)
  b$Page$navigate(url)
  Sys.sleep(sample(3:7,1,replace = F))
  
  # chrome to site
  html <- b$Runtime$evaluate("document.documentElement.outerHTML")$result$value
  Sys.sleep(1)
  
  # revest the static content
  page <- read_html(html)
  carlist=page %>% html_elements("article")
  log_print(url)
  tryCatch({
    prices <- page %>% html_nodes("[class*='Listing_price']") %>% html_text()
    make_model <- page %>% html_nodes("[class*='Listing_makeModel']") %>% html_text()
    
    tmpdf = data.frame(
      prices=prices,
      make_model=make_model
      )
    
    cardf=rbind(cardf, tmpdf)
  }, error = function(e){
    log_print(str_c("Error at iteration", i, ":", conditionMessage(e)))
    return(i)
  }
  )
}
b$close()
saveRDS(cardf, "ford.rds")