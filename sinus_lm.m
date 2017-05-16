% Close all figures and clear workspace
close all;
clear;

% Create 3*sin(2*x)+7 and plot it
syms x;
f = matlabFunction(paramedSinus([x,3,2,7]));


% Generate evaluation points which will be used fit the curve
points = (-3:0.2:3).';
n = length(points)

% Evaluate f at generated points 
values = double(f(points));

% Create residual matrix with parameters a, b and c
% model: rMatrix(i) = a*sin(b*x(i))+c-y(i)
syms a b c;
rMatrix = paramedSinus([points, a*ones(n,1), b*ones(n,1), c-values]);

% Get a matlab e.g. non symbolic function for more speed
r = matlabFunction(rMatrix, 'Vars', {[a;b;c]});

x = sym('x', [3 1]);
% Calculate jacobian and convert it into a matlab function as well
jR = matlabFunction(jacobian(r(x)) , 'Vars', {x});

% Same for g = ||f||_2^2
g = @(x) (0.5 * norm(r(x))^2);
jG = matlabFunction(jacobian(g(x)).', 'Vars', {x});

% set start parameter
params = [1;1;0]
outfun = @(params, optimValues, state) (sinusOut(params, optimValues, state, points));
params = myLevenbergMarquardt(r,g,jR,jG, params, 10, 0.1, 10,outfun)

pause()


% Close all figures and clear workspace
close all;
clear;

% Create 3*sin(2*x)+7 and plot it
syms x;
f = matlabFunction(paramedSinus([x,3,2,7]));
%fp =  fplot(f, 'Color', 'green')
% hold on;
% grid on;

% Generate evaluation points which will be used fit the curve
points = (-3:1:3).';
n = length(points)

% Evaluate f at generated points 
values = double(f(points));

% plot generated points
%scatter(points,values);

% Create residual matrix with parameters a, b and c
% model: rMatrix(i) = a*sin(b*x(i))+c-y(i)
syms a b c;
rMatrix = paramedSinus([points, a*ones(n,1), b*ones(n,1), c-values]);

% Get a matlab e.g. non symbolic function for more speed
r = matlabFunction(rMatrix, 'Vars', {[a;b;c]});

x = sym('x', [3 1]);
% Calculate jacobian and convert it into a matlab function as well
jR = matlabFunction(jacobian(r(x)) , 'Vars', {x});

% Same for g = ||f||_2^2
g = @(x) (0.5 * norm(r(x))^2);
jG = matlabFunction(jacobian(g(x)).', 'Vars', {x});

% set start parameter
params = [1;1;0]
outfun = @(params, optimValues, state) (sinusOut(params, optimValues, state, points));
params = myLevenbergMarquardt(r,g,jR,jG, params, 10, 0.1, 10,outfun)

