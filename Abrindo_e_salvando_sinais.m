%% abrindo sinais

Microfone_eletreto = openBin('0123_ch1.bin', inf, 0, 200e3);

Dir_X = openBin('0123_ch2.bin', inf, 0, 200e3);

Dir_Y = openBin('0123_ch3.bin', inf, 0, 200e3);


Step_X = openBin('0123_ch4.bin', inf, 0, 200e3);

Step_Y = openBin('0123_ch5.bin', inf, 0, 200e3);

Dir_X_ajustado = zeros(size(Dir_X));
Dir_Y_ajustado = zeros(size(Dir_Y));

for i = 1:length(Dir_X)

    if Dir_X(i) > 2
        Dir_X_ajustado(i) = 5;
    else
        Dir_X_ajustado(i) = 0;
    end
end

for i = 1:length(Dir_Y)

    if Dir_Y(i) > 2
        Dir_Y_ajustado(i) = 5;
    else
        Dir_Y_ajustado(i) = 0;
    end
end

Microfone_eletreto_normalizado = Normaliz3r(Microfone_eletreto);
Dir_Y_ajustado_normalizado = Normaliz3r(Dir_Y_ajustado);
Dir_X_ajustado_normalizado = Normaliz3r(Dir_X_ajustado);

%%

plot(Microfone_eletreto_normalizado,'DisplayName','Microfone_eletreto_normalizado');hold on;plot(Dir_X_ajustado_normalizado,'DisplayName','Dir_X_ajustado_normalizado');plot(Dir_Y_ajustado_normalizado,'DisplayName','Dir_Y_ajustado_normalizado');hold off;

ylim ([0 1.4]);

%% Algoritmo de detecção automática da mudança de linha


% Inicialmente utilizamos como referência os sinais binários dos motores de
% passso X e Y. Vamos compor um vetor único, que demonstrará onde foram
% realizadas mudanças de direção no sinal. Este é o vetor denonimado
% "Posicao_mudanca".

% Ademais, é importante mencionar que definimos a variável
% num_amostras_minimo, de forma a não considerar mudanças que foram
% captadas pelos motores de passo X e Y, mas que não representam
% verdadeiramente mudanças de direção no extrusor.

% Vale ressaltar que a variável num_amostras_minimo aqui tem seu valor
% definido apenas para permitir encontrar o ponto de mudança entre padrões.
% Ela também permitirá encontrar a separação entre linhas para o padrão
% externo. Porém, para o padrão interno, o valor deverá mudar, de forma a
% considerar a ocorrência de mudanças de direçao mais curtas.


valor_x = 0;
valor_y = 0;
ultima_mudanca = 0;
num_amostras_minimo = 50000;
Posicao_mudanca = zeros(size(Microfone_eletreto_normalizado))';


for i = 1:length(Microfone_eletreto_normalizado)

    if Dir_X_ajustado_normalizado(i) ~= valor_x &&...
            i - ultima_mudanca >= num_amostras_minimo
        valor_x = Dir_X_ajustado_normalizado(i);
        Posicao_mudanca(i) = 1;
        ultima_mudanca = i;
    else
        if Dir_Y_ajustado_normalizado(i) ~= valor_y &&...
                i - ultima_mudanca >= num_amostras_minimo
            valor_y = Dir_Y_ajustado_normalizado(i);
            Posicao_mudanca(i) = 1;
            ultima_mudanca = i;
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

for i = 1:length(Posicao_mudanca)
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

% figure; plot(Duracao(:,1));


% Para permitir encontrar o ponto de separacao entre padrão externo e
% padrão interno, vou percorrer todo o vetor da duracao até encontrar um
% valor conhecido de duracao (duracao da fabricação da linha 10). Ai
% armazeno as posições relativas ao início da fabricação da linha 10, linha
% 11 e linha 12. Sei que as 3 devem ser muito similares, então faço um
% teste nas linhas 11 e 12. Se elas estiverem dentro do mesmo intervalo,
% está identificado o final do padrão externo. Caso negativo, volto a
% verificar na duração por este padrão.

bloco_1 = zeros(3);

flag = 1;
for i = 1:length(Duracao(:,1))

    if Duracao(i,1) > 223e3 && Duracao(i,1) < 224e3 && flag ~= 2
        bloco_1(1,1) = Duracao(i,2);
        bloco_1(1,2) = Duracao(i,3);
        bloco_1(2,1) = Duracao(i+1,2);
        bloco_1(2,2) = Duracao(i+1,3);
        bloco_1(3,1) = Duracao(i+2,2);
        bloco_1(3,2) = Duracao(i+2,3);
        flag = 2;
    end
    soma = 0;
    if flag == 2
        for j = 1:3
            bloco_1(j, 3) = bloco_1 (j,1) - bloco_1 (j,2);
            if bloco_1(j,3) > 220e3 && bloco_1(j,3) < 224e3
                soma = soma +1;
            end
        end
        if soma == 3
            ponto_separacao_padroes = bloco_1(3,1);
            break;
        end
        if soma ~= 3
            flag = 1;
        end
    end

end


% Separacao de linhas do padrão externo
a = find(Duracao(:,3) == ponto_separacao_padroes);

separacao_padrao_externo = zeros(size(Microfone_eletreto_normalizado));
linhas_padrao_externo = zeros(1,13);


for i = 1:13
    linhas_padrao_externo(1,i) = Duracao(a-13+i,3);
    sinal_temporario = plota_linha(1, linhas_padrao_externo(1,i),...
        Microfone_eletreto_normalizado);
    separacao_padrao_externo = sinal_temporario'...
        + separacao_padrao_externo;
    clear sinal_temporario
end


% figure;
%
% plot (Microfone_eletreto_normalizado); hold on; plot (Posicao);
% plot(sinal_final);


clear Posicao_mudanca a bloco_1 cont Duracao flag i j num_amostras_minimo
clear Separacao_1 Separacao_2 soma ultima_mudanca valor_x valor_y

save ('padrao externo', 'separacao_padrao_externo', 'ponto_separacao_padroes', 'linhas_padrao_externo');
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

Sinal_linhas_internas = Compos3r(Microfone_eletreto_normalizado, Linhas_padrao_interno(:,2:3), 2);
Sinal_transicao_internas = Compos3r(Microfone_eletreto_normalizado, Transicao_linhas_padrao_interno(:,2:3), 2);


save('padrao interno','ponto_separacao_padroes','Sinal_linhas_internas','Sinal_transicao_internas','Movimento_inicio_linhas_interno','Linhas_padrao_interno','linhas_padrao_externo');


