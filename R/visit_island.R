library(stats)

visit_island <- function(current_island, proposed_island, num_islands, df){
  # Propose new island
  if(current_island == 1){
    proposed_island <- 2
  } else if (current_island == num_islands){
    proposed_island <- num_islands - 1
  } else {
    # Randomly choose whether to consider a left or right move: 0=left and 1=right.
    direction = sample.int(n=2, size=1)
    if (direction==1){
      proposed_island <- current_island + 1
    } else {
      proposed_island <- current_island - 1
    }
  }
  
  #Chose whether to move to proposed island
  island_pops <- df['island_pops']
  pi_move = min(island_pops$island_pops[proposed_island]/island_pops$island_pops[current_island], 1)
  if (island_pops$island_pops[proposed_island] > island_pops$island_pops[current_island]){
    visit_yn <- 'y'
  } else {
    u = runif(n=1)
    if (u <= pi_move ){
      visit_yn <- 'y'
    } else {
      visit_yn <- 'n'
    }
  }
  
  # If you decided to move, update current island
  if (visit_yn == 'y'){
    # set current island to proposed island
    current_island <- proposed_island
  } 
  
  # Update visits
  df[current_island, 'visits'] <- as.integer(df[current_island, 'visits'] + 1)
  
  # Recalculate proportion_of_total_visits
  total_visits = sum(df['visits'])
  df <- df %>% 
    mutate(proportion_of_total_visits = visits/total_visits)
  
  output <- list(current_island, proposed_island, df)
  
  return(output)
  
}