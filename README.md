# Island Hopping Simulation

A Shiny web application that simulates island hopping using Bayesian statistics and the Metropolis-Hastings algorithm. This interactive simulation demonstrates how populations influence movement decisions in a chain of islands.

## Overview

This application simulates a traveler moving between a chain of islands, where the decision to move to a neighboring island depends on the relative populations of the islands. The simulation uses a Metropolis-Hastings-style algorithm where:

- Movement is more likely toward islands with larger populations
- Movement to smaller population islands occurs with probability proportional to the population ratio
- The traveler can only move to adjacent islands (left or right in the chain)

## Features

- **Interactive Parameters**: Customize the number of islands, maximum population, and starting position
- **Step-by-step Simulation**: Visit islands one at a time to observe the decision-making process
- **Batch Simulation**: Run multiple visits at once (up to 10,000)
- **Real-time Statistics**: Track visit counts and proportions for each island
- **Population Proportional Sampling**: Islands with larger populations are visited more frequently

## Files

- `ui.R` - User interface definition with input controls and layout
- `server.R` - Server logic handling reactive updates and simulation orchestration
- `visit_island.R` - Core algorithm implementing the island-hopping decision logic
- `plot_islands.R` - Visualization function for plotting islands (currently unused in UI)

## Algorithm

The simulation follows these steps:

1. **Proposal**: From the current island, propose moving to an adjacent island:
   - If on island 1: propose island 2
   - If on the last island: propose the second-to-last island
   - Otherwise: randomly choose left or right neighbor

2. **Decision**: Accept or reject the proposed move:
   - If proposed island has larger population: always move
   - If proposed island has smaller population: move with probability = (proposed_pop / current_pop)

3. **Update**: Record the visit to the final island (current if rejected, proposed if accepted)

This creates a Markov Chain where the stationary distribution is proportional to island populations.

## Installation & Usage

### Prerequisites
- R (version 3.6 or higher)
- Required R packages:
  ```r
  install.packages(c("shiny", "tidyverse", "stats"))
  ```

### Running the Application

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/island-hopping-simulation.git
   cd island-hopping-simulation
   ```

2. Open R/RStudio and set the working directory to the project folder

3. Run the application:
   ```r
   library(shiny)
   runApp()
   ```

### Using the Simulation

1. **Set Parameters**:
   - Number of islands (3-20)
   - Maximum population per island (5-50)
   - Starting island position

2. **Start Simulation**:
   - Click "Start your trip" to initialize the simulation
   - Islands will be assigned random populations up to your specified maximum

3. **Explore Movement**:
   - Click "Visit another island?" for single-step movement
   - Use the slider and "Simulate n visits?" for batch simulation

4. **Analyze Results**:
   - View the data table showing island populations, visit counts, and proportions
   - Observe how visit proportions converge toward population proportions

## Theory

This simulation demonstrates the **Metropolis-Hastings algorithm**, a Markov Chain Monte Carlo (MCMC) method. In this context:

- **Target Distribution**: Proportional to island populations
- **Proposal Distribution**: Uniform over adjacent islands
- **Acceptance Probability**: min(proposed_pop/current_pop, 1)

As the number of visits increases, the proportion of visits to each island should converge to that island's proportion of the total population, demonstrating how MCMC methods can sample from complex distributions.

## Applications

This simulation has educational value for:

- **Bayesian Statistics**: Understanding MCMC sampling methods
- **Markov Chains**: Visualizing stationary distributions and convergence
- **Population Dynamics**: Modeling movement patterns in ecology
- **Algorithm Design**: Learning acceptance-rejection sampling techniques

## Future Enhancements

Potential improvements could include:

- Visualization of the island chain with current position
- Convergence diagnostics and plots
- Different proposal mechanisms (e.g., allowing jumps to non-adjacent islands)
- Temperature parameter for controlling acceptance rates
- Export functionality for simulation results

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests to improve the simulation.

## License

This project is open source. Please add your preferred license here.
