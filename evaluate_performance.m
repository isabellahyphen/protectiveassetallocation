function performance = evaluate_performance(portfolioValue, riskFreeRate, dates)
    % evaluate_performance :)
    %
    % Inputs:
    %   portfolioValue - A vector of portfolio values over time
    %   riskFreeRate - A vector of risk-free rates over the same period
    %   dates - A vector of dates corresponding to portfolio values
    %
    % Output:
    %   performance - A struct containing CAGR, Volatility, Max Drawdown, Sharpe Ratio, MAR, Win0, and Win5

    % CAGR
    nYears = years(dates(end) - dates(1));
    CAGR = (portfolioValue(end) / portfolioValue(1))^(1/nYears) - 1;

    % Annualized volatility
    monthlyReturns = diff(log(portfolioValue));
    volatility = std(monthlyReturns) * sqrt(12);

    % Maximum drawdown :(
    maxDrawdown = maxdrawdown(portfolioValue);

    % Sharpe Ratio
    excessReturns = monthlyReturns - (riskFreeRate / 12);
    sharpeRatio = mean(excessReturns) / std(excessReturns) * sqrt(12);

    % MAR (CAGR / Max Drawdown)
    MAR = CAGR / maxDrawdown;

    % Win0 and Win5
    rollingReturns = movsum(monthlyReturns, 12);
    Win0 = mean(rollingReturns >= 0);
    Win5 = mean(rollingReturns >= -0.05);

    % Return the performance metrics!
    performance = struct('CAGR', CAGR, 'Volatility', volatility, ...
                         'MaxDrawdown', maxDrawdown, 'SharpeRatio', sharpeRatio, ...
                         'MAR', MAR, 'Win0', Win0, 'Win5', Win5);
end
