# Packages
library(tidyverse)
library(gapminder)
library(dplyr)
library(data.table)
library(ggplot2)
library(systemfonts)
library(ggforce)

# Data
df <- readr::read_csv('https://raw.githubusercontent.com/elartedeldato/datasets/main/vinos_2018_19.csv')

# Colors
library(rcartocolor)
carto_col <- colorRampPalette(carto_pal(7, "ArmyRose"))(12)
other_col <- colorRampPalette(c('#BC8880','#B3C0AE', '#C8626D', '#EDD0C0'))(12)

# Plot
df %>% 
  select(-TOTAL) %>% 
  filter(DOP!='TOTAL') %>%  
  mutate(across(everything(), ~replace_na(.x, 0))) %>%
  pivot_longer(!DOP, names_to = 'tipo', values_to = 'hl') %>%
  arrange(-hl) %>%
  mutate(tipo:=ifelse(tipo %in% c('Tinto', 'Blanco', 'Rosado', 'Espumado'), tipo, 'Other')) %>%
  mutate(tipo:=ifelse(tipo=='Tinto', 'Red', ifelse(tipo=='Blanco', 'White', ifelse(tipo=='Rosado', 'Rosé', ifelse(tipo=='Espumado', 'Sparkling', 'Other'))))) %>%
  group_by(DOP, tipo) %>%
  summarise(hl:=sum(hl)) %>%
  arrange(-hl) %>%
  ungroup() %>%
  mutate(rank:=1:n()) %>%
  mutate(DOP:=ifelse(rank>10, 'Other', DOP), tipo:=ifelse(rank>10, 'Other', tipo)) %>%
  group_by(DOP, tipo) %>%
  summarise(hl:=sum(hl)) %>%
  ggplot() +
  geom_col(aes(x=1, y=hl, fill=reorder(interaction(DOP, tipo, sep='-'),-hl)), color='black', size=0.3) +
  theme_void() +
  scale_fill_manual(values=other_col[12:1]) +
  #scale_fill_carto_d(palette = 'Pastel') +
  coord_polar(theta='y', direction = -1) +
  xlim(c(-1, 1.5)) +
  labs(fill='', title='Sales Volume of main Spanish PDO Wines', 
       subtitle='Campaign 2018/19. Legend indicates PDO - Wine Category. Total Volume: 11M hl.', 
       caption = "Visualization by Paula L. Casado (@elartedeldato) •  Data: mapa.gob.es \n#30DayChartChallenge | Day 1: Part-to-whole") +
  theme(text = element_text(family='mono', color='white'),
        plot.background = element_rect(fill='black', color='black'),
        plot.margin = unit(c(1,1,1,1), 'cm'),
        plot.caption = element_text(hjust=0.5)) -> p
p
#ggsave('plots/1-Part-to-whole.png', p, height = 8, width = 9)
