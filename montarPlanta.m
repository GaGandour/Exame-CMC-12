function G = montarPlanta(planta)
s = tf('s');
m = planta.m;
b = planta.b;
G = 1/(m*s+b);
end