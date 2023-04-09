function plota_figura_unica(eixox, eixoy, tipo, nova_ou_sobrepor,...
    legenda, titulo, label_eixox, label_eixoy, x_ticks, y_ticks, ...
    limite_x1, limite_x2, limite_y1, limite_y2,...
    salvar, nome_do_arquivo, tipo_legenda, tipo_fonte, tamanho_fonte)
%Desenvolvida por Thiago Glissoi Lopes
%Laboratório de Aquisição de Dados e Processamento Digital de Sinais(LADAPS)
%FEB - UNESP - Bauru
%08/2019 - update 05/2020 - update 09/2020
%
%plota_figura_unica(eixox, eixoy, tipo, nova_ou_sobrepor,...
%    legenda, titulo, label_eixox, label_eixoy, x_ticks,...
%    y_ticks, limite_x1, limite_x2, limite_y1, limite_y2,...
%    salvar, nome_do_arquivo, tipo_legenda)
%
% - % - % - tipo - % - % - :
%1 = normal; 2 = bar; 3 = stem;
% - % - % - nova_ou_sobrepor - % - % - :
%1 = figura nova; 2 = sobrepor figura atual;
% - % - % - legenda - % - % - :
%lengenda para a figura. Escrever da seguinte maneira: 'exemplo';
% - % - % - titulo - % - % - :
%titulo para a figura. Escrever da seguinte maneira: 'exemplo';
% - % - % - label_eixox - % - % - :
%Label para o eixo X da figura. Escrever da seguinte maneira: 'exemplo';
% - % - % - label_eixoy - % - % - :
%Label para o eixo Y da figura. Escrever da seguinte maneira: 'exemplo';
% - % - % - x_ticks - % - % - :
%'ticks' usados no eixo X da figura. Escrever da seguinte maneira:...
%[0 10 30 50];
% - % - % - y_ticks - % - % - :
%'ticks' usados no eixo Y da figura. Escrever da seguinte maneira:...
%[0 10 30 50];
% - % - % - limite_x1 - % - % - :
%Limite inferior a ser aplicado no eixo X da figura;
% - % - % - limite_x2 - % - % - :
%Limite superior a ser aplicado no eixo X da figura;
% - % - % - limite_y1 - % - % - :
%Limite inferior a ser aplicado no eixo Y da figura;
% - % - % - limite_y2 - % - % - :
%Limite superior a ser aplicado no eixo Y da figura;
% - % - % - salvar - % - % - :
% 0 = salvar tiff; 1 = salvar fig e tiff; 2 = não salvar;
% - % - % - nome_do_arquivo - % - % - :
%Nome que será utilizado para salvar o .fig e o .tiff da figura.
%Escrever da seguinte maneira: 'exemplo';
% - % - % - tipo_legenda - % - % - :
%Localização da legenda na figura
%1 = Melhor localização automática; 2 = Canto superior direito;
%3 = Canto superior esquerdo; 4 = Canto inferior esquerdo;
%5 = Canto inferior direito
% - % - % - tipo_fonte - % - % - :
%Define o tipo da fonte a ser empregada.
%Escrever da seguinte maneira: 'Times New Roman';
% - % - % - tamanho_fonte - % - % - :
%Define o tamanho da fonte a ser empregada nos textos.
%Escrever da seguinte maneira: 12;
%Exemplo
if (nova_ou_sobrepor == 1)
    figure;
end

if (nova_ou_sobrepor == 2)
    hold on;
    %     grid off;
end

if (tipo == 1)
    if legenda ~= 0
        p = plot (eixox, eixoy, 'DisplayName', legenda); %PLA
        %         p = plot (eixox, eixoy, 'DisplayName', legenda, 'Color', [212,175,55]/255); %PETG
    else
        p = plot(eixox, eixoy); %PLA
        %         p = plot(eixox, eixoy, 'Color', [212,175,55]/255); %PETG
    end
    p.LineWidth = 2;
end

if (tipo == 2)
    if (legenda ~= 0)
        bar (eixox, eixoy,'DisplayName', legenda) %PLA
        %         bar (eixox, eixoy,'DisplayName', legenda, 'Color', [212,175,55]/255) %PETG
    else
        bar (eixox, eixoy) %PLA
        %         bar (eixox, eixoy, 'Color', [212,175,55]/255) %PETG
    end
end
if (tipo == 3)
    if (legenda ~= 0)
        stem (eixox, eixoy,'DisplayName', legenda) %PLA
        %         stem (eixox, eixoy,'DisplayName', legenda, 'Color', [212,175,55]/255) %PETG
    else
        stem (eixox, eixoy) %PLA
        %         stem (eixox, eixo, 'Color', [212,175,55]/255) %PETG
    end
end

if (titulo ~= 0)
    title (titulo);
end

if (label_eixox ~= 0)
    xlabel (label_eixox);
end

if (label_eixoy ~= 0)
    ylabel (label_eixoy);
end

if (legenda ~= 0)
    legend ('show');
end

aux_x_ticks = length(x_ticks);

if (aux_x_ticks ~= 1)
    xticks (x_ticks);
end

aux_y_ticks = length(y_ticks);

if (aux_y_ticks ~= 1)
    yticks (y_ticks);
end

if (limite_x2 ~= 0)
    xlim ([limite_x1 limite_x2]);
end

if (limite_y2 ~= 0)
    ylim ([limite_y1 limite_y2]);
end

if (tipo_fonte ~= 0)
    set(gca,'fontname', tipo_fonte, 'fontsize', tamanho_fonte);
end

if (legenda ~= 0)
    if (tipo_legenda == 1)
        legend('Location','best');
    end

    if (tipo_legenda == 2 || tipo_legenda == 0)
        legend('Location','northeast');
    end

    if (tipo_legenda == 3)
        legend('Location','northwest');
    end

    if (tipo_legenda == 4)
        legend('Location','southwest');
    end

    if (tipo_legenda == 5)
        legend('Location','southeast');
    end
end

set(gcf, 'Position', get(0, 'Screensize'));
grid on;
grid minor;

if (nova_ou_sobrepor == 2)
    hold on;
    %     grid off;
    numb_fig = size(allchild(gca));
    numb_fig_v = numb_fig(1,1);
    numb_col = round(numb_fig_v/4,0);
    if numb_col == 0
        numb_col = 1;
    end
    legend('NumColumns',numb_col);

    ordem_cor = [0.00,0.45,0.74; 0.85,0.33,0.10; 0.93,0.69,0.13;...
        0.49,0.18,0.56; 0.47,0.67,0.19; 0.30,0.75,0.93;...
        0.64,0.08,0.18; 0.85,0.85,0.35; 0.07,0.62,1.00;...
        1.00,0.55,0.00; 0.39,0.83,0.07; 0.72,0.27,1.00;...
        0.41,0.82,0.82; 1.00,0.07,0.65; 1.00,0.00,0.00;...
        0.65,0.65,0.65; 0.00, 1.00,0.00; 0.00,0.00, 1.00;...
        0.00,0.00,0.00];

    colororder(ordem_cor(1:numb_fig_v,:));
end

if (salvar ~= 2)
    if (salvar == 1)
        nome_do_arquivo1 = [nome_do_arquivo, '.tiff'];
        salvarFigura(gca,'centimeters',[13 7]*1.8,600,nome_do_arquivo1)
        nome_do_arquivo2 = [nome_do_arquivo, '.fig'];
        savefig(nome_do_arquivo2);
    end
    if (salvar == 0)
        nome_do_arquivo1 = [nome_do_arquivo, '.tiff'];
        salvarFigura(gca,'centimeters',[13 7]*1.8,600,nome_do_arquivo1)
    end
end