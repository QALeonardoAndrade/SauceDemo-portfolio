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

Quando ele informa as credenciais de um usuário inexistente
    Input Text    id=user-name    ${INVALID_USER_NAME}
    Input Password    id=password    ${PASSWORD}

Então deve exibir a mensagem de erro de usuário inexistente
    Wait Until Element Is Visible    css=.error-message-container    timeout=10s
    Element Should Contain    css=.error-message-container    Epic sadface: Username and password do not match any user in this service

Quando informa um usuário válido sem preencher a senha
    Input Text    id=user-name    ${USER_NAME}
    Input Password    id=password    ${NULL_PASSWORD}

Então deve exibir uma mensagem solicitando a senha
    Wait Until Element Is Visible    css=.error-message-container    timeout=10s
    Element Should Contain    css=.error-message-container    Epic sadface: Password is required

Quando informa uma senha válida sem preencher o campo de usuário
    Input Text    id=user-name    ${NULL_USER_NAME}
    Input Password    id=password    ${PASSWORD}

Então deve exibir uma mensagem solicitando o usuário
    Wait Until Element Is Visible    css=.error-message-container    timeout=10s
    Element Should Contain    css=.error-message-container    Epic sadface: Username is required

E deve visualizar a lista de produtos disponíveis
    Wait Until Element Is Visible    css=.inventory_list    timeout=10s
    Element Should Be Visible    css=.inventory_list

Dado que o usuário acessa a página de produtos
    Input Text    id=user-name    ${USER_NAME}
    Input Password    id=password    ${PASSWORD}
    Click Button    id=login-button

Quando seleciona a opção de ordenação "Price (low to high)"
    Select From List By Value    css=.product_sort_container    lohi

Então os produtos devem ser exibidos em ordem crescente de preço
    ${prices}=    Get WebElements    css=.inventory_item_price
    ${price_values}=    Create List

    FOR    ${price}    IN    @{prices}
        ${text}=    Get Text    ${price}
        ${value}=    Convert To Number    ${text.replace('$', '')}
        Append To List    ${price_values}    ${value}
    END

    ${sorted_prices}=    Evaluate    sorted($price_values)
    Should Be Equal    ${price_values}    ${sorted_prices}

Quando clica no produto "Sauce Labs Backpack"
    Click Element    xpath=//div[text()='Sauce Labs Backpack']

Então deve ser redirecionado para a página de detalhes do produto
    Wait Until Element Is Visible    css=.inventory_details_container    timeout=10s
    Title Should Be    Swag Labs

E deve visualizar as informações detalhadas do produto
    Element Should Be Visible    css=.inventory_details_name
    Element Should Be Visible    css=.inventory_details_desc
    Element Should Be Visible    css=.inventory_details_price

Quando adiciona o produto "Sauce Labs Backpack" ao carrinho
    Click Button    //button[contains(@data-test,'add-to-cart') and contains(@data-test,'sauce-labs-backpack')]

Então o produto deve ser exibido no carrinho
    Click Element    css=.shopping_cart_link
    Wait Until Element Is Visible    css=.cart_list    timeout=10s
    Element Should Contain    css=.cart_item_label    Sauce Labs Backpack

E o contador do carrinho deve apresentar 1 item
    Element Should Contain    css=.shopping_cart_badge    1

Dado que existe um produto adicionado ao carrinho
    Input Text    id=user-name    ${USER_NAME}
    Input Password    id=password    ${PASSWORD}
    Click Button    id=login-button
    Click Button    xpath=//div[text()='Sauce Labs Backpack']/ancestor::div[@class='inventory_item']//button

Quando remove o produto "Sauce Labs Backpack" do carrinho
    Click Element    css=.shopping_cart_link
    Wait Until Element Is Visible    css=.cart_list    timeout=10s
    Click Button    xpath=//div[text()='Sauce Labs Backpack']/ancestor::div[@class='cart_item']//button

Quando remove o produto do carrinho
    Click Element    css=.shopping_cart_link
    Wait Until Element Is Visible    css=.cart_list    timeout=10s
    Click Button    xpath=//div[text()='Sauce Labs Backpack']/ancestor::div[@class='cart_item']//button

Então o carrinho deve ficar vazio
    Element Should Not Be Visible    css=.cart_item_label

E o contador de produtos não deve ser exibido
    Element Should Not Be Visible    css=.shopping_cart_badge

Dado que existem produtos adicionados ao carrinho
    Input Text    id=user-name    ${USER_NAME}
    Input Password    id=password    ${PASSWORD}
    Click Button    id=login-button
    Click Button    xpath=//div[text()='Sauce Labs Backpack']/ancestor::div[@class='inventory_item']//button
    Click Button    xpath=//div[text()='Sauce Labs Bike Light']/ancestor::div[@class='inventory_item']//button

Quando acessa o carrinho
    Click Element    css=.shopping_cart_link
    Wait Until Element Is Visible    css=.cart_list    timeout=10s

E clica em Checkout
    Click Button    id=checkout

E deixa os campos obrigatórios em branco
    Input Text    id=first-name    ${NULL_FIRST_NAME}
    Input Text    id=last-name    ${NULL_LAST_NAME}
    Input Text    id=postal-code    ${NULL_POSTAL_CODE}
    Click Button    id=continue

E clica em Continue
    Click Button    id=continue

Então deve exibir uma mensagem de erro solicitando o preenchimento dos campos obrigatórios
    Wait Until Element Is Visible    css=.error-message-container    timeout=10s
    Element Should Contain    css=.error-message-container    Error: First Name is required

E informa o primeiro nome "Leonardo"
    Input Text    id=first-name    ${FIRST_NAME}

E informa o sobrenome "Andrade"
    Input Text    id=last-name    ${LAST_NAME}

E informa o código postal "17250000"
    Input Text    id=postal-code    ${POSTAL_CODE}

Então deve visualizar o resumo da compra
    Wait Until Element Is Visible    css=.summary_info    timeout=10s
    Element Should Be Visible    css=.summary_info

E clica em Finish
    Click Button    id=finish

Então deve visualizar a mensagem "Thank you for your order!"
    Wait Until Element Is Visible    css=.complete-header    timeout=10s
    Element Should Contain    css=.complete-header    Thank you for your order!

E a compra deve ser finalizada com sucesso
    Element Should Be Visible    css=.complete-text

Dado que o usuário está logado no sistema
    Input Text    id=user-name    ${USER_NAME}
    Input Password    id=password    ${PASSWORD}
    Click Button    id=login-button

Quando clica na opção de Logout
    Click Element    //*[@id="react-burger-menu-btn"]
    Wait Until Element Is Visible    id=logout_sidebar_link    timeout=10s
    Click Element    id=logout_sidebar_link

Então deve ser redirecionado para a página de login
    Wait Until Element Is Visible    id=login-button    timeout=10s

E a sessão do usuário deve ser encerrada com sucesso
    Element Should Be Visible    id=login-button


