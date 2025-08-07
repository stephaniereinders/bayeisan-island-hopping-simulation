library(tidyverse)

plot_islands <- function(df, current_island){

  # Update colors (every turn)
  df$color <- "other"
  df$color[current_island] <- "current"
  
  # Create island plot
  p <- df %>% ggplot(aes(x=island_name, y=1, size=island_pop, color=as.factor(color))) +
    geom_point() +
    theme_bw() + 
    scale_y_discrete(labels = NULL, breaks = NULL) + 
    scale_size_continuous(labels = NULL, breaks = NULL) +
    labs(x = "",
         y = "",
         color="Location") +
    annotate("text", x = df$island_name, y = 0.8, label = paste("pop.", df$island_pop)) +
    theme(panel.grid.major.x = element_blank(),
          panel.grid.minor.x = element_blank())

  return(p)
}