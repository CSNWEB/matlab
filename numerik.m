syms x;
f = symfun([x+1;0.5*x^2+x-1], x);
j = jacobian(f);
f = matlabFunction(f);
j = matlabFunction(j);
result = gaussnewton(1,f,j)
%f = symfun(100*(x2-x1^2)^2 + (1-x1)^2, [x1, x2]);
f = @(x) 100*(x(2)-x(1)^2)^2+(1-x(1))^2
%j = jacobian(f);
%f = @(x) matlabFunction(f,x(1),x(2));
%f([1,2])
%j = matlabFunction(j);
j = @(x) [ 2*x(1) - 400*x(1)*(- x(1)^2 + x(2)) - 2; - 200*x(1)^2 + 200*x(2)]
result = j([1.9,2])
result = gaussnewton([-1.9,2],f,j,1050)
f(result)