% % LEIA-ME
% Esta função é utilizada para segmentar de forma automática as linhas de
% fabricação de contorno, que compõem o padrão externo, as linhas de
% fabricação raster, que compõem o padrão interno, e demais movimentações
% de um sinal obtido de fabricação monocamada pelo processo de fabricação
% por filamento fundido (FFF).
%
% % Versão 2.4
% Autoria: Thiago Glissoi Lopes - LADAPS - UNESP BAURU
% Última edição: Thiago Glissoi Lopes - LADAPS - UNESP BAURU

% CORE
function fff_segmenter (sensor_signal, Dir_X, Dir_Y, Fs)
%% Input prompts
clc;
disp ("Provide the signal identification");
prompt = "Signal name: ";
signal_identifier = input(prompt,'s');
if isempty(signal_identifier)
    signal_identifier = 'segmentation results';
end
clear prompt
clc;

disp ("Would you like to obtain the segmentation index (points) or the segments of signal (segments)? ");
prompt = "Response points/segments [points]: ";
segmentation_choice = input(prompt,'s');
if isempty(segmentation_choice)
    segmentation_choice = 'points';
end

test_segment_choice_points = strcmp(segmentation_choice,'points');
test_segment_choice_segments = strcmp(segmentation_choice,'segments');

if test_segment_choice_points ~= 1 && test_segment_choice_segments ~= 1
    segmentation_choice = 'points';
end


clear prompt
clc;

disp ("Would you like to obtain graphical visualization of the segmentation?");
prompt = "Response Y/N [Y]: ";
graphical_choice = input(prompt,'s');
if isempty(graphical_choice)
    graphical_choice = 'Y';
end

test_graphical_choice_Y = strcmp(graphical_choice,'Y');
test_graphical_choice_N = strcmp(graphical_choice,'N');

if test_graphical_choice_Y ~= 1 && test_graphical_choice_N ~= 1
    segmentation_choice = 'Y';
end

clear prompt
clc;
if graphical_choice == 'Y'
    disp ("Would you like to autosave the figures?");
    prompt = "Response Y/N [Y]: ";
    figure_choice = input(prompt,'s');
    if isempty(figure_choice)
        figure_choice = 'Y';
    end

    test_figure_choice_Y = strcmp(figure_choice,'Y');
    test_figure_choice_N = strcmp(figure_choice,'N');

    if test_figure_choice_Y ~= 1 && test_figure_choice_N ~= 1
        figure_choice = 'Y';
    end

    clc;
    clear prompt
end

disp ("Would you like to obtain automatic .mat files of the segmentation results?");
prompt = "Response Y/N [Y]: ";
save_choice = input(prompt,'s');
if isempty(save_choice)
    save_choice = 'Y';
end

test_save_choice_Y = strcmp(save_choice,'Y');
test_save_choice_N = strcmp(save_choice,'N');

if test_save_choice_Y ~= 1 && test_save_choice_N ~= 1
    save_choice = 'Y';
end

clc;
clear prompt

disp ("Choices");
disp ("Signal name: ");
disp (signal_identifier);
disp ("Segmentation choice: ");
disp (segmentation_choice);
disp ("Graphical choice: ");
disp (graphical_choice);
if graphical_choice == 'Y'
    disp ("Save figure choice: ");
    disp (figure_choice);
end
disp ("Save data choice: ");
disp (save_choice);
disp ("Wait just a few moments while we segment your FFF signal...");

%% Pré-processamentos


% generate_standard_fig(eixox, eixoy, tipo, nova_ou_sobrepor,...
%     legenda, titulo, label_eixox, label_eixoy, x_ticks, y_ticks, ...
%     limite_x1, limite_x2, limite_y1, limite_y2,...
%     tipo_legenda, tipo_fonte, tamanho_fonte)

% % DEBUG - POI-1 - Why adjust the X and Y signals?
% 
% figure;
% subplot(2,5,1:3);
% generate_standard_fig(obtain_time_vec(Dir_X,Fs), Dir_X, 1, 2,...
%     'Raw direction X signal', 'DEBUG - POI-1', 'Time (s)',...
%     'Amplitude (V)', 0, 0, ...
%     0, 0, 0, 0,...
%     4, 'Times New Roman', 16);
% 
% subplot(2,5,4);
% generate_standard_fig(obtain_time_vec(Dir_X,Fs), Dir_X, 1, 2,...
%     0 , 0 , 0,...
%     0, 0, 0, ...
%     50, 55, -0.5, 0.5,...
%     2, 'Times New Roman', 16);
% legend('off');
% 
% subplot(2,5,5);
% generate_standard_fig(obtain_time_vec(Dir_X,Fs), Dir_X, 1, 2,...
%     0 , 0 , 0,...
%     0, 0, 0, ...
%     50, 55, 4.5, 5.5,...
%     2, 'Times New Roman', 16);
% legend('off');
% 
% subplot(2,5,6:8);
% generate_standard_fig(obtain_time_vec(Dir_Y,Fs), Dir_Y, 1, 2,...
%     'Raw direction Y signal', 0, 'Time (s)',...
%     'Amplitude (V)', 0, 0, ...
%     0, 0, 0, 0,...
%     4, 'Times New Roman', 16);
% 
% subplot(2,5,9);
% generate_standard_fig(obtain_time_vec(Dir_Y,Fs), Dir_Y, 1, 2,...
%     0 , 0 , 0,...
%     0, 0, 0, ...
%     50, 55, -0.5, 0.5,...
%     2, 'Times New Roman', 16);
% legend('off');
% 
% subplot(2,5,10);
% generate_standard_fig(obtain_time_vec(Dir_Y,Fs), Dir_Y, 1, 2,...
%     0 , 0 , 0,...
%     0, 0, 0, ...
%     50, 55, 4.5, 5.5,...
%     2, 'Times New Roman', 16);
% legend('off');
% 
%     DEBUG_ID = 'POI-1.png';
%     salvarFigura(gca,'centimeters',[13 8]*1.8,600,DEBUG_ID);
% 
% % \ DEBUG - POI-1

Dir_X_ajustado = zeros(size(Dir_X));
Dir_Y_ajustado = zeros(size(Dir_Y));

% 1° Normalize the X and Y step motor control signals between 0V and 5V
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
% \ 1°

% % DEBUG - POI-2 - X and Y adjusted signals
% 
% figure;
% subplot(2,5,1:3);
% generate_standard_fig(obtain_time_vec(Dir_X_ajustado,Fs), Dir_X_ajustado, 1, 2,...
%     'Adjusted direction X signal', 'DEBUG - POI-2', 'Time (s)',...
%     'Amplitude (V)', 0, 0, ...
%     0, 0, 0, 0,...
%     4, 'Times New Roman', 16);
% 
% subplot(2,5,4);
% generate_standard_fig(obtain_time_vec(Dir_X_ajustado,Fs), Dir_X_ajustado, 1, 2,...
%     0 , 0 , 0,...
%     0, 0, 0, ...
%     50, 55, -0.5, 0.5,...
%     2, 'Times New Roman', 16);
% legend('off');
% 
% subplot(2,5,5);
% generate_standard_fig(obtain_time_vec(Dir_X_ajustado,Fs), Dir_X_ajustado, 1, 2,...
%     0 , 0 , 0,...
%     0, 0, 0, ...
%     50, 55, 4.5, 5.5,...
%     2, 'Times New Roman', 16);
% legend('off');
% 
% subplot(2,5,6:8);
% generate_standard_fig(obtain_time_vec(Dir_Y_ajustado,Fs), Dir_Y_ajustado, 1, 2,...
%     'Adjusted direction Y signal', 0, 'Time (s)',...
%     'Amplitude (V)', 0, 0, ...
%     0, 0, 0, 0,...
%     4, 'Times New Roman', 16);
% 
% subplot(2,5,9);
% generate_standard_fig(obtain_time_vec(Dir_Y_ajustado,Fs), Dir_Y_ajustado, 1, 2,...
%     0 , 0 , 0,...
%     0, 0, 0, ...
%     50, 55, -0.5, 0.5,...
%     2, 'Times New Roman', 16);
% legend('off');
% 
% subplot(2,5,10);
% generate_standard_fig(obtain_time_vec(Dir_Y_ajustado,Fs), Dir_Y_ajustado, 1, 2,...
%     0 , 0 , 0,...
%     0, 0, 0, ...
%     50, 55, 4.5, 5.5,...
%     2, 'Times New Roman', 16);
% legend('off');
% 
%     DEBUG_ID = 'POI-2.png';
%     salvarFigura(gca,'centimeters',[13 8]*1.8,600,DEBUG_ID);
% 
% % \ DEBUG - POI-2

% 2° Normalize the acoustic signal, and the X and Y step motor control
% signals between -1 and 1 (acoustic signal) and 0 & 1 (step motor signals)

sensor_signal_normalizado = Normaliz3r(sensor_signal);
Dir_Y_ajustado_normalizado = Normaliz3r(Dir_Y_ajustado);
Dir_X_ajustado_normalizado = Normaliz3r(Dir_X_ajustado);
% \ 2°

% % DEBUG - POI-3 - X and Y Normalized signals
% 
% figure;
% subplot(2,5,1:3);
% generate_standard_fig(obtain_time_vec(Dir_X_ajustado_normalizado,Fs), Dir_X_ajustado_normalizado, 1, 2,...
%     'Normalized direction X signal', 'DEBUG - POI-3', 'Time (s)',...
%     'Amplitude (V)', 0, 0, ...
%     0, 0, 0, 0,...
%     4, 'Times New Roman', 16);
% 
% subplot(2,5,4);
% generate_standard_fig(obtain_time_vec(Dir_X_ajustado_normalizado,Fs), Dir_X_ajustado_normalizado, 1, 2,...
%     0 , 0 , 0,...
%     0, 0, 0, ...
%     50, 55, -0.5, 0.5,...
%     2, 'Times New Roman', 16);
% legend('off');
% 
% subplot(2,5,5);
% generate_standard_fig(obtain_time_vec(Dir_X_ajustado_normalizado,Fs), Dir_X_ajustado_normalizado, 1, 2,...
%     0 , 0 , 0,...
%     0, 0, 0, ...
%     50, 55, -0.5, 0.5,...
%     2, 'Times New Roman', 16);
% legend('off');
% 
% subplot(2,5,6:8);
% generate_standard_fig(obtain_time_vec(Dir_Y_ajustado_normalizado,Fs), Dir_Y_ajustado_normalizado, 1, 2,...
%     'Normalized direction Y signal', 0, 'Time (s)',...
%     'Amplitude (V)', 0, 0, ...
%     0, 0, 0, 0,...
%     4, 'Times New Roman', 16);
% 
% subplot(2,5,9);
% generate_standard_fig(obtain_time_vec(Dir_Y_ajustado_normalizado,Fs), Dir_Y_ajustado_normalizado, 1, 2,...
%     0 , 0 , 0,...
%     0, 0, 0, ...
%     50, 55, -0.5, 0.5,...
%     2, 'Times New Roman', 16);
% legend('off');
% 
% subplot(2,5,10);
% generate_standard_fig(obtain_time_vec(Dir_Y_ajustado_normalizado,Fs), Dir_Y_ajustado_normalizado, 1, 2,...
%     0 , 0 , 0,...
%     0, 0, 0, ...
%     50, 55, -0.5, 0.5,...
%     2, 'Times New Roman', 16);
% legend('off');
% 
%     DEBUG_ID = 'POI-3.png';
%     salvarFigura(gca,'centimeters',[13 8]*1.8,600,DEBUG_ID);
% 
% % \ DEBUG - POI-3


% % DEBUG - POI-4 - why verify the minimum variation number?
% 
% figure;
% subplot(2,2,1:2);
% generate_standard_fig(obtain_time_vec(Dir_X_ajustado_normalizado,Fs), Dir_X_ajustado_normalizado, 1, 2,...
%     'Normalized direction X signal', 'DEBUG - POI-4', 'Time (s)',...
%     'Amplitude (V)', 0, 0, ...
%     0, 0, 0, 0,...
%     4, 'Times New Roman', 16);
% 
% subplot(2,2,3);
% generate_standard_fig(obtain_time_vec(Dir_X_ajustado_normalizado,Fs), Dir_X_ajustado_normalizado, 1, 2,...
%     0 , 0 , 'Time (s)',...
%     'Amplitude (V)', 0, 0,...
%     50.115, 50.155, 0, 0,...
%     2, 'Times New Roman', 16);
% legend('off');
% 
% subplot(2,2,4);
% generate_standard_fig(obtain_time_vec(Dir_X_ajustado_normalizado,Fs), Dir_X_ajustado_normalizado, 1, 2,...
%     0 , 0 , 'Time (s)',...
%     0, 0, 0,...
%     50.133, 50.135, 0, 0,...
%     2, 'Times New Roman', 16);
% legend('off');
% 
%     DEBUG_ID = 'POI-4.png';
%     salvarFigura(gca,'centimeters',[13 8]*1.8,600,DEBUG_ID);
% 
% % \ DEBUG - POI-4

% 3° Test for the occurence of the variation problem
result_problem = test_Minvariations(sensor_signal_normalizado, Dir_X_ajustado_normalizado,...
    Dir_Y_ajustado_normalizado);
% \ 3°

clear Dir_X_ajustado Dir_X Dir_Y_ajustado Dir_Y sensor_signal

%% External pattern segmentation

% result_problem = true; % % Necessary for the May/2023 data

% 4° Obtain the duration vector
Duration = obtainDuration(sensor_signal_normalizado, Dir_X_ajustado_normalizado,...
    Dir_Y_ajustado_normalizado, result_problem);
% \ 4°

% % DEBUG - POI-6 - Duration for the external analysis
% 
% generate_standard_fig(1:length(Duration(:,1)), Duration(:,1), 1, 1,...
%     'Duration', 'DEBUG - POI-6', 'Segment',...
%     'Duration (number of samples)', 0, 0, ...
%     0, 0, 0, 0,...
%     2, 'Times New Roman', 16);
% 
% DEBUG_ID = 'POI-6.png';
% salvarFigura(gca,'centimeters',[13 8]*1.8,600,DEBUG_ID);
% 
% % \ DEBUG - POI-6

% Para permitir encontrar o ponto de separacao entre padrão externo e
% padrão interno, vou percorrer todo o vetor da Duration até encontrar um
% valor conhecido de Duration (Duration da fabricação da linha 10). Ai
% armazeno as posições relativas ao início da fabricação da linha 10, linha
% 11 e linha 12. Sei que as 3 devem ser muito similares, então faço um
% teste nas linhas 11 e 12. Se elas estiverem dentro do mesmo intervalo,
% está identificado o final do padrão externo. Caso negativo, volto a
% verificar na duração por este padrão.

% 5° Find the separation point
referencia_tamanho = 150e3; % known duration for the last contour printing

for i = 1:length(Duration(:,1))

    result_sep = encontra_ponto_separacao(Duration, i, referencia_tamanho);

    if result_sep == true
        ponto_signal_contour_PI = Duration(i,2);
        break;
    else
        clear result_sep
    end
end
% \ 5°

% 6° Contour lines obtaining
separation_index = find(Duration(:,3) == ponto_signal_contour_PI);
linhas_PE = zeros(1,13);
cont = 1;

for i = 1:13
    linhas_PE(1,i) = Duration(separation_index-13+i,3);
end
for i = 1:length(linhas_PE)-1
    index_contour_temp(cont,1) = linhas_PE(i+1) - linhas_PE(i);
    index_contour_temp(cont,2) = linhas_PE(i);
    index_contour_temp(cont,3) = linhas_PE(i+1);
    cont = cont+1;
end
% \ 6°

% 7° Repositioning evaluation and contour lines correction

% reposition 1
mean_contourgroup1 = round(mean([index_contour_temp(2,1) index_contour_temp(3,1)...
    index_contour_temp(4,1)]),0);

correct_contour_line1(1,1) = mean_contourgroup1;
correct_contour_line1(1,3) = index_contour_temp(1,3);
correct_contour_line1(1,2) = index_contour_temp(1,3) - mean_contourgroup1;

if index_contour_temp(1,1) - mean_contourgroup1 < 1
repo_to_contour_line1(1,1) = abs(index_contour_temp(1,1) - mean_contourgroup1);
repo_to_contour_line1(1,3) = correct_contour_line1(1,2);
repo_to_contour_line1(1,2) = repo_to_contour_line1(1,3)...
    - repo_to_contour_line1(1,1);
else
repo_to_contour_line1(1,1) = index_contour_temp(1,1) - mean_contourgroup1;
repo_to_contour_line1(1,3) = correct_contour_line1(1,2);
repo_to_contour_line1(1,2) = index_contour_temp(1,2);
end

% reposition 2
mean_contourgroup2 = round(mean([index_contour_temp(6,1) index_contour_temp(7,1)...
    index_contour_temp(8,1)]),0);

correct_contour_line5(1,1) = mean_contourgroup2;
correct_contour_line5(1,3) = index_contour_temp(5,3);
correct_contour_line5(1,2) = index_contour_temp(5,3) - mean_contourgroup2;

repo_to_contour_line5(1,1) = index_contour_temp(5,1) - mean_contourgroup2;
repo_to_contour_line5(1,3) = correct_contour_line5(1,2);
repo_to_contour_line5(1,2) = index_contour_temp(5,2);

% reposition 3
mean_contourgroup3 = round(mean([index_contour_temp(10,1) index_contour_temp(11,1)...
    index_contour_temp(12,1)]),0);

correct_contour_line9(1,1) = mean_contourgroup3;
correct_contour_line9(1,3) = index_contour_temp(9,3);
correct_contour_line9(1,2) = index_contour_temp(9,3) - mean_contourgroup3;

repo_to_contour_line9(1,1) = index_contour_temp(9,1) - mean_contourgroup3;
repo_to_contour_line9(1,3) = correct_contour_line9(1,2);
repo_to_contour_line9(1,2) = index_contour_temp(9,2);

index_contour = index_contour_temp;
index_contour(1,:) = correct_contour_line1;
index_contour(5,:) = correct_contour_line5;
index_contour(9,:) = correct_contour_line9;

contour_repositions = [repo_to_contour_line1; repo_to_contour_line5; repo_to_contour_line9];
% \ 7°

%% Internal pattern segmentation

% 8° Obtaining first duration matrix for the internal pattern
% There is no need to check for the problem of too many consecutive transition lines here
% since there are very small line segments in the internal pattern. On the cobtrary, 
% this could cause some issues. So the result_problem value is set to false.
result_problem = false;

% Obtaining duration matrix
Duration = obtainDuration(sensor_signal_normalizado, Dir_X_ajustado_normalizado,...
    Dir_Y_ajustado_normalizado, result_problem);

% \ 8°

% % DEBUG - POI-7 - First duration for the internal analysis
% 
% generate_standard_fig(1:length(Duration(:,1)), Duration(:,1), 1, 1,...
%     'Duration', 'DEBUG - POI-7', 'Segment',...
%     'Duration (number of samples)', 0, 0, ...
%     0, 0, 0, 0,...
%     2, 'Times New Roman', 16);
% 
% DEBUG_ID = 'POI-7.png';
% salvarFigura(gca,'centimeters',[13 8]*1.8,600,DEBUG_ID);
% 
% % \ DEBUG - POI-7

% 9° Obtaining second duration matrix for the internal pattern

% Filtering the duration matrix to remove the small line segments
cont_val_8000 = 1;
Duration2 = zeros(3);
alterationDuration = 8000;
for i = 1:length(Duration(:,1))
    if Duration(i,1) > alterationDuration
        Duration2(cont_val_8000,:) = Duration(i,:);
        cont_val_8000 = cont_val_8000 + 1;
    end
end

clear Duration
% \ 9°

% % DEBUG - POI-8 - Second duration for the internal analysis
% 
% generate_standard_fig(1:length(Duration2(:,1)), Duration2(:,1), 1, 1,...
%     'Duration', 'DEBUG - POI-8', 'Segment',...
%     'Duration (number of samples)', 0, 0, ...
%     0, 0, 0, 0,...
%     2, 'Times New Roman', 16);
% 
% DEBUG_ID = 'POI-8.png';
% salvarFigura(gca,'centimeters',[13 8]*1.8,600,DEBUG_ID);
% 
% % \ DEBUG - POI-8

% 10° Obtaining third duration matrix for the internal pattern

lines_under_9000_samples = find(Duration2(:,1) < 9000);
Duration3 = zeros(3);
previousPeak = 0;
previousPeak2 = 0;
middle_rasterDuration = 310e3;

for i = 1:length (lines_under_9000_samples)
    if i == length (lines_under_9000_samples)
        break;
    end
    index_ini = lines_under_9000_samples(i);
    index_fin = lines_under_9000_samples(i+1);
    result = detectAnom(index_ini, index_fin);
    previousPeak2 = previousPeak;
    previousPeak = Duration3(end-1,1);
    if  previousPeak < previousPeak2 % Change of behaviour from increasing to decreasing
        break;
    end
    if  previousPeak > middle_rasterDuration % Is larger than the middle raster duration, 
    % found the end of the increasing behaviour
        break;
    end
    if result == true % normal situation
        tempDuration= isNormal(Duration2, ...
            index_ini, index_fin, ...
            1);
        if Duration3(1,1) == 0
            Duration3 = tempDuration;
        else
            Duration3 = [Duration3(1:end-1,:); tempDuration];
        end
        clear tempDuration
    else % abnormal situation
        tempDuration = isAnormal(Duration2, ...
            index_ini, index_fin, ...
            previousPeak);
        Duration3 = [Duration3(1:end-1,:); tempDuration];
        clear tempDuration
    end
end

clear Duration2
% \ 10°

% % DEBUG - POI-9 - Third duration for the internal analysis
% 
% generate_standard_fig(1:length(Duration3(:,1)), Duration3(:,1), 1, 1,...
%     'Duration', 'DEBUG - POI-9', 'Segment',...
%     'Duration (number of samples)', 0, 0, ...
%     0, 0, 0, 0,...
%     2, 'Times New Roman', 16);
% 
% DEBUG_ID = 'POI-9.png';
% salvarFigura(gca,'centimeters',[13 8]*1.8,600,DEBUG_ID);
% 
% % \ DEBUG - POI-9

% 11° Obtaining fourth duration matrix for the internal pattern
aux1 = find (Duration3(:,1) == previousPeak2);
Duration3_v2 = Duration3(1:end-(end-aux1)+1,:);
% \ 11°

clear Duration3
% % DEBUG - POI-10 - Fourth duration for the internal analysis
% 
% generate_standard_fig(1:length(Duration3_v2(:,1)), Duration3_v2(:,1), 1, 1,...
%     'Duration', 'DEBUG - POI-10', 'Segment',...
%     'Duration (number of samples)', 0, 0, ...
%     0, 0, 0, 0,...
%     2, 'Times New Roman', 16);
% 
% DEBUG_ID = 'POI-10.png';
% salvarFigura(gca,'centimeters',[13 8]*1.8,600,DEBUG_ID);
% 
% % \ DEBUG - POI-10

% 12° Obtaining fifth duration matrix for the internal pattern
% Raster area mirroring

cont = length(Duration3_v2(:,1));
Duration4 = Duration3_v2;

for i = 1:length(Duration3_v2(:,1))-2
    if i == 1
        Duration4(cont,1) = Duration3_v2(length(Duration3_v2(:,1))-i-1,1);
        Duration4(cont,3) = Duration3_v2(length(Duration3_v2(:,1))-i,2);
        Duration4(cont,2) = Duration4(cont,3) + Duration4(cont,1);
        cont = cont + 1;
    end
    if i ~= 1
        Duration4(cont,1) = Duration3_v2(length(Duration3_v2(:,1))-i-1,1);
        Duration4(cont,3) = Duration4(cont-1,2);
        Duration4(cont,2) = Duration4(cont,3) + Duration4(cont,1);
        cont = cont + 1;
    end
end
% \ 12°

clear Duration3_v2

% % DEBUG - POI-11 - Fifith duration for the internal analysis
% 
% generate_standard_fig(1:length(Duration4(:,1)), Duration4(:,1), 1, 1,...
%     'Duration', 'DEBUG - POI-11', 'Segment',...
%     'Duration (number of samples)', 0, 0, ...
%     0, 0, 0, 0,...
%     2, 'Times New Roman', 16);
% 
% DEBUG_ID = 'POI-11.png';
% salvarFigura(gca,'centimeters',[13 8]*1.8,600,DEBUG_ID);
% 
% % \ DEBUG - POI-11

% 13° Obtaining sixth duration matrix for the internal pattern
% Obtain the first raster line and add to the beggining of the duraction matrix
Duration4_v2(1,2) = Duration4(1,3);
Duration4_v2(1,1) = Duration4(2,1)-11e3;
Duration4_v2(1,3) = Duration4_v2(1,2) - Duration4_v2(1,1);
Duration4_v2(2:length(Duration4(:,1))+1,:) = Duration4;

% Obtain the last raster line and add to the end of the duraction matrix
Duration4_v2(length(Duration4(:,1))+2,3) = Duration4_v2(length(Duration4(:,1))+1,2);
Duration4_v2(length(Duration4(:,1))+2,1) = Duration4_v2(length(Duration4(:,1)),1)-11e3;
Duration4_v2(length(Duration4(:,1))+2,2) = Duration4_v2(length(Duration4(:,1))+2,1) + Duration4_v2(length(Duration4(:,1))+2,3);
% \ 13°

clear Duration4
% % DEBUG - POI-12 - Eleventh duration for the internal analysis
% 
% generate_standard_fig(1:length(Duration4_v2(:,1)), Duration4_v2(:,1), 1, 1,...
%     'Duration', 'DEBUG - POI-12', 'Segment',...
%     'Duration (number of samples)', 0, 0, ...
%     0, 0, 0, 0,...
%     2, 'Times New Roman', 16);
% 
% DEBUG_ID = 'POI-12.png';
% salvarFigura(gca,'centimeters',[13 8]*1.8,600,DEBUG_ID);
% 
% % \ DEBUG - POI-12

% 14° Obtaining the index values from the last duration matrix
cont_internal = 1;
cont_trans_internal = 1;

for j = 1:length(Duration4_v2(:,1))
    if Duration4_v2(j,1) < 8000 || Duration4_v2(j,1) > 9000
        index_raster(cont_internal,:) = Duration4_v2(j,:);
        cont_internal = cont_internal + 1;
    else
        index_trans_raster(cont_trans_internal,:) = Duration4_v2(j,:);
        cont_trans_internal = cont_trans_internal + 1;
    end
end

contour_to_raster_reposition(1,3) = index_contour(12,3);
contour_to_raster_reposition(1,2) = Duration4_v2(1,3);
contour_to_raster_reposition(1,1) = contour_to_raster_reposition(1,2) -...
    contour_to_raster_reposition(1,3);

index_contour_alt = index_contour;

for i = 1:1:12
    index_contour_alt(i,2) = index_contour(i,2);
    index_contour_alt(i,3) = index_contour(i,3)-5;
end

if length(index_raster) < 55
    [index_raster,index_trans_raster] =...
        adjust_internal(index_raster,index_trans_raster);

end


signal_reposition = Compos3r(sensor_signal_normalizado,contour_to_raster_reposition(:,2:3))+...
    Compos3r(sensor_signal_normalizado,contour_repositions(:,2:3));
signal_raster = Compos3r(sensor_signal_normalizado, index_raster(:,2:3));
signal_trans_raster = Compos3r(sensor_signal_normalizado, index_trans_raster(:,2:3));
signal_contour = Compos3r(sensor_signal_normalizado, index_contour_alt(:,2:3));

% \ 14°

% 15° Obtain the segmentation results

test_segment_choice = strcmp(segmentation_choice,'points');

if test_segment_choice == true
    result_reposition = [contour_repositions; contour_to_raster_reposition];
    result_contour = index_contour;
    result_raster = index_raster;
    result_transition_raster = index_trans_raster;
end

test_segment_choice = strcmp(segmentation_choice,'segments');

if test_segment_choice == true
    result_reposition = gen_signal_segments(sensor_signal_normalizado,...
        contour_repositions);
    result_reposition(1,4) = gen_signal_segments(sensor_signal_normalizado,...
        contour_to_raster_reposition);
    result_contour = gen_signal_segments(sensor_signal_normalizado, index_contour);
    result_raster = gen_signal_segments(sensor_signal_normalizado, index_raster);
    result_transition_raster = gen_signal_segments(sensor_signal_normalizado, index_trans_raster);
end

% \ 15°

% 16° Save the results and generate the graphs

if save_choice == 'Y'
    save_files(result_reposition, result_contour, result_raster,...
        result_transition_raster, segmentation_choice, signal_identifier);
end

if graphical_choice == 'Y'
    gen_graph(signal_reposition, sensor_signal_normalizado, Fs,...
        signal_identifier, signal_contour, signal_raster,...
        signal_trans_raster, index_raster, figure_choice);
end

% \ 16°

end

% SUB1
function result = detectAnom(initialPoint, lastPoint)

if lastPoint - initialPoint == 2
    % Normal situation
    result = true;

else
    % Abnormal situation
    result = false;

end
end

% SUB2
function composedDuration = isNormal(originalDuration, ...
    initialPoint, lastPoint, ...
    indexDuration)

% Transition period (aprox 8000 samples)
composedDuration(indexDuration, 3) =  originalDuration(initialPoint,3);
composedDuration(indexDuration, 2) =  originalDuration(initialPoint,2);
composedDuration(indexDuration, 1) =  composedDuration(indexDuration, 2)...
    - composedDuration(indexDuration, 3);

% Raster period (value above 9000 samples, and that increases
% 11e3 in relation to the previous fabrication period
composedDuration(indexDuration+1, 3) =  originalDuration(initialPoint+1,3);
composedDuration(indexDuration+1, 2) =  originalDuration(initialPoint+1,2);
composedDuration(indexDuration+1, 1) =  composedDuration(indexDuration+1, 2)...
    - composedDuration(indexDuration+1, 3);

% Transition period (aprox 8000 samples)
composedDuration(indexDuration+2, 3) =  originalDuration(lastPoint,3);
composedDuration(indexDuration+2, 2) =  originalDuration(lastPoint,2);
composedDuration(indexDuration+2, 1) =  composedDuration(indexDuration+2, 2)...
    - composedDuration(indexDuration+2, 3);
end

% SUB3
function composedDuration = isAnormal(originalDuration, ...
    initialPoint, lastPoint, ...
    picoAnterior)


    cont = 1;
    for i = initialPoint:2:lastPoint
        if lastPoint - i == 1 || lastPoint == i 
            if lastPoint - initialPoint > 3
            % normal transition
            % Transition period (aprox 8000 samples)
            composedDuration(cont, 3) =  composedDuration(cont-1, 2);
            composedDuration(cont, 2) =  originalDuration(lastPoint, 2);
            composedDuration(cont, 1) =  composedDuration(cont, 2)...
                - composedDuration(cont, 3);
            if composedDuration(cont, 1) < 0 % overlap the treshold
                aux = length(composedDuration(:,1));
                composedDuration2(:,:) = composedDuration(1:aux-2,:);
                clear composedDuration
                composedDuration =  composedDuration2;
                clear composedDuration2
                aux = length(composedDuration(:,1));
                if aux == 1
                    break;
                end
                cont = cont-2;
                composedDuration(cont, 3) =  composedDuration(cont-1, 2);
                composedDuration(cont, 2) =  originalDuration(lastPoint, 2);
                composedDuration(cont, 1) =  composedDuration(cont, 2)...
                   - composedDuration(cont, 3);
               if composedDuration(cont, 1) < 0 % overlap the treshold
                   aux = length(composedDuration(:,1));
                   composedDuration2(:,:) = composedDuration(1:aux-2,:);
                    clear composedDuration
                    composedDuration =  composedDuration2;
                    clear composedDuration2
                    cont = cont-2;
                    composedDuration(cont, 3) =  composedDuration(cont-1, 2);
                    composedDuration(cont, 2) =  originalDuration(lastPoint, 2);
                    composedDuration(cont, 1) =  composedDuration(cont, 2)...
                        - composedDuration(cont, 3);
                end
            end
            break;
            end
        end
        if i == initialPoint % If it is the first case
           % Transition period (aprox 8000 samples)
           composedDuration(cont, 3) =  originalDuration(i,3); %#ok<*AGROW>
           composedDuration(cont, 2) =  originalDuration(i,2);
           composedDuration(cont, 1) =  composedDuration(cont, 2)...
               - composedDuration(cont, 3);
           cont = cont +1;
       else % Normal transition
           composedDuration(cont, 3) =  composedDuration(cont-1, 2);
           composedDuration(cont, 2) =  composedDuration(cont, 3) +...
               8.4e3;
           composedDuration(cont, 1) =  composedDuration(cont, 2)...
               - composedDuration(cont, 3);
           cont = cont +1;
       end
       % Transition period (aprox 8000 samples), and that grows
       % 11e3 in relation to the previous fabrication period
       composedDuration(cont, 3) =  composedDuration(cont-1, 2);
       composedDuration(cont, 2) =  composedDuration(cont, 3) +...
           picoAnterior + 11e3;
       composedDuration(cont, 1) =  composedDuration(cont, 2)...
           - composedDuration(cont, 3);
        picoAnterior = composedDuration(cont, 1);
        cont = cont +1;
   
        % Normal transition
        composedDuration(cont, 3) =  composedDuration(cont-1, 2);
        composedDuration(cont, 2) =  composedDuration(cont, 3) +...
            8.4e3;
        composedDuration(cont, 1) =  composedDuration(cont, 2)...
            - composedDuration(cont, 3);
    end
end

% SUB4
function duration = obtainDuration (sensor_signal_normalizado, Dir_X_ajustado_normalizado,...
    Dir_Y_ajustado_normalizado, result_problem)

valor_x = 0;
valor_y = 0;
ultima_mudanca = 0;
if result_problem == true
    minimum_sampleValue = 50e3;
else
    minimum_sampleValue = 0;
end

Posicao_mudanca = zeros(size(sensor_signal_normalizado))';

for i = 1:length(sensor_signal_normalizado)
    if Dir_X_ajustado_normalizado(i) ~= valor_x &&...
            i - ultima_mudanca >= minimum_sampleValue
        valor_x = Dir_X_ajustado_normalizado(i);
        Posicao_mudanca(i) = 1;
        ultima_mudanca = i;
    else
        if Dir_Y_ajustado_normalizado(i) ~= valor_y &&...
                i - ultima_mudanca >= minimum_sampleValue
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
position_Initial = 0;
position_Final = 0;
cont = 1;

for i = 1:length(Posicao_mudanca)
    if Posicao_mudanca(i) == 1 && flag == 0
        position_Initial = i;
        flag = 1;
    else
        if Posicao_mudanca(i) == 1 && flag == 1
            position_Final = i;
            flag = 2;
        end
    end
    if flag == 2
        duration(cont,1) = position_Final - position_Initial; %#ok<*SAGROW>
        duration(cont,2) = position_Final;
        duration(cont,3) = position_Initial;
        cont = cont+1;
        flag = 1;
        position_Initial = position_Final;
    end
end
end

% SUB5
function result_problem = test_Minvariations(sensor_signal_normalizado, Dir_X_ajustado_normalizado,...
    Dir_Y_ajustado_normalizado)

% TODO Incoporar teste de se houve dados com poucas amostras entre as
% linhas do padrão externo

valor_x = 0;
valor_y = 0;
ultima_mudanca = 0;
minimum_sampleValue = 0;

Posicao_mudanca = zeros(size(sensor_signal_normalizado))';

for i = 1:length(sensor_signal_normalizado)
    if Dir_X_ajustado_normalizado(i) ~= valor_x &&...
            i - ultima_mudanca >= minimum_sampleValue
        valor_x = Dir_X_ajustado_normalizado(i);
        Posicao_mudanca(i) = 1;
        ultima_mudanca = i;
    else
        if Dir_Y_ajustado_normalizado(i) ~= valor_y &&...
                i - ultima_mudanca >= minimum_sampleValue
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
position_Initial = 0;
position_Final = 0;
cont = 1;

for i = 1:length(Posicao_mudanca)
    if Posicao_mudanca(i) == 1 && flag == 0
        position_Initial = i;
        flag = 1;
    else
        if Posicao_mudanca(i) == 1 && flag == 1
            position_Final = i;
            flag = 2;
        end
    end
    if flag == 2
        duration(cont,1) = position_Final - position_Initial; %#ok<*SAGROW>
        duration(cont,2) = position_Final;
        duration(cont,3) = position_Initial;
        cont = cont+1;
        flag = 1;
        position_Initial = position_Final;
    end
end

cont_low_dur = 0;

for i = 1:length(duration(:,1))
    if duration(i,1) < 8e3
        cont_low_dur = cont_low_dur + 1;
    end
end

% % DEBUG - POI-5 - why the min value of 50?
% 
% generate_standard_fig(1:length(duration(:,1)), duration(:,1), 1, 1,...
%     'Duration', 'DEBUG - POI-5', 'Segment',...
%     'Duration (number of samples)', 0, 0, ...
%     0, 0, 0, 0,...
%     2, 'Times New Roman', 16);
% 
% DEBUG_ID = 'POI-5.png';
% salvarFigura(gca,'centimeters',[13 8]*1.8,600,DEBUG_ID);
% 
% % \ DEBUG - POI-5

if cont_low_dur > 50
    result_problem = true;
else
    result_problem = false;
end




end

% OP1
function gen_graph(signal_reposition, sensor_signal, Fs,...
    signal_identifier, signal_contour, signal_raster,...
    signal_trans_raster, index_raster, figure_choice)

sensor_signal = Normaliz3r(sensor_signal);

% Segment signals for the zoom window

sensor_signal_segmented =...
    sensor_signal(index_raster(1,3)-(2.0*Fs):index_raster(1,3)+(1.5*Fs));

signal_contour_segmented =...
    signal_contour(index_raster(1,3)-(2.0*Fs):index_raster(1,3)+(1.5*Fs));

signal_reposition_segmented =...
    signal_reposition(index_raster(1,3)-(2.0*Fs):index_raster(1,3)+(1.5*Fs));

signal_raster_segmented =...
    signal_raster(index_raster(1,3)-(2.0*Fs):index_raster(1,3)+(1.5*Fs));

signal_trans_raster_segmented =...
    signal_trans_raster(index_raster(1,3)-(2.0*Fs):index_raster(1,3)+(1.5*Fs));

t_segmented = obtain_time_vec(sensor_signal_segmented,200e3);

%

t = obtain_time_vec(sensor_signal,Fs);

sensor_signal = decimate(sensor_signal,10);
signal_reposition = decimate(signal_reposition,10);

t_decimated = obtain_time_vec(sensor_signal,Fs/10);

%Obtain the last point of the external pattern index in the time domain
a = index_raster(1,3)/Fs;
xlim_min = a - 2.0;
xlim_max = a + 1.5;

ticks = round(xlim_min:1:xlim_max,1);
ticks = num2str(ticks');

figure;
subplot (2,3,1:2);
generate_standard_fig(t_decimated, sensor_signal, 1, 2,...
    'Acoustic signal', 0, 0, 0, 0, 0, ...
    0, 0, -1.1, 1.1,...
    2, 'Times New Roman', 16);
generate_standard_fig(t, signal_contour, 1, 2,...
    'Contour lines', 0, 0, 0, 0, 0, ...
    0, 0, -1.1, 1.1,...
    2, 'Times New Roman', 16);
generate_standard_fig(t_decimated, signal_reposition, 1, 2,...
    'Reposition', 0, 0, 0, 0, 0, ...
    0, 0, -1.1, 1.1,...
    2, 'Times New Roman', 16);
generate_standard_fig(t, signal_raster, 1, 2,...
    'Raster lines', 0, 'Time (s)', 'Normalized amplitude', 0, 0, ...
    0, 100, -1.1, 1.1,...
    4, 'Times New Roman', 16);


% zoom
subplot (2,3,3);
generate_standard_fig(t_segmented, sensor_signal_segmented, 1, 2,...
    0, 0, 0, 0, 0, 0, ...
    0, 0, -1.1, 1.1,...
    2, 'Times New Roman', 16);
generate_standard_fig(t_segmented, signal_contour_segmented, 1, 2,...
    0, 0, 0, 0, 0, 0, ...
    0, 0, -1.1, 1.1,...
    2, 'Times New Roman', 16);
generate_standard_fig(t_segmented, signal_reposition_segmented, 1, 2,...
    0, 0, 0, 0, 0, 0, ...
    0, 0, -1.1, 1.1,...
    2, 'Times New Roman', 16);
generate_standard_fig(t_segmented, signal_raster_segmented, 1, 2,...
    0, 0, 0, 0, 0:1:3.5, 0, ...
    0, length(signal_raster_segmented)/Fs, 0, 1.1,...
    5, 'Times New Roman', 16);
legend('off');
grid minor;

xticklabels (ticks);

subplot (2,3,4:5);
generate_standard_fig(t_decimated, sensor_signal, 1, 2,...
    'Acoustic signal', 0, 0, 0, 0, 0, ...
    0, 0, -1.1, 1.1,...
    2, 'Times New Roman', 16);
generate_standard_fig(t, signal_contour, 1, 2,...
    'Contour lines', 0, 0, 0, 0, 0, ...
    0, 0, -1.1, 1.1,...
    2, 'Times New Roman', 16);
generate_standard_fig(t_decimated, signal_reposition, 1, 2,...
    'Reposition', 0, 0, 0, 0, 0, ...
    0, 0, -1.1, 1.1,...
    2, 'Times New Roman', 16);
generate_standard_fig(t, signal_trans_raster, 1, 2,...
    'Transition between raster lines',...
    0, 'Time (s)', 'Normalized amplitude', 0, 0, ...
    0, 100, -1.1, 1.1,...
    4, 'Times New Roman', 16);

%zoom
subplot (2,3,6);
generate_standard_fig(t_segmented, sensor_signal_segmented, 1, 2,...
    0, 0, 0, 0, 0, 0, ...
    0, 0, -1.1, 1.1,...
    2, 'Times New Roman', 16);
generate_standard_fig(t_segmented, signal_contour_segmented, 1, 2,...
    0, 0, 0, 0, 0, 0, ...
    0, 0, -1.1, 1.1,...
    2, 'Times New Roman', 16);
generate_standard_fig(t_segmented, signal_reposition_segmented, 1, 2,...
    0, 0, 0, 0, 0, 0, ...
    0, 0, -1.1, 1.1,...
    2, 'Times New Roman', 16);
generate_standard_fig(t_segmented, signal_trans_raster_segmented, 1, 2,...
    0, 0, 0, 0, 0:1:3.5, 0, ...
    0, length(signal_trans_raster_segmented)/Fs, 0, 1.1,...
    5, 'Times New Roman', 16);
legend('off');
grid minor;

xticklabels (ticks);

if figure_choice == 'Y'
    signal_identifier2 = ['Segmentation results ',signal_identifier, '.png'];
    salvarFigura(gca,'centimeters',[13 11]*1.8,600,signal_identifier2)
end

end

% OP2
function save_files(result_reposition, result_contour, result_raster,...
    result_transition_raster, segmentation_choice, signal_identifier)

save ([segmentation_choice,' segmentation results ',signal_identifier],...
    'result_reposition', 'result_contour',...
    'result_raster', 'result_transition_raster');

end

% AUX1
function generate_standard_fig(eixox, eixoy, tipo, nova_ou_sobrepor,...
    legenda, titulo, label_eixox, label_eixoy, x_ticks, y_ticks, ...
    limite_x1, limite_x2, limite_y1, limite_y2,...
    tipo_legenda, tipo_fonte, tamanho_fonte)
%Desenvolvida por Thiago Glissoi Lopes
%Laboratório de Aquisição de Dados e Processamento Digital de Sinais(LADAPS)
%FEB - UNESP - Bauru
%08/2019 - update 05/2020 - update 04/2023
%
%generate_standard_fig(eixox, eixoy, tipo, nova_ou_sobrepor,...
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
end

if (tipo == 1)
    if legenda ~= 0
        p = plot (eixox, eixoy, 'DisplayName', legenda); %PLA
    else
        p = plot(eixox, eixoy); %PLA
    end
    p.LineWidth = 1;
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

set(hFigure, 'PaperUnits', unit);
set(hFigure, 'PaperSize', size);
set(hFigure, 'PaperOrientation', 'portrait');
set(hFigure, 'PaperPositionMode', 'manual');
set(hFigure, 'PaperPosition', pos_);

print(hFigure, '-loose', res, '-djpeg', fileName);

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
function t = obtain_time_vec(signal,Fs)
t = 0:(1/Fs):(length(signal)-1)/Fs;
end

% AUX6
function composedSignal = Compos3r(sinal_base, matriz_posicoes)

aux = zeros(length(sinal_base),1);

if matriz_posicoes(1,1) > matriz_posicoes(1,2)
    low_column = 2;
    high_column = 1;
else
    low_column = 1;
    high_column = 2;
end

min_situation = [1,2];

for i = 1:length(matriz_posicoes)
    aux(matriz_posicoes(i,low_column):matriz_posicoes(i,high_column)) = 1;
    if size(matriz_posicoes) == min_situation %#ok<BDSCI>
        break;
    end
end
    composedSignal = aux;
end

% AUX7
function result_sep = encontra_ponto_separacao(Duration, i,...
    referencia_tamanho)

val_atual = Duration(i,1);
val_seguinte1 = Duration(i+1,1);
val_seguinte2 = Duration(i+2,1);
val_seguinte3 = Duration(i+3,1);
val_seguinte4 = Duration(i+4,1);
val_seguinte5 = Duration(i+5,1);

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

% AUX8
function signal_segments = gen_signal_segments(raw_signal, index_matrix)

num_interactions = size (index_matrix,1);

if index_matrix(1,2) > index_matrix(1,3)
    low_column = 3;
    high_column = 2;
else
    low_column = 2;
    high_column = 3;
end

for var_num_interactions = 1:num_interactions
    signal_segments{:,var_num_interactions} = ...
        raw_signal(index_matrix(var_num_interactions,low_column)...
        :index_matrix(var_num_interactions,high_column));
end

end

% AUX9

function [index_raster_alt,index_trans_raster_alt] =...
    adjust_internal(index_raster,index_trans_raster)

index_trans_raster_alt = index_trans_raster; % TODO adjust the 
% trans_raster for this situation

id_index_raster = 0;

for i = 2:length(index_raster)
    if (abs(index_raster(i,1)-index_raster(i-1,1))) > 12e3
        qnt = floor(abs((index_raster(i,1)-index_raster(i-1,1)))/11e3);
        id_index_raster(i,1) = qnt-1;
    else
        id_index_raster(i,1) = 0;
    end
end

ind_id = find(id_index_raster > 0);

aux1 = 1;
index_raster_alt = [0 0 0];

for j = 1:length(ind_id)


    index_raster_alt = [index_raster_alt;...
        index_raster(aux1:ind_id(j)-1,1:3)];

    last_peak = index_raster_alt(end,1:3);

    for k = 1:id_index_raster(ind_id(j))

        if ind_id(j) < 27
            temp_mat(k,1) = last_peak(1,1) + 11e3;
            temp_mat(k,3) = last_peak(1,2) + 8.4e3;
            temp_mat(k,2) = temp_mat(k,3) + temp_mat(k,1);



        else
            temp_mat(k,1) = last_peak(1,1) - 11e3;
            temp_mat(k,3) = last_peak(1,2) + 8.4e3;
            temp_mat(k,2) = temp_mat(k,3) + temp_mat(k,1);

        end


        
        last_peak = temp_mat(end,1:3);

    end
    index_raster_alt = [index_raster_alt;...
        temp_mat];
    clear temp_mat last_peak

    aux1 = ind_id(j);

    if j == length(ind_id)

        index_raster_alt = [index_raster_alt;...
            index_raster(aux1:end,1:3)];
    end


end
index_raster_alt = index_raster_alt(2:end,:);

b = find(index_raster_alt(:,1)==max(index_raster_alt(:,1)));

index_raster_alt = index_raster_alt(1:b,:);

% mirror in the middle

middle = length(index_raster_alt);

for i = 1:middle
   if i < middle
    index_raster_alt_2(i,1) = index_raster_alt(middle-i,1);
   else
       break;
   end
   if i == 1
   index_raster_alt_2(i,3) =...
       index_raster_alt(middle,2)+...
       8.4e3;
   else
   index_raster_alt_2(i,3) =...
       index_raster_alt_2(end-1,2) + 8.4e3;
   end
   index_raster_alt_2(i,2) =...
       index_raster_alt_2(i,1)+index_raster_alt_2(i,3);

end

index_raster_alt = [index_raster_alt;index_raster_alt_2];


end
