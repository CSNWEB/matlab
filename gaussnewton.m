function  [result] = gaussnewton(x, fun, jacobian, steps )
 if nargin < 4
     steps = 100;
 end
 for i = 1:steps
    x = double(x - inv(jacobian(x).' * jacobian(x)) * jacobian(x).' * fun(x));
 end
 result = x;
end

