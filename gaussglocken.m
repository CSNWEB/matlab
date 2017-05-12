function [ X,Y] = gaussglocken( params )
%GAUSSGLOCKEN Summary of this function goes here
%   Detailed explanation goes here
    X=(560:0.8:700).';
    Y=zeros(size(X,1), 1);    
    for index = 1:size(X,1)
            for i=1:size(params,1) 
                    Y(index) = Y(index) + params(i,1)*exp(-0.5*((X(index)-params(i,2))/params(i,3))^2);
            end
    end
end
