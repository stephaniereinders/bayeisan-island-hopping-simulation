library(stats)

propose_island <- function(current_island, num_islands){
  
  # Pick proposed island
  if(current_island == 1){
    proposed_island <- 2
  } else if (current_island == num_islands){
    proposed_island <- num_islands - 1
  } else {
      # Randomly choose whether to consider a left or right move: 0=left and 1=right.
      direction = sample.int(n=2, size=1)
      if (direction==1){
        proposed_island <- current_island - 1
      } else {
        proposed_island <- current_island + 1
      }
  }
  
  return(proposed_island)
}