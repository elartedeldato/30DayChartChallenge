# Packages
library(data.table)
library(tidyverse)
library(ggtext)
library(rcartocolor)
library(scales)

# Data
country_codes <- fread('data/covid-vaccination-doses-per-capita.csv') %>% select(Entity, Code) %>% distinct()
df <- fread('data/world-happiness-report-2021.csv.xls')
df_beer <- fread('data/HFA_429_EN.csv', skip=25)
df_beer_2018 <- df_beer %>% filter(YEAR==2018)

df %>% 
  select('Country name','Regional indicator','Ladder score') %>% 
  merge(country_codes, by.x='Country name', by.y='Entity',all.x = T) -> df

df_beer_2018 %>% merge(df, by.x='COUNTRY', by.y='Code') -> df_all




ggplot(df_all) +
  geom_point(aes(x=VALUE, y=`Ladder score`, size=VALUE, color=factor(VALUE)), alpha=0.5) +
  geom_text(data=filter(df_all, `Country name` %in% c('Azerbaijan')), 
            aes(x=VALUE, y=`Ladder score`, label=paste(`Country name`, 'consumes', VALUE, 'beer \nlitres of pure alcohol per \ncapita')),
            family='Anton-Regular' , nudge_x = 1.1, nudge_y = -1, size=3, hjust=0) +
  geom_curve(data=filter(df_all, `Country name` %in% c('Azerbaijan')), 
             curvature=-0.5,color='#C96E12',
             aes(x=VALUE+1, y=`Ladder score`-1, xend=VALUE, yend=`Ladder score`),
    arrow = arrow(length = unit(0.03, "npc"))
  ) +
  geom_text(data=filter(df_all, `Country name` %in% c('Austria')), 
            aes(x=VALUE, y=`Ladder score`, label=paste(`Country name`, 'consumes', VALUE, 'beer \nlitres of pure alcohol per \ncapita')),
            family='Anton-Regular', nudge_x = -1.1, nudge_y = 1, size=3, hjust=1) +
  geom_curve(data=filter(df_all, `Country name` %in% c('Austria')), 
             curvature=-0.5,color='#FFF897',
             aes(x=VALUE-1, y=`Ladder score`+1, xend=VALUE, yend=`Ladder score`+0.3, label=`Country name`),
             arrow = arrow(length = unit(0.03, "npc"))
  ) +
  geom_smooth(aes(x=VALUE, y=`Ladder score`), 
              formula='y ~ x', method = 'lm', se=F, color='grey') +
  scale_color_manual(values=colorRampPalette(c('#C96E12','#DF8D03', '#EC9D00', '#F6C101', '#FAE96F', '#FFF897'))(50)) +
  scale_size(range=c(1,15)) +
  theme_minimal() +
  theme(text=element_text(color='black',family='BebasNeue-Regular'),
        legend.position = 'none',
        strip.text.x = element_blank(),
        panel.border= element_blank(),
        axis.title = element_text(hjust=1),
        plot.margin = margin(20,20,20,20),
        panel.background = element_rect(fill='transparent', color='transparent'),
        plot.title = element_markdown(size=50, color='#212529', face='bold', family='BebasNeue-Regular', 
                                      hjust = 0, margin=margin(10,0,10,0)),
        plot.subtitle = element_markdown(size=9),
        plot.caption =  element_text(hjust=0.5, margin=margin(30,0,10,0))) +
  labs(title="Does beer <br>bring happiness?",
       color='',
       x='Beer consumed in pure alcohol, litres per capita, age 15+',
       y='Ladder Score: the happiness score or subjective well-being',
       subtitle='',
       caption = "Paula L. Casado (@elartedeldato) | Data: WHO/World Happiness Report 2021
  #30DayChartChallenge | Day 13: Correlation") -> p

p
ggsave('plots/13-Correlation.png', p, height = 9, width = 8)
