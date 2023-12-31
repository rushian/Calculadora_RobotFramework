*** Settings ***
Documentation   Arquivo para importacao de bibliotecas comuns a todos os testes
...             Tambem foram inclusas palavras chaves que podem ser utilizadas em todos os testes

Library         AppiumLibrary
Library         BuiltIn
Library         Collections
Library         DateTime
Library         JSONLibrary
Library         OperatingSystem
Library         Screenshot
# caso nao seja utilizada a pasta actions, entao nas bibliotecas abaixo deve-se remover ../
Library         geral.py
                
*** Variables ***
${REMOTE_URL}               http://127.0.0.1:4723/wd/hub
${platformName}             Android
${automationName}           uiautomator2
${deviceName}               emulator-5554
${appPackage}               com.google.android.calculator
${appActivity}              com.android.calculator2.Calculator                      
${ensureWebviewsHavePages}  true
${nativeWebScreenshot}      true

*** Keywords ***
Abrir o app [no dispositivo: ${avd}]  
    ${data_atual}=                  Get Current Date             result_format=%d-%m-%Y
    Set Suite Variable      ${titulo}          ${TEST NAME}
    Create Directory                evidencias\\${data_atual}
    Log to console   Abrir o app Calculadora ${appPackage}
    #Abrir aplicacao com os parametros fornecidos nas variaveis
    Open Application    ${REMOTE_URL}   
    ...    platformName=${platformName}  
    ...    automationName=${automationName}  
    ...    deviceName=${deviceName}  
    ...    appPackage=${appPackage}  
    ...    appActivity=${appActivity}
    ...    avd=${avd}
    ...    ensureWebviewsHavePages=${ensureWebviewsHavePages}  
    ...    nativeWebScreenshot=${nativeWebScreenshot}  

Ler Arquivo Json [${LocalArquivoJson}]    
    ${ArquivoJson}     Load Json From File     ${LocalArquivoJson}
    Log To Console    \nArquivo utilizado: ${LocalArquivoJson}
    [Return]            ${ArquivoJson}     


Tirar print
    Set Suite Variable      ${titulo}          ${TEST NAME}
    ${data_atual}=                  Get Current Date             result_format=%d-%m-%Y
    ${nome_arquivo}                 Get Current Date             result_format=%H-%M-%S
    Create Directory                evidencias\\${data_atual}\\${titulo}
    Set Screenshot Directory        evidencias\\${data_atual}\\${titulo}
    Take Screenshot                 appium-screenshot-${nome_arquivo}.png
Espere por ${tempo} segundos ate que a palavra chave (${palavra-chave}) seja executada com sucesso, verifica a cada ${intervalo}s
    Wait Until Keyword Succeeds       ${tempo}      ${intervalo}      ${palavra-chave}

Pagina deve conter o elemento ${locator}
    Page Should Contain Element     ${locator}

Arrastar pra cima
    Swipe    500    1450    500    150
    
Arrastar pra baixo
    Swipe    500    150    500    1450

Mover Screenshots
    Set Suite Variable      ${titulo}          ${TEST NAME}
    ${DATA_ATUAL}=                         Get Current Date      result_format=%d-%m-%Y
    Move Files                             appium-screenshot-*.png    ${EXECDIR}\\evidencias\\${DATA_ATUAL}\\${titulo}

Sair do app
    Log to console    \n== Sair do aplicativo ==
    Close Application
