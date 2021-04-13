# Packages
library(ggplot2)
library(ggtext)

# Data
df <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-07-28/penguins.csv')

# Plot
ggplot(df) +
  geom_point(aes(x=body_mass_g, y=flipper_length_mm, color=species), alpha=0.5, stroke=0, size=2) +
  geom_density_2d(aes(x=body_mass_g, y=flipper_length_mm, color=species), size=0.15) +
  scale_color_manual(values=c("#5D69B1","#52BCA3","#99C945")) +
  theme_bw() +
  theme(legend.position = "none",
        text=element_text(color='black',family='Roboto-Light'),
        panel.border= element_blank(),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_line(size=0.15),
        axis.title = element_text(hjust=1, size=8, family='Roboto-Light'),
        plot.margin = margin(20,50,20,50),
        panel.background = element_rect(fill='transparent'),
        plot.title = element_text(size=20, face = "bold", hjust = 0.5, margin=margin(10,0,10,0)),
        plot.subtitle = element_markdown(size=10, hjust = 0.5, margin=margin(0,0,30,0)),
        plot.caption =  element_text(hjust=0.5, margin=margin(30,0,10,0))) +
  labs(title="Body Mass and Flipper Length of Palmer Penguins",
       subtitle='Data is based on 344 penguins from the Palmer Archipelago, Antarctica.<br> Species are <b style="color: #5D69B1;">Adelie</b>, <b style="color: #52BCA3;">Chinstrap</b>, and <b style="color: #99C945;">Gentoo</b> Penguins.',
       caption = "Paula L. Casado (@elartedeldato) | Data: #Tidytuesday | #30DayChartChallenge | Day 8: Animals", x='Body Mass (g)', y='Flipper Length (mm)') -> p
p
#ggsave('plots/8-Animals.png', p, height = 8, width = 8)
