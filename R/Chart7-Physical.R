# Packages
library(data.table)
library(tidyverse)
library(pdftools) 
library(rcartocolor)

# Data
PDF <- pdf_text('http://www.ign.es/web/resources/docs/IGNCnig/SIS-Tablas_estadisticas_PIberica.pdf') %>%
readr::read_lines()

PDF[3:11] %>%
  str_squish() %>%
  strsplit(split = " ") -> pdf_split
pdf_split[[2]] <- c(paste(pdf_split[[2]][1:2], collapse = ''), pdf_split[[2]][3:12])
for(i in 3:9){
  pdf_split[[i]] <- c(paste(pdf_split[[i]][1:3], collapse = ''), pdf_split[[i]][4:13])
}

pdf_split %>%  
  plyr::ldply() -> df
names(df) <- df[1,]
df <- df[-1,]

df_longer <- df %>% 
  pivot_longer(cols=starts_with('20'), names_to='year', values_to='n') %>%
  mutate(magnitude:=factor(Magnitud, levels=df$Magnitud[8:1])) %>%
  mutate(n:=as.numeric(str_replace(n,'\\.',''))) %>%
  select(-Magnitud)
df_longer <- df_longer %>% group_by(year) %>% mutate(total_n:=sum(n))

# Fonts
plotfont <- 'BebasNeue-Regular'

# Plot
ggplot(df_longer) +
  geom_area(aes(x=magnitude, y=n, fill=total_n, group=year)) +
  coord_polar(theta='x') +
  scale_fill_carto_c(palette='OrYel') +
  facet_wrap(~ year) +
  theme_bw() +
  theme(legend.position = "none",
        text=element_text(color='white',family=plotfont),
        panel.border= element_blank(),
        strip.background = element_rect(color="transparent", fill="transparent"),
        strip.text = element_text(color='#b2b5b8', family=plotfont, size=12),
        axis.title = element_blank(),
        axis.text = element_text(color='#6f7275', family=plotfont, size=6),
        panel.grid = element_line(size=0.15, color='#6f7275'),
        axis.ticks = element_blank(),
        plot.margin = margin(20,50,20,50),
        panel.background = element_rect(fill='transparent'),
        plot.background = element_rect(fill='#212529', color='#212529'),
        plot.title = element_text(size=20, hjust = 0.5, margin=margin(10,0,30,0)),
        plot.caption =  element_text(hjust=0.5, margin=margin(30,0,10,0))) +
  labs(title="Earthquakes in Spain",
       caption = "Paula L. Casado (@elartedeldato) | Data: National Geographic Institute of Spain \n #30DayChartChallenge | Day 7: Physical") -> p
p
#ggsave('plots/7-Physical.png', p, height = 8, width = 6)
