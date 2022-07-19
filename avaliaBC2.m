function avaliaBC2()
%----------------------------------------------------------------------%
%
% Simula a técnica Back-Calculation2 (BC2) e traça os gráficos.
% Os gráficos são os gráficos de comandos e de evolução de velocidade.
%
%----------------------------------------------------------------------%
planta = obterPlanta();
controlador = projetarControladorPI(planta);

% Configurando as variaveis usadas no Simulink
assignin('base', 'controlador', controlador);
assignin('base', 'planta', planta);

outSaturadoComAntiWindup = sim("BC1.slx"); % o diagrama de blocos é o mesmo do BC1.
%-------------------------------------------------------------------------%
controlador.Tt_inv = 0;

assignin('base', 'controlador', controlador);
assignin('base', 'planta', planta);
outSaturadoSemAntiWindup = sim("BC1.slx");
%-------------------------------------------------------------------------%
planta.comandoNominal = 1e15;
assignin('base', 'controlador', controlador);
assignin('base', 'planta', planta);
outSemSaturacao = sim('BC1.slx');
%-------------------------------------------------------------------------%
%-------------------------------------------------------------------------%
%-------------------------------------------------------------------------%
figure;
hold on;
plot(outSaturadoComAntiWindup.comando.time, outSaturadoComAntiWindup.comando.signals.values, 'LineWidth', 2);
plot(outSaturadoComAntiWindup.comandosaturado.time, outSaturadoComAntiWindup.comandosaturado.signals.values, 'LineWidth', 2);
ylim([-500 3000]);

xlabel('Tempo (s)', 'FontSize', 14);
ylabel('Comando', 'FontSize', 14);
set(gca, 'FontSize', 14);
legend('Comando', 'Comando Saturado');
grid on;
title('Comando Vs Comando Saturado (Com Anti-Windup)');
%print -dpng -r400 comandos_com_AntiwindupBC2.png % para usuarios de Word
print -depsc2 comandos_com_AntiwindupBC2.eps % para usuarios de LaTeX
hold off;
%-------------------------------------------------------------------------%
figure;
hold on;
plot(outSaturadoSemAntiWindup.comando.time, outSaturadoSemAntiWindup.comando.signals.values, 'LineWidth', 2);
plot(outSaturadoSemAntiWindup.comandosaturado.time, outSaturadoSemAntiWindup.comandosaturado.signals.values, 'LineWidth', 2);
ylim([-500 3000]);

xlabel('Tempo (s)', 'FontSize', 14);
ylabel('Comando', 'FontSize', 14);
set(gca, 'FontSize', 14);
legend('Comando', 'Comando Saturado');
grid on;
title('Comando Vs Comando Saturado (Sem Anti-Windup)');
% print -dpng -r400 comandos_sem_AntiwindupBC2.png % para usuarios de Word
print -depsc2 comandos_sem_AntiwindupBC2.eps % para usuarios de LaTeX
hold off;
%-------------------------------------------------------------------------%
figure;
hold on;
plot(outSemSaturacao.comando.time, outSemSaturacao.comando.signals.values, 'LineWidth', 2);
plot(outSemSaturacao.comandosaturado.time, outSemSaturacao.comandosaturado.signals.values, 'LineWidth', 2);
ylim([-500 3000]);

xlabel('Tempo (s)', 'FontSize', 14);
ylabel('Comando', 'FontSize', 14);
set(gca, 'FontSize', 14);
grid on;
title('Comando (Sem Saturador)');
% print -dpng -r400 comando_sem_saturadorBC2.png % para usuarios de Word
print -depsc2 comando_sem_saturadorBC2.eps % para usuarios de LaTeX
hold off;
%-------------------------------------------------------------------------%
figure;
hold on;
plot(outSemSaturacao.ref.time, outSemSaturacao.ref.signals.values, 'LineWidth', 2);
plot(outSemSaturacao.Y.time, outSemSaturacao.Y.signals.values, 'LineWidth', 2);
plot(outSaturadoSemAntiWindup.Y.time, outSaturadoSemAntiWindup.Y.signals.values, 'LineWidth', 2);
plot(outSaturadoComAntiWindup.Y.time, outSaturadoComAntiWindup.Y.signals.values, 'LineWidth', 2);
title('Velocidade - Técnica BC2');
xlabel('Tempo (s)', 'FontSize', 14);
ylabel('Velocidade', 'FontSize', 14);
set(gca, 'FontSize', 14);
legend('Referência', 'Sem saturação', 'Saturação sem anti-windup', 'Com anti-windup')
grid on;
% print -dpng -r400 velocidadeBC2.png % para usuarios de Word
print -depsc2 velocidadeBC2.eps % para usuarios de LaTeX

end