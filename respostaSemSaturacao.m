function respostaSemSaturacao()
planta = obterPlanta();
controlador = projetarControlador(planta);
% controlador.Tt_inv = 0;

% Configurando as variaveis usadas no Simulink
assignin('base', 'controlador', controlador);
assignin('base', 'planta', planta);

out = sim('BC1.slx');

figure;
hold on;

plot(out.comando.time, out.comando.signals.values, 'LineWidth', 2);

plot(out.comandosaturado.time, out.comandosaturado.signals.values, 'LineWidth', 2);

xlabel('Tempo (s)', 'FontSize', 14);
ylabel('Comando', 'FontSize', 14);
set(gca, 'FontSize', 14);
legend('Comando', 'Comando Saturado');
grid on;
print -dpng -r400 comando.png % para usuarios de Word
% print -depsc2 degrau_thetal.eps % para usuarios de LaTeX
hold off;

figure;
plot(out.Y.time, out.Y.signals.values, 'LineWidth', 2);
xlabel('Tempo (s)', 'FontSize', 14);
ylabel('Velocidade', 'FontSize', 14);
set(gca, 'FontSize', 14);
%legend('Velocidade')
grid on;
print -dpng -r400 degrau_thetam.png % para usuarios de Word
% print -depsc2 degrau_thetam.eps % para usuarios de LaTeX

end