package com.algaworks.ecommerce.jpql;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.model.Pedido;
import jakarta.persistence.TypedQuery;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import java.util.List;

public class FuncoesTest extends EntityManagerTest {

    @Test
    public void aplicarFuncao() {

//        String jpql = "select c.nome, concat('Categoria: ', c.nome) from Categoria c";
//        String jpql = "select c.nome, length(c.nome) from Categoria c";
//        String jpql = "select c.nome, locate('a', c.nome) from Categoria c";
//        String jpql = "select c.nome, substring(c.nome, 1, 2) from Categoria c";
//        String jpql = "select c.nome, lower(c.nome) from Categoria c";
        String jpql = "select c.nome, upper(c.nome) from Categoria c";
//        String jpql = "select c.nome, trim(c.nome) from Categoria c";

        TypedQuery<Object[]> typedQuery = entityManager.createQuery(jpql, Object[].class);
        List<Object[]> lista = typedQuery.getResultList();
        Assertions.assertFalse(lista.isEmpty());

        lista.forEach(arr -> System.out.println(arr[0] + " - " + arr[1]));

    }

    @Test
    public void aplicarFuncaoData() {

//        TimeZone.setDefault(TimeZone.getTimeZone("UTC"));

//        String jpql = "select current_date, current_time, current_timestamp from Pedido p";
        String jpql = "select year(p.dataCriacao), month(p.dataCriacao), day(p.dataCriacao), hour(p.dataCriacao), minute(p.dataCriacao), second(p.dataCriacao) from Pedido p";

        TypedQuery<Object[]> typedQuery = entityManager.createQuery(jpql, Object[].class);
        List<Object[]> lista = typedQuery.getResultList();
        Assertions.assertFalse(lista.isEmpty());

        lista.forEach(arr -> System.out.println(arr[0] + " | " + arr[1] + " | " + arr[2]));

    }

    @Test
    public void aplicarFuncaoNumero(){

        String jpql = "select abs(p.total), mod(p.id, 2), sqrt(p.total) from Pedido p";

        TypedQuery<Object[]> typedQuery = entityManager.createQuery(jpql, Object[].class);
        List<Object[]> lista = typedQuery.getResultList();
        Assertions.assertFalse(lista.isEmpty());

        lista.forEach(arr -> System.out.println(arr[0] + " | " + arr[1] + " | " + arr[2]));

    }

    @Test
    public void aplicarFuncaoColecao(){

        String jpql = "select size(p.itensPedido) from Pedido p where size(p.itensPedido) > 1";

        TypedQuery<Integer> typedQuery = entityManager.createQuery(jpql, Integer.class);
        List<Integer> lista = typedQuery.getResultList();
        Assertions.assertFalse(lista.isEmpty());

//        lista.forEach(size -> System.out.println(size));
        lista.forEach(System.out::println);

    }

    @Test
    public void aplicarFuncaoNativa(){

        String jpql = "select p from Pedido p where function('acima_media_faturamento', p.total) = 1";

        TypedQuery<Pedido> typedQuery = entityManager.createQuery(jpql, Pedido.class);
        List<Pedido> lista = typedQuery.getResultList();
        Assertions.assertFalse(lista.isEmpty());

        lista.forEach(obj -> System.out.println(obj));

    }

    @Test
    public void aplicarFuncaoAgregacao(){

//        String jpql = "select avg(p.total) from Pedido p";
//        String jpql = "select count(p.total) from Pedido p";
//        String jpql = "select min(p.total) from Pedido p";
//        String jpql = "select max(p.total) from Pedido p";
        String jpql = "select sum(p.total) from Pedido p";

        TypedQuery<Number> typedQuery = entityManager.createQuery(jpql, Number.class);
        List<Number> lista = typedQuery.getResultList();
        Assertions.assertFalse(lista.isEmpty());

        lista.forEach(obj -> System.out.println(obj));

    }

}
