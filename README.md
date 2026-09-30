# A Genetic Algorithm-Based Automated Domestic Load Shedding System for Efficient Solar Energy Utilization

**Author**: Garland Leo Unogwu  
**Institution**: Department of Electrical Engineering, Ahmadu Bello University, Zaria, Nigeria  
**Contact**: garlandleo200@gmail.com  
**Application / Scope**: Renewable Energy Microgrids, Domestic Demand-Side Management, Computational Intelligence  

---

## Abstract

In developing countries with unstable central grids, domestic photovoltaic (PV) and battery storage installations frequently suffer from premature battery depletion, inverter tripping, and prolonged power outages due to unmanaged demand. This project designs and simulates an intelligent, automated load-shedding and energy-management system that dynamically balances solar generation, battery state of charge (SOC), and domestic consumption over a 24-hour cycle.

By integrating a **Genetic Algorithm (GA)** to pre-schedule circuit connectivity and heavily prioritize critical loads, the system reduces domestic blackout time from **8 hours** (unmanaged baseline) to **1 hour**, increasing overall power availability from **66.67% to 95.83%**, and outperforming instantaneous rule-based analytical shedding.

---

## Key System Specifications

| Subsystem | Parameter | Specification |
| :--- | :--- | :--- |
| **Grid / Electrical** | Voltage / Current Rating | 230 V AC / 100 A (100 A Main Breaker) |
| **Circuits** | Number of Sub-circuits | 12 domestic circuits (LR, Dining, Bedrooms, Bathrooms, Kitchen, Garage, Laundry) |
| **PV Generation** | Solar Capacity | $5 \times 300\text{ W}$ panels = **1500 W total installed capacity** |
| **Inverter** | Efficiency Characteristic | $\eta_{\text{inv}}(G) = 0.95 - 0.05 e^{-G/1000}$ ($G$ in $\text{W/m}^2$) |
| **Energy Storage** | Battery Storage Capacity | 2000 Wh (Nominal), Initial SOC = 50% |
| **Storage Limits** | Charge / Discharge Limits | Max 1000 W continuous charge / discharge; Round-trip efficiency $\eta = 0.90$ |
| **Optimizer** | Genetic Algorithm (GA) | Pop: 50, Gen: 100, $P_{\text{cross}} = 0.8$, $P_{\text{mut}} = 0.1$, Roulette Wheel + Elitism |

---

## Performance Comparison

Simulated over a standard 24-hour diurnal cycle with synthetic solar irradiance and dynamic domestic usage patterns:

| Performance Metric | System A: Baseline (No Shedding) | System B: Analytical (Rule-Based) | System C: GA-Optimized (Proposed) |
| :--- | :---: | :---: | :---: |
| **Total Blackout Time** | 8.00 hours | 2.00 hours | **1.00 hour** |
| **Critical Load Blackout Rate ($P_{\text{blackout}}$)** | 33.33% | 8.33% | **4.17%** |
| **Total Power Availability ($P_{\text{availability}}$)** | 66.67% | 91.67% | **95.83%** |

---

## Repository Structure

```
.
├── main.m                         # Master execution pipeline
├── house_specs.m                  # Circuit definitions, load ratings, and priority flags
├── solar_battery_specs.m          # PV sizing, battery ratings, and inverter efficiency model
├── load_profiles.m                # 12x24 binary load activity profile matrix
├── generate_weather_data.m        # Synthetic 24-hour solar irradiance & temperature model
├── plot_weather_data.m            # Weather profile visualization utility
├── simulate_baseline.m            # System A simulation engine (No load shedding)
├── simulate_load_shedding.m       # System B simulation engine (Analytical priority shedding)
├── simulate_ga_optimization.m     # System C simulation engine (Genetic Algorithm optimization)
├── calculate_metrics.m            # Performance metrics evaluator & comparative summary
├── visualize_results.m            # Result plotting and visualization
└── weatherData.mat                # Pre-generated weather profile data
```

---

## How to Run the Simulation

### Prerequisites
* MATLAB (R2018b or later recommended).
* No additional toolboxes required (all GA selection, crossover, mutation, and simulation routines are implemented natively).

### Setup & Execution
1. Clone the repository:
   ```bash
   git clone https://github.com/GarlandIL/genetic-algorithm-optimized-energy-utilization-system.git
   cd genetic-algorithm-optimized-energy-utilization-system
   ```
2. Open MATLAB and set the repository folder as your working directory.
3. Run the master script from the MATLAB Command Window:
   ```matlab
   main
   ```

### Generated Outputs
* **Figure 1**: Aggregate 24-hour household load curve.
* **Figure 4**: Hourly solar power curve and System B analytical shedding heatmap.
* **Figure 5**: System C GA-optimized shedding heatmap showing preserved critical circuits.
* **Summary Tables**: Formatted Command Window and UI tables detailing hourly dispatch and comparative metrics across all systems.

---

## Citation & Academic Reference

If you build upon this work or simulation framework, please cite:
> Unogwu, G. L. (2024). *A Genetic Algorithm-Based Automated Domestic Load Shedding System for Efficient Solar Energy Utilization*. Department of Electrical Engineering, Ahmadu Bello University, Zaria, Nigeria.
