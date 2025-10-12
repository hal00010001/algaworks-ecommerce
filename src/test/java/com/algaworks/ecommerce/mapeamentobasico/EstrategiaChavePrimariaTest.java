package com.algaworks.ecommerce.mapeamentobasico;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.model.Categoria;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

public class EstrategiaChavePrimariaTest extends EntityManagerTest {

    @Test
    public void testarEstrategiaChave(){
        Categoria categopria = new Categoria();
        categopria.setNome("Revistas");

        entityManager.getTransaction().begin();
        entityManager.persist(categopria);
        entityManager.getTransaction().commit();

        entityManager.clear();

        Categoria categoriaVerificado = entityManager.find(Categoria.class, categopria.getId());
        Assertions.assertNotNull(categoriaVerificado);

    }

}
