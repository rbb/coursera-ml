function centroids = computeCentroids(X, idx, K)
%COMPUTECENTROIDS returns the new centroids by computing the means of the 
%data points assigned to each centroid.
%   centroids = COMPUTECENTROIDS(X, idx, K) returns the new centroids by 
%   computing the means of the data points assigned to each centroid. It is
%   given a dataset X where each row is a single data point, a vector
%   idx of centroid assignments (i.e. each entry in range [1..K]) for each
%   example, and K, the number of centroids. You should return a matrix
%   centroids, where each row of centroids is the mean of the data points
%   assigned to it.
%

% Useful variables
[m n] = size(X);

% You need to return the following variables correctly.
centroids = zeros(K, n);


% ====================== YOUR CODE HERE ======================
% Instructions: Go over every centroid and compute mean of all points that
%               belong to it. Concretely, the row vector centroids(i, :)
%               should contain the mean of the data points assigned to
%               centroid i.
%
% Note: You can use a for-loop over the centroids to compute this.
%

centroids = zeros(K,size(X,2));
for k = 1:K
   cm = mean( X(find(idx == k),:) );
   if isempty(cm)
      %disp(['k = ', num2str(k), "\tsize(cm) = ", num2str(size(cm))]);
      %cm = mean(X);
      %disp('Empty cluster, using mean of all values');
      rm = round(rand()*m);
      disp(['Empty cluster k = ', num2str(k), ', using random data point ', num2str(rm)]);
      cm = X(rm,:);
      %TODO: Try the farthest point from the largest cluster instead of a random point
      %TODO: match kmeans() singleton: Try the point with the highest error
   end
      
   centroids(k,:) = cm;
end



% =============================================================


end

