# Atividade Final UC7

Este repositório contém os artefatos da Atividade Final da Unidade Curricular 7 (UC7), focada na **modelagem e implementação de um sistema para gestão de vendas**, incluindo produtos, clientes, pedidos e um robusto controle de acesso baseado em grupos de usuários e permissões.

---

## 🚀 Visão Geral

O projeto visa demonstrar a aplicação de conceitos de banco de dados, desenvolvimento web (PHP), e segurança (autenticação e autorização) para criar um sistema funcional de gerenciamento de vendas. A estrutura do banco de dados foi projetada para ser flexível e escalável, suportando diversas entidades e seus relacionamentos.

---

## 📊 Modelo de Banco de Dados

O banco de dados é composto por 10 tabelas, que se interligam para formar um esquema relacional completo. Abaixo, detalhamos cada uma das tabelas e seus principais atributos:

### `Categoria`
Armazena informações sobre as categorias dos produtos disponíveis para venda.
-   **`CategoriaID`**: Chave primária única.
-   **`Nome`**: Nome da categoria.
-   **`Descricao`**: Descrição da categoria.
-   **`DataCriacao`**: Data de criação do registro.
-   **`DataAtualizacao`**: Data da última atualização do registro.
-   **`UsuarioAtualizacao`**: ID do usuário que realizou a última atualização.
-   **`Ativo`**: Indica se a categoria está ativa (1) ou inativa (0).

### `FormaPagamento`
Mantém informações sobre as formas de pagamento disponíveis para os clientes.
-   **`FormaPagamentoID`**: Chave primária única.
-   **`Nome`**: Nome da forma de pagamento.
-   **`Descricao`**: Descrição da forma de pagamento.
-   **`DataCriacao`**: Data de criação do registro.
-   **`DataAtualizacao`**: Data da última atualização do registro.
-   **`UsuarioAtualizacao`**: ID do usuário que realizou a última atualização.
-   **`Ativo`**: Indica se a forma de pagamento está ativa (1) ou inativa (0).

### `Produto`
Mantém informações sobre os produtos disponíveis para venda.
-   **`ProdutoID`**: Chave primária única.
-   **`Nome`**: Nome do produto.
-   **`Descricao`**: Descrição detalhada do produto.
-   **`Preco`**: Preço do produto.
-   **`CategoriaID`**: Chave estrangeira que referencia a tabela `Categoria`.
-   **`DataCriacao`**: Data de criação do registro.
-   **`DataAtualizacao`**: Data da última atualização do registro.
-   **`UsuarioAtualizacao`**: ID do usuário que realizou a última atualização.
-   **`Ativo`**: Indica se o produto está ativo (1) ou inativo (0).

### `Cliente`
Armazena informações sobre os clientes que realizam compras.
-   **`ClienteID`**: Chave primária única.
-   **`Nome`**: Nome do cliente.
-   **`Email`**: Endereço de e-mail do cliente.
-   **`Telefone`**: Número de telefone do cliente.
-   **`DataCriacao`**: Data de criação do registro.
-   **`DataAtualizacao`**: Data da última atualização do registro.
-   **`UsuarioAtualizacao`**: ID do usuário que realizou a última atualização.
-   **`Ativo`**: Indica se o cliente está ativo (1) ou inativo (0).

### `Pedido`
Mantém informações sobre os pedidos realizados pelos clientes.
-   **`PedidoID`**: Chave primária única.
-   **`ClienteID`**: Chave estrangeira que referencia a tabela `Cliente`.
-   **`DataPedido`**: Data em que o pedido foi realizado.
-   **`FormaPagamentoID`**: Chave estrangeira que referencia a tabela `FormaPagamento`.
-   **`Status`**: Status do pedido (ex: "Pendente", "Concluído", "Cancelado").
-   **`DataCriacao`**: Data de criação do registro.
-   **`DataAtualizacao`**: Data da última atualização do registro.
-   **`UsuarioAtualizacao`**: ID do usuário que realizou a última atualização.

### `ItemPedido`
Mantém informações sobre os itens incluídos em cada pedido.
-   **`ItemPedidoID`**: Chave primária única.
-   **`PedidoID`**: Chave estrangeira que referencia a tabela `Pedido`.
-   **`ProdutoID`**: Chave estrangeira que referencia a tabela `Produto`.
-   **`Quantidade`**: Quantidade do produto incluída no pedido.
-   **`DataCriacao`**: Data de criação do registro.
-   **`DataAtualizacao`**: Data da última atualização do registro.
-   **`UsuarioAtualizacao`**: ID do usuário que realizou a última atualização.

### `GrupoUsuario`
Mantém informações sobre os grupos de usuários do sistema, para controle de acesso.
-   **`GrupoUsuarioID`**: Chave primária única.
-   **`Nome`**: Nome do grupo de usuário (ex: "Administrador", "Vendedor", "Cliente").
-   **`Descricao`**: Descrição do grupo de usuário.
-   **`DataCriacao`**: Data de criação do registro.
-   **`DataAtualizacao`**: Data da última atualização do registro.
-   **`UsuarioAtualizacao`**: ID do usuário que realizou a última atualização.
-   **`Ativo`**: Indica se o grupo de usuário está ativo (1) ou inativo (0).

### `Permissao`
Mantém informações sobre as permissões granulares do sistema.
-   **`PermissaoID`**: Chave primária única.
-   **`Nome`**: Nome da permissão (ex: "criar_produto", "editar_cliente", "visualizar_pedido").
-   **`Descricao`**: Descrição da permissão.
-   **`DataCriacao`**: Data de criação do registro.
-   **`DataAtualizacao`**: Data da última atualização do registro.
-   **`UsuarioAtualizacao`**: ID do usuário que realizou a última atualização.
-   **`Ativo`**: Indica se a permissão está ativa (1) ou inativa (0).

### `PermissaoGrupo`
Associa permissões a grupos de usuários, definindo quais ações cada grupo pode realizar.
-   **`PermissaoID`**: Chave estrangeira que referencia a tabela `Permissao`.
-   **`GrupoUsuarioID`**: Chave estrangeira que referencia a tabela `GrupoUsuario`.
-   **`PRIMARY KEY (PermissaoID, GrupoUsuarioID)`**: Chave primária composta para garantir a unicidade de cada associação.

### `Usuario`
Armazena informações sobre os usuários que acessam o sistema.
-   **`UsuarioID`**: Chave primária única.
-   **`NomeUsuario`**: Nome de usuário único para login.
-   **`Senha`**: Senha criptografada do usuário.
-   **`Email`**: Endereço de e-mail do usuário.
-   **`GrupoUsuarioID`**: Chave estrangeira que referencia a tabela `GrupoUsuario`.
-   **`Ativo`**: Indica se o usuário está ativo (1) ou inativo (0).
-   **`DataCriacao`**: Data de criação do registro.
-   **`DataAtualizacao`**: Data da última atualização do registro.
-   **`UsuarioAtualizacao`**: ID do usuário que realizou a última atualização.

---

## 🛠️ Tecnologias Utilizadas

* **PHP**: Linguagem de programação backend para a lógica de negócio e interação com o banco de dados.
* **MySQL/MariaDB**: Sistema de gerenciamento de banco de dados relacional.
* **HTML**: Estrutura das páginas web.
* **CSS**: Estilização das páginas web (conforme o `style.css` fornecido).

---

## 🚀 Como Executar o Projeto (Instruções Breves)

1.  **Clone o repositório:**
    ```bash
    git clone <URL_DO_REPOSITORIO>
    cd <nome_do_repositorio>
    ```
2.  **Configurar o Banco de Dados:**
    * Crie um banco de dados MySQL/MariaDB (ex: `uc7_vendas`).
    * Utilize o esquema de tabelas descrito acima para criar as tabelas (um arquivo `.sql` pode ser incluído no futuro para facilitar).
    * Preencha as tabelas com dados de exemplo, se necessário, especialmente para `GrupoUsuario` e `Usuario` para testes de login.
3.  **Configurar o PHP:**
    * Garanta que você tem um servidor web (Apache, Nginx) com PHP instalado.
    * Configure as credenciais de conexão com o banco de dados nos arquivos PHP (geralmente em um arquivo de configuração como `config.php` ou `db.php`).
4.  **Acessar a Aplicação:**
    * Abra seu navegador e navegue até o diretório raiz do projeto no seu servidor web (ex: `http://localhost/uc7_vendas/`).

---

## 🧑‍💻 Contribuição

Contribuições são bem-vindas! Se você tiver sugestões, melhorias ou encontrar algum bug, sinta-se à vontade para abrir uma *issue* ou enviar um *pull request*.

---