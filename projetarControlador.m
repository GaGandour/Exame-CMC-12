function controlador = projetarControlador(planta)
%----------------------------------------------------------------------%
%
% Projeta um controlador PID com base na planta.
% A conta supõe que a malha resulta em um sistema de segunda ordem, o
% que NÃO é verdade na ausência de um pré-filtro.
% 
% Essa conta foi feita apenas para gerar um resultado fácil de visualizar
% no gráfico e que fizesse sentido.
% 
%----------------------------------------------------------------------%
m = planta.m;
b = planta.b;

wn = 2;
xi = 0.7;

Kd = 0.4;
Ki = wn^2*(m+Kd);
Kp = 2*xi*wn*(m+Kd) - b;

Ti = Kp/Ki;
Td = Kd/Kp;
Tt = sqrt(Ti*Td);

controlador.Kp = Kp;
controlador.Ki = Ki;
controlador.Kd = Kd;
controlador.Ti = Ti;
controlador.Td = Td;
controlador.Tt = Tt;
controlador.Tt_inv = 1/Tt;
end