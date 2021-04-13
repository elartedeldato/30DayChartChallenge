# Packages
library(data.table)
library(dplyr)
library(ggplot2)
library(tidyverse)
library(ggforce)
library(ggtext)

# Data
df <- readr::read_csv('https://raw.githubusercontent.com/elartedeldato/datasets/main/vinos_2018_19.csv')

df %>%
  filter(DOP=='TOTAL') %>%
  select(-DOP) %>%
  pivot_longer(cols= everything(), names_to = 'tipo', values_to = 'hl') %>%
  filter(tipo != 'TOTAL') %>%
  mutate(tipo_agrup := c('Blanco', 'Rosado','Tinto', rep('De licor',2), rep('Espumoso',2), rep('Otros',3))) %>%
  group_by(tipo_agrup) %>%
  summarise(hl:=sum(hl)) %>%
  mutate('pct_hl':=round(hl/sum(hl)*100,2)) %>%
  arrange(desc(pct_hl)) -> df_vinos

  bottle <- tribble(
    ~id, ~x, ~y,
    1, 0, 0, 
    2, 1, 0, 
    3, 1, 5.5,
    4, 0.6, 5.5,
    5, 0.6, 7.5,
    6, 0.40, 7.5,
    7, 0.40, 5.5,
    8, 0, 5.5,
    9, 0, 0
  )

  bottles <- purrr::map_dfr(seq_len(100), ~bottle)
  bottles$bid <- rep(1:100, each=9)
  bottles$tipo <- rep(rep(df_vinos$tipo_agrup, round(df_vinos$pct_hl,0)),each=9)

  ggplot(bottles) + 
    geom_shape(aes(x, y, color=tipo), fill='black', size=0.25, radius = unit(0.25, 'mm')) +
    facet_wrap('bid', ncol = 20) + 
    scale_color_manual(values=c('#eff0b6', '#bfb051', '#c5d7bd', '#f1d1d0', '#763857')) + 
    scale_fill_manual(values=c('#eff0b6', '#bfb051', '#c5d7bd', '#f1d1d0', '#763857')) + 
    theme_void() + 
    theme(
      strip.background = element_blank(),
      strip.text.x = element_blank(),
      plot.background = element_rect(fill = "black", color='black'),
      panel.background = element_rect(fill = "black", color='black'),
      plot.margin = margin(2, 4, 2, 4, "cm"),
      text = element_text(color='white'),
      legend.position = 'none',
      plot.title = element_text(size=14, family='Anton',  margin=margin(0,0,15,0)),
      plot.subtitle = element_markdown(size=8, family='mono', margin=margin(0,0,30,0)),
      plot.caption = element_markdown(size=6, family='mono', margin=margin(30,0,0,0)),
    ) +
    labs(title='Sales Distribution of Spanish PDO Wines by category',
         subtitle='<b style="color: #763857;">Red</b>, <b style="color: #eff0b6;">White</b>, 
         <b style="color: #c5d7bd;">Sparkling</b>, 
         <b style="color: #f1d1d0;">Rose</b> and <b style="color: #bfb051;">Dessert</b> Wine. 
         Rest is < 0.02%',
         caption='Visualization by Paula L. Casado  (@elartedeldato) • Data: mapa.gob.es 
         \n#30DayChartChallenge | Day 2: Pictogram',
         fill='', color='') -> p
p
# ggsave('plots/2-Pictogram.png',p, height = 7, width = 8)