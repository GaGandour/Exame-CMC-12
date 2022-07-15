planta = obterPlanta();
controlador = projetarControlador(planta);
C = montarPID(controlador);
G = montarPlanta(planta);
Ga = G*C;
Gf1 = minreal(feedback(Ga,1));
F = projetarFiltro(controlador);
Gf = F*Gf1;
step(Gf);