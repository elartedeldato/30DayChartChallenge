# Packages
library(data.table)
library(tidyverse)
library(ggtext)
library(rcartocolor)
library(scales)

# Data
df <- fread('data/covid-vaccination-doses-per-capita.csv')
df <- df %>% 
  filter(Entity %in% c('Africa', 'Asia', 'Europe', 'Oceania', 'North America', 'South America')) %>%
  group_by(Entity) %>% 
  mutate(max_n:=max(total_vaccinations_per_hundred))

ggplot(df) +
  geom_segment(aes(x = Day, xend = Day, y=0, yend = 1, color=total_vaccinations_per_hundred/100), size=0.75) +
  facet_wrap(~ reorder(Entity, desc(max_n))) +
  geom_text(data = df %>% filter(Day==min(Day)), 
            aes(label = Entity, x = as.Date("2020-12-13"), y = 0, color=max_n/100), 
            size = 14, family = "BebasNeue-Regular", 
            hjust = 0, vjust = 0) +
  scale_y_continuous(limits=c(0,1.3)) +
  scale_color_carto_c(palette='Magenta', labels = percent, direction = 1) +
  theme_minimal() +
  theme(text=element_text(color='black',family='BebasNeue-Regular'),
        legend.position = 'bottom',
        strip.text.x = element_blank(),
        panel.border= element_blank(),
        panel.grid = element_blank(),
        axis.title = element_blank(),
        axis.text.y = element_blank(),
        plot.margin = margin(20,20,20,20),
        panel.background = element_rect(fill='transparent', color='transparent'),
        plot.title = element_markdown(size=60, color='#212529', face='bold', family='BebasNeue-Regular', 
                                      hjust = 0, margin=margin(10,0,10,0)),
        plot.caption =  element_text(hjust=0.5, margin=margin(30,0,10,0))) +
  labs(title="The World<br>Vaccination Race",
       color='',
       caption = "Paula L. Casado (@elartedeldato) | Data: @ourworldindata | #30DayChartChallenge | Day 12: Strips") -> p

p
ggsave('plots/12-Strips.png', p, height = 8, width = 12)
