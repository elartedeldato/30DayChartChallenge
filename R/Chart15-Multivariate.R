# Packages
library(data.table)
library(tidyverse)
library(ggtext)
library(rcartocolor)
library(rvest)

# Data
olympic <- xml2::read_html("https://www.worldathletics.org/competitions/olympic-games/the-xxxi-olympic-games-7093747/results/men/decathlon/1500-metres/points")
olympic %>%
  html_nodes("table") %>%
  html_table() -> olympic_table

df <- olympic_table[[1]]
df <- df %>% 
  select(-5) %>% 
  pivot_longer(!c('POS','ATHLETE', 'COUNTRY', 'Points'), names_to='discipline', values_to='values')

df <- df %>% 
  rename(position=POS, athlete=ATHLETE, country=COUNTRY, final_points=Points) %>%
  mutate(points:=unlist(lapply(values, function(x) unlist(str_split(str_squish(x), ' '))[1])),
         mark:=unlist(lapply(values, function(x) unlist(str_split(str_squish(x), ' '))[2])),
         overall:=unlist(lapply(values, function(x) unlist(str_split(str_squish(x), ' '))[4]))) %>%
  select(-values)

df <- df %>%
  mutate(points:=as.numeric(points),
         overall:=as.numeric(overall),
         final_points:=as.numeric(str_extract(final_points,'[[:digit:]]*')))
discipline_levels <- df$discipline[1:10]
df$discipline <- factor(df$discipline, levels=discipline_levels)


# Plot

coord_radar <- function (theta = "x", start = 0, direction = 1) 
{
  theta <- match.arg(theta, c("x", "y"))
  r <- if (theta == "x") 
    "y"
  else "x"
  ggproto("CoordRadar", CoordPolar, theta = theta, r = r, start = start, 
          direction = sign(direction),
          is_linear = function(coord) TRUE)
}

ggplot(filter(df, position<21)) +
  geom_line(aes(x=as.numeric(discipline), y=points), color='white', size=0.25) +
  geom_point(aes(x=as.numeric(discipline), y=points, size=points), color='white') +
  facet_wrap(~ reorder(athlete, position)) +
  scale_size(range=c(0.15,2)) +
  scale_color_gradient(low='#6e0202', high='white') +
  scale_x_continuous(breaks=1:11, labels = c(discipline_levels, ''), limits = c(1,11)) +
  coord_radar() +
  theme_minimal() +
  theme(text=element_text(color='white', family='BebasNeue-Regular'),
        legend.position = 'none',
        strip.text = element_text(family='BebasNeue-Regular', color='white', size=7.5),
        panel.border= element_blank(),
        axis.text = element_text(family='BebasNeue-Regular', color='#a33131'),
        axis.title = element_blank(),
        panel.grid = element_line(color='#a33131', size=0.25),
        plot.margin = margin(20, 100, 20, 100),
        plot.background = element_rect(fill='#6e0202', color='#6e0202'),
        panel.background = element_rect(fill='transparent', color='transparent'),
        plot.title = element_markdown(size=25, color='white', face='bold', family='BebasNeue-Regular', 
                                      hjust = 0, margin=margin(10,0,20,0)),
        plot.subtitle = element_markdown(size=12, family='BebasNeue-Regular', color='#ffffff', margin=margin(0,0,30,0)),
        plot.caption =  element_text(size=7.5, hjust=0.5, color='#a33131', family='BebasNeue-Regular', margin=margin(30,0,10,0))) +
  labs(title="Decathlon Rio 2016 Olympic Games",
       subtitle='For the first time in Olympic history, 11 men scored 8300 or higher.<br>
       Disciplines are 100m, Long Jump, Shot Put, High Jump, <br>400m, 110m Hurdles,  Discus Throw, 
       Pole Vault, Javelin Throw, and 1500m.', 
       caption = "Paula L. Casado (@elartedeldato) | Data: worldathletics.org 
       #30DayChartChallenge | Day 15: Multivariate") -> p
p
ggsave('plots/15-Multivariate.png', p, height = 8, width = 8.5)


