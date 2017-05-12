clear;
clf;
syms x a b c;
f = symfun(3*sin(2*x)+7, x)
%points = [-5,-4,-3,-2,-1,0,1,2,3,4,5];
%points = -5:1:5;
points = -5:1:5;
y=zeros(size(points,2),1);
for i=1:size(y,1)
    y(i) = double(f(points(i)));
end
fplot(f, 'Color', 'green')
hold on;
grid on;
scatter(points,y)


for i=1:size(points,2)
    func_mat(i) = a*sin(points(i)*b)+c-y(i);
end
r = symfun(func_mat, [a])
r([1,2,3])
% r = symfun([a*sin(points(1)*b)+c-y(1);
%             a*sin(points(2)*b)+c-y(2);
%             a*sin(points(3)*b)+c-y(3)], [a b c])
j = jacobian(r);
matf_r = matlabFunction(r);
matf_j = matlabFunction(j);
func_r = @(x) (matf_r(x(1),x(2),x(3)).');

func_j = @(x) (matf_j(x(1),x(2),x(3)));
%params = [2,1.5,6].'
params = [2,1.6,6].'

params
func_r(params)
func_j(params)

current_f = '';
for i=1:10
    params = gaussnewton(params,func_r,func_j,1)    
    %if mod(i,10) == 0
        norm(func_r(params))
        f_step = symfun(params(1)*sin(x*params(2))+params(3), x);
        delete(current_f);
        current_f = fplot(f_step, 'Color', 'red');
        drawnow;    
        pause(1);
    %end
end