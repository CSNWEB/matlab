% Close all figures and clear workspace
close all;
clear;

% Create 3*sin(2*x)+7 and plot it
syms x;
f = matlabFunction(paramedSinus([x,3,2,7]));
% fplot(f, 'Color', 'green')
% hold on;
% grid on;

% Generate evaluation points which will be used fit the curve
points = (-3:0.2:3).';
n = length(points)

% Evaluate f at generated points 
values = double(f(points));

% plot generated points
%scatter(points,values);

% Create residual matrix with parameters a, b and c
% model: rMatrix(i) = a*sin(b*x(i))+c-y(i)
syms a b c;
rMatrix = paramedSinus([points, a*ones(n,1), b*ones(n,1), c-values]);

% Get a vetor matlab function based on rMatrix and its jacobian
r = matlabFunction(rMatrix, 'Vars', {[a;b;c]});
j = matlabFunction(jacobian(rMatrix), 'Vars', {[a;b;c]});


% set start parameters
params = [1;1;0]

% options = optimoptions(@lsqnonlin, 'OutputFcn', @sinusOut);
% paramsOut = lsqnonlin(r, params, [], [], options)

%Iterate GN and plot current approximation
outfun = @(params, optimValues, state) (sinusOut(params, optimValues, state, points));
params = gaussnewton(params,r,j,100,outfun)

pause()
clear;

% Create 3*sin(2*x)+7 and plot it
syms x;
f = matlabFunction(paramedSinus([x,3,2,7]));

% Generate evaluation points which will be used fit the curve
points = (-3:1:3).';
n = length(points)

% Evaluate f at generated points 
values = double(f(points));

% Create residual matrix with parameters a, b and c
% model: rMatrix(i) = a*sin(b*x(i))+c-y(i)
syms a b c;
rMatrix = paramedSinus([points, a*ones(n,1), b*ones(n,1), c-values]);

% Get a vetor matlab function based on rMatrix and its jacobian
r = matlabFunction(rMatrix, 'Vars', {[a;b;c]});
j = matlabFunction(jacobian(rMatrix), 'Vars', {[a;b;c]});


% set start parameters
params = [1;1;0]


%Iterate GN xand plot current approximation
outfun = @(params, optimValues, state) (sinusOut(params, optimValues, state, points));
params = gaussnewton(params,r,j,100,outfun)      
pause()
close all;
f_step = paramedSinus([x,params.']);
fplot(f_step);

