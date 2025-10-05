package com.algaworks.ecommerce.model;

import jakarta.persistence.*;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@Getter
@Setter
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
@SecondaryTable(name = "cliente_detalhe", pkJoinColumns = @PrimaryKeyJoinColumn(name = "cliente_id"))
@Entity
@Table(name = "cliente")
public class Cliente {

    @EqualsAndHashCode.Include
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String nome;

    @ElementCollection
    @CollectionTable(name = "cliente_contato", joinColumns = @JoinColumn(name = "cliente_id"))
    @MapKeyColumn(name = "tipo")
    @Column(name = "descricao")
    private Map<String, String> contatos;

    @Transient
    private String primeiroNome;

    @Column(table = "cliente_detalhe")
    @Enumerated(EnumType.STRING)
    private SexoCliente sexo;

    @Column(name = "data_nascimento", table = "cliente_detalhe")
    private LocalDate dataNascimento;

    @OneToMany(mappedBy = "cliente")
    private List<Pedido> pedidos;

    @PostLoad
    public void configurarPrimeiroNome(){
        if(nome != null && !nome.isBlank()){
            int index = nome.indexOf(" ");
            if (index > -1){
                primeiroNome = nome.substring(0, index);
            }
        }
    }

    /*@Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Cliente other)) return false;
        if (this.id == null || other.id == null) return false;
        return this.id.equals(other.id);
    }

    @Override
    public int hashCode() {
        return (id == null) ? 0 : id.hashCode();
    }*/

}
