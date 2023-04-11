function vetor_normalizado = Normaliz3r (vetor_original)
aux1 = max(vetor_original);
aux2 = vetor_original*-1;
aux3 = max(aux2);

if aux3 >= aux1
    aux1 = aux3;
end

vetor_normalizado = vetor_original/aux1;

end