# Packages
library(ggplot2)

# Data
df <- data.frame(
  x = rep(c(2, 5, 7, 9, 12), 2),
  y = rep(c(1, 2), each = 5),
  z = factor(rep(1:5, each = 2)),
  w = rep(diff(c(0, 4, 6, 8, 10, 14)), 2)
)

# Plot
ggplot(df, aes(xmin = x - w / 2, xmax = x + w / 2, ymin = y, ymax = y + 1)) +
  geom_rect(aes(fill = z), colour = "black", size=4) +
  scale_fill_manual(values=c('red','blue','yellow','white', 'red')) +
  theme_void() +
  theme(legend.position = "none",
        plot.margin = margin(20,70,20,70),
        plot.title = element_text(size=20, face = "bold", hjust = 0.5, margin=margin(10,0,10,0)),
        plot.caption =  element_text(margin=margin(30,0,10,0)),
        plot.subtitle = element_text(hjust = 0.5, margin=margin(0,0,30,0))) +
  labs(title='MondRian',
       caption = "Paula L. Casado (@elartedeldato) | Data: ggplot2.tidyverse.org | #30DayChartChallenge | Day 10: Abstract") -> p
p
#ggsave('10-Abstract.png', p, height = 9, width = 11)
