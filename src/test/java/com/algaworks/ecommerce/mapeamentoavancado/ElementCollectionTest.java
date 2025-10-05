package com.algaworks.ecommerce.mapeamentoavancado;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.model.Atributo;
import com.algaworks.ecommerce.model.Cliente;
import com.algaworks.ecommerce.model.Produto;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class ElementCollectionTest extends EntityManagerTest {

    @Test
    public void aplicarTags(){
        entityManager.getTransaction().begin();

        Produto produto = entityManager.find(Produto.class, 1);
        produto.setTags(Arrays.asList("ebook", "livro-digital"));

        entityManager.getTransaction().commit();

        entityManager.clear();

        Produto produtoVerificacao = entityManager.find(Produto.class, produto.getId());
        Assertions.assertFalse(produtoVerificacao.getTags().isEmpty());
    }

    @Test
    public void aplicarAtributos(){
        entityManager.getTransaction().begin();

        Produto produto = entityManager.find(Produto.class, 1);
        produto.setAtributos(List.of(new Atributo("tela", "320x600")));

        entityManager.getTransaction().commit();

        entityManager.clear();

        Produto produtoVerificacao = entityManager.find(Produto.class, produto.getId());
        Assertions.assertFalse(produtoVerificacao.getTags().isEmpty());
    }

    @Test
    public void aplicarContato(){
        entityManager.getTransaction().begin();

        Cliente cliente = entityManager.find(Cliente.class, 1);
        cliente.setContatos(Collections.singletonMap("email", "joao@email.com"));

        entityManager.getTransaction().commit();

        entityManager.clear();

        Cliente clienteVerificacao = entityManager.find(Cliente.class, cliente.getId());
        Assertions.assertEquals("joao@email.com", clienteVerificacao.getContatos().get("email"));

    }

}
