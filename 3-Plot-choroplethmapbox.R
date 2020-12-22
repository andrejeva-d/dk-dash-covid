
library(plotly)

colorscale_1 = c(
  list(c(0, "#292927")),#melns
  list(c(0.2, "#264563")), #peleks
  list(c(0.4, "#3a9fe8")),#zils
  list(c(0.6, "#9391c4")),#dzeltens
  list(c(0.8, "#c468ae")),#dzeltens
  list(c(1, "#ba4a75")))#sarkans

colorscale_2 = c(
  list(c(0, "#292927")),#melns
  list(c(0.15, "#264563")), #peleks
  list(c(0.3, "#3a9fe8")),#zils
  list(c(0.45, "#9391c4")),#dzeltens
  list(c(0.6, "#c468ae")),#dzeltens
  list(c(1, "#ba4a75")))#sarkans

githubURL <-
  "https://github.com/andrejeva-d/dk-dash-covid/blob/main/Data/plot_dk_map_municip.RData?raw=true"
load(url(githubURL))

rm(fig)
fig <- plot_ly()

fig_1 <- fig %>% add_trace(
  type="choroplethmapbox",
  geojson=geoj,
  locations=REZ_DONE$subreg,
  z=as.numeric(REZ_DONE$Positive_100000),
  visible = c(TRUE),
  colorscale=colorscale_1,
  hoverinfo="text",
  colorbar= list(len=1,title="",x=1,y=1,outlinewidth=0.1,outlinecolor = "white"),
  hovertext=paste0(toupper(REZ_DONE$reg),"\n",
                   "Positive\n",
                   "cases per 100.000\n",
                   round(REZ_DONE$Positive_100000 ,2)),
  marker=list(line=list(width=0),opacity=0.7)
)

fig_2 <- fig_1 %>% add_trace(
  type="choroplethmapbox",
  geojson=geoj,
  locations=REZ_DONE$subreg,
  z=as.numeric(REZ_DONE$Positive),
  visible = c(FALSE),
  colorscale=colorscale_2,
  hoverinfo="text",
  colorbar= list(len=1,title="",x=1,y=1,  
                 outlinewidth=0.1,
                 outlinecolor = "white"),
  hovertext=paste0(toupper(REZ_DONE$reg),"\n",
                   "Total Positive\n",
                   "cases\n",
                   round(REZ_DONE$Positive,2)),
  marker=list(line=list(width=0),opacity=0.7)
)

button_1_100000 <- list(method = "update",args = list(
  list(visible = c(TRUE, FALSE))),label = "Positive cases per 100.000")  
button_2_total <- list(method = "update",args = list(
  list(visible = c(FALSE,TRUE))),label = "Total number of positive cases")  

color_types <- list(
  list(type = "buttons",active=-1,direction = "right",
       xanchor = 'left',yanchor = "left",
       x = 0.01, y = 0.99,
       buttons=list(button_1_100000, button_2_total ))
)

fig_map_dk <- fig_2 %>% layout(
  legend = list(orientation = "h"),
  margin=list(l=0, t=0, r=0, b=0, pad=0),
  mapbox=list(
    bearing=0,
    zoom =5.6,
    center = list(lon = 10.38066, lat = 56.18807),
    style="carto-positron"),
  updatemenus = (color_types)
)
fig_map_dk
















