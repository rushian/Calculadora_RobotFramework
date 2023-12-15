*** Settings ***
Documentation   Validacao de operacoes matematicas
Resource        ../test_steps/Steps_Calculadora.robot

Suite Setup      Log to console    \n==== INICIO DA AUTOMACAO ====
Suite Teardown   Sair do app

*** Test Cases ***
Calculo com numeros inteiros 
    [Documentation]    Testes com calculos de numeros inteiros exceto divisao
    [Tags]    inteiros    soma    subttracao     multiplicacao
    Dado que estou com a calculadora aberta
    E informo um valor (12)
    E escolho uma operacao (*)
    E informo um segundo valor (3)
    Quando aciono a opcao igual
    Entao o resultado do calculo deve ser exibido

Calculo com numeros inteiros - divisao
    [Documentation]    Testes com calculos de divisao de numeros inteiros 
    [Tags]    inteiros    divisao
    Dado que estou com a calculadora aberta
    E informo um valor (22)
    E escolho uma operacao (/)
    E informo um segundo valor (5)
    Quando aciono a opcao igual
    Entao o resultado do calculo deve ser exibido


Calculo com numeros inteiros vindos de um json
    [Documentation]    Testes a partir dos valores definidos em um json
    [Tags]    ler json
    Dado que estou com a calculadora aberta
    E passo uma lista de operacoes num json
    Entao realizo os calculos registrados no json