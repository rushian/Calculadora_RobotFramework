*** Settings ***
Documentation   Tela de login
Resource        ../resources/base.robot
    
*** Variables ***
${btn_0}                    //*[@resource-id='com.google.android.calculator:id/digit_0']
${btn_1}                    //*[@resource-id='com.google.android.calculator:id/digit_1']
${btn_2}                    //*[@resource-id='com.google.android.calculator:id/digit_2']
${btn_3}                    //*[@resource-id='com.google.android.calculator:id/digit_3']
${btn_4}                    //*[@resource-id='com.google.android.calculator:id/digit_4']
${btn_5}                    //*[@resource-id='com.google.android.calculator:id/digit_5']
${btn_6}                    //*[@resource-id='com.google.android.calculator:id/digit_6']
${btn_7}                    //*[@resource-id='com.google.android.calculator:id/digit_7']
${btn_8}                    //*[@resource-id='com.google.android.calculator:id/digit_8']
${btn_9}                    //*[@resource-id='com.google.android.calculator:id/digit_9']
${btn_=}                    //*[@resource-id='com.google.android.calculator:id/eq']
${btn_+}                    //*[@resource-id='com.google.android.calculator:id/op_add']
${btn_-}                    //*[@resource-id='com.google.android.calculator:id/op_sub']
${btn_*}                    //*[@resource-id='com.google.android.calculator:id/op_mul']
${btn_/}                    //*[@resource-id='com.google.android.calculator:id/op_div']
${texto_resultado}          //*[@resource-id='com.google.android.calculator:id/result_preview']
${texto_resultado_final}    //*[@resource-id='com.google.android.calculator:id/result_final']
${clear}                    //*[@resource-id='com.google.android.calculator:id/clr']

*** Keywords ***
Dado que estou com a calculadora aberta
    Abrir o app [no dispositivo: nexus10]
    Wait Until Element Is Visible    ${texto_resultado}     15

E informo um valor (${var_valor1})
    ${lista}=    Listar Digitos    ${var_valor1}
    
    FOR    ${digito}    IN    @{lista}
        ${n}=     Catenate     SEPARATOR=      \$\{    btn_     ${digito}    \}
        ${numero}     Replace Variables    ${n}
        Click Element    ${numero}
    END
    Set Global Variable    ${var_valor1}
    
E escolho uma operacao (${oper})
    ${s}=     Catenate    SEPARATOR=    \$\{       btn_      ${oper}    \}
    ${sinal}     Replace Variables    ${s}
    Click Element    ${sinal}
    Set Global Variable    ${oper}

E informo um segundo valor (${var_valor2})
    ${lista}=    Listar Digitos    ${var_valor2}
    
    FOR    ${digito}    IN    @{lista}
        ${n}=     Catenate    SEPARATOR=     \$\{      btn_      ${digito}    \}
        ${numero}     Replace Variables    ${n}
        Click Element    ${numero}
    END
    Set Global Variable    ${var_valor2}
    
Quando aciono a opcao igual
    Click Element    ${btn_=}
Entao o resultado do calculo deve ser exibido
    Log to console    ${var_valor1}${oper}${var_valor2}
    ${rsltd_esperado}         Evaluate    ${var_valor1}${oper}${var_valor2}
    ${resultado_esperado}    Convert to string     ${rsltd_esperado}
    ${resultado_obtido}           Get Text     ${texto_resultado_final}
    
    Element Should Contain Text    ${texto_resultado_final}     ${resultado_esperado}
    Log to console   Resultado esperado: ${resultado_esperado} Resultado obtido: ${resultado_obtido}

    Run Keyword And Ignore Error    Tirar print

E aciono a opcao limpar
    Click Element    ${clear}

E passo uma lista de operacoes num json
    ${ArquivoJson}    Ler Arquivo Json [test_data\\operacoes.json]
    Set Suite Variable    ${ArquivoJson}
Entao realizo os calculos registrados no json
    ${tamanhoJson}    Get Length    ${ArquivoJson}
    Log To Console    Quantidade de operacoes: ${tamanhoJson}
    FOR    ${counter}    IN RANGE    0    ${tamanhoJson}
        ${valor1}                Get From Dictionary    ${ArquivoJson[${counter}]}    valor1
        ${valor2}                Get From Dictionary    ${ArquivoJson[${counter}]}    valor2
        ${oper}                  Get From Dictionary    ${ArquivoJson[${counter}]}    oper
        ${resultado_esperado}     Get From Dictionary    ${ArquivoJson[${counter}]}    rslt_esperado
        Exibir no console ${valor1}${oper}${valor2}
        E informo um valor (${valor1})
        E escolho uma operacao (${oper})
        E informo um segundo valor (${valor2})
        Quando aciono a opcao igual
        
        ${resultado_obtido}           Get Text     ${texto_resultado_final}
    
        Element Should Contain Text    ${texto_resultado_final}     ${resultado_esperado}
        Exibir no console Resultado esperado: ${resultado_esperado} Resultado obtido: ${resultado_obtido}

        Run Keyword And Ignore Error    Tirar print
        E aciono a opcao limpar
    END
    