% File: visualize_results.m
% Visualizes simulation results matching Manuscript Figures 1, 4, 5 and Table 3.

function visualize_results(allCircuits, allLoads, loadProfiles, solarPowerB, batterySOC_B, shedLoadsB, shedLoadsC, comparisonTable)

    % 1. FIGURE 1: Aggregate Household Load Profile Over 24 Hours
    plot_figure_1(allLoads, loadProfiles);

    % 2. FIGURE 4: System B (Analytical Approach) Load Shedding & Solar Power Output
    plot_figure_4(allCircuits, solarPowerB, shedLoadsB);

    % 3. FIGURE 5: System C (GA-Optimized) Load Shedding Heatmap
    plot_figure_5(allCircuits, shedLoadsC);

    % 4. TABLE 3: Hourly Solar Power Output, Battery SOC, and Total Shed Load (System B)
    display_table_3(solarPowerB, batterySOC_B, shedLoadsB);

    % 5. TABLE 4: UI Table for Comparative Analysis
    if nargin >= 8 && ~isempty(comparisonTable)
        display_table_4_ui(comparisonTable);
    end
end

% --- FIGURE 1 ---
function plot_figure_1(allLoads, loadProfiles)
    dailyLoad = zeros(size(loadProfiles));
    for i = 1:length(allLoads)
        dailyLoad(i, :) = loadProfiles(i, :) * allLoads(i);
    end
    totalHourlyLoad = sum(dailyLoad, 1);

    fig1 = figure('Name', 'Figure 1: Aggregate Household Load Profile', 'Color', 'w');
    plot(0:23, totalHourlyLoad, 'b-', 'LineWidth', 1.8);
    title('Total Load Profile for 24 Hours', 'FontSize', 12, 'FontWeight', 'bold');
    xlabel('Hour of the Day', 'FontSize', 11);
    ylabel('Total Load (Watts)', 'FontSize', 11);
    xticks(0:23);
    grid on;
    legend({'Total Load'}, 'Location', 'northeast');
end

% --- FIGURE 4 ---
function plot_figure_4(allCircuits, solarPowerOutput, shedLoads)
    fig4 = figure('Name', 'Figure 4: Analytical Approach (System B)', 'Color', 'w');

    % Top subplot: Load Shedding Heatmap
    subplot(2, 1, 1);
    imagesc(shedLoads);
    title('Load Shedding Over 24 Hours', 'FontSize', 12, 'FontWeight', 'bold');
    xlabel('Hour of Day', 'FontSize', 10);
    ylabel('Circuit Number', 'FontSize', 10);
    yticks(1:length(allCircuits));
    yticklabels(allCircuits);
    xticks(1:24);
    xticklabels(0:23);
    colorbar;
    colormap(flipud(gray));
    if max(shedLoads(:)) > 0
        caxis([0 max(shedLoads(:))]);
    end
    grid on;

    % Bottom subplot: Solar Power Output
    subplot(2, 1, 2);
    plot(0:23, solarPowerOutput, 'g-', 'LineWidth', 1.8);
    title('Solar Power Output', 'FontSize', 12, 'FontWeight', 'bold');
    xlabel('Time (Hours)', 'FontSize', 10);
    ylabel('Power (W)', 'FontSize', 10);
    xticks(0:23);
    grid on;
    legend({'Solar Power Output'}, 'Location', 'northeast');
end

% --- FIGURE 5 ---
function plot_figure_5(allCircuits, shedLoadsGA)
    fig5 = figure('Name', 'Figure 5: GA-Optimized Approach (System C)', 'Color', 'w');

    imagesc(shedLoadsGA);
    title('Load Shedding Over 24 Hours (Amount of Load Shed)', 'FontSize', 12, 'FontWeight', 'bold');
    xlabel('Hour of Day', 'FontSize', 10);
    ylabel('Circuit Number', 'FontSize', 10);
    yticks(1:length(allCircuits));
    yticklabels(allCircuits);
    xticks(1:24);
    xticklabels(0:23);
    colorbar;
    colormap(flipud(gray));
    if max(shedLoadsGA(:)) > 0
        caxis([0 max(shedLoadsGA(:))]);
    end
    grid on;
end

% --- TABLE 3 DISPLAY ---
function display_table_3(solarPowerOutput, batterySOCArray, shedLoads)
    timeHours = (0:23)';
    totalShed = sum(shedLoads, 1)';

    t3 = table(timeHours, solarPowerOutput', batterySOCArray', totalShed, ...
        'VariableNames', {'Hour', 'Solar_Power_Output_W', 'Battery_SOC', 'Total_Shed_Load_W'});

    fprintf('========================================================================================\n');
    fprintf('           TABLE 3. HOURLY SOLAR POWER, BATTERY SOC, AND TOTAL SHED LOAD (SYSTEM B)     \n');
    fprintf('========================================================================================\n');
    fprintf('%-8s | %-24s | %-16s | %-18s\n', 'Hour', 'Solar Power Output (W)', 'Battery SOC', 'Total Shed Load (W)');
    fprintf('----------------------------------------------------------------------------------------\n');
    for r = 1:height(t3)
        fprintf('%-8d | %24.2f | %16.4f | %18.2f\n', ...
            t3.Hour(r), t3.Solar_Power_Output_W(r), t3.Battery_SOC(r), t3.Total_Shed_Load_W(r));
    end
    fprintf('========================================================================================\n\n');

    % UI Table window
    figT3 = figure('Name', 'Table 3: Hourly Results (System B)', 'Color', 'w', 'Position', [100 100 620 450]);
    uitable(figT3, 'Data', table2cell(t3), 'ColumnName', {'Hour', 'Solar Power Output (W)', 'Battery SOC', 'Total Shed Load (W)'}, ...
        'RowName', [], 'Units', 'normalized', 'Position', [0.05 0.05 0.9 0.9]);
end

% --- TABLE 4 UI DISPLAY ---
function display_table_4_ui(compTable)
    figT4 = figure('Name', 'Table 4: Comparative Summary', 'Color', 'w', 'Position', [150 150 720 250]);
    uitable(figT4, 'Data', table2cell(compTable), ...
        'ColumnName', {'Metric', 'Before Load Shedding', 'After Analytical', 'After GA Optimization'}, ...
        'RowName', [], 'Units', 'normalized', 'Position', [0.05 0.05 0.9 0.9]);
end
