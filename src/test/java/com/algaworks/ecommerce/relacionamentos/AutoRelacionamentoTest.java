package com.algaworks.ecommerce.relacionamentos;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.model.Categoria;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

public class AutoRelacionamentoTest extends EntityManagerTest {

//    @Test
    public void verificarRelacionamentoCategoriaPai(){
        Categoria categoriaPai = new Categoria();
        categoriaPai.setNome("Futebol");

        Categoria categoria = new Categoria();
        categoria.setNome("Uniformes");
        categoria.setCategoriaPai(categoriaPai);

        entityManager.getTransaction().begin();
        entityManager.persist(categoriaPai);
        entityManager.persist(categoria);
        entityManager.getTransaction().commit();

        entityManager.clear();

        Categoria categoriaVerificada = entityManager.find(Categoria.class, categoria.getId());
        Assertions.assertNotNull(categoriaVerificada.getCategoriaPai());

        Categoria categoriaPaiVerificada = entityManager.find(Categoria.class, categoriaPai.getId());
        Assertions.assertFalse(categoriaPaiVerificada.getCategorias().isEmpty());
    }

}
