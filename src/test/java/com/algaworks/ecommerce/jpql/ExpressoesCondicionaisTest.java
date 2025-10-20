package com.algaworks.ecommerce.jpql;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.model.Pedido;
import com.algaworks.ecommerce.model.Produto;
import jakarta.persistence.TypedQuery;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

public class ExpressoesCondicionaisTest extends EntityManagerTest {

    @Test
    public void usarExpressaoCondicionalLike() {

        /*
        Forma 1 - usando o % no parâmetro

        String jpql = "select c from Cliente c where c.nome like :nome";

        TypedQuery<Object[]> typedQuery = entityManager.createQuery(jpql, Object[].class);
        typedQuery.setParameter("nome", "João%");
        List<Object[]> lista = typedQuery.getResultList();*/

        /*
        Forma 2 - usando o % na string jpql
        String jpql = "select c from Cliente c where c.nome like concat(:nome, '%')";

        TypedQuery<Object[]> typedQuery = entityManager.createQuery(jpql, Object[].class);
        typedQuery.setParameter("nome", "João");
        List<Object[]> lista = typedQuery.getResultList();*/

        /*
        Forma 3 - usando o % no começo e colocando sobrenome na variável
        String jpql = "select c from Cliente c where c.nome like concat('%', :nome)";

        TypedQuery<Object[]> typedQuery = entityManager.createQuery(jpql, Object[].class);
        typedQuery.setParameter("nome", "Silva");
        List<Object[]> lista = typedQuery.getResultList();*/

        // Forma 4 - buscando todos que tem a letra "a" em qualquer do nome
        String jpql = "select c from Cliente c where c.nome like concat('%', :nome, '%')";

        TypedQuery<Object[]> typedQuery = entityManager.createQuery(jpql, Object[].class);
        typedQuery.setParameter("nome", "a");
        List<Object[]> lista = typedQuery.getResultList();

        Assertions.assertFalse(lista.isEmpty());

    }

    @Test
    public void usarIsNull() {

        String jpql = "select p from Produto p where p.foto is null";

        TypedQuery<Object[]> typedQuery = entityManager.createQuery(jpql, Object[].class);
        List<Object[]> lista = typedQuery.getResultList();

        Assertions.assertFalse(lista.isEmpty());

    }

//    @Test
    public void usarIsEmpty() {

        String jpql = "select p from Produto p where p.categorias is empty";

        TypedQuery<Object[]> typedQuery = entityManager.createQuery(jpql, Object[].class);
        List<Object[]> lista = typedQuery.getResultList();

        Assertions.assertFalse(lista.isEmpty());

    }

    @Test
    public void usarMaiorMenor() {

//        String jpql = "select p from Produto p where p.preco > :preco";

        String jpql = "select p from Produto p where p.preco >= :precoInicial and p.preco <= :precoFinal";

        TypedQuery<Produto> typedQuery = entityManager.createQuery(jpql, Produto.class);
//        typedQuery.setParameter("preco", new BigDecimal(499));
        typedQuery.setParameter("precoInicial", new BigDecimal(400));
        typedQuery.setParameter("precoFinal", new BigDecimal(1500));
        List<Produto> lista = typedQuery.getResultList();

        Assertions.assertFalse(lista.isEmpty());

    }

    @Test
    public void usarMaiorMenorComDatas() {

        String jpql = "select p from Pedido p where p.dataCriacao > :dataVariavel";

        TypedQuery<Pedido> typedQuery = entityManager.createQuery(jpql, Pedido.class);
        typedQuery.setParameter("dataVariavel", LocalDateTime.now().minusDays(2));

        List<Pedido> lista = typedQuery.getResultList();

        Assertions.assertFalse(lista.isEmpty());

    }

//    @Test
    public void usarBetween(){

        String jpql = "select p from Pedido p where p.dataCriacao between :dataInicial and :dataFinal";

        TypedQuery<Pedido> typedQuery = entityManager.createQuery(jpql, Pedido.class);
        typedQuery.setParameter("dataInicial", LocalDateTime.now().minusDays(2));
        typedQuery.setParameter("dataFinal", LocalDateTime.now());

        List<Pedido> lista = typedQuery.getResultList();
        Assertions.assertFalse(lista.isEmpty());

    }

    @Test
    public void usarExpressaoDiferente(){

        String jpql = "select p from Produto p where p.preco <> 100";
        TypedQuery<Produto> typedQuery = entityManager.createQuery(jpql, Produto.class);
        List<Produto> lista = typedQuery.getResultList();

        Assertions.assertFalse(lista.isEmpty());

    }

}
