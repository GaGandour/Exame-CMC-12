function avaliaAS()
%----------------------------------------------------------------------%
%
% Simula a técnica Anti-Reset (AS) e traça os gráficos.
% Os gráficos são os gráficos de comandos e de evolução de velocidade.
%
%----------------------------------------------------------------------%
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
outSaturadoComAntiWindup = sim("AS.slx");

%-------------------------------------------------------------------------%

antiwindupON = 0;
assignin('base', 'antiwindupON', antiwindupON);
outSaturadoSemAntiWindup = sim("AS.slx");

%-------------------------------------------------------------------------%
planta.comandoNominal = 1e15;
% assignin('base', 'controlador', controlador);
assignin('base', 'planta', planta);
outSemSaturacao = sim('AS.slx');
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
%print -dpng -r400 comandos_com_AntiwindupBC1.png % para usuarios de Word
print -depsc2 comandos_com_AntiwindupAS.eps % para usuarios de LaTeX
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
% print -dpng -r400 comandos_sem_AntiwindupBC1.png % para usuarios de Word
print -depsc2 comandos_sem_AntiwindupAS.eps % para usuarios de LaTeX
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
% print -dpng -r400 comando_sem_saturadorBC1.png % para usuarios de Word
print -depsc2 comando_sem_saturadorAS.eps % para usuarios de LaTeX
hold off;
%-------------------------------------------------------------------------%
figure;
hold on;
plot(outSemSaturacao.ref.time, outSemSaturacao.ref.signals.values, 'LineWidth', 2);
plot(outSemSaturacao.Y.time, outSemSaturacao.Y.signals.values, 'LineWidth', 2);
plot(outSaturadoSemAntiWindup.Y.time, outSaturadoSemAntiWindup.Y.signals.values, 'LineWidth', 2);
plot(outSaturadoComAntiWindup.Y.time, outSaturadoComAntiWindup.Y.signals.values, 'LineWidth', 2);
title('Velocidade - Técnica AS');
xlabel('Tempo (s)', 'FontSize', 14);
ylabel('Velocidade', 'FontSize', 14);
set(gca, 'FontSize', 14);
legend('Referência', 'Sem saturação', 'Saturação sem anti-windup', 'Com anti-windup')
%legend('Referência', 'Sem saturação', 'Com anti-windup')
grid on;
% print -dpng -r400 velocidadeBC1.png % para usuarios de Word
print -depsc2 velocidadeAS.eps % para usuarios de LaTeX
hold off;

end