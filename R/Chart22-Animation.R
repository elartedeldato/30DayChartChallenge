library(gapminder)
library(ggplot2)
library(data.table)
library(gganimate)



df <- fread('data/world_cup.csv')

ggplot(df) +
  geom_point(aes(1, 1, size = `Total\nattendance`, color = Hosts), show.legend = FALSE) +
  geom_text(aes(1,1.04, color = Hosts, label=Hosts), size=20, family='Anton-Regular', show.legend = FALSE) +
  scale_size(range = c(2, 76)) +
  scale_y_continuous(limits = c(0.95,1.045)) +
  transition_time(Year) +
  ease_aes('linear') +
  theme_void() +
  theme(plot.background = element_rect(fill='#1f1f1f'),
        
    plot.title = element_text(family='Anton-Regular', color='white', hjust=0.5, size=40,  margin=margin(10,0,10,0)),
        plot.subtitle = element_text(vjust = -30,family='Anton-Regular', color='#525252', hjust=0.5, size=65, margin=margin(0,0,0,0)),
        plot.caption =  element_text(family='Anton-Regular',color='white', hjust=0.5, size=8, margin=margin(30,0,10,0))) +
  labs(title='FIFA World Cup Attendance',
       subtitle = '{frame_time}',
       caption = "Paula L. Casado (@elartedeldato) \n Data: FIFA | #30DayChartChallenge | Day 22: Animation")
anim_save('plots/22-Animations.gif')
