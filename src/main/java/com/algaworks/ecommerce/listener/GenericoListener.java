package com.algaworks.ecommerce.listener;

import jakarta.persistence.PostLoad;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;

public class GenericoListener {

    @PostLoad
    public void logCarregamento(Object obj){
        System.out.println("Entidade " + obj.getClass().getSimpleName() + " foi carregada");
    }

}
