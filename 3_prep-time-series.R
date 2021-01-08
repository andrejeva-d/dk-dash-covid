

library(readr)

#########################################################################################
# PREPARE Death data

raw_data_death <- read_delim(
  "https://raw.githubusercontent.com/andrejeva-d/dk-dash-covid/main/Data/Data-Epidemiologiske-Rapport-16122020-20kr/Deaths_over_time.csv",
  ";",
  escape_double = FALSE,
  trim_ws = TRUE
)
colnames(raw_data_death) <- c("Data", "Death")
raw_data_death$Data <-
  as.Date(raw_data_death$Data, tryFormats = c("%Y-%m-%d"))

#########################################################################################
# PREPARE positive data

raw_data_pos <- read_delim(
  "https://raw.githubusercontent.com/andrejeva-d/dk-dash-covid/main/Data/Data-Epidemiologiske-Rapport-16122020-20kr/Test_pos_over_time.csv",
  ";",
  escape_double = FALSE,
  trim_ws = TRUE
)
raw_data_pos <- data.frame(lapply(raw_data_pos, function(x) {
  gsub("\\.", "", x)
}))
raw_data_pos <- data.frame(lapply(raw_data_pos, function(x) {
  gsub("\\,", ".", x)
}))

raw_data_pos[, c(-1)] <-
  data.frame(lapply(raw_data_pos[, c(-1)], as.numeric))
raw_data_pos$Date <-
  as.Date(raw_data_pos$Date, tryFormats = c("%Y-%m-%d"))

raw_data_pos_ratio <- raw_data_pos[, c("Date", "PosPct")]
colnames(raw_data_pos_ratio) <- c("Data", "Ratio")

raw_data_tested <- raw_data_pos[, c("Date", "Tested")]
colnames(raw_data_tested) <- c("Data", "Tested")

raw_data_pos <- raw_data_pos[, c("Date", "NewPositive")]
colnames(raw_data_pos) <- c("Data", "Positive")

#########################################################################################
# PREPARE admitted data

raw_data_adm <- read_delim(
  "https://raw.githubusercontent.com/andrejeva-d/dk-dash-covid/main/Data/Data-Epidemiologiske-Rapport-16122020-20kr/Newly_admitted_over_time.csv",
  ";",
  escape_double = FALSE,
  trim_ws = TRUE
)
raw_data_adm <- raw_data_adm[, c("Dato", "Total")]
colnames(raw_data_adm) <- c("Data", "Adm")

#########################################################################################
# Merge data

tab <- merge(raw_data_death,
             raw_data_pos_ratio,
             by = "Data",
             all = TRUE)
tab <- merge(tab, raw_data_pos, by = "Data", all = TRUE)
tab <- merge(tab, raw_data_adm, by = "Data", all = TRUE)
tab <- merge(tab, raw_data_tested, by = "Data", all = TRUE)

tab <- subset(tab, Data < max(tab$Data, na.rm = TRUE))
tab <- subset(tab, Data >= "2020-03-16")

save(tab, file = "Data/data_time_series.RData")


