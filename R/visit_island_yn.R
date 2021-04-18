library(stats)

visit_island_yn <- function(current_island, proposed_island, island_pops){
  
  #Chose whether to move to proposed island
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
  
  return(visit_yn)
}