package com.algaworks.ecommerce.operacoesemcascata;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.model.ItemPedido;
import com.algaworks.ecommerce.model.ItemPedidoId;
import com.algaworks.ecommerce.model.Pedido;
import com.algaworks.ecommerce.model.Produto;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

public class CascadeTypeRemoveTest extends EntityManagerTest {

//    @Test
    public void removerItensOrfaos(){

        Pedido pedido = entityManager.find(Pedido.class, 1);

        Assertions.assertFalse(pedido.getItensPedido().isEmpty());

        entityManager.getTransaction().begin();
        pedido.getItensPedido().remove(0);
        entityManager.getTransaction().commit();

        entityManager.clear();

        Pedido pedidoVerificacao = entityManager.find(Pedido.class, pedido.getId());


    }

//    @Test
    public void removerRelacaoProdutoCategoria(){

        Produto produto = entityManager.find(Produto.class, 1);

        Assertions.assertFalse(produto.getCategorias().isEmpty());

        entityManager.getTransaction().begin();
        produto.getCategorias().clear();
        entityManager.getTransaction().commit();

        entityManager.clear();

        Produto produtoVerificacao = entityManager.find(Produto.class, produto.getId());
        Assertions.assertTrue(produtoVerificacao.getCategorias().isEmpty());

    }

//    @Test
    public void removerPedidoEItens(){

        Pedido pedido = entityManager.find(Pedido.class, 1);

        entityManager.getTransaction().begin();
//        pedido.getItensPedido().forEach(i -> entityManager.remove(i));
        entityManager.remove(pedido);
        entityManager.getTransaction().commit();

        entityManager.clear();

        Pedido pedidoVerificacao = entityManager.find(Pedido.class, pedido.getId());
        Assertions.assertNull(pedidoVerificacao);

    }

//    @Test
    public void removerItemPedidoEPedido(){

        ItemPedido itemPedido = entityManager.find(ItemPedido.class, new ItemPedidoId(1, 1));

        entityManager.getTransaction().begin();
        entityManager.remove(itemPedido);
        entityManager.getTransaction().commit();

        entityManager.clear();

        Pedido pedidoVerificacao = entityManager.find(Pedido.class, itemPedido.getPedido().getId());
        Assertions.assertNull(pedidoVerificacao);

    }

}
