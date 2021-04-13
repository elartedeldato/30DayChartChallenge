# Packages
library(ggplot2)

# Data
n <- 100000
x1<-runif(n, min=-1, max=1)
x2<-runif(n, min=-1, max=1)
z<-sqrt(x1^2+x2^2)
pi <- 4*sum((z<=1))/length(z)

df <- data.frame(x1, x2, z)
df$in_out <- ifelse(z<=1, 'in', 'out')

# Plot
ggplot(df) +
  geom_point(aes(x=x1, y=x2, color = in_out), alpha=0.9, stroke=0, size=0.25) +
  scale_color_manual(values=c('#f72585', "#4cc9f0")) +
  theme_bw() +
  theme(legend.position = "none",
        text=element_text(color='white',family='Roboto-Light'),
        panel.border= element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        panel.grid = element_blank(),
        axis.ticks = element_blank(),
        plot.margin = margin(20,50,20,50),
        panel.background = element_rect(fill='transparent'),
        plot.background = element_rect(fill='#212529', color='black'),
        plot.title = element_text(size=20, face = "bold", hjust = 0.5, margin=margin(10,0,10,0)),
        plot.caption =  element_text(margin=margin(30,0,10,0)),
        plot.subtitle = element_text(hjust = 0.5, margin=margin(0,0,30,0))) +
  labs(title=expression("Estimating"~pi~"with Monte Carlo"),
       subtitle = expression(pi==4*~"Area of the Circle"/"Area of the Square"%~~%3.14668),
       caption = "Paula L. Casado (@elartedeldato) | Data: simulated | #30DayChartChallenge | Day 6: Experimental") -> p 
p
#ggsave('plots/6-Experimental.png', p, height = 7, width = 6)