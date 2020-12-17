
library(readr)
dat1 <- read_delim("C:/Users/andre/Documents/R_projects/plotly_viz/data/data_maps/Data-Epidemiologiske-Rapport-07122020-07de/Municipality_test_pos.csv", 
                   ";", escape_double = FALSE, trim_ws = TRUE,locale = locale(decimal_mark = ","))
colnames(dat1)<-c("id", "Kommune", "Tested","COVID", "Pop", "Pos")
dat1B<-dat1[,c("Kommune", "Pos","Tested", "COVID", "Pop")]
colnames(dat1B)<-c("Kommune", "Pos","Tested", "COVID", "Pop")
write.table(dat1B, file = "Municipality_tested_persons_time_series.txt", sep = "\t",
            row.names = FALSE)
dat <- read.delim("~/R_projects/plotly_viz/data/data_maps/Municipality_tested_persons_time_series.txt")
tab<-dat1B
tab$Kommune<-tolower(tab$Kommune)
tab$Kommune<-str_replace_all(tab$Kommune, "\u00f8", "o")
tab$Kommune<-str_replace_all(tab$Kommune, "\u00e6", "ae")
tab$Kommune<-str_replace_all(tab$Kommune, "\u00e5", "a")
tab$Kommune<-str_replace_all(tab$Kommune, "\u00c6", "ae")
tab$Kommune<-str_replace_all(tab$Kommune, "-", "")

tab$Kommune[tab$Kommune=="faaborgmidtfyn"]<-"faaborg midtfyn"
tab$Kommune[tab$Kommune=="fano"]<-"fanoe"
tab$Kommune[tab$Kommune=="dragor"]<-"dragoer"
tab$Kommune[tab$Kommune=="fureso"]<-"furesoe"
tab$Kommune[tab$Kommune=="helsingor"]<-"helsingoer"
tab$Kommune[tab$Kommune=="hillerod"]<-"hilleroed"
tab$Kommune[tab$Kommune=="laeso"]<-"laesoe"
tab$Kommune[tab$Kommune=="aero"]<-"aeroe"
tab$Kommune[tab$Kommune=="allerod"]<-"alleroed"
tab$Kommune[tab$Kommune=="bronderslev"]<-"broenderslev"
tab$Kommune[tab$Kommune=="ishoj"]<-"ishoej"
tab$Kommune[tab$Kommune=="kobenhavn"]<-"koebenhavn"
tab$Kommune[tab$Kommune=="morso"]<-"morsoe"
tab$Kommune[tab$Kommune=="brondby"]<-"broendby"
tab$Kommune[tab$Kommune=="christianso"]<-"christiansoe"
tab$Kommune[tab$Kommune=="hjorring"]<-"hjoerring"
tab$Kommune[tab$Kommune=="hojetaastrup"]<-"hoeje taastrup"
tab$Kommune[tab$Kommune=="koge"]<-"koege"
tab$Kommune[tab$Kommune=="ringkobingskjern"]<-"ringkoebing skjern"
tab$Kommune[tab$Kommune=="horsholm"]<-"hoersholm"
tab$Kommune[tab$Kommune=="ikastbrande"]<-"ikast brande"
tab$Kommune[tab$Kommune=="lyngbytaarbaek"]<-"lyngby taarbaek"
tab$Kommune[tab$Kommune=="rodovre"]<-"roedovre"
tab$Kommune[tab$Kommune=="samso"]<-"samsoe"
tab$Kommune[tab$Kommune=="solrod"]<-"solroed"
tab$Kommune[tab$Kommune=="sonderborg"]<-"soenderborg"
tab$Kommune[tab$Kommune=="soro"]<-"soroe"
tab$Kommune[tab$Kommune=="tonder"]<-"toender"
tab$Kommune[tab$Kommune=="tarnby"]<-"taarnby"

