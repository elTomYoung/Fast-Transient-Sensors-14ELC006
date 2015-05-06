syms x
t2 = 0:1*10^-10:10*10^-9;
%%
rogowski_current = @(x,Rrt,Lr,Cb,Lb,Rb,Vo) exp((Rrt./Lr).*x).*(k.*(Vo./((1./sqrt(Lb.*Cb)).*Lb).*(((1./sqrt(Lb.*Cb)).*exp((-1.*(Rb./(2.*Lb)).*x)).*cos((1./sqrt(Lb.*Cb)).*x))+((-1.*(Rb./(2.*Lb))).*exp((-1.*(Rb./(2.*Lb)).*x)).*sin((1./sqrt(Lb.*Cb)).*x)))));
RIntegral = integral(@(x)rogowski_current(x,Rrt,Lr,Cb,Lb,Rb,Vo),0,10*10^-9);
rc = symfun((exp(-(Rrt./Lr).*x)./Lr).*RIntegral, [x]);
y = subs(diff(rc(x)),t2);