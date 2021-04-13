# Packages
library(data.table)
library(tidyverse)
library(ggtext)

# Data
df <- fread('data/both.csv')
names(df) <- c('week','AstraZeneca', 'Pfizer')
df_longer <- df %>% pivot_longer(cols = c('AstraZeneca', 'Pfizer'), names_to='vaccine', values_to='n')
#df <- as.data.frame(lapply(df, rep, df$n))

df_longer$n <- ifelse(df_longer$n == '<1', 0.5, df_longer$n) %>% as.numeric()

grid_x <- tibble(x = df$week[seq(1,52,4)], 
                 y = rep(0, 13), 
                 xend = df$week[seq(1,52,4)], 
                 yend = rep(Inf, 13))

# Plot
ggplot(df_longer) +
  geom_area(aes(x=week, y=n, color=vaccine, fill=vaccine), position='identity', alpha=0.4, size=0.2) +
  geom_point(aes(x=week, y=n, color=vaccine), alpha=0.7, size=0.5) +
  geom_hline(yintercept = seq(0,100,20), colour = "grey", size=0.15) +
  geom_segment(data = grid_x , 
               aes(x = x, y = y, xend = xend, yend = yend), 
               col = "grey", size=0.15) +
  scale_y_continuous(limits = c(-.2, 100), expand = c(0, 0)) +
  scale_x_date(breaks = df$week[seq(1,52,4)], date_labels = '%d %b %Y') +
  scale_fill_manual(values=c('#52BCA3', '#CC3A8E')) +
  scale_color_manual(values=c('#52BCA3', '#CC3A8E')) +
  coord_polar() +
  theme_minimal() +
  theme(text=element_text(color='black',family='BebasNeue-Regular'),
        legend.position = 'none',
        panel.border= element_blank(),
        panel.grid = element_blank(),
        axis.title.y = element_blank(),
        axis.text.y = element_blank(),
        plot.margin = margin(20,20,20,20),
        panel.background = element_rect(fill='transparent', color='transparent'),
        plot.title = element_markdown(size=20, face='bold', family='BebasNeue-Regular', hjust = 0.5, margin=margin(10,0,40,0)),
        plot.caption =  element_text(hjust=0.5, margin=margin(30,0,10,0))) +
  labs(title="Google Searches of <span style='color: #52BCA3;'>'AstraZeneca'</span> & 
       <span style='color: #CC3A8E;'>'Pfizer'</span> in Spain",
       caption = "Paula L. Casado (@elartedeldato) | Data: Google Trends | #30DayChartChallenge | Day 11: Circular") -> p

p
ggsave('plots/11-Circular.png', p, height = 8, width = 7)
