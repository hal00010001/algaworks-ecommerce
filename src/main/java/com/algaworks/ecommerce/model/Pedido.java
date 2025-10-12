package com.algaworks.ecommerce.model;

import com.algaworks.ecommerce.listener.GenericoListener;
import com.algaworks.ecommerce.listener.GerarNotaFiscalListener;
import jakarta.persistence.*;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
@EntityListeners({ GerarNotaFiscalListener.class, GenericoListener.class })
@Entity
@Table(name = "pedido")
public class Pedido extends EntidadeBaseInteger {

    @Column(name = "data_criacao", updatable = false, nullable = false)
    private LocalDateTime dataCriacao;

    @Column(name = "data_ultima_atualizacao", insertable = false)
    private LocalDateTime dataUltimaAtualizacao;

    /*@Column(name = "cliente_id")
    private Integer clienteId; Não é necessário criar o cliente_id, pois quando é apontado o ManyToOne, ele já aponta pra tabela cliente (se colocar vai dar erro) */
    /*@Column(name = "nota_fiscal_id")
    private Integer notaFiscalId;*/

    @Column(nullable = false)
    private BigDecimal total;

    @Column(length = 30, nullable = false)
    @Enumerated(EnumType.STRING)
    private StatusPedido status;

    @Embedded
    private EnderecoEntregaPedido enderecoEntrega;

    @ManyToOne(optional = false)//, cascade = CascadeType.PERSIST)
    @JoinColumn(name = "cliente_id", nullable = false, foreignKey = @ForeignKey(name = "fk_pedido_cliente"))
    private Cliente cliente;

    @OneToMany(mappedBy = "pedido") //, cascade = CascadeType.PERSIST, orphanRemoval = true) // A única maneira do orphanRemoval funcionar é colocando o cascade persist //, cascade = CascadeType.REMOVE)
    private List<ItemPedido> itensPedido;

    @Column(name = "data_conclusao")
    private LocalDateTime dataConclusao;

    @OneToOne(mappedBy = "pedido")
    private Pagamento pagamento;

    @OneToOne(mappedBy = "pedido")
    private NotaFiscal notaFiscal;

    public boolean isPago(){
        return StatusPedido.PAGO.equals(this.status);
    }

    /*private void calcularTotal(){
        if(this.itensPedido != null){
            this.total = this.itensPedido.stream().map(ItemPedido::getPrecoProduto)
                    .reduce(BigDecimal.ZERO, BigDecimal::add);
        }
    }*/

    private void calcularTotal(){
        if(this.itensPedido != null){
            this.total = this.itensPedido.stream().map(
                    i -> new BigDecimal(i.getQuantidade()).multiply(i.getPrecoProduto()))
                    .reduce(BigDecimal.ZERO, BigDecimal::add);
        }
        else {
            total = BigDecimal.ZERO;
        }
    }

    @PrePersist
    private void aoPersistir(){
        dataCriacao = LocalDateTime.now();
        calcularTotal();
    }

    @PreUpdate
    private void aoAtualizar(){
        dataUltimaAtualizacao = LocalDateTime.now();
        calcularTotal();
    }

    @PostPersist
    private void aposPersistir(){
        System.out.println("Após persistir pedido");
    }

    @PostUpdate
    private void aposAtualizar(){
        System.out.println("Após atualizar pedido");
    }

    @PreRemove
    private void aoRemover(){
        System.out.println("Antes de remover pedido");
    }

    @PostRemove
    private void aposRemover(){
        System.out.println("Após remover pedido");
    }

    @PostLoad
    private void aoCarregar(){
        System.out.println("Após carregar o pedido");
    }

}
