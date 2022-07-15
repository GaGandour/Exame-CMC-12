function C = montarPID(controlador)
s = tf('s');
Kp = controlador.Kp;
Ki = controlador.Ki;
Kd = controlador.Kd;
C = Kp + Ki/s + Kd*s;
end