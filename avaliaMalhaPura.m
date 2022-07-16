function avaliaMalhaPura()
planta = obterPlanta();
controlador = projetarControlador(planta);

% Configurando as variaveis usadas no Simulink
assignin('base', 'controlador', controlador);
assignin('base', 'planta', planta);

assignin('base', 'controlador', controlador);
assignin('base', 'planta', planta);
outSaturadoSemAntiWindup = sim("cruizeController.slx");
%-------------------------------------------------------------------------%
planta.comandoNominal = inf;
assignin('base', 'controlador', controlador);
assignin('base', 'planta', planta);
outSemSaturacao = sim('cruizeController.slx');
%-------------------------------------------------------------------------%
%-------------------------------------------------------------------------%
%-------------------------------------------------------------------------%
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
% print -dpng -r400 comandos_sem_Antiwindup.png % para usuarios de Word
print -depsc2 comandos_sem_Antiwindup.eps % para usuarios de LaTeX
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
% print -dpng -r400 comando_sem_saturador.png % para usuarios de Word
print -depsc2 comando_sem_saturador.eps % para usuarios de LaTeX
hold off;
%-------------------------------------------------------------------------%
figure;
hold on;
plot(outSemSaturacao.ref.time, outSemSaturacao.ref.signals.values, 'LineWidth', 2);
plot(outSemSaturacao.Y.time, outSemSaturacao.Y.signals.values, 'LineWidth', 2);
plot(outSaturadoSemAntiWindup.Y.time, outSaturadoSemAntiWindup.Y.signals.values, 'LineWidth', 2);
title('Velocidade - Técnica BC2');
xlabel('Tempo (s)', 'FontSize', 14);
ylabel('Velocidade', 'FontSize', 14);
set(gca, 'FontSize', 14);
legend('Referência', 'Sem saturação', 'Saturação sem anti-windup');
grid on;
% print -dpng -r400 velocidade.png % para usuarios de Word
print -depsc2 velocidade.eps % para usuarios de LaTeX

end