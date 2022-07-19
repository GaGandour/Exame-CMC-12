function C = montarPID(controlador)
%----------------------------------------------------------------------%
%
% Monta uma função de transferência do tipo PID para o controlador 
% e a retorna.
% 
%----------------------------------------------------------------------%
s = tf('s');
Kp = controlador.Kp;
Ki = controlador.Ki;
Kd = controlador.Kd;
C = Kp + Ki/s + Kd*s;
end