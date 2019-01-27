function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%



%{
%steps = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];
%steps = [0.01, 1, 10];
steps = [0.03, 0.1, 0.3, 1, 3, 10];

merr = zeros(length(steps), length(steps));
merrval = zeros(length(steps), length(steps));
%models = zeros(length(steps), length(steps));
models = {};
for Cn = 1:length(steps)
   for Sn = 1:length(steps)
      C = steps(Cn);
      sigma = steps(Sn);
      model= svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma));

      pred = svmPredict(model,X);
      merr(Cn, Sn) = mean(double(pred ~= y));

      predval = svmPredict(model,Xval);
      merrval(Cn, Sn) = mean(double(predval ~= yval));

      models{Cn,Sn} = model;
   end
end

[Sv,Sin] = min(merrval)
[Cv,Cin] = min(Sv)

[v,ind]=min(merrval(:));
[min_row,min_col]=ind2sub(size(merrval),ind);
C = steps(min_row)
sigma = steps(min_col)
model = models{min_row, min_col};
%}
C = 1;
sigma = 0.1;



% =========================================================================

end
