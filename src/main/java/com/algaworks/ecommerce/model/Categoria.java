package com.algaworks.ecommerce.model;

import jakarta.persistence.*;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
//@EqualsAndHashCode(onlyExplicitlyIncluded = true)
@Entity
@Table(name = "categoria")
public class Categoria extends EntidadeBaseInteger {

    /*@EqualsAndHashCode.Include
    @Id*/
//    @GeneratedValue(strategy = GenerationType.AUTO)
//    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    /*@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq")
    @SequenceGenerator(name = "seq", sequenceName = "categoria_sequencia_chave_primaria", allocationSize = 50)*/
    /*@GeneratedValue(strategy = GenerationType.TABLE, generator = "tabela")
    @TableGenerator(name = "tabela", table = "hibernate_sequences",
                        pkColumnName = "sequence_name",
                        pkColumnValue = "categoria",
                        valueColumnName = "next_val",
                        initialValue = 0,
                        allocationSize = 50)*/
    /*@GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;*/

    private String nome;

    /*@Column(name = "categoria_pai_id")
    private Integer categoriaPaiId;*/

    @ManyToOne
    @JoinColumn(name = "categoria_pai_id") // precisa ser opcional pois a categoria pode ser a raiz
    private Categoria categoriaPai;

    @OneToMany(mappedBy = "categoriaPai")
    private List<Categoria> categorias;

    @ManyToMany(mappedBy = "categorias")
    private List<Produto> produtos;

}
