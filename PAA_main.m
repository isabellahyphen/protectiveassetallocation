% PAA_main.m - Protective Asset Allocation (PAA) Implementation

% Parameters Initialization
L = 12; % Lookback period in months, 6, 9, 12
a = 2;  % Protection factor (0 = low, 1 = medium, 2 = high)
Top = 6; % Number of top assets to select for the risky portfolio
N = 12; % Number of assets in the universe
transactionFee = 0.001; % Transaction fee (0.1%)

% Data Loading
data = load_data('etf_data.csv'); 
dates = data.Date;
prices = data.Prices; % Prices should be an NxM matrix where N = # of assets, M = # of months
riskFreeRate = data.RiskFreeRate; % Risk-free rate data
iefPrices = data.IEF; % Safe bond (IEF) prices

% Initialize variables to store our results
portfolioValue = zeros(1, length(dates) - L);
weights = zeros(N, length(dates) - L);

% Looping over the Backtest Period
for t = L:length(dates)
    
    % Get the current price vector (current month)
    currentPrices = prices(:, t);
    
    % Find the Momentum Indicators
    sma = movmean(prices(:, t-L+1:t), [L-1 0], 2);
    mom = currentPrices ./ sma(:, end) - 1;
    
    % Determine Good and Bad Assets
    goodAssets = mom > 0;
    n = sum(goodAssets);
    
    % Bond Fraction (BF) --> calculate_bond_fraction.m
    BF = calculate_bond_fraction(N, n, a);
    
    % Form the Risky Portfolio
    [sortedMom, idx] = sort(mom, 'descend');
    topAssets = idx(1:min(Top, n)); % Select top 'Top' good assets
    riskyPortfolioWeights = zeros(N, 1);
    riskyPortfolioWeights(topAssets) = 1 / length(topAssets);
    
    % Combine Risky Portfolio with Bond Allocation
    bondWeight = BF;
    riskyWeight = 1 - BF;
    weights(:, t-L+1) = bondWeight * (iefPrices(:, t) / sum(iefPrices(:, t))) + riskyWeight * riskyPortfolioWeights;
    
    % Calculate Portfolio Value
    portfolioValue(t-L+1) = sum(weights(:, t-L+1) .* currentPrices) * (1 - transactionFee);
end

% Performance Evaluation
performance = evaluate_performance(portfolioValue, riskFreeRate(L:end), dates(L:end));

% Results Reporting 
fprintf('PAA Model Performance:\n');
fprintf('CAGR: %.2f%%\n', performance.CAGR * 100);
fprintf('Volatility: %.2f%%\n', performance.Volatility * 100);
fprintf('Max Drawdown: %.2f%%\n', performance.MaxDrawdown * 100);
fprintf('Sharpe Ratio: %.2f\n', performance.SharpeRatio);
fprintf('MAR: %.2f\n', performance.MAR);
fprintf('Win0: %.2f%%\n', performance.Win0 * 100);
fprintf('Win5: %.2f%%\n', performance.Win5 * 100);

% Results Plotting
figure;
plot(dates(L:end), portfolioValue);
xlabel('Date');
ylabel('Portfolio Value');
title('PAA Model Portfolio Value Over Time');
grid on;

