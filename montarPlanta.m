function G = montarPlanta(planta)
%----------------------------------------------------------------------%
%
% Monta uma função de transferência para a planta e a retorna.
% 
%----------------------------------------------------------------------%
s = tf('s');
m = planta.m;
b = planta.b;
G = 1/(m*s+b);
end