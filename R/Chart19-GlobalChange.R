# Packages
library(tidyverse)
library(data.table)

# Data
df <- fread('https://www.esrl.noaa.gov/gmd/webdata/ccgg/trends/co2/co2_mm_mlo.txt', skip=52)
df$fecha <- paste(df$`#`, df$date, '01', sep='-') %>% as.Date()

# Plot
ggplot(df) +
  geom_line(aes(x=fecha, y=alized, color=alized)) +
  scale_color_gradient(low='white', high='red') +
  theme_minimal() +
  theme(legend.position='none',
        axis.text = element_text(color='white', family='mono'),
        axis.title = element_text(color='white', family='mono'),
        axis.title.x = element_blank(),
        panel.grid = element_line(size=0.15),
        panel.background = element_blank(),
        plot.background = element_rect(fill='#1a1a1a', color='#1a1a1a'),
        plot.title = element_text(family='mono', color='#ffffff', size=20, face = "bold",  hjust = 0.5, margin=margin(10,0,0,0)),
        plot.subtitle = element_text(family='mono', color='#ffffff', size=10, face = "bold", hjust = 0.5, margin=margin(10,0,30,0)),
        plot.caption =  element_text(family='mono', color='#ffffff', size=8, hjust=0.5, margin=margin(30,0,10,0))) +
  labs(title='Global Change',
       y='parts per million',
       subtitle='Evolution of Atmospheric Carbon Dioxide 1958-2021',
       caption = "Paula L. Casado (@elartedeldato) \n Data: NOAA | #30DayChartChallenge | Day 19: Global Change") -> p
p
ggsave('plots/19-GlobalChange.png', p, height = 10, width = 10)
