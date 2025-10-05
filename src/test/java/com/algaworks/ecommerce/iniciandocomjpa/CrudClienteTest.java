package com.algaworks.ecommerce.iniciandocomjpa;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.model.Cliente;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

public class CrudClienteTest extends EntityManagerTest {

    @Test
    public void criarCliente() {

        Cliente cliente = new Cliente();

//        cliente.setId(3);
        cliente.setNome("Fulano da Silva");

        entityManager.getTransaction().begin();
        entityManager.persist(cliente);
        entityManager.getTransaction().commit();

        entityManager.clear();

        Cliente clienteVerificado = entityManager.find(Cliente.class, cliente.getId());
        Assertions.assertNotNull(clienteVerificado);
//        Assertions.assertEquals(3, clienteVerificado.getId());
        Assertions.assertEquals("Fulano da Silva", clienteVerificado.getNome());

    }

    @Test
    public void buscarCliente(){

        Cliente cliente = entityManager.find(Cliente.class, 1);

        entityManager.clear();

        Assertions.assertEquals("João da Silva", cliente.getNome());

    }

    @Test
    public void atualizarCliente(){

        Cliente cliente = entityManager.find(Cliente.class, 3);

        cliente.setNome("Fulano da Costa");

        entityManager.getTransaction().begin();
        entityManager.merge(cliente);
        entityManager.getTransaction().commit();

        entityManager.clear();

        Cliente clienteVerificado = entityManager.find(Cliente.class, cliente.getId());
        Assertions.assertEquals("Fulano da Costa", clienteVerificado.getNome());

    }

    @Test
    public void removerCliente(){

        Cliente cliente = entityManager.find(Cliente.class, 3);

        entityManager.getTransaction().begin();
        entityManager.remove(cliente);
        entityManager.getTransaction().commit();

        Cliente clienteVerificado = entityManager.find(Cliente.class, 3);
        Assertions.assertNull(clienteVerificado);

    }

}
