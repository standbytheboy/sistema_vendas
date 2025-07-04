<?php

/**
 * Classe base abstrata para todas as entidades do sistema.
 * Contém campos comuns de auditoria e controle.
 */
class Entidade
{
    protected ?int $id;
    protected ?string $dataCriacao;
    protected ?string $dataAtualizacao;
    protected ?Usuario $usuarioAtualizacao;
    protected bool $ativo;

    public function __construct(?int $id, bool $ativo, ?string $dataCriacao, ?string $dataAtualizacao, ?Usuario $usuarioAtualizacao = null)
    {
        $this->id = $id;
        $this->ativo = $ativo;
        $this->dataCriacao = $dataCriacao;
        $this->dataAtualizacao = $dataAtualizacao;
        $this->usuarioAtualizacao = $usuarioAtualizacao;
    }

    public function getId(): ?int { return $this->id; }
    public function isAtivo(): bool { return $this->ativo; }
    public function getDataCriacao(): ?string { return $this->dataCriacao; }
    public function getDataAtualizacao(): ?string { return $this->dataAtualizacao; }
    public function getUsuarioAtualizacao(): ?Usuario { return $this->usuarioAtualizacao; }
}