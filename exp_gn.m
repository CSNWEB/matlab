% Close all figures and clear workspace
close all;
clear;


rng default % for reproducibility
d = linspace(0,3);
y = exp(-1.3*d) + 0.05*randn(size(d));

fun = @(r)exp(-d*r)-y;


x0 = 4;
xFitted = lsqnonlin(fun,x0)


plot(d,y,'ko',d,exp(-xFitted*d),'b-')
legend('Data','Best fit')
xlabel('t')
ylabel('exp(-tx)')

hold on;

pause()

% Create residual matrix with parameters a, b and c
% model: rMatrix(i) = a*sin(b*x(i))+c-y(i)
syms x;
rMatrix = fun(x).';

% Get a vetor matlab function based on rMatrix and its jacobian
r = matlabFunction(rMatrix);
j = matlabFunction(jacobian(rMatrix));

% hold off;
% x=-2:0.01:4
% y = zeros(1,length(x))
% for i=1:length(x)
%     y(i) = norm(r(x(i)))
% end
% plot(x,y)
% hold on;
% 

xFitted = x0;
%init function
current_f='';
%Iterate GN and plot current approximation
for i=1:12
    xFitted= gaussnewton(xFitted,r,j,1)      
    %scatter(xFitted, norm(r(xFitted)))
    f_step = @(d) exp(-xFitted*d)
    delete(current_f);    
    current_f = fplot(f_step, [0 3],'Color', 'red');
    drawnow;    
    pause(0.2);
end