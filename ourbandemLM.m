OPTIONS=optimset('LargeScale','off','OutputFcn',@bandemOutFcn);
      OPTIONS = optimset(OPTIONS,'Algorithm','levenberg-marquardt','MaxFunEvals',200, ...
          'Jacobian','on','ScaleProblem','jacobian');
      JAC='[-20*x(1), 10; -1, 0]';
      f='[10*(x(2)-x(1)^2),(1-x(1))]';
      str2='[x,resnorm,residual,exitflag,output]= lsqnonlin({f,JAC},x,[],[],OPTIONS);';
      [x,resnorm,residual,exitflag,output]= lsqnonlin({f,JAC},x,[],[],OPTIONS);
      fval = resnorm;
   funEvals=sprintf(' Number of iterations: %g.  Number of function evaluations: %g.', output.iterations, output.funcCount);
   
 
r = @(x) ([10*(x(2)-x(1)^2);(1-x(1))]);
g = @(x) (0.5 * norm(r(x))^2);
jR = @(x) ([-20*x(1), 10; -1, 0]);
b = sym('b', [2 1])
jR2 = matlabFunction(jacobian(r(b)), 'Vars', {b})
jG = matlabFunction(jacobian(g(b)).', 'Vars', {b})
params = [-1.9, 2].'
jR(params)
jR2(params)
jR2([1;1])
r(params)

jG(params)
paramsOut = myLevenbergMarquardt2(r,g,jR2,jG, params, 25, 1, 10)