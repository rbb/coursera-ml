%% Machine Learning Online Class
%  Exercise 7 | Principle Component Analysis and K-Means Clustering
%
%  Instructions
%  ------------
%
%  This file contains code that helps you get started on the
%  exercise. You will need to complete the following functions:
%
%     pca.m
%     projectData.m
%     recoverData.m
%     computeCentroids.m
%     findClosestCentroids.m
%     kMeansInitCentroids.m
%
%  For this exercise, you will not need to change any code in this file,
%  or any other files other than those mentioned above.
%

%% Initialization
clear ; %close all; clc

%% ============= Part 4: K-Means Clustering on Pixels ===============
%  In this exercise, you will use K-Means to compress an image. To do this,
%  you will first run K-Means on the colors of the pixels in the image and
%  then you will map each pixel onto its closest centroid.
%  
%  You should now complete the code in kMeansInitCentroids.m
%

fprintf('\nRunning K-Means clustering on pixels from an image.\n\n');

%  Load an image of a bird
A = double(imread('bird_small.png'));

% If imread does not work for you, you can try instead
%   load ('bird_small.mat');

A = A / 255; % Divide by 255 so that all values are in the range 0 - 1

% Size of the image
img_size = size(A);

% Reshape the image into an Nx3 matrix where N = number of pixels.
% Each row will contain the Red, Green and Blue pixel values
% This gives us our dataset matrix X that we will use K-Means on.
X = reshape(A, img_size(1) * img_size(2), 3);

% Run your K-Means algorithm on this data
% You should try different values of K and max_iters here
max_iters = 5;
a = imread('bird_small.png');
np = length(a(:));
Ks =[8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096];
Nruns = 3;
fractions = zeros(length(Ks), Nruns);
for nK = 1:length(Ks)
   K = Ks(nK)
   for nrun = 1:Nruns

      % When using K-Means, it is important the initialize the centroids
      % randomly. 
      % You should complete the code in kMeansInitCentroids.m before proceeding
      %{
      initial_centroids = kMeansInitCentroids(X, K);

      % Run K-Means
      [centroids, idx] = runkMeans(X, initial_centroids, max_iters, false);

      %fprintf('Program paused. Press enter to continue.\n');
      %pause;


      %% ================= Part 5: Image Compression ======================
      %  In this part of the exercise, you will use the clusters of K-Means to
      %  compress an image. To do this, we first find the closest clusters for
      %  each example. After that, we 

      fprintf('\nApplying K-Means(%d) to compress an image, run %d.\n\n', K, nrun);

      % Find closest cluster members
      idx = findClosestCentroids(X, centroids);
      %}

      fprintf('\nApplying K-Means(%d) to compress an image, run %d.\n\n', K, nrun);
      [idx, centroids, sumd, dist] = kmeans(X, K, "Start", "sample", "MaxIter",
      max_iters, "EmptyAction", "singleton");
      %[idx, centroids, sumd, dist] = kmeans(X, K, "MaxIter", max_iters);

      % Essentially, now we have represented the image X as in terms of the
      % indices in idx. 

      % We can now recover the image from the indices (idx) by mapping each pixel
      % (specified by its index in idx) to the centroid value
      X_recovered = centroids(idx,:);

      % Reshape the recovered image into proper dimensions
      X_recovered = reshape(X_recovered, img_size(1), img_size(2), 3);

      %figure(2);
      % Display the original image 
      %subplot(1, 2, 1);
      %imagesc(A); 
      %title('Original');

      % Display compressed image side by side
      %subplot(1, 2, 2);
      %imagesc(X_recovered)
      %title(sprintf('Compressed, with %d colors.', K));


      %fprintf('Program paused. Press enter to continue.\n');
      %pause;

      Xr_int = uint8(round(X_recovered .* 255.0));
      d = a -Xr_int;
      nd = sum(d(:) != 0)
      fraction = nd/np

      fractions(nK, nrun) = fraction;
   end
   %imwrite(Xr_int, sprintf('bird_small_out%d.png',K), "Compression", "none");
   %imwrite(uint8(round(X_recovered .* 255.0)), sprintf('bird_small_out%d.bmp',K), "Compression", "none");
end

save('fractions.mat', 'fractions', 'Ks');

am = uint32(a(:,1)).*uint32(a(:,2)).*uint32(a(:,3));
Xrm = uint32(Xr_int(:,1)).*uint32(Xr_int(:,2)).*uint32(Xr_int(:,3));

