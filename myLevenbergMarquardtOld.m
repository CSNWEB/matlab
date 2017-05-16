function [ xk ] = myLevenbergMarquardt( R, g, jR, jG, xk, maxStep, radius, maxRadius)
%LEVENBERGMARQUARDT Summary of this function goes here
%   Detailed explanation goes here
     x = sym('x', size(xk));
%      jR = matlabFunction(jacobian(R(x)) , 'Vars', {x});
%      g = @(x) (0.5 * norm(R(x))^2);
%      jG = matlabFunction(jacobian(g(x)).', 'Vars', {x});
     
     for i=1:maxStep
         model = @(p) (g(xk)+jG(xk).'*p+0.5*p.'*jR(xk)'*jR(xk)*p);
         nonlin = @(p) (regionConstraint(p, radius));
         p = fmincon(model, zeros(size(xk)), [], [], [], [], [], [], nonlin)
         nextXk = xk + p
         roh = (g(xk)-g(nextXk))/(g(xk)-model(p))
         if roh < 0.25
            %nicht erfolgreich
         else
            xk = nextXk;
         end

         if roh < 0.25 
             radius = 0.25 * radius
         elseif roh > 0.75 && norm(p) == radius
             radius = min(2*radius, maxRadius)        
         end
     end      
end

