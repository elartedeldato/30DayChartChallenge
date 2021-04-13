# Packages
library(data.table)
library(dplyr)
library(ggplot2)
library(ggtext)
library(ggfx)

# Data
df <- read_csv('https://raw.githubusercontent.com/elartedeldato/datasets/main/Top%2050%2B%20Magic%20and%20Magician%20related%20movies.csv')
df <- df %>% arrange(-`IMDb Rating`) %>% head(30)

# Colors
colors <- c("#7400b8","#6930c3","#5e60ce","#5390d9","#4ea8de","#48bfe3","#56cfe1","#64dfdf","#72efdd","#80ffdb")
colors <- colors[10:1]

# Plot
ggplot(df) +
  geom_text(aes(y=reorder(Title, `IMDb Rating`), x=`IMDb Rating`, 
                 color=`IMDb Rating`, label=label), nudge_x =0.5, family='Zapfino', size=3) + 
  geom_segment(aes(x=0, y=reorder(Title, `IMDb Rating`),
                   yend=reorder(Title, `IMDb Rating`), xend=`IMDb Rating`, color=`IMDb Rating`), size=0.25) +
  geom_point(aes(y=reorder(Title, `IMDb Rating`), x=`IMDb Rating`, alpha=`IMDb Rating`, 
                 color=`IMDb Rating`), size=0.75) +
  with_blur(geom_point(aes(y=reorder(Title, `IMDb Rating`), x=`IMDb Rating`, alpha=`IMDb Rating`, 
                   color=`IMDb Rating`), 
           size=6, alpha=0.3, stroke=0), sigma = unit(1, 'mm')) +
  scale_alpha(range = c(.33, 1), guide = F) +
  scale_color_gradientn(colours = colors) +
  labs(title='Top 30 IMDb Magic Movies',
       caption = "Paula L. Casado (@elartedeldato) | Data: IMDb | #30DayChartChallenge | Day 4: Magical") +
  theme(plot.background = element_rect(fill = "black", color='black'),
        panel.background = element_rect(fill = "black", color='black'),
        axis.title = element_blank(),
        axis.ticks = element_blank(),
        axis.text.x = element_blank(), 
        axis.text.y = element_text(color='white', family='Zapfino', size=7.5),
        panel.grid = element_blank(),
        legend.position = 'none',
        text=element_text(color='white', family='Zapfino'),
                plot.margin = unit(rep(1.5,4), 'cm'),
        plot.title = element_text(size=22, family='Zapfino',  margin=margin(0,0,30,0), hjust = 1.5),
        plot.subtitle = element_markdown(size=8, family='Zapfino', margin=margin(0,0,30,0)),
        plot.caption = element_markdown(size=6, family='mono', margin=margin(30,0,0,0))) -> p
p
#ggsave('plots/4-Magical.png', p, height = 10, width = 8.7)
