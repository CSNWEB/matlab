clear;
clf;
close all;
P5
y = y*100
hold off;
scatter(x,y, 36, 'red')
hold on;
grid on;
n=size(x,1)
anz=5;
a = sym('a', [anz 3]);




func_mat = sym([]);
for i=1:n
    func_mat(i) = -y(i);
    for j=1:anz
        func_mat(i) = func_mat(i) + a(j,1)*exp(-0.5*((x(i)-a(j,2))/a(j,3))^2);
    end
    func_mat(i) = (func_mat(i))^2;
end
aVec = reshape(a, [1 numel(a)]);
r = symfun(func_mat.', aVec);
j = jacobian(r);
jFunc = makeVectorFunc(j);
rFunc = makeVectorFunc(r);
params = [0.03 0.02 0.03 0.02 0.011 630 615 697 552 577 10 31 151 30 12].';
params = [3 3 3 3 3 550 570 600 650 700 25 25 25 25 80].';
params = [0.08139 0.062464093417129 0.0613278652259899 0.05066 0.0490458751859601 630 621.5 638 577 608 4.52430291249564   6.60153662783602   7.78536915375689   14.3629568331098   10.1880036889133].';
%params = [8.139 6.2464093417129 6.13278652259899 5.066 4.90458751859601 630 621.5 638 577 608 4.52430291249564   6.60153662783602   7.78536915375689   14.3629568331098   10.1880036889133].';
%options = optimoptions(@lsqnonlin,'PlotFcn', {@optimplotx, @optimplotfval, @optimplotresnorm}, 'OutputFcn', @outfun);
params = lsqnonlin(rFunc, params, [-Inf -Inf -Inf -Inf -Inf -Inf -Inf -Inf -Inf -Inf -Inf 0 0 0 0 0], [])
norm(rFunc(params))
[X2, Y2] = gaussglocken(reshape(params, [anz 3]));
plot(X2,Y2)
%jFunc(params)
x = sym('x', size(params));
jR = matlabFunction(jacobian(rFunc(x)) , 'Vars', {x});
g = @(x) (0.5 * norm(rFunc(x))^2);

jG = matlabFunction(jacobian(g(x)).', 'Vars', {x});


%params = myLevenbergMarquardt2(rFunc, g, jR, jG, params, 100, 3, 50)
params = myLevenbergMarquardt(rFunc,g, jR, jG,params, 100, 3, 50)
params = gaussnewton(params,rFunc,jFunc)
[X2, Y2] = gaussglocken(reshape(params, [anz 3]));

plot(X2,Y2, 'blue')
r(params)
rFunc(params)
jFunc(params)
        

params = [1 0 0 0 600 0 0 0 1 1 1 1].';
[X2, Y2] = gaussglocken(reshape(params, [anz 3]));
plot(X2,Y2)



