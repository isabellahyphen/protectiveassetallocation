% Utility functions used across PAA

% Pay a transaction fee to the portfolio value change
function netValue = apply_transaction_fee(grossValue, fee)
    netValue = grossValue * (1 - fee);
end

% Normalize portfolio weights to sum to 1
function normalizedWeights = normalize_weights(weights)
    normalizedWeights = weights / sum(weights);
end
