function [ stop ] = sinusOut( params ,optimValues,state, points )
   stop = false;   
   switch state
       case 'init'
             figure('units','normalized','outerposition',[0 0 1 1])
             subplot(2,2,[3 4]);
             syms x;
             f = matlabFunction(paramedSinus([x,3,2,7]));
             fplot(f, 'Color', 'green');
             legend('show')
             xlabel('x')
             ylabel('y')
             title('Ursprüngliche Funktion und derzeitige Aproximation')
             hold on;
             values = f(points);
             scatter(points,values, 'DisplayName', 'Messungen');             
             pause()
       case 'iter'
             pause(0.2)
             subplot(2,2,1)
             bar(params)
             title('Parameterwerte')
             ylabel('Parameterwert')
             xlabel('Parameternummer')
             subplot(2,2,2)
             scatter(optimValues.iteration, optimValues.resnorm)
             title('Norm der Residuen')
             xlabel('Iteration')
             ylabel('Norm des Residuums')
             hold on;
             subplot(2,2,[3 4])
             syms x;
             f_step = paramedSinus([x,params.']);
             colors = hot(15);
             fplot(f_step, 'DisplayName',string(optimValues.iteration), 'Color', colors(optimValues.iteration,:));
             hold on;
             pause(0.2)
       case 'done'
             hold off
       otherwise
   end
end

