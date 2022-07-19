% Arquivo utilizado apenas para testes

planta = obterPlanta();
controlador = projetarControlador(planta);
C = montarPID(controlador);
G = montarPlanta(planta);
Ga = G*C;
Gf = minreal(feedback(Ga,1));
step(Gf);