package com.algaworks.ecommerce.mapeamentoavancado;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.model.NotaFiscal;
import com.algaworks.ecommerce.model.Pedido;
import com.algaworks.ecommerce.model.Produto;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.util.Date;
import java.util.Objects;

public class SalvandoArquivosTest extends EntityManagerTest {

    @Test
    public void salvarFotoProduto(){
        entityManager.getTransaction().begin();
        Produto produto = entityManager.find(Produto.class, 1);
        produto.setFoto(carregarFoto());
        entityManager.getTransaction().commit();

        entityManager.clear();

        Produto produtoVerificacao = entityManager.find(Produto.class, 1);
        Assertions.assertNotNull(produtoVerificacao.getFoto());
        Assertions.assertTrue(produtoVerificacao.getFoto().length > 0);
    }

    @Test
    public void salvarXmlNota(){

        Pedido pedido = entityManager.find(Pedido.class, 1);

        NotaFiscal notaFiscal = new NotaFiscal();
        notaFiscal.setPedido(pedido);
        notaFiscal.setDataEmissao(new Date());
        notaFiscal.setXml(carregarNotaFiscal());

        entityManager.getTransaction().begin();
        entityManager.persist(notaFiscal);
        entityManager.getTransaction().commit();

        entityManager.clear();

        NotaFiscal notaFiscalVerificacao = entityManager.find(NotaFiscal.class, notaFiscal.getId());

        Assertions.assertNotNull(notaFiscalVerificacao.getXml());
        Assertions.assertTrue(notaFiscalVerificacao.getXml().length > 0);

        /*try {
            OutputStream outputStream = new FileOutputStream(Files.createFile(Paths.get(System.getProperty("user.home") + "/xml.xml")).toFile());
            outputStream.write(notaFiscalVerificacao.getXml());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }*/


    }

    public static byte[] carregarFoto(){
        return carregarArquivo("/eu_hard_rock_new_new.png");
    }

    public static byte[] carregarNotaFiscal(){
        return carregarArquivo("/nota-exemplo.xml");
    }

    private static byte[] carregarArquivo(String nome){
        try {
            return SalvandoArquivosTest.class.getResourceAsStream(nome).readAllBytes();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

}
