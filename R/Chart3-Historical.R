# Packages
library(ggplot2)
library(tidyverse)
library(systemfonts)
library(ggimage)

# Data
emperors <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-08-13/emperors.csv")
font <- 'Cinzel-Regular'
red_color <- '#9c150e'

# Plot
ggplot(emperors %>% count(cause)) +
  geom_col(aes(n, reorder(cause, n)), fill=red_color, width=0.2, size=0) +
  geom_text(aes(0, reorder(cause, n), label=cause), 
            size=3.5, color=red_color, family=font, vjust=-1.6, nudge_x = 0, hjust=0) +
    geom_text(aes(0, reorder(cause, n), label=cause), 
            size=3.5, color=red_color, family=font, vjust=-1.6, nudge_x = 0, hjust=0) +
    geom_text(aes(0, reorder(cause, n), label=cause), 
            size=3.5, color=red_color, family=font, vjust=-1.6, nudge_x = 0, hjust=0) +
  geom_text(aes(n, reorder(cause, n),  label=n),  size=4,
            nudge_x = 0.5,  color=red_color, family=font) + 
  theme(plot.background=element_rect(fill='transparent', color='transparent'),
        axis.ticks = element_blank(),
        axis.text = element_blank(),
        axis.title = element_blank(),
        panel.background = element_blank(),
        panel.grid = element_blank(),
        legend.position = 'none',
        text=element_text(family=font),
        plot.title=element_text(hjust=0.5, size=20, margin=margin(30,0,30,30))) +
    labs(title='Number of Deaths of the Legitimate \nRoman Emperors by Cause',
      caption='Visualization by Paula L. Casado  (@elartedeldato) • Data: Wikipedia/#TidyTuesday 
         \n#30DayChartChallenge | Day 3: Historical',
         fill='', color='') -> p
p
ggbackground(p, 'https://cdn.wallpapersafari.com/98/25/nJe0m7.jpg')
# ggsave('plots/3-Historical.png',  ggbackground(p, 'bg.png'), height = 7, width = 8)