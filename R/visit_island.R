library(stats)

visit_island <- function(current_island, proposed_island, num_islands, df){
  
  # Randomly choose whether to consider a left or right move: 0=left and 1=right.
  direction = sample.int(n=2, size=1)
  
  # Propose new island
  proposed_island <- dplyr::case_when(
    current_island == 1 & direction == 1 ~ num_islands,
    current_island == num_islands & direction == 2 ~ 1,
    direction == 2 ~ current_island + 1,
    direction == 1 ~ current_island - 1
  )

  # Chose whether to move to proposed island ---- Rule 1. If the proposed island
  # has a larger population that the current island, move to the proposed
  # island. Rule 2. Randomly select a number u from the uniform distribution on
  # [0,1]. Calculate the probability of a move pi_move as 1 if the population of
  # the proposed island is larger than the current island's population, and the
  # population of the proposed island divided by the current island's population
  # otherwise. If u is less than or equal to pi_move, then move to the proposed
  # island, otherwise stay on the current island.
  pi_move = min(df$island_pop[proposed_island]/df$island_pop[current_island], 1)
  if (df$island_pop[proposed_island] > df$island_pop[current_island]){
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