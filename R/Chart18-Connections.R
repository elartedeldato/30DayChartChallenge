# Packages
library(tidygraph)
library(igraph)
library(ggplot2)
library(ggraph)

# Data
star_wars <- jsonlite::fromJSON('https://storage.googleapis.com/kagglesdsdata/datasets/826031/1411936/starwars-full-interactions-allCharacters.json?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=gcp-kaggle-com%40kaggle-161607.iam.gserviceaccount.com%2F20210417%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20210417T105928Z&X-Goog-Expires=259199&X-Goog-SignedHeaders=host&X-Goog-Signature=72d70d05b9d9e6a7d71b8f6afbabaa90613b7599b879240217cd713cba65c43d11b5a0d88af758fccb0e9e1da25e9e13c1bb109eaeef5149e397e30119210e4742bc4ee1b3c6702c63f29c44acf9509262961d4ec8fc9ac6f06e0ac23ab283c2015d7969430cbace0e07c8253b1bc7b6253711b00ccac7d6a8ce404a9b4f922421f0d86a86c1f98e108b2a45a60b033e32c383482c12af9e6c1004436957e03b69b0c69386b3fba054081e1d164b69894ffe1545761171da2b6c74bde9db8bfdeda59edf0d690934c48e84a184258f25b7ba46494b8391b584dec28db26fb49fad9893cb251cffc814461b5a77cebf7c9eeb0acf2367a35848638ebd01ec1422')
nodes <- data.frame(id=0:111, star_wars$nodes)
nodes <- nodes %>% filter(name != 'GOLD FIVE')
nodes$name <- tolower(nodes$name)
main_names <- nodes %>% arrange(desc(value)) %>% head(15) %>% pull(name)
nodes$label <- ifelse(nodes$name %in% main_names, nodes$name, '')
nodes$color <- ifelse(nodes$name %in% main_names, 'main', 'second')
graph  <- graph_from_data_frame(star_wars$links, vertices=nodes)

set.seed(28)
p <- ggraph(graph, layout = 'igraph', algorithm = 'dh') 

p + geom_edge_link(aes(alpha=value), color='#fee917') + 
  geom_node_point(aes(size=value, color=color)) +
  scale_color_manual(values=c('black','#fee917')) +
  geom_node_text(aes(label = label, x = x, y = y, size=value), color='#fee917', family='StarJedi') +
  theme(legend.position='none',
        panel.background = element_blank(),
        plot.background = element_rect(fill='black', color='black'),
        plot.title = element_text(color='#fee917', size=50, face = "bold", family='StarJedi', hjust = 0.5, margin=margin(10,0,0,0)),
        plot.subtitle = element_text(color='#fee917', size=30, face = "bold", family='StarJedi', hjust = 0.5, margin=margin(0,0,30,0)),
        plot.caption =  element_text(color='#fee917', size=8, family='StarJedi', hjust=0.5, margin=margin(30,0,10,0))) +
  labs(title='Star Wars',
       subtitle='interactions',
       caption = "Paula L. Casado (elartedeldato) \n Data: Kaggle # 30DayChartChallenge # Day 18: Connections") -> p2
p2
#ggsave('plots/18-Connections-Yellow.png', p2, height = 10, width = 10)
