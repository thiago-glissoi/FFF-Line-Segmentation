function caracteristica = extrair_caracteristica_gcode(nome_arquivo, nome_caracteristica)
%   caracteristica = extrair_caracteristica_gcode(nome_arquivo, nome_caracteristica) retorna o valor da 
%   característica especificada pelo nome_caracteristica do arquivo .gcode especificado pelo nome_arquivo.
%
%   Argumentos:
%       nome_arquivo: string que contém o nome do arquivo .gcode que será analisado.
%       nome_caracteristica: string que contém o nome da característica desejada.
%
%   Valor de retorno:
%       caracteristica: valor da característica extraída do arquivo .gcode. Pode ser um valor numérico ou uma
%       string.
%
%   Exemplo de uso:
%       nome_arquivo = 'arquivo.gcode';
%       nome_caracteristica = 'layerHeight';
%       valor_caracteristica = extrair_caracteristica_gcode(nome_arquivo, nome_caracteristica);
%
%   Observações:
%       - A função utiliza a função "contains" para verificar se a linha contém a característica procurada.
%       - A função utiliza a função "split" para dividir a linha com base na vírgula.
%       - A função utiliza a função "strtrim" para remover espaços em branco antes e depois do valor da 
%         característica.
%       - Se a característica não for encontrada no arquivo, a função retorna uma mensagem de erro.
%       - Se o valor da característica for numérico, a função converte a string para um valor numérico.
%
%
%   Exemplo de uso
%    % Extrair a característica "extruderDiameter"
%    diametro = extrair_caracteristica_gcode('nome_arquivo.gcode', 'extruderDiameter');
%    disp(diametro);
%     
%    % Extrair a característica "processName"
%    processo = extrair_caracteristica_gcode('nome_arquivo.gcode', 'processName');
%    disp(processo);

%
%   Autor: Thiago Glissoi Lopes - Laboratório de Aquisição de Dados e
%   Processamento Digital de Sinais (LADAPS)
%   Data de criação: 08/04/2023
%   Última modificação: 08/04/2023

% Abre o arquivo para leitura
fid = fopen(nome_arquivo, 'r');
if fid == -1
    error('Erro ao abrir o arquivo.');
end

% Lê o arquivo linha por linha
linha = fgetl(fid);
while ischar(linha)
    % Verifica se a linha contém a característica procurada
    if contains(linha, nome_caracteristica)
        % Divide a linha com base na vírgula
        valores = split(linha, ',');
        % Extrai o valor da característica
        caracteristica = strtrim(valores{2});
        % Verifica se o valor é numérico
        if isnumeric(str2double(caracteristica))
            if isnan(str2double(caracteristica))
            else
            caracteristica = str2double(caracteristica);
            end
            
        end
        % Fecha o arquivo e retorna o valor da característica
        fclose(fid);
        return;
    end
    linha = fgetl(fid);
end

% Se a característica não foi encontrada, retorna uma mensagem de erro
error('Característica não encontrada no arquivo.');
end
