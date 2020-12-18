
locale = locale(decimal_mark = ",")
library(readr)
raw_data <- read_delim(
  "https://raw.githubusercontent.com/andrejeva-d/dk-dash-covid/main/Data/Data-Epidemiologiske-Rapport-16122020-20kr/Municipality_test_pos.csv", 
  ";", escape_double = FALSE, col_types = cols(Antal_testede = col_number(), 
                                               `Antal_bekr\303\246ftede_COVID-19` = col_number(), 
                                               Befolkningstal = col_number(), `Kumulativ_incidens_(per_100000)` = col_number()), 
  trim_ws = TRUE)
raw_data<-raw_data[,-1]
colnames(raw_data)<-c("Kommune", "Tested", "Positive", "Population","Positive_100000")
rep<-tolower(raw_data$Kommune)


rep<-str_replace_all(rep, "\u00f8", "o")
rep<-str_replace_all(rep, "\u00e6", "ae")
rep<-str_replace_all(rep, "\u00e5", "a")
rep<-str_replace_all(rep, "\u00c6", "ae")
rep<-str_replace_all(rep, "-", "")

rep[rep=="faaborgmidtfyn"]<-"faaborg midtfyn"
rep[rep=="fano"]<-"fanoe"
rep[rep=="dragor"]<-"dragoer"
rep[rep=="fureso"]<-"furesoe"
rep[rep=="helsingor"]<-"helsingoer"
rep[rep=="hillerod"]<-"hilleroed"
rep[rep=="laeso"]<-"laesoe"
rep[rep=="aero"]<-"aeroe"
rep[rep=="allerod"]<-"alleroed"
rep[rep=="bronderslev"]<-"broenderslev"
rep[rep=="ishoj"]<-"ishoej"
rep[rep=="kobenhavn"]<-"koebenhavn"
rep[rep=="morso"]<-"morsoe"
rep[rep=="brondby"]<-"broendby"
rep[rep=="christianso"]<-"christiansoe"
rep[rep=="hjorring"]<-"hjoerring"
rep[rep=="hojetaastrup"]<-"hoeje taastrup"
rep[rep=="koge"]<-"koege"
rep[rep=="ringkobingskjern"]<-"ringkoebing skjern"
rep[rep=="horsholm"]<-"hoersholm"
rep[rep=="ikastbrande"]<-"ikast brande"
rep[rep=="lyngbytaarbaek"]<-"lyngby taarbaek"
rep[rep=="rodovre"]<-"roedovre"
rep[rep=="samso"]<-"samsoe"
rep[rep=="solrod"]<-"solroed"
rep[rep=="sonderborg"]<-"soenderborg"
rep[rep=="soro"]<-"soroe"
rep[rep=="tonder"]<-"toender"
rep[rep=="tarnby"]<-"taarnby"

raw_data$Kommune<-rep

rm(list = setdiff(ls(), "raw_data"))
githubURL <- "https://github.com/andrejeva-d/dk-dash-covid/blob/main/Data/geo_data_municipality.RData?raw=true"
load(url(githubURL))
