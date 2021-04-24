# Packages
library(tidyverse)
library(data.table)
library(ggstream)

# Data
df <- fread('data/users-by-social-media-platform.csv')
names(df)[4] <- 'n'
df$n <- as.numeric(df$n)
df <- df %>% filter(Entity != 'Friendster')
library(rcartocolor)


# Plot
p <- ggplot(df, aes(Year, n, fill = as.factor(Entity), label=Entity)) +
  geom_stream() +
  geom_stream_label(size = 2,  family='Anton-Regular', color='white',  n_grid = 1000) +
  theme_minimal() +
  theme(legend.position='none',
        axis.text = element_blank(),
        axis.title = element_blank(),
        panel.grid = element_blank(),
        panel.background = element_blank(),
        plot.background = element_rect(fill='#1f1f1f', color='#1f1f1f'),
        plot.title = element_text(family='Anton-Regular', color='white', size=40, hjust=0.1,  margin=margin(20,0,-50,10)),
        plot.subtitle = element_text(family='Anton-Regular',color='white', size=8, hjust=0.1, margin=margin(50,0,-30,10)),
        plot.caption =  element_text(family='Anton-Regular',color='white', size=8, hjust=0.5, margin=margin(30,0,10,0))) +
  labs(title='SOCIAL MEDIA GROWTH',
       subtitle='Estimates correspond to monthly active users (MAUs). Data from 2008 to 2019',
       caption = "Paula L. Casado (@elartedeldato) \n Data: Our world in data | #30DayChartChallenge | Day 20: Upwards")
p
ggsave('plots/20-Upwards.png', p, height = 6, width = 10)
