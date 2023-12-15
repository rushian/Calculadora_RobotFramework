def listar_digitos(valor):
    lista = []
    valor_digitado = str(valor)
    for caracter in valor_digitado:
        lista.append(caracter)
    return lista

print(listar_digitos(321))