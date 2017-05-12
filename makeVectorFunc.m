function [ vectorFunc ] = makeVectorFunc( func, argCount )
%MAKEVECTORFUNC Summary of this function goes here
%   Detailed explanation goes here
    matFunc = matlabFunction(func);
    params = symvar(func);  
    for i=1:size(params,2)
        args(i) =  strcat('x(', string(i), ')');
    end
    vectorFunc =  eval(strcat('@(x) (matFunc(',join(args,','),'));'));
end

