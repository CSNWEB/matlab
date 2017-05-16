lambda = 0.01
g = @(x) ((0.5 * norm(x))^2)

gJ = matlabFunction(jacobian(g([a;b;c])).', 'Vars', {[a;b;c]})

p = inv(j(params).'*j(params) + lambda * eye(3))*-1*gJ(params)
newParams = params + p 
if(r(newParams) < r(params))
    params = newParams
    lambda = 0.1 * lambda
else
    lambda = 10 * lambda
end
