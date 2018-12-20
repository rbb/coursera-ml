disp(' ')
disp('Question 1')
disp('----------')
A = [1 2; 3 4; 5 6]
B = [1 2 3; 4 5 6]

disp("A'+B")
A'+B
disp('B*A')
B*A
disp('A+B --> nonconformant arguments')
%A+B
disp("B'*A --> nonconformant arguments")
%B'*A


disp(' ')
disp('Question 2')
disp('----------')
clear
A = [ 16 2 3 13; 5 11 10 8; 9 7 6 12; 4 14 15 1]
B=A(:, 1:2)

disp('A(1:4, 1:2)')
A(1:4, 1:2)
disp('A(1:2, 1:4)')
A(1:2, 1:4)



disp(' ')
disp('Question 3')
disp('----------')
clear
A = magic(10)
x = rand(10,1)

v = zeros(10, 1);
for i = 1:10
  for j = 1:10
    v(i) = v(i) + A(i, j) * x(j);
  end
end
v

disp('A.*x')
A.*x

disp('A * x == v')
A * x == v
disp('Ax == v ---> Ax is not a variable')
%Ax == v
disp('A .* x == v')
A .* x == v
disp('sum (A * x) == v')
sum (A * x) == v

return

disp(' ')
disp('Question 4')
disp('----------')
clear
v = rand(7,1);
w = rand(7,1);

z = 0;
for i = 1:7
  z = z + v(i) * w(i);
end
z


disp('sum (v .* w) == z')
sum (v .* w) == z

disp("v' * w == z")
v' * w == z

disp("v * w' == z")
v * w' == z

disp('v .* w == z')
v .* w == z

return

disp(' ')
disp('Question 5')
disp('----------')

clear
X = rand(7,7)
for i = 1:7
  for j = 1:7
    A(i, j) = log(X(i, j));
    B(i, j) = X(i, j) ^ 2;
    C(i, j) = X(i, j) + 1;
    D(i, j) = X(i, j) / 4;
  end
end
size(A)
size(B)
size(C)
size(D)

disp('C == X + 1')
C == X + 1
disp('D == X / 4')
D == X / 4
disp('A == log (X)')
A == log (X)
disp('B == X ^ 2')
B == X ^ 2


