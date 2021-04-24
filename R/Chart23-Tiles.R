# Packages
library(ggplot2)
library(data.table)
library(rcartocolor)

# Data
df <- fread('data/horas_de_luz_por_provinci.csv')
df$Periodo <- factor(df$Periodo , labels=unique(df$Periodo), levels=unique(df$Periodo))
ggplot(df, aes(x=Parámetro, y=Periodo, fill=`Salida y puesta del sol`)) + 
  geom_tile(color='white') + 
  coord_equal() +
  scale_fill_carto_c(palette='PinkYl') +
  theme_minimal() +
  theme(legend.position='bottom',
        legend.direction="horizontal",
        legend.justification = c("left"),
        legend.text=element_text(family='mono'),
        legend.title = element_text(family='mono', size=8), 
        axis.title = element_blank(),
        axis.text = element_text(family='mono', size=8),
        axis.text.x = element_text(family='mono', angle=45, hjust=1),
        axis.ticks = element_blank(),
        panel.grid = element_blank(),
        plot.margin = margin(0,25,0,25),
        plot.title = element_text(family='mono', size=15,  margin=margin(10,0,10,0)),
        plot.caption =  element_text(family='mono', size=8, hjust=1, margin=margin(-25,0,0,0))) +
  labs(title='Horas de luz en España',
       fill='horas',
       caption = "Paula L. Casado (@elartedeldato) | Data: epdata\n#30DayChartChallenge | Day 23: Tiles")
ggsave('plots/23-Tiles.png', height = 8, width = 10)
