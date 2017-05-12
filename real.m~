clear;
clf;
P5
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
params = [0.03 0.02 0.03 0.02  0.011 630 615 697 552 577 10 31 151 30 12].';
% params = [0.03 0.03y 0.03 0.03 0.03 550 570 600 650 700 25 25 25 25 80].';
params = lsqnonlin(rFunc, params)
[X2, Y2] = gaussglocken(reshape(params, [anz 3]));
plot(X2,Y2)
%jFunc(params)
params = gaussnewton(params,rFunc,jFunc,1)
[X2, Y2] = gaussglocken(reshape(params, [anz 3]));
plot(X2,Y2, 'blue')
r(params)
rFunc(params)
jFunc(params)
        

params = [1 0 0 0 600 0 0 0 1 1 1 1].';
[X2, Y2] = gaussglocken(reshape(params, [anz 3]));
plot(X2,Y2)



