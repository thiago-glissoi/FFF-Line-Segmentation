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