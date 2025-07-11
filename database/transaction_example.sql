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