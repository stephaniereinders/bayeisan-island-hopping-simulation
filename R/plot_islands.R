library(tidyverse)

plot_islands <- function(df, current_island){

  # Update colors (every turn)
  df$color <- "other"
  df$color[current_island] <- "current"
  
  # Create island plot
  p <- df %>% ggplot(aes(x=islands, y=1, size=island_pops, color=as.factor(color))) +
    geom_point() +
    theme_bw() + 
    scale_x_discrete(labels = NULL, breaks = NULL) + 
    scale_y_discrete(labels = NULL, breaks = NULL) + 
    scale_size_continuous(labels = NULL, breaks = NULL) +
    labs(x = "",
         y = "",
         color="location",
         size="population") +
    annotate("text", x = df$islands, y = 0.9, label = df$island_pops)

  return(p)
}