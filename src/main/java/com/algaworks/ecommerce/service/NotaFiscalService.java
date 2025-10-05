package com.algaworks.ecommerce.service;

import com.algaworks.ecommerce.model.Pedido;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;

public class NotaFiscalService {

    @PrePersist
    @PreUpdate
    public void gerar(Pedido pedido){
        System.out.println("Gerando nota para o pedido" + pedido.getId());
    }

}
