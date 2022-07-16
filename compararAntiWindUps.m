function compararAntiWindUp()
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

%IMPLEMENTAR PRO SEU CASO MM

%-------------------------------------------------------------------------%
figure;
hold on;
plot(outSemSaturacao.ref.time, outSemSaturacao.ref.signals.values, 'LineWidth', 2);
plot(outSemSaturacao.Y.time, outSemSaturacao.Y.signals.values, 'LineWidth', 2);
plot(outSaturadoSemAntiWindup.Y.time, outSaturadoSemAntiWindup.Y.signals.values, 'LineWidth', 2);
plot(outSaturadoComAntiWindupCI.Y.time, outSaturadoComAntiWindupCI.Y.signals.values, 'LineWidth', 2);
plot(outSaturadoComAntiWindupBC1.Y.time, outSaturadoComAntiWindupBC1.Y.signals.values, 'LineWidth', 2);
%ADICIONAR UMA LINHA AQUI PARA PLOTAR O SEU MM

title('Velocidade - Técnica BC1');
xlabel('Tempo (s)', 'FontSize', 14);
ylabel('Velocidade', 'FontSize', 14);
set(gca, 'FontSize', 14);

%ADICIONAR MAIS UMA LEGENDA ABAIXO

legend('Referência', 'Sem saturação', 'Saturação sem anti-windup', 'CI','BC1')
grid on;
% print -dpng -r400 velocidadeBC1.png % para usuarios de Word
print -depsc2 velocidadeComparacao.eps % para usuarios de LaTeX

end
