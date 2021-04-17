# Packages
library(ggplot2)
library(dplyr)
library(tidyr)
library(ggimage)
library(ggnewscale)

# Data
anscombe_tidy <- anscombe %>%
  mutate(observation = seq_len(n())) %>%
  gather(key, value, -observation) %>%
  separate(key, c("variable", "set"), 1, convert = TRUE) %>%
  mutate(set = c("I", "II", "III", "IV")[set]) %>%
  spread(variable, value)

head(anscombe_tidy)

light_colors <- c('#08cfc9','#f36391', '#f03495', '#fcc704')
dark_colors <- c('#148c83', '#c424a5', '#a91a69', '#ff910a')


d <- data.frame(x = rnorm(10),
                y = rnorm(10),
                image = sample(c("https://www.r-project.org/logo/Rlogo.png",
                                 "https://jeroenooms.github.io/images/frink.png"),
                               size=10, replace = TRUE)
)
df_img <- data.frame(set=c("I", "II", "III", "IV"), img=c('img/bub.png'))

points <- data.frame(x =  1:20, y = 1:20)
points_exp <- expand(points, x, y)
points_exp$x <- ifelse(points_exp$y %% 2 == 0, points_exp$x + 0.5 , points_exp$x)
df1 <- data.frame(points_exp, set='I')
df2 <- data.frame(points_exp, set='II')
df3 <- data.frame(points_exp, set='III')
df4 <- data.frame(points_exp, set='IV')
total_df <- rbind(df1, df2, df3, df4)
total_df$x <- total_df$x*2 
total_df$y <- total_df$y*2 

# Plot
ggplot() +
  geom_rect(data = data.frame(light_colors, set=c("I", "II", "III", "IV")), 
            aes(fill = set),xmin = -Inf,xmax = Inf,ymin = -Inf,ymax = Inf) +
  facet_wrap(~ set) +
  scale_fill_manual(values=light_colors) +
  new_scale_fill() +
  geom_point(data=total_df, aes(x, y, color=set), size=4) +
  scale_color_manual(values=dark_colors) +
  new_scale_color() +
  geom_image(data=df_img, aes(x=10, y=10, image=img, fill=set), size=1.1) +
  geom_smooth(method = "lm", se = FALSE, data=anscombe_tidy, aes(x, y, color=set), size=2.5, fullrange=TRUE) +
  scale_color_manual(values=light_colors[c(2,4,1,3)]) +
  geom_point(data=anscombe_tidy, aes(x, y, fill=set), color='black', size=5, stroke=2, shape=21) +
  scale_fill_manual(values=dark_colors[c(2,4,1,3)]) +
  scale_x_continuous(limits=c(3,19)) +
  scale_y_continuous(limits=c(2,20)) +
  theme_void() +
  theme(  
    legend.position = 'none',
    strip.background = element_blank(),
    strip.text.x = element_blank(),
    plot.margin = margin(20,70,20,70),
    plot.title = element_text(size=40, face = "bold", family='MarkerFelt-Wide', hjust = 0.5, margin=margin(10,0,30,0)),
    plot.caption =  element_text(family='mono', hjust=0.5, margin=margin(30,0,10,0))) +
  labs(title='Pop Anscombe',
       caption = "Paula L. Casado (@elartedeldato) | Data: Anscombe \n#30DayChartChallenge | Day 17: Pop Culture") -> p
p
#ggsave('plots/17-PopCulture.png', p, height = 10, width = 10)
