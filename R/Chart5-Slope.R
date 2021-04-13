# Packages
library(data.table)
library(dplyr)
library(ggplot2)
library(ggtext)
library(glue)

# Data
partido <- c('PSOE', 'PP', 'Cs', 'Más Madrid', 'Vox', 'Podemos')
fecha <- c(rep(2019,6), rep(2015,6))
escanos <- c(37, 30, 26, 20, 12, 7, 37, 48, 17, 0, 0, 27)
colores <- c('#f31912', '#17589D','#fa5000', '#45BB89', '#7cbd2a', '#683278')
df <- data.frame(fecha, partido, escanos, colores)

# Plot
ggplot(df, aes(x = fecha, y = escanos, group = partido)) +
  geom_line(aes(color = partido), size = 1) +
  geom_point(aes(color = partido), size = 4) +
  geom_richtext(data = df %>% filter(fecha == 2015), 
            aes(label = glue::glue("<b style='color:{colores};'>{partido}</b><br><span style='color: black;'>{escanos}<span>")) , 
            nudge_x  = -0.15, nudge_y=c(0,0,0,0,5,0), hjust=1,size = 4, color='transparent', family='Roboto') +
  geom_richtext(data = df %>% filter(fecha == 2019), 
            aes(label = glue::glue("<b style='color:{colores};'>{partido}</b><br><span style='color: black;'>{escanos}<span>")) , 
            nudge_x = 0.15, hjust=0,size = 4, color='transparent', family='Roboto') +
  scale_color_manual(values=colores[order(partido)]) +
  scale_x_continuous(limits=c(2014, 2020), breaks=c(2015, 2019), position = 'top') +
  theme_bw() +
  theme(legend.position = "none",
        text=element_text(family='Roboto-Light'),
        panel.border= element_blank(),
        axis.title = element_blank(),
        axis.text.y = element_blank(),
        panel.grid.major.x = element_line(size=0.15),
        axis.text.x = element_text(size=14, face='bold', family='Roboto'),
        panel.grid = element_blank(),
        axis.ticks = element_blank(),
        plot.margin = margin(20,70,20,70),
        plot.title = element_text(size=20, face = "bold", hjust = 0.5, margin=margin(10,0,10,0)),
        plot.caption =  element_text(margin=margin(30,0,10,0)),
        plot.subtitle = element_text(hjust = 0.5, margin=margin(0,0,30,0))) +
  labs(title='Assembly of Madrid Electoral Results',
       subtitle = 'Seats of the 2015 and 2019 elections',
       caption = "Paula L. Casado (@elartedeldato) | Data: asambleamadrid.es | #30DayChartChallenge | Day 5: Slope") -> p
p
#ggsave('plots/5-Slope.png', p, height = 9, width = 11)
