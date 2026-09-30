% =========================================================================
% MASTER EXECUTION SCRIPT
% Project: A Genetic Algorithm-Based Automated Domestic Load Shedding System
%          for Efficient Solar Energy Utilization
% Author:  Garland Leo Unogwu
% Institution: Department of Electrical Engineering, Ahmadu Bello University
% =========================================================================
%
% This script executes the complete simulation pipeline:
% 1. Generates synthetic solar irradiance and temperature data.
% 2. Loads household specifications, circuit loads, and priority classifications (Table 1).
% 3. Loads solar PV ratings (5 panels = 1500 W) and battery storage specifications.
% 4. Loads the 24-hour dynamic load profiles (Table 2).
% 5. Simulates System A: Baseline (No Load Shedding).
% 6. Simulates System B: Analytical (Rule-Based Priority Load Shedding).
% 7. Simulates System C: Genetic Algorithm (GA-Optimized Load Shedding).
% 8. Computes and displays Table 4 (Comparative Summary).
% 9. Renders Figure 1 (Load Profile), Figure 4 (System B Heatmap), and Figure 5 (System C Heatmap).
% =========================================================================

clear;
close all;
clc;

fprintf('=========================================================================\n');
fprintf('  DOMESTIC SOLAR LOAD SHEDDING OPTIMIZATION SYSTEM - SIMULATION RUNNER  \n');
fprintf('=========================================================================\n\n');

%% 1. Generate Synthetic Weather Data
fprintf('[1/6] Generating synthetic weather data...\n');
weatherData = generate_weather_data();

%% 2. Load System Specifications
fprintf('[2/6] Loading system specifications and load profiles...\n');
[voltage, mainCurrent, mainCircuitBreaker, allCircuits, allLoads, allLoadPriority] = house_specs();
[totalSolarPower, batteryCapacity, batterySOC, batteryEfficiency, maxChargeRate, maxDischargeRate, inverterEfficiencyCurve] = solar_battery_specs();
loadProfiles = load_profiles();

fprintf('      - Installed Solar Capacity : %d W (%d panels @ 300 W)\n', totalSolarPower, totalSolarPower / 300);
fprintf('      - Battery Storage Capacity : %d Wh (Initial SOC: %.0f%%)\n', batteryCapacity, batterySOC * 100);
fprintf('      - Total Connected Circuits : %d circuits\n', length(allCircuits));

%% 3. Simulate System A: Baseline (No Load Shedding)
fprintf('\n[3/6] Simulating System A: Baseline (No Load Shedding)...\n');
[solarPowerA, batteryPowerA, batterySOC_A, hourlyDemandA, unservedLoadA, isBlackoutA, metricsA] = ...
    simulate_baseline(weatherData, allLoads, loadProfiles, totalSolarPower, batteryCapacity, ...
                      batterySOC, batteryEfficiency, maxChargeRate, maxDischargeRate, inverterEfficiencyCurve);
fprintf('      -> System A Complete: Total Blackout = %d hours, Availability = %.2f%%\n', ...
    metricsA.totalBlackoutHours, metricsA.powerAvailabilityPercent);

%% 4. Simulate System B: Analytical (Rule-Based Load Shedding)
fprintf('\n[4/6] Simulating System B: Analytical Rule-Based Load Shedding...\n');
[solarPowerB, batteryPowerB, batterySOC_B, shedLoadsB, metricsB] = ...
    simulate_load_shedding(weatherData, voltage, allLoads, allLoadPriority, loadProfiles, ...
                          totalSolarPower, batteryCapacity, batterySOC, batteryEfficiency, ...
                          maxChargeRate, maxDischargeRate, inverterEfficiencyCurve);
fprintf('      -> System B Complete: Total Blackout = %d hours, Availability = %.2f%%\n', ...
    metricsB.totalBlackoutHours, metricsB.powerAvailabilityPercent);

%% 5. Simulate System C: Genetic Algorithm (GA) Optimization
fprintf('\n[5/6] Simulating System C: Genetic Algorithm Optimization...\n');
fprintf('      Running GA (50 individuals, 100 generations, Crossover=0.8, Mutation=0.1)...\n');
[solarPowerC, batteryPowerC, batterySOC_C, shedLoadsC, bestSchedule, metricsC] = ...
    simulate_ga_optimization(weatherData, voltage, allLoads, allLoadPriority, loadProfiles, ...
                             totalSolarPower, batteryCapacity, batterySOC, batteryEfficiency, ...
                             maxChargeRate, maxDischargeRate, inverterEfficiencyCurve);
fprintf('      -> System C Complete: Total Blackout = %d hour, Availability = %.2f%%\n', ...
    metricsC.totalBlackoutHours, metricsC.powerAvailabilityPercent);

%% 6. Comparative Analysis & Visualizations
fprintf('\n[6/6] Generating Tables and Visualizations...\n');

% Calculate and display Table 4 (Comparative Metrics)
comparisonTable = calculate_metrics(metricsA, metricsB, metricsC);

% Render Figures 1, 4, 5 and Table 3
visualize_results(allCircuits, allLoads, loadProfiles, solarPowerB, batterySOC_B, shedLoadsB, shedLoadsC, comparisonTable);

fprintf('=========================================================================\n');
fprintf('  SIMULATION COMPLETED SUCCESSFULLY!\n');
fprintf('  All simulation figures and summary tables have been generated.\n');
fprintf('=========================================================================\n');
