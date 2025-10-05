package com.algaworks.ecommerce.relacionamentos;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.model.*;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class RelacionamentoManyToOneTest extends EntityManagerTest {

    @Test
    public void verificarRelacionamentoItemPedidoProdutoPedido() {

        entityManager.getTransaction().begin();

        Cliente cliente = entityManager.find(Cliente.class, 1);
        Produto produto = entityManager.find(Produto.class, 1);

        Pedido pedido = new Pedido();
        pedido.setDataCriacao(LocalDateTime.now());
        pedido.setStatus(StatusPedido.AGUARDANDO);
        pedido.setTotal(BigDecimal.TEN);
        pedido.setCliente(cliente);

//        entityManager.persist(pedido);

        // Pode ser que logo ao executar o metodo "persist" o JPA já faça a sincronização com a base.
        // Mas caso isso não aconteça, o flush garante a sincronização.
//        entityManager.flush();

        ItemPedido itemPedido = new ItemPedido();
//        itemPedido.setPedidoId(pedido.getId());
//        itemPedido.setProdutoId(produto.getId());
//        itemPedido.setId(new ItemPedidoId(pedido.getId(), produto.getId()));
        itemPedido.setId(new ItemPedidoId());
        itemPedido.setQuantidade(1);
        itemPedido.setPedido(pedido);
        itemPedido.setProduto(produto);
        itemPedido.setPrecoProduto(produto.getPreco());

        entityManager.persist(pedido);
        entityManager.persist(itemPedido);
        entityManager.getTransaction().commit();

        entityManager.clear();

        ItemPedido itemPedidoVerificado = entityManager.find(ItemPedido.class, new ItemPedidoId(pedido.getId(), produto.getId()));
        Assertions.assertNotNull(itemPedidoVerificado.getPedido());
        Assertions.assertNotNull(itemPedidoVerificado.getProduto());

    }

    @Test
    public void verificarRelacionamentoClientePedido() {
        Cliente cliente = entityManager.find(Cliente.class, 1);

        Pedido pedido = new Pedido();
        pedido.setStatus(StatusPedido.AGUARDANDO);
        pedido.setDataCriacao(LocalDateTime.now());
        pedido.setTotal(BigDecimal.TEN);

        pedido.setCliente(cliente);

        entityManager.getTransaction().begin();
        entityManager.persist(pedido);
        entityManager.getTransaction().commit();

        entityManager.clear();

        Pedido pedidoVerificado = entityManager.find(Pedido.class, pedido.getId());
        Assertions.assertNotNull(pedidoVerificado.getCliente());

    }

}
