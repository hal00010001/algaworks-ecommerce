package com.algaworks.ecommerce.util;

import com.algaworks.ecommerce.model.Produto;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class IniciarUnidadePersistencia {

    public static void main(String[] args) {
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("ecommerce-pu");
        EntityManager entityManager = entityManagerFactory.createEntityManager();

//        Faça seus testes aqui

        Produto produto = entityManager.find(Produto.class, 1);
        System.out.println(produto.getNome());

        entityManager.close();
        entityManagerFactory.close();

    }

}
