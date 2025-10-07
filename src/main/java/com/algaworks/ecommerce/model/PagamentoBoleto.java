package com.algaworks.ecommerce.model;

import jakarta.persistence.*;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@DiscriminatorValue("boleto")
//@Table(name = "pagamento_boleto")
public class PagamentoBoleto extends Pagamento {

    /*@Column(name = "pedido_id")
    private Integer pedidoId;

    @Enumerated(EnumType.STRING)
    private StatusPagamento status;*/

    @Column(name = "codigo_barras")
    private String codigoBarras;

}
