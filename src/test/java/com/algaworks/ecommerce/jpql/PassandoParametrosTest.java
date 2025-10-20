package com.algaworks.ecommerce.jpql;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.model.NotaFiscal;
import com.algaworks.ecommerce.model.Pedido;
import com.algaworks.ecommerce.model.StatusPagamento;
import jakarta.persistence.TemporalType;
import jakarta.persistence.TypedQuery;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

public class PassandoParametrosTest extends EntityManagerTest {

    @Test
    public void passarParametro(){

        /*String jpql = "select p from Pedido p join p.pagamento pag " +
                "where p.id = ?1 and pag.status = ?2";  Pode ser usado com variáveis, com números de posição ou misto */

        String jpql = "select p from Pedido p join p.pagamento pag " +
                "where p.id = :pedidoId and pag.status = :pagamentoStatus";

        TypedQuery<Pedido> typedQuery = entityManager.createQuery(jpql, Pedido.class);
        /*typedQuery.setParameter(1, 2);
        typedQuery.setParameter(2, StatusPagamento.PROCESSANDO);*/

        typedQuery.setParameter("pedidoId", 2);
        typedQuery.setParameter("pagamentoStatus", StatusPagamento.PROCESSANDO);

        List<Pedido> lista = typedQuery.getResultList();

        System.out.println("============================");
        System.out.println(lista.size());

        Assertions.assertTrue(lista.size() == 1);

    }

//    @Test
    public void passarParametroDate(){

        String jpql = "select nf from NotaFiscal nf where nf.dataEmissao <= ?1";

        TypedQuery<NotaFiscal> typedQuery = entityManager.createQuery(jpql, NotaFiscal.class);
        typedQuery.setParameter(1, new Date(), TemporalType.TIMESTAMP);

        List<NotaFiscal> lista = typedQuery.getResultList();

        System.out.println("============================");
        System.out.println(lista.size());

        Assertions.assertTrue(lista.size() == 1);

    }

}
