function [SMA, MOM] = calculate_momentum(prices, L)
    % calculate_momentum for each asset
    %
    % Inputs:
    %   prices - An NxM matrix of asset prices where N is the number of assets and M is the number of time periods
    %   L - The lookback period (in months) for the SMA and MOM calculation
    %
    % Outputs:
    %   SMA - An NxM matrix of Simple Moving Averages (SMA) for each asset
    %   MOM - An Nx1 vector of momentum (MOM) values for each asset at the most recent time period
    
    % SMA over the lookback period L
    SMA = movmean(prices, [L-1 0], 2);
    
    % The most recent prices (p0)
    currentPrices = prices(:, end);
    
    % The Momentum (MOM(L)) based on SMA and current prices
    MOM = currentPrices ./ SMA(:, end) - 1;
    
    % Return the SMA and MOM values
end
