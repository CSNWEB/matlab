function [ c, ceq ] = regionConstraint( p, dk )
%REGIONCONSTRAINT Summary of this function goes here
%   Detailed explanation goes here
    c = norm(p)-dk;
    ceq = [];

end

