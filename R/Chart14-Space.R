# Packages
library(data.table)
library(tidyverse)
library(ggtext)
library(waffle)

# Data
df <- fread('data/spacex_data.csv', select = 1:3)

ggplot(df[-7,], aes(values=N, fill=rocket, color=rocket)) +
  geom_waffle(n_rows = 1, flip = TRUE, size=0.25, 
              radius = unit(0.08, 'cm'))  +
  facet_wrap(~ Year, nrow = 1, strip.position = 'bottom') +
  scale_y_continuous(breaks=1:26) +
  scale_color_manual(values=c("black","black", "black",'black',"green", 'black')) +
  scale_fill_manual(values=c("red","green", "green",'green',"black", 'green')) +
  theme_minimal() +
  theme(text=element_text(color='green','mono'),
        legend.position = 'none',
        strip.text = element_text(family='Audiowide-Regular', color='green'),
        panel.border= element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.text.y = element_text(color='green', size=10),
        panel.grid.major = element_line(color='green', size=0.07),
        panel.grid.minor = element_line(color='green', size=0.05),
        plot.margin = margin(20,20,20,20),
        plot.background = element_rect(fill='black', color='black'),
        panel.background = element_rect(fill='transparent', color='transparent'),
        plot.title = element_markdown(size=30, color='white', face='bold', family='Audiowide-Regular', 
                                      hjust = 0, margin=margin(10,0,10,0)),
        plot.subtitle = element_markdown(size=12, family='Audiowide-Regular', color='red'),
        plot.caption =  element_text(hjust=1, family='Audiowide-Regular', margin=margin(30,0,10,0))) +
  labs(title="SPACEX rocket launches",
       subtitle='Failures: 5.0000 <br><span style="color: green;">Successes: 117.0000 </span><br>
       <span style="color: green;">Planned: 15.0000 <br> <span style="color: green;">No launches in 2011</span>',
       caption = "Paula L. Casado (@elartedeldato) | Data: SpaceX 
       #30DayChartChallenge | Day 14: Space")  -> p

p
ggsave('plots/14-Space.png', p, height = 8, width = 10)
