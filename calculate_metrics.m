% Generates and displays comparative summary table across:
% System A (baseline), System B (analytical), and System C (GA-optimized).

function comparisonTable = calculate_metrics(metricsA, metricsB, metricsC)
    metricsList = {
        'Total blackout time (hours)';
        'Percentage blackout, critical loads (%)';
        'Total power availability (%)'
    };

    systemA_Values = [
        metricsA.totalBlackoutHours;
        metricsA.criticalBlackoutPercent;
        metricsA.powerAvailabilityPercent
    ];

    systemB_Values = [
        metricsB.totalBlackoutHours;
        metricsB.criticalBlackoutPercent;
        metricsB.powerAvailabilityPercent
    ];

    systemC_Values = [
        metricsC.totalBlackoutHours;
        metricsC.criticalBlackoutPercent;
        metricsC.powerAvailabilityPercent
    ];

    comparisonTable = table(metricsList, systemA_Values, systemB_Values, systemC_Values, ...
        'VariableNames', {'Metric', 'Before_Load_Shedding', 'After_Analytical_Load_Shedding', 'After_GA_Optimization'});

    % Print formatted table to Command Window
    fprintf('\n========================================================================================\n');
    fprintf('           TABLE 4. SUMMARY COMPARISON OF SYSTEM A, SYSTEM B, AND SYSTEM C             \n');
    fprintf('========================================================================================\n');
    fprintf('%-42s | %-12s | %-14s | %-12s\n', 'Metric', 'System A', 'System B', 'System C');
    fprintf('%-42s | %-12s | %-14s | %-12s\n', '', '(Baseline)', '(Analytical)', '(GA-Optimized)');
    fprintf('----------------------------------------------------------------------------------------\n');
    for r = 1:height(comparisonTable)
        fprintf('%-42s | %10.2f   | %12.2f   | %10.2f  \n', ...
            comparisonTable.Metric{r}, ...
            comparisonTable.Before_Load_Shedding(r), ...
            comparisonTable.After_Analytical_Load_Shedding(r), ...
            comparisonTable.After_GA_Optimization(r));
    end
    fprintf('========================================================================================\n\n');
end
