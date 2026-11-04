*** Settings ***
Resource    ../variables/variables.robot
Library    SeleniumLibrary

*** Keywords ***
Dado que o usuário acessa a página de login do site
    Go To    ${BASE_URL}
    Wait Until Page Contains Element    id=user-name    timeout=10s

Quando ele informa as credenciais válidas
    Input Text    id=user-name    ${USER_NAME}
    Input Password    id=password    ${PASSWORD}

Quando ele informa as credenciais inválidas
    Input Text    id=user-name    ${INVALID_USER_NAME}
    Input Password    id=password    ${INVALID_PASSWORD}

Quando ele informa credenciais com campos vazios
    Input Text    id=user-name    ${NULL_USER_NAME}
    Input Password    id=password    ${NULL_PASSWORD}
    # Este passo valida a regra de negócio em que o botão de login deve bloquear o envio sem usuário e senha.

Quando ele informa as credenciais do usuário bloqueado
    Input Text    id=user-name    ${LOCKED_USER_NAME}
    Input Password    id=password    ${LOCKED_PASSWORD}

E clica no botão de login
    Click Button    id=login-button

Então deve ser redirecionado para a página de produtos
    Wait Until Element Is Visible    css=.inventory_list    timeout=10s
    Title Should Be    Swag Labs

Então deve exibir a mensagem de erro de bloqueio
    Wait Until Element Is Visible    css=.error-message-container    timeout=10s
    Element Should Contain    css=.error-message-container    Epic sadface: Sorry, this user has been locked out.

 Então deve exibir a mensagem de erro invalida
    Wait Until Element Is Visible    css=.error-message-container    timeout=10s
    Element Should Contain    css=.error-message-container    not match any user in this service

 Então deve exibir a mensagem de erro vazios
    Wait Until Element Is Visible    css=.error-message-container    timeout=10s
    Element Should Contain    css=.error-message-container    Epic sadface: Username is required

Login com credenciais válidas
    [Documentation]    Realiza o login com usuário e senha válidos.
    Quando ele informa as credenciais válidas
    E clica no botão de login
    Então deve ser redirecionado para a página de produtos

Login com credenciais inválidas
    [Documentation]    Tenta autenticar com usuário e senha incorretos.
    Quando ele informa as credenciais inválidas
    E clica no botão de login
    Então deve exibir a mensagem de erro

Login com campos vazios
    [Documentation]    Tenta autenticar sem informar usuário e senha.
    Quando ele informa credenciais com campos vazios
    E clica no botão de login
    Então deve exibir a mensagem de erro

Login com usuário bloqueado
    [Documentation]    Tenta autenticar com um usuário bloqueado.
    Quando ele informa as credenciais do usuário bloqueado
    E clica no botão de login
    Então deve exibir a mensagem de erro