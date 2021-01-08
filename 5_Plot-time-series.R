
library(plotly)

#########################################################################################
# PREPARE Death data

githubURL <-
  "https://github.com/andrejeva-d/dk-dash-covid/blob/main/Data/data_time_series.RData?raw=true"
load(url(githubURL))




#########################################################################################
# PREPARE Death data


colorscale2 = c(
  list(c(0, "#292927")),#melns
  list(c(0.2, "#264563")), #peleks
  list(c(0.4, "#3a9fe8")),#zils
  list(c(0.6, "#9391c4")),#dzeltens
  list(c(0.8, "#c468ae")),#dzeltens
  list(c(1, "#ba4a75")))#sarkans
colorscale2

font_list <- list(size = 12,
                  family = "13px-apple-system, Courier New, monospace",
                  color = toRGB("grey40"))

tickfont_list <- list(size = 10,
                      family = "13px-apple-system, Courier New, monospace")

xform <- list(
  range = c("2020-03-10", "2020-12-06"),
  dtick = c("M1"),
  type = 'date',
  autotick = T,
  fixedrange = FALSE,
  tickformat = "%d %b",
  tickangle = 0,
  tickfont = tickfont_list,
  zeroline = T,
  showticklabels = T
)

head(tab)
fit_Death <- fitted(loess(tab$Death ~ seq(1:dim(tab)[1]), span=0.1))
fit_Admitted <- fitted(loess(tab$Adm ~ seq(1:dim(tab)[1]), span=0.1))
fit_Positive <- fitted(loess(tab$Positive ~ seq(1:dim(tab)[1]), span=0.1))



#########################################################################################
# Plot Positive

yform <- list(
  dtick = c(400),
  fixedrange = FALSE,
  tickfont = tickfont_list,
  zeroline = T,
  showticklabels = T
)

fig <- plot_ly()
fig <- fig %>% add_trace(
  type = "bar",
  x = tab$Data,
  y = tab$Positive,
  color = fit_Positive,
  hoverinfo = "text",
  hovertext = paste0("Nr. of New Positive = ", tab$Positive, "\n", tab$Data),
  marker = list(opacity = 0.5, colorscale = colorscale2)
)

fig <- fig %>% add_trace(
  mode = 'lines+markers',
  x = tab$Data,
  y = fit_Positive,
  color = fit_Positive,
  hoverinfo = "none",
  line = list(color = "#000000"),
  marker = list(colorscale = colorscale2)
)

fig_plot_1 <- fig %>% layout(
  xaxis = xform,
  yaxis = yform,
  showlegend = FALSE,
  margin = list(l = 35,r = 5,b = 0,t = 20,pad = 1),
  annotations =
    list(
      x = 0.96,
      y = 0.95,
      text = "Number of New Positive",
      showarrow = F,
      xref = 'paper',
      yref = 'paper',
      font = font_list
    )
)
fig_plot_1 %>% hide_colorbar() %>% config(scrollZoom = TRUE)

#########################################################################################
# Plot Death

yform <- list(
  dtick = c(4),
  fixedrange = FALSE,
  tickfont = tickfont_list,
  zeroline = T,
  showticklabels = T
)

fig <- plot_ly()
fig <- fig %>% add_trace(
  type = "bar",
  x = tab$Data,
  y = tab$Death,
  color = fit_Death,
  hoverinfo = "text",
  hovertext = paste0("Nr. of Deceased = ", tab$Death, "\n", tab$Data),
  marker = list(opacity = 0.5, colorscale = colorscale2)
)

fig <- fig %>% add_trace(
  mode = 'lines+markers',
  x = tab$Data,
  y = fit_Death,
  color = fit_Death,
  hoverinfo = "none",
  line = list(color = "#000000"),
  marker = list(colorscale = colorscale2)
)

fig_plot_3 <- fig %>% layout(
  xaxis = xform,
  yaxis = yform,
  showlegend = FALSE,
  margin = list(l = 35,r = 5,b = 0,t = 20,pad = 1),
  annotations =
    list(
      x = 0.96,
      y = 0.95,
      text = "Number of Newly Admitted",
      showarrow = F,
      xref = 'paper',
      yref = 'paper',
      font = font_list
    )
)
fig_plot_3 %>% hide_colorbar() %>% config(scrollZoom = TRUE)



#########################################################################################
# Plot Positive

yform <- list(
  dtick = c(40),
  fixedrange = FALSE,
  tickfont = tickfont_list,
  zeroline = T,
  showticklabels = T
)

fig <- plot_ly()
fig <- fig %>% add_trace(
  type = "bar",
  x = tab$Data,
  y = tab$Adm,
  color = fit_Admitted,
  hoverinfo = "text",
  hovertext = paste0("Nr. of Newly Admitted = ", tab$Adm, "\n", tab$Data),
  marker = list(opacity = 0.5, colorscale = colorscale2)
)

fig <- fig %>% add_trace(
  mode = 'lines+markers',
  x = tab$Data,
  y = fit_Admitted,
  color = fit_Admitted,
  hoverinfo = "none",
  line = list(color = "#000000"),
  marker = list(colorscale = colorscale2)
)

fig_plot_2 <- fig %>% layout(
  xaxis = xform,
  yaxis = yform,
  showlegend = FALSE,
  margin = list(l = 35,r = 5,b = 0,t = 20,pad = 1),
  annotations =
    list(
      x = 0.96,
      y = 0.95,
      text = "Number of Newly Admitted",
      showarrow = F,
      xref = 'paper',
      yref = 'paper',
      font = font_list
    )
)
fig_plot_2 %>% hide_colorbar() %>% config(scrollZoom = TRUE)










