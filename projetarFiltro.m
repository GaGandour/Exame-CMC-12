function F = projetarFiltro (controlador)
Kp = controlador.Kp;
Ki = controlador.Ki;
Kd = controlador.Kd;
s = tf('s');
F = Ki/(Kd*s^2 + Kp*s + Ki);
end