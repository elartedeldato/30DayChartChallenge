# Packages
library(data.table)
library(tidyverse)
library(ggtext)

# Data
set.seed(123)
z <- runif(60,0,1)
y <- matrix(ncol=2, nrow=60)

for (i in 1:60) 
  {
  if (z[i]<0.5) {y[i,] <- c(rnorm(1,0,0.7),1)}
  else {y[i,] <- c(rnorm(1,1,0.2),2)}
}

sim<-y[,1]
sim <- iris %>% filter(Species=='setosa') %>% pull(Petal.Length)
den.normal<-density(sim, kernel="gaussian")
den.rec<-density(sim, kernel="rectangular")
den.tri<-density(sim, kernel="triangular")
den.epa<-density(sim, kernel="epanechnikov")
den.bi<-density(sim, kernel="biweight")
den.cos<-density(sim, kernel="cosine")
den.opt <-density(sim, kernel="optcosine")

data.frame(x=den.normal$x, y=den.normal$y, kernel='gaussian') %>%
  rbind(data.frame(x=den.rec$x, y=den.rec$y, kernel='rectangular')) %>%
    rbind(data.frame(x=den.tri$x, y=den.tri$y, kernel='triangular')) %>%
    rbind(data.frame(x=den.epa$x, y=den.epa$y, kernel='epanechnikov')) %>%
    rbind(data.frame(x=den.bi$x, y=den.bi$y, kernel='biweight')) %>%
    rbind(data.frame(x=den.cos$x, y=den.cos$y, kernel='cosine')) %>%
    rbind(data.frame(x=den.opt$x, y=den.opt$y, kernel='optcosine')) -> df


# Plot
ggplot(df) +
  geom_area(aes(x,y,group=kernel, fill=kernel)) +
  facet_wrap(~ kernel, strip.position = 'bottom') +
  theme_bw() +
  theme(legend.position = "none",
        text=element_text(family='mono'),
        panel.border= element_blank(),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_line(size=0.15),
        axis.title = element_blank(),
        plot.margin = margin(20,50,20,50),
        strip.background = element_rect(color='transparent', fill='black'),
        strip.text = element_text(color='white', size=10),
        panel.spacing = unit(2, "line"),
        panel.background = element_rect(fill='transparent'),
        plot.title = element_text(size=20, face = "bold", hjust = 0.5, margin=margin(10,0,10,0)),
        plot.subtitle = element_markdown(size=10, hjust = 0.5, margin=margin(0,0,30,0)),
        plot.caption =  element_text(hjust=0.5, margin=margin(30,0,10,0))) +
  labs(title="Exploring Kernels for Density Estimation.",
       subtitle='Petal Length Density Estimation of Iris Setosa Specie',
       caption = "Paula L. Casado (@elartedeldato) | Data: R Datasets | #30DayChartChallenge | Day 9: Statistics") -> p
p
#ggsave('plots/9-Statistics.png', p, height = 9, width = 8)
