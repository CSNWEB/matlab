function fs=fstrich(F,x)
%
% x: Argument für F'(x)
%
% fs: Differenzenapproximation von F'(x)
%
fw=feval(F,x); n=length(fw);
fs=zeros(n);
he=1e-8;
for j=1:n
    h=(abs(x(j))+1e-3)*he; 
    xx=x; xx(j)=xx(j)+h;
        fx=feval(F,xx);
    fs(:,j)=(fx-fw)/h;    
end