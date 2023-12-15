from geral import listar_digitos


def test_listar_digitos():
    #configura
    valor_digitado = 253
    valor_esperado = ['2','5','3']
    #executa
    valor_obtido = listar_digitos(253)
    #valida
    print('valor esperado: ',valor_esperado,' valor obtido: ',valor_obtido)
    assert valor_esperado == valor_obtido
    


