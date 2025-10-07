package com.algaworks.ecommerce.model;

import jakarta.persistence.*;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "estoque")
public class Estoque extends EntidadeBaseInteger {

    @OneToOne(optional = false) // é falso porque é preciso sempre informar o produto
    @JoinColumn(name = "produto_id")
    private Produto produto;

    private Integer quantidade;

}
