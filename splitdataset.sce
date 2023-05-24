function [X_train, X_test, y_train, y_test] = splitdataset(X, y, test_size)
    // Calculate the number of samples for testing set
    n_test = round(test_size * size(X, 1));
    
    // Randomly permute the indices of samples
    idx = randperm(size(X, 1));
    
    // Split the dataset into training and testing sets
    X_train = X(idx(1:end-n_test), :);
    X_test = X(idx(end-n_test+1:end), :);
    y_train = y(idx(1:end-n_test));
    y_test = y(idx(end-n_test+1:end));
endfunction
