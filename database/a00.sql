-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS sistema_vendas;
USE sistema_vendas;

-- Tabela usuario (unifica clientes e administradores)
CREATE TABLE IF NOT EXISTS usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome_completo VARCHAR(150) NOT NULL, -- Campo para o nome real do cliente/admin
    nome_usuario VARCHAR(50) NOT NULL UNIQUE, -- Campo para login
    senha VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE,
    telefone VARCHAR(20),
    cpf VARCHAR(14) UNIQUE,
    is_admin TINYINT(1) DEFAULT 0, -- Simplificação do sistema de permissão
    ativo TINYINT(1) DEFAULT 1,
    token VARCHAR(255),
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario_atualizacao INT,
    FOREIGN KEY (usuario_atualizacao) REFERENCES usuario(id) ON DELETE SET NULL
);

-- Tabela categoria
CREATE TABLE IF NOT EXISTS categoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario_atualizacao INT,
    ativo TINYINT(1) DEFAULT 1,
    FOREIGN KEY (usuario_atualizacao) REFERENCES usuario(id) ON DELETE SET NULL
);

-- Tabela forma_pagamento
CREATE TABLE IF NOT EXISTS forma_pagamento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario_atualizacao INT,
    ativo TINYINT(1) DEFAULT 1,
    FOREIGN KEY (usuario_atualizacao) REFERENCES usuario(id) ON DELETE SET NULL
);

-- Tabela produto
CREATE TABLE IF NOT EXISTS produto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2) NOT NULL,
    categoria_id INT,
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario_atualizacao INT,
    ativo TINYINT(1) DEFAULT 1,
    INDEX idx_nome (nome),
    CONSTRAINT fk_produto_categoria FOREIGN KEY (categoria_id) REFERENCES categoria(id) ON DELETE SET NULL,
    FOREIGN KEY (usuario_atualizacao) REFERENCES usuario(id) ON DELETE SET NULL
);

-- Tabela pedido
CREATE TABLE IF NOT EXISTS pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT, -- Refere-se a um 'usuario'
    data_pedido DATETIME NOT NULL,
    forma_pagamento_id INT,
    status VARCHAR(50) NOT NULL, -- Ex: 'Pendente', 'Pago', 'Enviado', 'Cancelado'
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario_atualizacao INT,
    ativo TINYINT(1) DEFAULT 1,
    FOREIGN KEY (cliente_id) REFERENCES usuario(id) ON DELETE SET NULL,
    FOREIGN KEY (forma_pagamento_id) REFERENCES forma_pagamento(id) ON DELETE SET NULL,
    FOREIGN KEY (usuario_atualizacao) REFERENCES usuario(id) ON DELETE SET NULL
);

-- Tabela item_pedido
CREATE TABLE IF NOT EXISTS item_pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    produto_id INT,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (produto_id) REFERENCES produto(id) ON DELETE SET NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedido(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS conta (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome_cliente VARCHAR(100) NOT NULL,
    saldo DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    CHECK (saldo >= 0)
);
 
INSERT INTO conta (nome_cliente, saldo) VALUES ('Ana', 1000.00);
INSERT INTO conta (nome_cliente, saldo) VALUES ('Bob', 500.00);
 
-- Debita da conta da Ana
UPDATE conta SET saldo = saldo - 200 WHERE nome_cliente = 'Ana';
 
-- Aqui ocorre uma falha (ex: perda de conexão)
 
-- Credita na conta do Bob
UPDATE conta SET saldo = saldo + 200 WHERE nome_cliente = 'Bob';
 
-- Exemplo Seguro:
START TRANSACTION;
 
-- Debita da conta de Ana
UPDATE conta SET saldo = saldo - 200 WHERE nome_cliente = 'Ana';
 
-- Confere se a conta da Ana tem saldo suficiente (opcional, mas ilustrativo)
SELECT saldo FROM conta WHERE nome_cliente = 'Ana';
 
-- Credita na conta do Bob
UPDATE conta SET saldo = saldo + 200 WHERE nome_cliente = 'Bob';
 
-- Se tudo ocorreu bem, confirma a transação
COMMIT;
 
-- Exemplo com Erro:
START TRANSACTION;
 
UPDATE conta SET saldo = saldo - 200 WHERE nome_cliente = 'Ana';
 
-- Simulando erro: coluna inexistente
UPDATE conta SET saldxo = saldo + 200 WHERE nome_cliente = 'Bob';
 
-- ROLLBACK será necessário porque a segunda falha
ROLLBACK;