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
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
@EntityListeners({ GerarNotaFiscalListener.class, GenericoListener.class })
@Entity
@Table(name = "pedido")
public class Pedido {

    @EqualsAndHashCode.Include
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "data_criacao", updatable = false)
    private LocalDateTime dataCriacao;

    @Column(name = "data_ultima_atualizacao", insertable = false)
    private LocalDateTime dataUltimaAtualizacao;

    /*@Column(name = "cliente_id")
    private Integer clienteId; Não é necessário criar o cliente_id, pois quando é apontado o ManyToOne, ele já aponta pra tabela cliente (se colocar vai dar erro) */
    /*@Column(name = "nota_fiscal_id")
    private Integer notaFiscalId;*/

    private BigDecimal total;

    @Enumerated(EnumType.STRING)
    private StatusPedido status;

    @Embedded
    private EnderecoEntregaPedido enderecoEntrega;

    @ManyToOne(optional = false)
    @JoinColumn(name = "cliente_id")
    private Cliente cliente;

    @OneToMany(mappedBy = "pedido")
    private List<ItemPedido> itensPedido;

    @OneToOne(mappedBy = "pedido")
    private PagamentoCartao pagamentoCartao;

    @OneToOne(mappedBy = "pedido")
    private NotaFiscal notaFiscal;

    public boolean isPago(){
        return StatusPedido.PAGO.equals(this.status);
    }

    private void calcularTotal(){
        if(this.itensPedido != null){
            this.total = this.itensPedido.stream().map(ItemPedido::getPrecoProduto)
                    .reduce(BigDecimal.ZERO, BigDecimal::add);
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
