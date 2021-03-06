function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
%theta = nn_params;

XpBias = [ones(m, 1) X];
z2 = XpBias*Theta1'; % 5000x401 * (25x401)' = 5kx25
a2 = sigmoid(z2);
a2pBias = [ones(m, 1) a2];
z3 = a2pBias*Theta2';
h = sigmoid(z3);

yn = zeros(m, num_labels); % 10*5000
for i=1:m,
  yn(i, y(i))=1;
end
J = sum ( sum ( -yn .* log(h) - (1-yn) .* log(1-h) )) ./m;
Jreg = lambda * (sum(sum(Theta1(:,2:end).^2)) + sum(sum(Theta2(:,2:end).^2))) /2/m;
J = J + Jreg;

% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
delta3 = zeros(m,num_labels);
delta2 = zeros(m,hidden_layer_size);
%dispv("h", h);
%dispv("y", y);
%dispv("a2", a2);
%dispv("h(1,:)", h(1,:));
%dispv("delta3", delta3);
%dispv("a2pBias", a2pBias);
%dispv("Theta1", Theta1);
%dispv("Theta2", Theta2);
%dispv("Theta2_grad", Theta2_grad);
%dispv("z2", z2);           %5000 x 25
z2pBias = [ones(m,1) z2];
for t=1:m
   a3 = h(t,:);

   yk = zeros(1,num_labels);
   yk(y(t)) = 1;

   dt3 = a3 - yk;      % a3 = h
   delta3(t,:) = dt3;
   %      (10x26)'*(1x10)'                   1x26
   dt2pBias = ( (Theta2' *dt3') .* sigmoidGradient(z2pBias(t,:)') )';
   dt2 = dt2pBias(2:end);
   delta2(t,:) = dt2;
   
   %                           (1x10)'*1x26
   Theta2_grad = Theta2_grad + dt3' * a2pBias(t,:);
   Theta1_grad = Theta1_grad + dt2' * XpBias(t,:);
end
Theta2_grad /= m;
Theta1_grad /= m;

%dispv("Theta2_grad", Theta2_grad);
%dispv("Theta1_grad", Theta1_grad);

%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

Theta1_grad(:, 2:end) += ((lambda/m) * Theta1(:, 2:end));
Theta2_grad(:, 2:end) += ((lambda/m) * Theta2(:, 2:end));


% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
