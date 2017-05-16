function [ xk ] = myLevenbergMarquardt( R, g, jR, jG, xk, maxStep, radius, maxRadius,outfun)
     syms l;
     TOL = 10e-8;
     outfun(xk, struct('iteration',0,'resnorm',0), 'init');
     for i=1:maxStep
         model = @(p) (g(xk)+jG(xk).'*p+0.5*p.'*jR(xk)'*jR(xk)*p);
         % Case lambda = 0
         p = -1*(jR(xk).' * jR(xk)) \ jG(xk);
         if norm(p) > radius
            % Step goes out of TrustRegion --> change direction to stay in
            % Create function for norm of direction p based on lambda minus radius
            pL = @(l) (norm((jR(xk).' * jR(xk) + l * eye(size(jR(xk),2))) \ (-1*jG(xk)))^2-radius);            
            % and its jacobian
            jacpL = jacobian(pL(l));            
            jpL = symfun (jacpL, [l]);  %symbolic jacobian very precise but slow
            % minimize pL to get optimal lambda
            lambda = gaussnewton(0.1, pL, jpL,1000);
            % calculate p based on lambda
            p = (jR(xk).' * jR(xk) + lambda * eye(size(jR(xk),2))) \ (-1*jG(xk));
         end
         
         % calculate preliminary next params
         nextXk = xk + p;
         
         % shold the algorithm stop?
         if abs(g(nextXk)-g(xk)) <= TOL * (1+g(nextXk)^2) || ...
            norm(nextXk-xk) <= sqrt(TOL) * (1+norm(nextXk)) 
            break;
         end
    
         
         % how precise is the model?
         roh = abs(g(xk)-g(nextXk))/(g(xk)-model(p));                 
         
         if roh >= 0.25
            % step successful set new xk
            xk = nextXk;
         end         
         if roh < 0.25 
             % bad approximation --> smaller trust region
             radius = 0.25 * radius;
         elseif roh > 0.75
             % good approximation --> larger trust region
             radius = min(2*radius, maxRadius);
         end
                  
         
         outfun(xk, struct('iteration',i,'resnorm',norm(R(xk))), 'iter');
     end
     outfun(xk, struct('iteration',i,'resnorm',norm(R(xk))), 'done');
end

