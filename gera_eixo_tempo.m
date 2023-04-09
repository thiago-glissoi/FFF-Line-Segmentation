function t = gera_eixo_tempo(sinal,Fs)
    t = 0:(1/Fs):(length(sinal)-1)/Fs;
end