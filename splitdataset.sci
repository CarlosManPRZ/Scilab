
//Scale and standardize dataset
function [X_scaled, scaler] = Standard_scaler(X, scaler)
    if nargin == 1
        // Compute mean and standard deviation
        mu = mean(X);
        sigma = stdev(X);
        
        // Create a scaler object with computed statistics
        scaler = [mu; sigma];
    end
    
    //Standardize the input features
    X_scaled = (X - scaler(1)) / scaler(2);
endfunction


//Split dataset function
function [X_train, X_test, y_train, y_test] = splitdataset(X, y, test_size)
    // Calculate the number of samples for testing set
    n_test = round(test_size * size(X, 1));
    col_size = size(X,1); 
    // Randomly permute the indices of samples    
    //idx = randperm(size(X, 1));
    idx = grand(1, "prm", 1:col_size)
    // Split the dataset into training and testing sets
    X_train = X(idx(1:col_size-n_test), :);
    X_test = X(idx(col_size-n_test+1:col_size), :);
    y_train = y(idx(1:col_size-n_test));
    y_test = y(idx(col_size-n_test+1:col_size));
endfunction
