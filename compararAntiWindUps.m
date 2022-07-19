function compararAntiWindUp()
%----------------------------------------------------------------------%
%
% Compara a evolução de velocidades para as diferentes técnicas de 
% anti-windup em um único gráfico.
%
%----------------------------------------------------------------------%
planta = obterPlanta();
controlador = projetarControlador(planta);


%-------------------------------------------------------------------------%
%Sem AntiWindup%
%-------------------------------------------------------------------------%
clampingON = 0;

assignin('base', 'controlador', controlador);
assignin('base', 'planta', planta);
assignin('base','clampingON',clampingON);
outSaturadoSemAntiWindup = sim("CI.slx");

%-------------------------------------------------------------------------%
planta.comandoNominal = 1e15;
assignin('base', 'controlador', controlador);
assignin('base', 'planta', planta);
outSemSaturacao = sim('CI.slx');
%-------------------------------------------------------------------------%



%-----------------------------%
% CI %
%-----------------------------%
clampingON = 1;

% Configurando as variaveis usadas no Simulink
planta = obterPlanta();
assignin('base', 'controlador', controlador);
assignin('base', 'planta', planta);
assignin('base','clampingON',clampingON);
outSaturadoComAntiWindupCI = sim("CI.slx");
%----------------------------------------------------%


%-----------------------------%
% BC1 %
%-----------------------------%
planta = obterPlanta();
controlador = projetarControlador(planta);

% Configurando as variaveis usadas no Simulink
assignin('base', 'controlador', controlador);
assignin('base', 'planta', planta);

outSaturadoComAntiWindupBC1 = sim("BC1.slx");



%-----------------------------%
% AS %
%-----------------------------%
planta = obterPlanta();
controlador = projetarControlador(planta);
Td = controlador.Kd/controlador.Kp;
Ti = controlador.Kp/controlador.Ki;
alpha = (1 + sqrt(1 - 4*Td/Ti))/2;
antiwindupON = 1;

% Configurando as variaveis usadas no Simulink
assignin('base', 'controlador', controlador);
assignin('base', 'planta', planta);
assignin('base', 'Td', Td);
assignin('base', 'Ti', Ti);
assignin('base', 'alpha', alpha);
assignin('base', 'antiwindupON', antiwindupON);

outSaturadoComAntiWindupAS = sim("AS.slx");

%-------------------------------------------------------------------------%
figure;
hold on;
plot(outSemSaturacao.ref.time, outSemSaturacao.ref.signals.values, 'LineWidth', 2, 'Color', 'black');
plot(outSemSaturacao.Y.time, outSemSaturacao.Y.signals.values, 'LineWidth', 2);
plot(outSaturadoSemAntiWindup.Y.time, outSaturadoSemAntiWindup.Y.signals.values, 'LineWidth', 2);
plot(outSaturadoComAntiWindupCI.Y.time, outSaturadoComAntiWindupCI.Y.signals.values, 'LineWidth', 2);
plot(outSaturadoComAntiWindupBC1.Y.time, outSaturadoComAntiWindupBC1.Y.signals.values, 'LineWidth', 2);
plot(outSaturadoComAntiWindupAS.Y.time, outSaturadoComAntiWindupAS.Y.signals.values, 'LineWidth', 2);

title('Comparação das técnicas');
xlabel('Tempo (s)', 'FontSize', 14);
ylabel('Velocidade', 'FontSize', 14);
set(gca, 'FontSize', 14);

legend('Referência', 'Sem saturação', 'Saturação sem anti-windup', 'CI','BC1', 'AS', 'Location', 'Southeast');
grid on;
% print -dpng -r400 velocidadeBC1.png % para usuarios de Word
print -depsc2 velocidadeComparacao.eps % para usuarios de LaTeX

end
