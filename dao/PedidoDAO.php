<?php

require_once __DIR__ . '/../dao/CategoriaDAO.php';
require_once __DIR__ . '/../model/Pedido.php';
require_once __DIR__ . '/../model/ItemPedido.php';
require_once __DIR__ . '/../model/Usuario.php';
require_once __DIR__ . '/../database/Database.php';

class PedidoDAO
{
    private PDO $db;

    public function __construct()
    {
        $this->db = Database::getInstance();
    }

    private function mapObject(array $row): Pedido
    {
        $usuarioDAO = new UsuarioDAO();
        $formaPgamentoDAO = new FormaPagamentoDAO();

        $cliente = $usuarioDAO->getById($row['cliente_id']);
        $formaPagamento = $formaPgamentoDAO->getById($row['forma_pagamento_id']);
        $usuarioAtualizacao = $usuarioDAO->getById($row['usuario_atualizacao']);

        $pedido = new Pedido(
            $row['id'],
            $cliente,
            $row['data_pedido'],
            $formaPagamento,
            $row['status'],
            (bool)$row['ativo'],
            [],
            $row['data_criacao'],
            $row['data_atualizacao'],
            $usuarioAtualizacao
        );

        return $pedido;
    }

}