<?php

header('Content-Type: text/plain; charset=utf-8');

require_once __DIR__ . '/Entidade.php';
require_once __DIR__ . '/Usuario.php'; 
require_once __DIR__ . '/Categoria.php';
require_once __DIR__ . '/FormaPagamento.php';
require_once __DIR__ . '/Produto.php';
require_once __DIR__ . '/ItemPedido.php';
require_once __DIR__ . '/Pedido.php';

echo "===============================================\n";
echo "INICIANDO TESTE DE INSTANCIAÇÃO DE MODELS\n";
echo "===============================================\n\n";

// Etapa preliminar: Criar um usuário admin para os registros de auditoria
echo "0. Criando Usuário Administrador para auditoria...\n";
$dataAtual = date('Y-m-d H:i:s');
$adminUser = new Usuario(
    1, 'Admin Sistema', 'admin', 'senha_admin', 'admin@sistema.com', 
    null, null, true, true, null, $dataAtual, $dataAtual, null
);
print_r($adminUser);
echo "\n";


// 1. Criando entidades simples
echo "1. Criando Categoria e Forma de Pagamento...\n";
$categoriaEletronicos = new Categoria(
    1, 'Eletrônicos', 'Dispositivos eletrônicos e acessórios', true, 
    $dataAtual, $dataAtual, $adminUser
);
$formaPagamentoCartao = new FormaPagamento(
    1, 'Cartão de Crédito', 'Pagamento via cartão de crédito', true, 
    $dataAtual, $dataAtual, $adminUser
);

print_r($categoriaEletronicos);
print_r($formaPagamentoCartao);
echo "\n";

// 2. Criando um usuário (que será nosso cliente)
echo "2. Criando um Usuário (Cliente)...\n";
$cliente = new Usuario(
    10, 'João da Silva Souza', 'joao.silva', 'senha_super_segura', 'joao@exemplo.com',
    '11999998888', '123.456.789-00', false, true, null,
    $dataAtual, $dataAtual, $adminUser
);

print_r($cliente);
echo "\n";

// 3. Criando produtos que pertencem a uma categoria
echo "3. Criando Produtos...\n";
$produtoNotebook = new Produto(
    101, 'Notebook Gamer', 'Notebook de alta performance para jogos', 7500.50, $categoriaEletronicos, true,
    $dataAtual, $dataAtual, $adminUser
);
$produtoMouse = new Produto(
    102, 'Mouse Sem Fio', 'Mouse óptico sem fio com 6 botões', 150.75, $categoriaEletronicos, true,
    $dataAtual, $dataAtual, $adminUser
);

print_r($produtoNotebook);
print_r($produtoMouse);
echo "\n";

// 4. criando itens do pedido
$item1 = new ItemPedido(201, 5001, $produtoNotebook, 1, $produtoNotebook->getPreco());
$item2 = new ItemPedido(201, 5001, $produtoMouse, 2, $produtoMouse->getPreco());


// 5. criando o pedido
$itensDoPedido = [$item1, $item2];
echo "5. Criando o pedido completo... \n";
$pedido = new Pedido(
    5001,
    $cliente,
    date('Y-m-d H:i:s'),
    $formaPagamentoCartao,
    'Pendente',
    true,
    $itensDoPedido,
    $dataAtual,
    $dataAtual,
    $cliente
);
echo "\n";
print_r($pedido);
echo "\n";

echo "\n===============================================\n";
echo "RESULTADO FINAL - OBJETO PEDIDO COMPLETO\n";
echo "===============================================\n\n";

// Exibindo o objeto Pedido completo com print_r para ver a estrutura aninhada
print_r($pedido);

echo "\n===============================================\n";
echo "EXIBINDO DADOS COM GETTERS\n";
echo "===============================================\n\n";

echo "ID do Pedido: " . $pedido->getId() . "\n";
echo "Cliente: " . $pedido->getCliente()->getNomeCompleto() . " (Email: " . $pedido->getCliente()->getEmail() . ")\n";
echo "Data do Pedido: " . $pedido->getDataPedido() . "\n";
echo "Status: " . $pedido->getStatus() . "\n";
echo "Forma de Pagamento: " . $pedido->getFormaPagamento()->getNome() . "\n";
echo "Auditoria: Criado em " . $pedido->getDataCriacao() . " por " . $pedido->getUsuarioAtualizacao()->getNomeCompleto() . "\n";
echo "-----------------------------------------------\n";
echo "Itens do Pedido:\n\n";

foreach ($pedido->getItens() as $item) {
    echo "  - Produto: " . $item->getProduto()->getNome() . "\n";
    echo "    Categoria: " . $item->getProduto()->getCategoria()->getNome() . "\n";
    echo "    Quantidade: " . $item->getQuantidade() . "\n";
    echo "    Preço Unitário: R$ " . number_format($item->getPrecoUnitario(), 2, ',', '.') . "\n";
    echo "    Subtotal: R$ " . number_format($item->getSubtotal(), 2, ',', '.') . "\n\n";
}

echo "-----------------------------------------------\n";
echo "TOTAL DO PEDIDO: R$ " . number_format($pedido->getTotal(), 2, ',', '.') . "\n";
echo "===============================================\n";
echo "TESTE CONCLUÍDO\n";
echo "===============================================\n";

?>