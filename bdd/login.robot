*** Settings ***
Resource    ../code/login_keywords.robot
Resource    ../variables/variables.robot
Library    SeleniumLibrary

Test Setup    Open Browser    ${BASE_URL}    ${BROWSER}
Test Teardown    Run Keywords    Capture Page Screenshot    Close Browser

*** Test Cases ***
CT 01 - Validar login com credenciais válidas
    [Documentation]    Cenário de login com credenciais válidas.
    [Tags]    teste01    teste-login
    Dado que o usuário acessa a página de login do site
    Quando ele informa as credenciais válidas
    E clica no botão de login
    Então deve ser redirecionado para a página de produtos

CT 02 - Validar login com credenciais inválidas
    [Documentation]    Cenário de login com credenciais inválidas.
    [Tags]    teste02    teste-login
    Dado que o usuário acessa a página de login do site
    Quando ele informa as credenciais inválidas
    E clica no botão de login
    Então deve exibir a mensagem de erro invalida

CT 03 - Validar login com campos vazios
    [Documentation]    Cenário de tentativa de login com campos vazios.
    [Tags]    teste03    teste-login
    Dado que o usuário acessa a página de login do site
    Quando ele informa credenciais com campos vazios
    E clica no botão de login
    Então deve exibir a mensagem de erro vazios

CT 04 - Validar login com usuário bloqueado
    [Documentation]    Cenário de tentativa de login com usuário bloqueado.
    [Tags]    teste04    teste-login
    Dado que o usuário acessa a página de login do site
    Quando ele informa as credenciais do usuário bloqueado
    E clica no botão de login
    Então deve exibir a mensagem de erro de bloqueio

CT 05 - Login sem informar senha
    [Documentation]    Cenário de tentativa de login sem informar senha.
    [Tags]    teste05    teste-login
    Dado que o usuário acessa a página de login
    Quando informa um usuário válido sem preencher a senha
    E clica no botão de login
    Então deve exibir uma mensagem solicitando a senha

CT 06 - Login sem informar usuário
    [Documentation]    Cenário de tentativa de login sem informar usuário.
    [Tags]    teste06    teste-login
    Dado que o usuário acessa a página de login
    Quando informa uma senha válida sem preencher o campo de usuário
    E clica no botão de login
    Então deve exibir uma mensagem solicitando o usuário

CT 07 - Adicionar um produto ao carrinho
    [Documentation]    Cenário de adição de produto ao carrinho.
    [Tags]    teste07    teste-carrinho
    Dado que o usuário acessa a página de produtos
    Quando adiciona o produto "Sauce Labs Backpack" ao carrinho
    Então o produto deve ser exibido no carrinho
    E o contador do carrinho deve apresentar 1 item

CT 08 - Adicionar múltiplos produtos ao carrinho
    [Documentation]    Cenário de adição de múltiplos produtos ao carrinho.
    [Tags]    teste08    teste-carrinho
    Dado que o usuário acessa a página de produtos
    Quando adiciona os produtos "Sauce Labs Backpack", "Sauce Labs Bike Light" e "Sauce Labs Bolt T-Shirt" ao carrinho
    Então o contador do carrinho deve apresentar 3 itens
    E os três produtos devem estar disponíveis no carrinho

CT 09 - Remover produto do carrinho
    [Documentation]    Cenário de remoção de produto do carrinho.
    [Tags]    teste09    teste-carrinho
    Dado que existe um produto adicionado ao carrinho
    Quando remove o produto
    Então o carrinho deve ficar vazio
    E o contador de produtos não deve ser exibido

CT10 - Acessar carrinho vazio
    [Documentation]    Cenário de acesso ao carrinho vazio.
    [Tags]    teste10    teste-carrinho
    Quando acessa o carrinho sem adicionar produtos
    Então deve visualizar o carrinho vazio
    E não deve encontrar nenhum produto listado

CT11 - Finalizar compra com dados válidos
    [Documentation]    Cenário de finalização de compra com dados válidos.
    [Tags]    teste11    teste-compra
    Dado que existem produtos adicionados ao carrinho
    Quando acessa o carrinho
    E clica em Checkout
    E informa o primeiro nome "Leonardo"
    E informa o sobrenome "Andrade"
    E informa o código postal "17250000"
    E clica em Continue
    Então deve visualizar o resumo da compra
    E clica em Finish
    Então deve visualizar a mensagem "Thank you for your order!"
    E a compra deve ser finalizada com sucesso