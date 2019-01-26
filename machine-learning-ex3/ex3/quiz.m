a2 = zeros(3,1);
Theta1 = rand(3,3);
x = rand(3,1);
for i = 1:3
   for j =1:3
      a2(i) = a2(i) + x(j) * Theta1(i,j);
   end
   a2(i) = sigmoid( a2(i) );
end

a2

a2v1 = sigmoid(Theta1*x)
