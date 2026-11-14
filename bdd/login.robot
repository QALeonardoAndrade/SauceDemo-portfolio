*** Settings ***
Resource    ../code/login_keywords.robot
Resource    ../variables/variables.robot
Library    SeleniumLibrary
Library    Collections

Test Setup    Open Browser    ${BASE_URL}    ${BROWSER}
Test Teardown    Run Keywords    Capture Page Screenshot    Close Browser

*** Test Cases ***
CT 01 - Validar login com credenciais válidas
    [Documentation]    Cenário de login com credenciais válidas.
    [Tags]    teste01    teste-login    testar-todos
    Dado que o usuário acessa a página de login do site
    Quando ele informa as credenciais válidas
    E clica no botão de login
    Então deve ser redirecionado para a página de produtos

CT 02 - Validar login com credenciais inválidas
    [Documentation]    Cenário de login com credenciais inválidas.
    [Tags]    teste02    teste-login    testar-todos
    Dado que o usuário acessa a página de login do site
    Quando ele informa as credenciais inválidas
    E clica no botão de login
    Então deve exibir a mensagem de erro invalida

CT 03 - Validar login com usuário inexistente
    [Documentation]    Cenário de tentativa de login com usuário inexistente.
    [Tags]    teste00    teste-login    testar-todos
    Dado que o usuário acessa a página de login do site
    Quando ele informa as credenciais de um usuário inexistente
    E clica no botão de login
    Então deve exibir a mensagem de erro de usuário inexistente

CT 04 - Validar login com campos vazios
    [Documentation]    Cenário de tentativa de login com campos vazios.
    [Tags]    teste03    teste-login    testar-todos
    Dado que o usuário acessa a página de login do site
    Quando ele informa credenciais com campos vazios
    E clica no botão de login
    Então deve exibir a mensagem de erro vazios

CT 05 - Validar login com usuário bloqueado
    [Documentation]    Cenário de tentativa de login com usuário bloqueado.
    [Tags]    teste04    teste-login    testar-todos
    Dado que o usuário acessa a página de login do site
    Quando ele informa as credenciais do usuário bloqueado
    E clica no botão de login
    Então deve exibir a mensagem de erro de bloqueio

CT 06 - Login sem informar senha
    [Documentation]    Cenário de tentativa de login sem informar senha.
    [Tags]    teste05    teste-login    testar-todos
    Dado que o usuário acessa a página de login do site
    Quando informa um usuário válido sem preencher a senha
    E clica no botão de login
    Então deve exibir uma mensagem solicitando a senha

CT 07 - Login sem informar usuário
    [Documentation]    Cenário de tentativa de login sem informar usuário.
    [Tags]    teste06    teste-login    testar-todos
    Dado que o usuário acessa a página de login do site
    Quando informa uma senha válida sem preencher o campo de usuário
    E clica no botão de login
    Então deve exibir uma mensagem solicitando o usuário

CT 08- Visualizar a lista de produtos após realizar login.
    [Documentation]    Cenário de visualização da lista de produtos após login.
    [Tags]    teste00    teste-produtos    testar-todos
    Dado que o usuário acessa a página de login do site
    Quando ele informa as credenciais válidas
    E clica no botão de login
    Então deve ser redirecionado para a página de produtos
    E deve visualizar a lista de produtos disponíveis

CT 09 -Ordenar produtos por preço, do menor para o maior.
    [Documentation]    Cenário de ordenação de produtos por preço.
    [Tags]    teste00    teste-produtos    testar-todos
    Dado que o usuário acessa a página de produtos
    Quando seleciona a opção de ordenação "Price (low to high)"
    Então os produtos devem ser exibidos em ordem crescente de preço

CT 10 - Acessar os detalhes de um produto.
    [Documentation]    Cenário de acesso aos detalhes de um produto.
    [Tags]    teste00    teste-produtos    testar-todos
    Dado que o usuário acessa a página de produtos
    Quando clica no produto "Sauce Labs Backpack"
    Então deve ser redirecionado para a página de detalhes do produto
    E deve visualizar as informações detalhadas do produto

CT 11 - Adicionar um produto ao carrinho
    [Documentation]    Cenário de adição de produto ao carrinho.
    [Tags]    teste07    teste-carrinho    testar-todos
    Dado que o usuário acessa a página de produtos
    Quando adiciona o produto "Sauce Labs Backpack" ao carrinho
    Então o produto deve ser exibido no carrinho
    E o contador do carrinho deve apresentar 1 item

CT 12 - Remover produto do carrinho
    [Documentation]    Cenário de remoção de produto do carrinho.
    [Tags]    teste09    teste-carrinho    testar-todos
    Dado que existe um produto adicionado ao carrinho
    Quando remove o produto do carrinho
    Então o carrinho deve ficar vazio
    E o contador de produtos não deve ser exibido


CT 13 - Tentar avançar no checkout sem preencher os campos obrigatórios.
    [Documentation]    Cenário de tentativa de avançar no checkout sem preencher os campos obrigatórios.
    [Tags]    teste00    teste-compra    testar-todos
    Dado que existem produtos adicionados ao carrinho
    Quando acessa o carrinho
    E clica em Checkout
    E deixa os campos obrigatórios em branco
    E clica em Continue
    Então deve exibir uma mensagem de erro solicitando o preenchimento dos campos obrigatórios


CT 14 - Finalizar compra com dados válidos
    [Documentation]    Cenário de finalização de compra com dados válidos.
    [Tags]    teste11    teste-compra    testar-todos
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

CT 15 -Encerrar a sessão do usuário por meio da opção Logout.
    [Documentation]    Cenário de encerramento de sessão do usuário.
    [Tags]    teste00    teste-logout    testar-todos
    Dado que o usuário está logado no sistema
    Quando clica na opção de Logout
    Então deve ser redirecionado para a página de login
    E a sessão do usuário deve ser encerrada com sucesso