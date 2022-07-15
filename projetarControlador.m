function controlador = projetarControlador(planta)
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