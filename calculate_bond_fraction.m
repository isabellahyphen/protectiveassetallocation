function BF = calculate_bond_fraction(N, n, a)
    % calculate_bond_fraction for asset allocation
    %
    % Inputs:
    %   N - Total number of assets in the universe
    %   n - Number of good assets (assets with positive momentum)
    %   a - Protection factor (0 = low, 1 = medium, 2 = high protection)
    %
    % Output:
    %   BF - The bond fraction - the proportion of capital allocated to the bond (the supposedly safe) asset

    % n1 per the protection factor a
    n1 = a * (N / 4);
    
    % Bond Fraction
    BF = (N - n) / (N - n1);
    
    % Cap BF at 100%
    BF = min(BF, 1);
end
