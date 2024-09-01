function data = load_data(filename)
    % Load the ETF-Proxy Data
    rawData = readtable(filename);
    
    % Extract Dates, Adjusted Prices
    dates = datetime(rawData.Date, 'InputFormat', 'yyyy-MM-dd');
    prices = table2array(rawData(:, 2:end));
    
    % Extract Specific Data Columns
    spyPrices = rawData.SPY;
    qqqPrices = rawData.QQQ;
    % ... Repeat for other ETFs
    iefPrices = rawData.IEF;
    
    % Risk-Free Rate
    riskFreeRate = rawData.BIL;
    
    % Package Data into a Struct
    data = struct('Date', dates, ...
                  'Prices', prices, ...
                  'SPY', spyPrices, ...
                  'QQQ', qqqPrices, ...
                  % ... Add other ETFs
                  'IEF', iefPrices, ...
                  'RiskFreeRate', riskFreeRate);
end
