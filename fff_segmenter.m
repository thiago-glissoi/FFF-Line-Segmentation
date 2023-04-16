% % LEIA-ME
% Esta função é utilizada para segmentar de forma automática as linhas de
% fabricação de contorno, que compõem o padrão externo, as linhas de
% fabricação raster, que compõem o padrão interno, e demais movimentações
% de um sinal obtido de fabricação monocamada pelo processo de fabricação
% por filamento fundido (FFF).
%
% Para utilizar esta função, deve-se:
% 1-> Obter os sinais de mudança de direção do eixo X, e do eixo Y;
% 2-> Conhecer a frequência de amostragem dos sinais;
% 3-> Conhecer a lógica de fabricação do padrão externo (n°_segmentos e
% n°_linhas_contorno);
% 4-> Conhecer a lógica de fabricação do padrão externo (n°_transições e
% n°_linhas_raster);
%
% Ademais, a função foi desenvolvida seguindo o princípio de que as linhas
% de contorno são fabricadas seguindo direções ortogonais, com segmentos
% que diminuem de comprimento a um n° específico de interações. Além
% disso, a função foi desenvolvida seguindo o princípio de que as linhas de
% raster são fabricadas seguindo ângulos de raster de 45°, com a lógica de
% crescência até o centro da área de deposição, e depois decrescência.
% Deve-se considerar ainda que a função foi desenvolvida seguindo o
% princípio de que as transições entre linhas de raster apresentam durações
% muito símilares entre si, e que no padrão interno segue-se uma sequência
% de linha de transição seguida de linha de fabricação, o que se repete até
% atingir o número de linhas. Sinais obtidos da fabricação de peças
% monocamada que possuam características geométricas e de fabricação
% distintas do que as aqui mencionadas não funcionarão
%
% A lógica de funcionamento principal da função roda no segmento
% identificado como CORE. Determinadas lógicas secundárias, que são
% chamadas no bloco CORE, rodam nos blocos SUB1, SUB2 e SUB3.
%
% Ao finalizar de rodar a função, o bloco CORE retorna os vetores:
%
% linhas_PE -> Vetor que apresenta os índices de mudança das linhas de ...
% contorno
%
% linhas_PI -> Matriz que apresenta os índices de mudança das linhas de ...
% raster. Na primeira coluna é apresentada a duração da linha, na ...
% segunda coluna é apresentado o índice final da linha, e na terceira ...
% coluna é apresentado o índice inicial da linha
%
% trans_PI -> Matriz que apresenta os índices de transição entre as ...
% linhas de raster. Na primeira coluna é apresentada a duração da ...
% transição, na segunda coluna é apresentado o índice final da transição, ...
% e na terceira coluna é apresentado o índice inicial da transição
%
% mov_ini_PI -> Vetor que apresenta o índice de transição entre o ...
% padrão externo e o padrão interno. Na primeira coluna é apresentada a ...
% duração da transiçã0, na segunda coluna é apresentado o índice final ...
% da transição, na terceira coluna é apresentado o índice inicial da ...
% transição
%
% ponto_sep_PE_PI -> Índice que indica o ponto de termino da fabricação ...
% do padrão externo
%
% sep_PE -> Sinal com indição das linhas de contorno
%
% sinal_linhas_PI -> Sinal com indição das linhas de raster
%
% sinal_trans_PI -> Sinal com indição das transições entre as linhas de ...
% raster
%
% Ao chamar a função, pode-se optar por plotar as figuras e salvá-las.
% Este tratamento é realizado na função local OP1
%
% Ao chamar a função, pode-se optar por salvar os dados em formato .mat.
% Este tratamento é realizado na função local OP2
%
% Determinadas lógicas auxiliares, como a de normalizar sinais, são
% realizadas nos blocos AUX1, AUX2, AUX3, AUX4, AUX5, e AUX6
%
% % Versão 1.0
% Autoria: Thiago Glissoi Lopes - LADAPS - UNESP BAURU
% Última edição: Thiago Glissoi Lopes - LADAPS - UNESP BAURU

% CORE
function [linhas_PE, linhas_PI, trans_PI, mov_ini_PI,...
    ponto_sep_PE_PI, sep_PE, sinal_linhas_PI, sinal_trans_PI] = ...
    fff_segmenter (sinal_sensor, Dir_X, Dir_Y, Fs, modo_linha,...
    modo_salvar, modo_plot, modo_salvar_figura, nome_sinal_bruto)
%% Pré-processamentos

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

sinal_sensor_normalizado = Normaliz3r(sinal_sensor);
Dir_Y_ajustado_normalizado = Normaliz3r(Dir_Y_ajustado);
Dir_X_ajustado_normalizado = Normaliz3r(Dir_X_ajustado);

%% Segmentação do padrão externo

valor_x = 0;
valor_y = 0;
ultima_mudanca = 0;
num_amostras_minimo = 50e3;
Posicao_mudanca = zeros(size(sinal_sensor_normalizado))';

for i = 1:length(sinal_sensor_normalizado)
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

% Para permitir encontrar o ponto de separacao entre padrão externo e
% padrão interno, vou percorrer todo o vetor da duracao até encontrar um
% valor conhecido de duracao (duracao da fabricação da linha 10). Ai
% armazeno as posições relativas ao início da fabricação da linha 10, linha
% 11 e linha 12. Sei que as 3 devem ser muito similares, então faço um
% teste nas linhas 11 e 12. Se elas estiverem dentro do mesmo intervalo,
% está identificado o final do padrão externo. Caso negativo, volto a
% verificar na duração por este padrão.

% bloco_1 = zeros(3);
% flag = 1;


% Fs = val
% 200e3 = 170e3
% x = y
% 170e3*x = 200e3*y
% y = (170e3*x)/(200e3);

referencia_tamanho = (150e3*Fs)/(200e3);

for i = 1:length(Duracao(:,1))

result_sep = encontra_ponto_separacao(Duracao, i, referencia_tamanho);

if result_sep == true
ponto_sep_PE_PI = Duracao(i,2);
break;
else
clear result_sep
end

%     if Duracao(i,1) > 223e3 && Duracao(i,1) < 224e3 && flag ~= 2
%         bloco_1(1,1) = Duracao(i,2);
%         bloco_1(1,2) = Duracao(i,3);
%         bloco_1(2,1) = Duracao(i+1,2);
%         bloco_1(2,2) = Duracao(i+1,3);
%         bloco_1(3,1) = Duracao(i+2,2);
%         bloco_1(3,2) = Duracao(i+2,3);
%         flag = 2;
%     end
%     soma = 0;
%     if flag == 2
%         for j = 1:3
%             bloco_1(j, 3) = bloco_1 (j,1) - bloco_1 (j,2);
%             if bloco_1(j,3) > 220e3 && bloco_1(j,3) < 224e3
%                 soma = soma +1;
%             end
%         end
%         if soma == 3
%             ponto_sep_PE_PI = bloco_1(3,1);
%             break;
%         end
%         if soma ~= 3
%             flag = 1;
%         end
%     end
% 


end


% Separacao de linhas do padrão externo
a = find(Duracao(:,3) == ponto_sep_PE_PI);

sep_PE = zeros(size(sinal_sensor_normalizado));
linhas_PE = zeros(1,13);


for i = 1:13
    linhas_PE(1,i) = Duracao(a-13+i,3);
    separacao_entre_pad = plota_linha(1, linhas_PE(1,i),...
        sinal_sensor_normalizado);
    sep_PE = separacao_entre_pad'...
        + sep_PE;
    clear separacao_entre_pad
end

clear Posicao_mudanca a bloco_1 cont Duracao flag i j num_amostras_minimo
clear Separacao_1 Separacao_2 soma ultima_mudanca valor_x valor_y

valor_x = 0;
valor_y = 0;
ultima_mudanca = 0;
num_amostras_minimo = 1;
Posicao_mudanca = zeros(size(sinal_sensor_normalizado))';
cont = 0;

for i = 1:length(sinal_sensor_normalizado)

    if Dir_X_ajustado_normalizado(i,1) ~= valor_x && (i - ultima_mudanca) > num_amostras_minimo
        valor_x = Dir_X_ajustado_normalizado(i,1);
        Posicao_mudanca(i) = 1;
        ultima_mudanca = i;
        cont = cont + 1;
    else
        if Dir_Y_ajustado_normalizado(i,1) ~= valor_y && (i - ultima_mudanca) > num_amostras_minimo
            valor_y = Dir_Y_ajustado_normalizado(i,1);
            Posicao_mudanca(i) = 1;
            ultima_mudanca = i;
            cont = cont + 1;
        else
            Posicao_mudanca(i) = 0;
        end
    end
end

% Agora vamos obter um vetor de duração, o qual exprimirá, em número de
% amostras, a duração entre cada mudança de direção.

flag = 0;
Separacao_1 = 0;
Separacao_2 = 0;
cont = 1;
clear Duracao

for i = ponto_sep_PE_PI:length(Posicao_mudanca)
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
        Duracao(cont,1) = Separacao_2 - Separacao_1; %#ok<*AGROW,*SAGROW>
        Duracao(cont,2) = Separacao_2;
        Duracao(cont,3) = Separacao_1;
        cont = cont+1;
        flag = 1;
        Separacao_1 = Separacao_2;
    end
end

%% Segmentação do padrão interno

cont = 1;
Duracao_2 = zeros(3);

for i = 1:length(Duracao(:,1))
    if Duracao(i,1) > 8000
        Duracao_2(cont,:) = Duracao(i,:);
        cont = cont + 1;
    end

end


indice_valores_abaixo_9000 = find(Duracao_2(:,1) < 9000);
indice_valores_acima_9000 = find(Duracao_2(:,1) > 9000);

valores_abaixo_9000 = Duracao_2(indice_valores_abaixo_9000);
valores_acima_9000 = Duracao_2(indice_valores_acima_9000); %#ok<*NASGU,*FNDSB>

media_transicao = round(mean(valores_abaixo_9000),0);

Duracao_3 = zeros(3);
picoAnterior1 = 0;
picoAnterior2 = 0;

for i = 1:length (indice_valores_abaixo_9000)

    if i == length (indice_valores_abaixo_9000)
        break;
    end

    if i > 5
        if  Duracao_3(i-1,1) == 160255
            a = 1;
        end
    end

    index_ini = indice_valores_abaixo_9000(i);
    index_fin = indice_valores_abaixo_9000(i+1);



    result = detectAnom(index_ini, index_fin);

    picoAnterior2 = picoAnterior1;
    picoAnterior1 = Duracao_3(end-1,1);

    if  picoAnterior1 < picoAnterior2
        break;
    end

    if  picoAnterior1 > 310e3
        break;
    end

    %     if picoAnterior1 < picoAnterior2 && picoAnterior2 > 280e3
    %         break;
    %     end

    if result == true % situação normal

        [Duracao_obtida, index_dur3] = isNormal(Duracao_2, ...
            index_ini, index_fin, ...
            1); %#ok<*ASGLU>
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


end


aux1 = find (Duracao_3(:,1) == picoAnterior2);

Duracao_3_v2 = Duracao_3(1:end-(end-aux1)+1,:);


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

cont_interno = 1;
cont_trans_interno = 1;

for j = 1:length(Duracao_4_v2(:,1))
    if Duracao_4_v2(j,1) < 8000 || Duracao_4_v2(j,1) > 9000
        linhas_PI(cont_interno,:) = Duracao_4_v2(j,:);
        cont_interno = cont_interno + 1;

    else
        trans_PI(cont_trans_interno,:) = Duracao_4_v2(j,:);
        cont_trans_interno = cont_trans_interno + 1;
    end

end

mov_ini_PI(1,1) = Duracao_2(1,1) - Duracao_4_v2(1,1);
mov_ini_PI(1,2) = Duracao_4_v2(1,3);
mov_ini_PI(1,3) = mov_ini_PI(1,2) - mov_ini_PI(1,1);

cont_interno = 1;
separacao_entre_pad = 0;

for j = 1:length(sinal_sensor_normalizado)

    if j >=  mov_ini_PI(1,3) && j <= mov_ini_PI(1,2)
        separacao_entre_pad(cont_interno,1) = 1;
        cont_interno = cont_interno + 1;

    else
        separacao_entre_pad(cont_interno,1) = 0;
        cont_interno = cont_interno + 1;
    end

end

figure;
plot(Duracao_4_v2(:,1));

if modo_linha == 1 && modo_plot < 5
    %sinal_linhas e sinal_transicao = binário
    sinal_linhas_PI = Compos3r(sinal_sensor_normalizado, linhas_PI(:,2:3), 1);
    sinal_trans_PI = Compos3r(sinal_sensor_normalizado, trans_PI(:,2:3), 1);
    yinf = -0.2;
    ysup = 1.2;
else
    sinal_linhas_PI = Compos3r(sinal_sensor_normalizado, linhas_PI(:,2:3), 1);
    sinal_trans_PI = Compos3r(sinal_sensor_normalizado, trans_PI(:,2:3), 1);
    yinf = 0;
    ysup = 0;
end

if modo_linha == 2
    %sinal_linhas e sinal_transicao = original
    sinal_linhas_PI = Compos3r(sinal_sensor_normalizado, linhas_PI(:,2:3), 2);
    sinal_trans_PI = Compos3r(sinal_sensor_normalizado, trans_PI(:,2:3), 2);
    yinf = 0;
    ysup = 0;
end

if modo_salvar ~=0
    save_files(modo_salvar, nome_sinal_bruto, linhas_PE, linhas_PI,...
        trans_PI, mov_ini_PI, ponto_sep_PE_PI, sep_PE, sinal_linhas_PI,...
        sinal_trans_PI);
end

sinal_sensor = Normaliz3r(sinal_sensor);

if modo_plot ~=0
    gen_graph(separacao_entre_pad, modo_plot, sinal_sensor, Fs,...
        nome_sinal_bruto, sep_PE,yinf,ysup, sinal_linhas_PI,...
        sinal_trans_PI, modo_salvar_figura);
end

end

% SUB1
function result = detectAnom(initialPoint, lastPoint)

if lastPoint - initialPoint == 2
    % Encontramos uma situação normal
    result = true;

else
    % Encontramos uma situação anormal
    result = false;

end
end

% SUB2
function [duracaoComposta, lastIndex] = isNormal(duracaoOriginal, ...
    initialPoint, lastPoint, ...
    indexDuracao)


% Período de transição (aprox 8000 amostras)
duracaoComposta(indexDuracao, 3) =  duracaoOriginal(initialPoint,3);
duracaoComposta(indexDuracao, 2) =  duracaoOriginal(initialPoint,2);
duracaoComposta(indexDuracao, 1) =  duracaoComposta(indexDuracao, 2)...
    - duracaoComposta(indexDuracao, 3);

% Período de fabricação (valor acima de 9000 amostras, e que cresça
% 11e3 em relação ao período de fabricação anterior
duracaoComposta(indexDuracao+1, 3) =  duracaoOriginal(initialPoint+1,3);
duracaoComposta(indexDuracao+1, 2) =  duracaoOriginal(initialPoint+1,2);
duracaoComposta(indexDuracao+1, 1) =  duracaoComposta(indexDuracao+1, 2)...
    - duracaoComposta(indexDuracao+1, 3);

% Período de transição
duracaoComposta(indexDuracao+2, 3) =  duracaoOriginal(lastPoint,3);
duracaoComposta(indexDuracao+2, 2) =  duracaoOriginal(lastPoint,2);
duracaoComposta(indexDuracao+2, 1) =  duracaoComposta(indexDuracao+2, 2)...
    - duracaoComposta(indexDuracao+2, 3);

lastIndex = indexDuracao+2;
end

% SUB3
function [duracaoComposta, lastIndex] = isAnormal(duracaoOriginal, ...
    initialPoint, lastPoint, ...
    picoAnterior)

cont = 1;

for i = initialPoint:2:lastPoint

    if lastPoint - i == 1 || lastPoint == i
        %transição correto
        % Período de transição (aprox 8000 amostras)
        duracaoComposta(cont, 3) =  duracaoComposta(cont-1, 2);
        duracaoComposta(cont, 2) =  duracaoOriginal(lastPoint, 2);
        duracaoComposta(cont, 1) =  duracaoComposta(cont, 2)...
            - duracaoComposta(cont, 3);

        if duracaoComposta(cont, 1) < 0 %ultrapassou o ponto

            aux = length(duracaoComposta(:,1));
            duracaoComposta2(:,:) = duracaoComposta(1:aux-2,:);
            clear duracaoComposta
            duracaoComposta =  duracaoComposta2;
            clear duracaoComposta2
            aux = length(duracaoComposta(:,1));
            if aux == 1
                break;
            end
            cont = cont-2;
            duracaoComposta(cont, 3) =  duracaoComposta(cont-1, 2);
            duracaoComposta(cont, 2) =  duracaoOriginal(lastPoint, 2);
            duracaoComposta(cont, 1) =  duracaoComposta(cont, 2)...
                - duracaoComposta(cont, 3);
            if duracaoComposta(cont, 1) < 0 %ultrapassou o ponto
                aux = length(duracaoComposta(:,1));
                duracaoComposta2(:,:) = duracaoComposta(1:aux-2,:);
                clear duracaoComposta
                duracaoComposta =  duracaoComposta2;
                clear duracaoComposta2
                cont = cont-2;
                duracaoComposta(cont, 3) =  duracaoComposta(cont-1, 2);
                duracaoComposta(cont, 2) =  duracaoOriginal(lastPoint, 2);
                duracaoComposta(cont, 1) =  duracaoComposta(cont, 2)...
                    - duracaoComposta(cont, 3);
            end
        end
        break;
    end
    if i == initialPoint % caso seja o primeiro, aproveita o valor de
        %transição correto
        % Período de transição (aprox 8000 amostras)
        duracaoComposta(cont, 3) =  duracaoOriginal(i,3); %#ok<*AGROW>
        duracaoComposta(cont, 2) =  duracaoOriginal(i,2);
        duracaoComposta(cont, 1) =  duracaoComposta(cont, 2)...
            - duracaoComposta(cont, 3);
        cont = cont +1;

    else %transicao_normal
        duracaoComposta(cont, 3) =  duracaoComposta(cont-1, 2);
        duracaoComposta(cont, 2) =  duracaoComposta(cont, 3) +...
            8.4e3;
        duracaoComposta(cont, 1) =  duracaoComposta(cont, 2)...
            - duracaoComposta(cont, 3);
        cont = cont +1;

    end


    % Período de fabricação (valor acima de 9000 amostras, e que cresça
    % 11e3 em relação ao período de fabricação anterior
    duracaoComposta(cont, 3) =  duracaoComposta(cont-1, 2);
    duracaoComposta(cont, 2) =  duracaoComposta(cont, 3) +...
        picoAnterior + 11e3;
    duracaoComposta(cont, 1) =  duracaoComposta(cont, 2)...
        - duracaoComposta(cont, 3);
    picoAnterior = duracaoComposta(cont, 1);
    cont = cont +1;


    %transicao_normal
    duracaoComposta(cont, 3) =  duracaoComposta(cont-1, 2);
    duracaoComposta(cont, 2) =  duracaoComposta(cont, 3) +...
        8.4e3;
    duracaoComposta(cont, 1) =  duracaoComposta(cont, 2)...
        - duracaoComposta(cont, 3);


end

lastIndex = cont;

end

% OP1
function gen_graph(separacao_entre_pad, modo_plot, sinal_sensor, Fs,...
    nome_sinal_bruto, sep_PE,yinf,ysup, sinal_linhas_PI,...
    sinal_trans_PI, modo_salvar_figura)


if modo_plot == 1
    %plota 1 figura de cada coisa sem salvar figuras

    %figura sinal original (tempo)
    plota_figura_unica(gera_eixo_tempo(sinal_sensor,Fs), sinal_sensor,...
        1, 1,nome_sinal_bruto, 0, 'tempo (s)',...
        'amplitude (V)', 0, 0, 0, 0, 0, 0, 2, 0, 3, 'Times New Roman', 16)

    %figura sinal padrão externo (tempo)
    plota_figura_unica(gera_eixo_tempo(sep_PE,Fs), sep_PE,...
        1, 1,'Linhas padrão externo', 0, 'tempo (s)',...
        'amplitude (V)', 0, 0, 0, 0, yinf, ysup, 2, 0, 2, 'Times New Roman', 16)

    %figura sinal padrão interno (tempo)
    plota_figura_unica(gera_eixo_tempo(sinal_linhas_PI,Fs), sinal_linhas_PI,...
        1, 1,'Linhas padrão interno', 0, 'tempo (s)',...
        'amplitude (V)', 0, 0, 0, 0, yinf, ysup, 2, 0, 3, 'Times New Roman', 16)

    %figura sinal transições do padrão interno (tempo)
    plota_figura_unica(gera_eixo_tempo(sinal_trans_PI,Fs), sinal_trans_PI,...
        1, 1,'Transições padrão interno', 0, 'tempo (s)',...
        'amplitude (V)', 0, 0, 0, 0, yinf, ysup, 2, 0, 3, 'Times New Roman', 16)
end


if modo_plot == 2
    % plota figuras de comparação sem salvar figuras
    figure;
    subplot(2,1,1); %subplot com original e padrão externo

    %figura sinal original (tempo)
    plota_figura_unica(gera_eixo_tempo(sinal_sensor,Fs), sinal_sensor,...
        1, 2,nome_sinal_bruto, 0, 'tempo (s)',...
        'amplitude (V)', 0, 0, 0, 0, 0, 0, 2, 0, 2, 'Times New Roman', 16)

    subplot(2,1,2);
    %figura sinal padrão externo (tempo)
    plota_figura_unica(gera_eixo_tempo(sep_PE,Fs), sep_PE,...
        1, 2,'Linhas padrão externo', 0, 'tempo (s)',...
        'amplitude (V)', 0, 0, 0, 0, yinf, ysup, 2, 0, 2, 'Times New Roman', 16)

    figure;
    subplot(3,1,1); %subplot com original e padrão interno

    %figura sinal original (tempo)
    plota_figura_unica(gera_eixo_tempo(sinal_sensor,Fs), sinal_sensor,...
        1, 2,nome_sinal_bruto, 0, 'tempo (s)',...
        'amplitude (V)', 0, 0, 0, 0, 0, 0, 2, 0, 3, 'Times New Roman', 16)

    subplot(3,1,2);
    %figura sinal padrão interno (tempo)
    plota_figura_unica(gera_eixo_tempo(sinal_linhas_PI,Fs), sinal_linhas_PI,...
        1, 2,'Linhas padrão interno', 0, 'tempo (s)',...
        'amplitude (V)', 0, 0, 0, 0, yinf, ysup, 2, 0, 3, 'Times New Roman', 16)

    subplot(3,1,3);
    %figura sinal transições do padrão interno (tempo)
    plota_figura_unica(gera_eixo_tempo(sinal_trans_PI,Fs), sinal_trans_PI,...
        1, 2,'Transições padrão interno', 0, 'tempo (s)',...
        'amplitude (V)', 0, 0, 0, 0, yinf, ysup, 2, 0, 3, 'Times New Roman', 16)
end


if modo_plot == 3
    %plota 1 figura de cada coisa salvando figuras

    %figura sinal original (tempo)
    plota_figura_unica(gera_eixo_tempo(sinal_sensor,Fs), sinal_sensor,...
        1, 1,nome_sinal_bruto, 0, 'tempo (s)',...
        'amplitude (V)', 0, 0, 0, 0, 0, 0, 1,...
        nome_sinal_bruto,...
        3, 'Times New Roman', 16)

    %figura sinal padrão externo (tempo)
    plota_figura_unica(gera_eixo_tempo(sep_PE,Fs), sep_PE,...
        1, 1,'Linhas padrão externo', 0, 'tempo (s)',...
        'amplitude (V)', 0, 0, ...
        0, 0, yinf, ysup,...
        1, ['Linhas_padrão_externo_',nome_sinal_bruto],...
        2, 'Times New Roman', 16)

    %figura sinal padrão interno (tempo)
    plota_figura_unica(gera_eixo_tempo(sinal_linhas_PI,Fs), sinal_linhas_PI,...
        1, 1,'Linhas padrão interno', 0, 'tempo (s)',...
        'amplitude (V)', 0, 0, 0, 0, yinf, ysup, modo_salvar_figura,...
        ['Linhas_padrão_interno_',nome_sinal_bruto],...
        3, 'Times New Roman', 16)

    %figura sinal transições do padrão interno (tempo)
    plota_figura_unica(gera_eixo_tempo(sinal_trans_PI,Fs), sinal_trans_PI,...
        1, 1,'Transições padrão interno', 0, 'tempo (s)',...
        'amplitude (V)', 0, 0, 0, 0, yinf, ysup, modo_salvar_figura,...
        ['Transições_padrão_interno_',nome_sinal_bruto],...
        3, 'Times New Roman', 16)

end


if modo_plot == 4
    % plota figuras de comparação salvando figuras
    figure;
    subplot(2,1,1); %subplot com original e padrão externo

    %figura sinal original (tempo)
    plota_figura_unica(gera_eixo_tempo(sinal_sensor,Fs), sinal_sensor,...
        1, 2,nome_sinal_bruto, 0, 'tempo (s)',...
        'amplitude (V)', 0, 0, 0, 0, 0, 0, 2, 0, 2, 'Times New Roman', 16)

    subplot(2,1,2);
    %figura sinal padrão externo (tempo)
    plota_figura_unica(gera_eixo_tempo(sep_PE,Fs), sep_PE,...
        1, 2,'Linhas padrão externo', 0, 'tempo (s)',...
        'amplitude (V)', 0, 0, 0, 0, yinf, ysup, modo_salvar_figura,...
        ['Comparação_padrão_externo_',nome_sinal_bruto],...
        2, 'Times New Roman', 16)

    figure;
    subplot(3,1,1); %subplot com original e padrão interno

    %figura sinal original (tempo)
    plota_figura_unica(gera_eixo_tempo(sinal_sensor,Fs), sinal_sensor,...
        1, 2,nome_sinal_bruto, 0, 'tempo (s)',...
        'amplitude (V)', 0, 0, 0, 0, 0, 0, 2, 0, 3, 'Times New Roman', 16)

    subplot(3,1,2);
    %figura sinal padrão interno (tempo)
    plota_figura_unica(gera_eixo_tempo(sinal_linhas_PI,Fs), sinal_linhas_PI,...
        1, 2,'Linhas padrão interno', 0, 'tempo (s)',...
        'amplitude (V)', 0, 0, 0, 0, yinf, ysup, 2, 0, 3, 'Times New Roman', 16)

    subplot(3,1,3);
    %figura sinal transições do padrão interno (tempo)
    plota_figura_unica(gera_eixo_tempo(sinal_trans_PI,Fs), sinal_trans_PI,...
        1, 2,'Transições padrão interno', 0, 'tempo (s)',...
        'amplitude (V)', 0, 0, 0, 0, yinf, ysup, modo_salvar_figura,...
        ['Comparação_padrão_interno_',nome_sinal_bruto],...
        3, 'Times New Roman', 16)
end

if modo_plot == 5
    %plota figura de comparação por subplot para preenchimento externo e
    %interno

    %figura sinal original (tempo)
    plota_figura_unica(gera_eixo_tempo(sinal_sensor,Fs), sinal_sensor,...
        1, 1,nome_sinal_bruto, 0, 'tempo (s)',...
        'amplitude (V)', 0, 0, 0, 0, 0, 0, 2, 0, 3, 'Times New Roman', 16)

    %figura sinal padrão externo (tempo)
    plota_figura_unica(gera_eixo_tempo(sep_PE,Fs), sep_PE,...
        1, 2,'Linhas padrão externo', 0, 'tempo (s)',...
        'amplitude (V)', 0, 0, 0, 0, yinf, ysup, 2, 0, 2, 'Times New Roman', 16)

    %figura ponto separação entre padrões
    plota_figura_unica(gera_eixo_tempo(separacao_entre_pad,Fs),...
        separacao_entre_pad, 1, 2,'Separação entre padrões', 0,...
        'tempo (s)', 'amplitude (V)', 0, 0, 0, 0, yinf, ysup,...
        2, 0, 2, 'Times New Roman', 16)

    %figura sinal padrão interno (tempo)
    plota_figura_unica(gera_eixo_tempo(sinal_linhas_PI,Fs), sinal_linhas_PI,...
        1, 2,'Linhas padrão interno', 0, 'tempo (s)',...
        'amplitude (V)', 0, 0, 0, 0, yinf, ysup, modo_salvar_figura,...
        ['Comparação_padrão_externo_e_interno_',nome_sinal_bruto],...
        3, 'Times New Roman', 16)
end

if modo_plot == 6
    %plota figura de comparação por subplot para transições do padrão
    % interno

    %figura sinal original (tempo)
    plota_figura_unica(gera_eixo_tempo(sinal_sensor,Fs), sinal_sensor,...
        1, 1,nome_sinal_bruto, 0, 'tempo (s)',...
        'amplitude (V)', 0, 0, 0, 0, 0, 0, 2, 0, 3, 'Times New Roman', 16)

    %figura ponto separação entre padrões
    plota_figura_unica(gera_eixo_tempo(separacao_entre_pad,Fs),...
        separacao_entre_pad, 1, 2,'Separação entre padrões', 0,...
        'tempo (s)', 'amplitude (V)', 0, 0, 0, 0, yinf, ysup,...
        2, 0, 2, 'Times New Roman', 16)

    %figura sinal transições do padrão interno (tempo)
    plota_figura_unica(gera_eixo_tempo(sinal_trans_PI,Fs), sinal_trans_PI,...
        1, 2,'Transições padrão interno', 0, 'tempo (s)',...
        'amplitude (V)', 0, 0, 0, 0, yinf, ysup, modo_salvar_figura,...
        ['Comparação_transicao_padrao_interno_',nome_sinal_bruto],...
        3, 'Times New Roman', 16)


end

end

% OP2
function save_files(modo_salvar, nome_sinal_bruto, linhas_PE, linhas_PI,...
    trans_PI, mov_ini_PI, ponto_sep_PE_PI, sep_PE, sinal_linhas_PI,...
    sinal_trans_PI)

if modo_salvar == 1
    %salvar arquivos separados
    save  (['Linhas_PE_',nome_sinal_bruto],'linhas_PE');
    save  (['Linhas_PI_',nome_sinal_bruto],'linhas_PI');
    save  (['Trans_PI_',nome_sinal_bruto],'trans_PI');
    save  (['Movimento_ini_PI_',nome_sinal_bruto],'mov_ini_PI');
    save  (['Ponto_sep_PE_PI_',nome_sinal_bruto],'ponto_sep_PE_PI');
    save  (['Separação_PE_',nome_sinal_bruto],'sep_PE');
    save  (['Sinal_linhas_PI_',nome_sinal_bruto],'sinal_linhas_PI');
    save  (['Sinal_trans_PI_',nome_sinal_bruto],'sinal_trans_PI');
end

if modo_salvar == 2
    %salvar arquivo juntos
    save (['Sinais_de_separação_',nome_sinal_bruto],'linhas_PE', 'linhas_PI',...
        'trans_PI', 'mov_ini_PI', 'ponto_sep_PE_PI',...
        'sep_PE', 'sinal_linhas_PI',...
        'sinal_trans_PI');

end
end

% AUX1
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

end

% AUX2
function salvarFigura(hFigure, unit, size, res, fileName)




try
    if strcmp(get(hFigure,'Type'),'axes')
        hFigure = get(hFigure,'Parent');
    elseif ~strcmp(get(hFigure,'Type'),'figure')
        error('Error:salvarFigura','O handler informado não é do tipo ''figure''.')
    end
catch me
    error('Error:salvarFigura','O handler informado não é válido.')
end

unitVal = strcmp(unit, {'normalized' 'inches' 'centimeters' 'points'});
if sum(unitVal) == 0
    error('Error:salvarFigura', ['A unidade informada não é válida.\nValores aceitos:\n\t- normalized'...
        '\n\t- points\n\t- centimeters\n\t- inches']);
elseif sum(unitVal) > 1
    error('Error:salvarFigura', 'Deve ser informada apenas uma unidade.')
end

if strcmp(class(res),'double') %#ok<*STISA>
    res = ['-r' num2str(res)];
elseif strncmp('-r', res, 2) == 0
    error('Error:salvarFigura', 'O valor informado para a resolução não é válido.')
end

pos_ = [0 0 size(1) size(2)];

% oldPaperUnits = get(hFigure,'PaperUnits');
% oldPaperSize = get(hFigure,'PaperSize');
% oldPaperOrientation = get(hFigure,'PaperOrientation');
% oldPaperPositionMode = get(hFigure,'PaperPositionMode');
% oldPaperPosition = get(hFigure,'PaperPosition');

set(hFigure, 'PaperUnits', unit);
set(hFigure, 'PaperSize', size);
set(hFigure, 'PaperOrientation', 'portrait');
set(hFigure, 'PaperPositionMode', 'manual');
set(hFigure, 'PaperPosition', pos_);

print(hFigure, '-loose', res, '-djpeg', fileName);
%print(hFigure, '-loose', res, '-dtiff', fileName);

% set(hFigure, 'PaperUnits', oldPaperUnits);
% set(hFigure, 'PaperSize', oldPaperSize);
% set(hFigure, 'PaperOrientation', oldPaperOrientation);
% set(hFigure, 'PaperPositionMode', oldPaperPositionMode);
% set(hFigure, 'PaperPosition', oldPaperPosition);

end

% AUX3
function vetor_normalizado = Normaliz3r (vetor_original)
aux1 = max(vetor_original);
aux2 = vetor_original*-1;
aux3 = max(aux2);

if aux3 >= aux1
    aux1 = aux3;
end

vetor_normalizado = vetor_original/aux1;

end

% AUX4
function t = gera_eixo_tempo(sinal,Fs)
t = 0:(1/Fs):(length(sinal)-1)/Fs;
end

% AUX5
function sinal_final = plota_linha(tipo, valor_constante, sinal_referencia)

if (tipo == 1) % Linha vertical
    for i = 1:(valor_constante-1)
        sinal_final(1,i) = 0;
    end
    sinal_final(1,valor_constante) = max(sinal_referencia);
    for i = (valor_constante+1):length(sinal_referencia)
        sinal_final(1,i) = 0;
    end
end

if (tipo == 2) % Linha horizontal
    for i = 1:length(sinal_referencia)
        sinal_final(1,i) = valor_constante;
    end
end


end

% AUX6
function sinal_composto = Compos3r(sinal_base, matriz_posicoes, modo)

aux = zeros(length(sinal_base),1);

if modo == 1 % cria um vetor binário indicando com 1 onde há confluência
    % de posições entre a matriz de posições e o sinal base

    for i = 1:length(matriz_posicoes)
        aux(matriz_posicoes(i,2):matriz_posicoes(i,1)) = 1;
    end

    sinal_composto = aux;

end

if modo == 2 % cria um vetor que apresenta valores do sinal original
    % onde há confluência e posições entre a matriz de posições e o sinal
    % base, para as outras posições indica 0

    for i = 1:length(matriz_posicoes)
        aux(matriz_posicoes(i,2):matriz_posicoes(i,1)) =...
            sinal_base(matriz_posicoes(i,2):matriz_posicoes(i,1));
    end

    sinal_composto = aux;

end

end

% AUX7
function result_sep = encontra_ponto_separacao(Duracao, i,...
    referencia_tamanho)

val_atual = Duracao(i,1);
val_seguinte1 = Duracao(i+1,1);
val_seguinte2 = Duracao(i+2,1);
val_seguinte3 = Duracao(i+3,1);
val_seguinte4 = Duracao(i+4,1);
val_seguinte5 = Duracao(i+5,1);

sub_seguinte1 = val_atual - val_seguinte1;
sub_seguinte2 = val_atual - val_seguinte2;
sub_seguinte3 = val_atual - val_seguinte3;
sub_seguinte4 = val_atual - val_seguinte4;
sub_seguinte5 = val_atual - val_seguinte5;

if sub_seguinte1 >= referencia_tamanho && ...
   sub_seguinte2 >= referencia_tamanho && ...
   sub_seguinte3 >= referencia_tamanho && ...
   sub_seguinte4 >= referencia_tamanho && ...
   sub_seguinte5 >= referencia_tamanho && ...
   val_seguinte1 < referencia_tamanho && ...
   val_seguinte2 < referencia_tamanho && ...
   val_seguinte3 < referencia_tamanho && ...
   val_seguinte4 < referencia_tamanho && ...
   val_seguinte5 < referencia_tamanho 
result_sep = true;
else
    result_sep = false;

end


end




