package com.algaworks.ecommerce.model;

import jakarta.persistence.*;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@Entity
@Table(name = "nota_fiscal")
public class NotaFiscal extends EntidadeBaseInteger {

    /*@JoinTable(name = "pedido_nota_fiscal",
                joinColumns = @JoinColumn(name = "nota_fiscal_id", unique = true),
                inverseJoinColumns = @JoinColumn(name = "pedido_id", unique = true)) só para anotar que também é possível usar o join table com one to one */
    /*@OneToOne(optional = false)
    @JoinColumn(name = "pedido_id", insertable = false, updatable = false)*/

    @MapsId
    @OneToOne(optional = false)
    @JoinColumn(name = "pedido_id", nullable = false, foreignKey = @ForeignKey(name = "fk_nota_fiscal_pedido"))
    private Pedido pedido;

    @Lob
    @Column(length = 1000, nullable = false)
    private byte[] xml;

    @Column(name = "data_emissao", nullable = false)
    private Date dataEmissao;

}
