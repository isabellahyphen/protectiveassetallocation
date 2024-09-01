function weights = form_portfolio(mom, BF, iefPrices, N, Top)
    % form_portfolio - Forms the risky EW portfolio and combines it with the bond allocation
    %
    % Inputs:
    %   mom - An Nx1 vector of momentum scores for each asset
    %   BF - The bond fraction (proportion of capital allocated to bonds)
    %   iefPrices - A scalar representing the current price of the bond asset (IEF)
    %   N - Total number of assets in the universe
    %   Top - Number of top assets to include in the risky portfolio
    %
    % Output:
    %   weights - An Nx1 vector of portfolio weights
    
    % Rank assets based on their momentum scores
    [~, idx] = sort(mom, 'descend');
    
    % Select the top Top assets
    topAssets = idx(1:min(Top, N));
    
    % Initialize weights to zero
    weights = zeros(N, 1);
    
    % Risky portfolio weights (equal weight among selected top assets)
    riskyWeight = (1 - BF) / length(topAssets);
    weights(topAssets) = riskyWeight;
    
    % Bond allocation (assuming IEF is the only bond asset and its index is known)
    bondWeight = BF;
    weights(end) = bondWeight; % Assuming the bond (IEF) is the last asset in the list
end
