%% Agora vamos para o padrão interno.


load('Sinais ajustados e normalizados.mat');
load('Ponto_separacao_padroes.mat');

valor_x = 0;
valor_y = 0;
ultima_mudanca = 0;
num_amostras_minimo = 1;
Posicao_mudanca = zeros(size(Microfone_eletreto_normalizado))';
cont = 0;

for i = 1:length(Microfone_eletreto_normalizado)

    if Dir_X_ajustado_normalizado(1,i) ~= valor_x && (i - ultima_mudanca) > num_amostras_minimo
        valor_x = Dir_X_ajustado_normalizado(1,i);
        Posicao_mudanca(i) = 1;
        ultima_mudanca = i;
        cont = cont + 1;
    else
        if Dir_Y_ajustado_normalizado(1,i) ~= valor_y && (i - ultima_mudanca) > num_amostras_minimo
            valor_y = Dir_Y_ajustado_normalizado(1,i);
            Posicao_mudanca(i) = 1;
            ultima_mudanca = i;
            cont = cont + 1;
        else
            Posicao_mudanca(i) = 0;
        end
    end


end
%
% figure;
%
% plot (Microfone_eletreto_normalizado); hold on; plot (Posicao_mudanca);


% Agora vamos obter um vetor de duração, o qual exprimirá, em número de
% amostras, a duração entre cada mudança de direção.

flag = 0;
Separacao_1 = 0;
Separacao_2 = 0;
cont = 1;
clear Duracao

for i = ponto_separacao_padroes:length(Posicao_mudanca)
    if Posicao_mudanca(i) == 1 && flag == 0
        Separacao_1 = i;
        flag = 1;
    else
        if Posicao_mudanca(i) == 1 && flag == 1
            Separacao_2 = i;
            flag = 2;
        end
    end
    if flag == 2
        Duracao(cont,1) = Separacao_2 - Separacao_1; %#ok<*SAGROW>
        Duracao(cont,2) = Separacao_2;
        Duracao(cont,3) = Separacao_1;
        cont = cont+1;
        flag = 1;
        Separacao_1 = Separacao_2;
    end
end
%
% figure; plot(Duracao(:,1));
cont = 1;
Duracao_2 = zeros(3);

for i = 1:length(Duracao(:,1))
    if Duracao(i,1) > 8000
        Duracao_2(cont,:) = Duracao(i,:);
        cont = cont + 1;
    end

end

% figure; plot(Duracao_2(:,1));

indice_valores_abaixo_9000 = find(Duracao_2(:,1) < 9000);
indice_valores_acima_9000 = find(Duracao_2(:,1) > 9000);

valores_abaixo_9000 = Duracao_2(indice_valores_abaixo_9000);
valores_acima_9000 = Duracao_2(indice_valores_acima_9000);

media_transicao = round(mean(valores_abaixo_9000),0);

Duracao_3 = zeros(3);
picoAnterior1 = 0;
picoAnterior2 = 0;

for i = 1:length (indice_valores_abaixo_9000)

    if i == length (indice_valores_abaixo_9000)
        break;
    end


    index_ini = indice_valores_abaixo_9000(i);
    index_fin = indice_valores_abaixo_9000(i+1);



result = detectAnom(index_ini, index_fin);

picoAnterior2 = picoAnterior1;
picoAnterior1 = Duracao_3(end-1,1);

if picoAnterior1 < picoAnterior2
break;
end

if result == true % situação normal

[Duracao_obtida, index_dur3] = isNormal(Duracao_2, ...
                                        index_ini, index_fin, ...
                                        1);
if Duracao_3(1,1) == 0
    Duracao_3 = Duracao_obtida;

else
    Duracao_3 = [Duracao_3(1:end-1,:); Duracao_obtida];
end



clear Duracao_obtida
else % situação anormal





    [Duracao_obtida, index_dur3] = isAnormal(Duracao_2, ...
    index_ini, index_fin, ...
    picoAnterior1);

Duracao_3 = [Duracao_3(1:end-1,:); Duracao_obtida];

    clear Duracao_obtida

end

% plot(Duracao_3(:,1));

end

aux1 = find (Duracao_3(:,1) > 300e3 & Duracao_3(:,1) < 310e3);
aux2 = length(Duracao_3) - aux1;

Duracao_3_v2 = Duracao_3(1:end-aux2+1,:);


% Espelhamento



cont = length(Duracao_3_v2(:,1));

Duracao_4 = Duracao_3_v2;

for i = 1:length(Duracao_3_v2(:,1))-2
    if i == 1
        Duracao_4(cont,1) = Duracao_3_v2(length(Duracao_3_v2(:,1))-i-1,1);
        Duracao_4(cont,3) = Duracao_3_v2(length(Duracao_3_v2(:,1))-i,2);
        Duracao_4(cont,2) = Duracao_4(cont,3) + Duracao_4(cont,1);
        cont = cont + 1;
    end
    if i ~= 1
        Duracao_4(cont,1) = Duracao_3_v2(length(Duracao_3_v2(:,1))-i-1,1);
        Duracao_4(cont,3) = Duracao_4(cont-1,2);
        Duracao_4(cont,2) = Duracao_4(cont,3) + Duracao_4(cont,1);
        cont = cont + 1;
    end
end



indice_2_valores_abaixo_9000 = find(Duracao_4(:,1) < 9000);
indice_2_valores_acima_9000 = find(Duracao_4(:,1) > 9000);

valores_2_abaixo_9000 = Duracao_4(indice_2_valores_abaixo_9000);
valores_2_acima_9000 = Duracao_4(indice_2_valores_acima_9000);

Duracao_4_v2(1,2) = Duracao_4(1,3);
Duracao_4_v2(1,1) = Duracao_4(2,1)-11e3;
Duracao_4_v2(1,3) = Duracao_4_v2(1,2) - Duracao_4_v2(1,1);
Duracao_4_v2(2:length(Duracao_4(:,1))+1,:) = Duracao_4;

Duracao_4_v2(length(Duracao_4(:,1))+2,3) = Duracao_4_v2(length(Duracao_4(:,1))+1,2);
Duracao_4_v2(length(Duracao_4(:,1))+2,1) = Duracao_4_v2(length(Duracao_4(:,1)),1)-11e3;
Duracao_4_v2(length(Duracao_4(:,1))+2,2) = Duracao_4_v2(length(Duracao_4(:,1))+2,1) + Duracao_4_v2(length(Duracao_4(:,1))+2,3);

figure;
plot (Duracao_4_v2(:,1));
Grid();


cont_interno = 1;
cont_trans_interno = 1;

for j = 1:length(Duracao_4_v2(:,1))
    if Duracao_4_v2(j,1) < 8000 || Duracao_4_v2(j,1) > 9000
        Linhas_padrao_interno(cont_interno,:) = Duracao_4_v2(j,:);
        cont_interno = cont_interno + 1;

    else
        Transicao_linhas_padrao_interno(cont_trans_interno,:) = Duracao_4_v2(j,:);
        cont_trans_interno = cont_trans_interno + 1;
    end

end

Movimento_inicio_linhas_interno(1,1) = Duracao_2(1,1) - Duracao_4_v2(1,1);
Movimento_inicio_linhas_interno(1,2) = Duracao_4_v2(1,3);
Movimento_inicio_linhas_interno(1,3) = Movimento_inicio_linhas_interno(1,2) - Movimento_inicio_linhas_interno(1,1);

Sinal_linhas_internas = Compos3r(Microfone_eletreto_normalizado, Linhas_padrao_interno(:,2:3));
Sinal_transicao_internas = Compos3r(Microfone_eletreto_normalizado, Transicao_linhas_padrao_interno(:,2:3));


