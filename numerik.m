syms x a b c;
f = symfun(4*x^2+11*x-8, x)
points = [-4,3,5];
y=zeros(3,1);
for i=1:size(y,1)
    y(i) = double(f(points(i)));
end
fplot(f)
hold on;
scatter(points,y)
for i=1:size(points,2)
    func_mat(i) = a*points(i)^2+b*points(i)+c-y(1);
end
r = symfun(func_mat, [a b c])
j = jacobian(r);
matf_r = matlabFunction(r);
matf_j = matlabFunction(j);
func_r = @(x) (matf_r(x(1),x(2),x(3)));
func_j = @(x) (matf_j(x(1),x(2),x(3)));


params = gaussnewton([0.2,-80,40].',func_r,func_j,1)
f_step = symfun(params(1)*x^2+params(2)*x+params(3), x)    
current_f = fplot(f_step)
drawnow;
pause(1);
for i=1:3
    params = gaussnewton(params,func_r,func_j,1)
    f_step = symfun(params(1)*x^2+params(2)*x+params(3), x);
    delete(current_f);
    current_f = fplot(f_step);
    drawnow;
    pause(1);
end








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
result = gaussnewton([-1.9,62],f,j,1050)
f(result)


