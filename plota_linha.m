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