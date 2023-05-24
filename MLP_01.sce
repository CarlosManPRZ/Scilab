// Load the Iris dataset
//load fisheriris
clear
clc
filename = 'D:\UDLAP\Doctorado\ML_scilab\iris.csv';
exec('D:\UDLAP\Doctorado\ML_scilab\splitdataset.sci');
//fullfile(TMPDIR, "iris.csv");

substitute = [['setosa';'versicolor';'virginica'],['1';'2';'3']];

fisheriris = csvRead(filename,[],[],[],substitute,[],[],1.0);
X = fisheriris(:, 1:4);
y = fisheriris(:, 5);

// Scale the input features
[X_scaled,scaler] = Standard_scaler(X);


// Split the dataset into training and testing sets
[X_train, X_test, y_train, y_test] = splitdataset(X_scaled, y, 0.2);

/*
// Create an MLP classifier
mlp = mlp(10, 10, 0.01, 1000, "logistic");

// Train the MLP classifier
mlp = mlptrain(mlp, X_train, y_train);

// Make predictions on the test set
y_pred = mlppredict(mlp, X_test);
*/
rand('seed',0);
lp=[0.01,0.001,0.99,0.025];
N = [4,100,3]
W = ann_FF_init(N)
disp('Initial Weights',W)
T=300
disp('Training')
W = ann_FF_Mom_online(X_train',y_train',N,W,lp,T);
disp('Final Weights',W)
y_pred_raw = ann_FF_run(X_test',N,W);
y_pred = zeros(1,30);
for i=1:30
    [_,y_pred(i)]=max(y_pred_raw(:,i))
end


// Calculate accuracy

accuracy = sum(y_pred' == y_test) / length(y_test);
disp("Accuracy: " + string(accuracy));
