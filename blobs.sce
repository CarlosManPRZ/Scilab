function [X,y,centers] = make_blobs(n_samples, n_features,n_centers, cluster_std, center_box, shuffle, random_state)

//Check input parameters
if argn(2) < 2
    error("Not enough input arguments.")
end

if argn(2) < 3
    n_centers = 2;
end

if argn(2) < 4
    cluster_std = 1.0 * ones(n_centers,1);
end

if argn(2) < 5
    if isscalar(n_centers)
        center_box = ones(n_centers,n_features)*[-10,0;0,10];
    else
        center_box = ones(length(n_centers(:,1)),n_features)*[-10,0;0,10];
    end
end

if argn(2) < 6
    shuffle = %F;
end

if argn(2) < 7
    random_state = 1;
end

// Generate random centers
//If specify the numbers of centers (clusters)
if isscalar(n_centers) then
    for i=1:n_centers
    centers(i,:) = grand(1, n_features,'unf',center_box(i,1),center_box(i,2));       
    end
else
    centers = n_centers;
    n_centers = length(n_centers(:,1));
end

/*
for i=1:n_centers
    centers(i,:) = grand(1, n_features,'unf',center_box(i,1),center_box(i,2));       
end
*/
disp('centers:',centers)

//Generate samples
n_samples_c = floor(n_samples/n_centers); //Average samples per cluster
disp('Samples',n_samples_c)
centers_samples = zeros(1,n_centers);
//Number of samples in the n-1 cluster = average samples per cluster
//Number of samles in the last cluster = n - (n-1)*av - In order to complete the numbers of samples
for i=1:n_centers
    if i == n_centers then
        centers_samples(1,i) = n_samples - (i-1)*n_samples_c;
    else
        centers_samples(1,i) = n_samples_c;
    end
end
disp('centers_samples',centers_samples)

//Initialize output vectors
X = zeros(n_samples,n_features);
y = zeros(n_samples,1);
idx_ini = 1;
c = cumsum(centers_samples);
for i=1:n_centers
    X(idx_ini:c(i),:) = grand(centers_samples(i),"mn",centers(i,:)',(cluster_std(i)^2)*eye(n_features,n_features))';
    y(idx_ini:c(i),1) = i;
    idx_ini = c(i)+1;
end

// Shuffle samples if requested
/*
if shuffle    
    idx = grand(1,n_samples,"unf",1,n_samples);
    //rand(n_samples,'prm',);
    X = X(idx, :);
end
*/
// Assign labels
//y = round(bsxfun(@minus, X, centers) ./ cluster_std);

endfunction


//Example
center_box=[-1,1;-5,5;-10,10];
std = [1,1,1,1];
centers = [0,0;-5,0;5,0];
[X,y,c] = make_blobs(1000,2,centers,std);
scatter(X(:,1),X(:,2),10,y)
plot(c(:,1),c(:,2),'*r','MarkerSize',10)

