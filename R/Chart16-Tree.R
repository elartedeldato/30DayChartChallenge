# Packages
library(data.table)
library(tidyverse)
library(ggtext)
library(ggtree)

# Data
data(iris)
rn <- paste0(iris[,5], "_", 1:150)
rownames(iris) <- rn
d_iris <- dist(iris[,-5], method="man")
tree_iris <- ape::bionj(d_iris)
grp <- list(setosa     = rn[1:50],
            versicolor = rn[51:100],
            virginica  = rn[101:150])
tree_iris <- groupOTU(tree_iris, grp, "Species")


# Plot
p <- ggtree(tree_iris, aes(color=Species), layout = 'daylight', branch.length='none')  
p + scale_color_manual(values=c('#7bbcb0','#f8b58b','#e38191')) +
  theme(legend.position = 'none',
        panel.border= element_blank(),
        panel.grid = element_line(color='#a33131', size=0.25),
        plot.margin = margin(20, 100, 20, 100),
        plot.background = element_rect(fill='#242629', color='#242629'),
        panel.background = element_rect(fill='transparent', color='transparent'),
        plot.title = element_markdown(size=10, color='white', family='mono', 
                                      hjust = 0, margin=margin(10,0,20,0)),
        plot.subtitle = element_markdown(size=6, family='mono', color='#ffffff', margin=margin(0,0,30,0)),
        plot.caption =  element_text(size=7.5, hjust=0.5, color='#ffffff', family='mono', margin=margin(30,0,10,0))) +
  labs(title='Phylogenetic Tree of Iris Species. <span style="color: #7bbcb0">Setosa.</span>
         <span style="color: #f8b58b">Versicolor.</span>
         <span style="color: #e38191">Virginica.</span><br>',
       caption = "Paula L. Casado (@elartedeldato) | Data: R datasets \n#30DayChartChallenge | Day 16: Tree") -> p
p
#ggsave('plots/16-Tree.png', p, height = 8, width = 8.7)
