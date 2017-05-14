function [ result ] = paramedSinus( params )
%PARAMEDSINUS Calculate a*sin(b*x)+c  
%   
    result = params(:,2).*sin(params(:,3).*params(:,1))+params(:,4);
end

