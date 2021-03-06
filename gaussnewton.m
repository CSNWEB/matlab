function  [x, i] = gaussnewton(x, fun, jacobian, maxSteps, outfun )
 TOL = 10e-8;
 if nargin > 4
    outfun(x, struct('iteration',0,'resnorm',0), 'init');
 end
 for i = 1:maxSteps
    xNew = double(x - inv(jacobian(x).' * jacobian(x)) * jacobian(x).' * fun(x));
    
    if abs(norm(fun(xNew))^2-norm(fun(x))^2) <= TOL * (1+norm(fun(xNew))^2) || ...
        norm(xNew-x) <= sqrt(TOL) * (1+norm(xNew)) 
        break;
    end
    
    x = xNew;
    
    if nargin > 4
        outfun(x, struct('iteration',i,'resnorm',norm(fun(x))), 'iter');
    end
 end
 
 if nargin > 4
    outfun(x, struct('iteration',i,'resnorm',norm(fun(x))), 'done');
 end
end

