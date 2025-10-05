insert into produto (id, nome, preco, data_criacao, descricao) values (1, 'Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle');
insert into produto (id, nome, preco, data_criacao, descricao) values (3, 'Câmera GoPro Hero 7', 1400.0, date_sub(sysdate(), interval 1 day), 'Desempenho 2x melhor');

insert into cliente (id, nome) values (1, 'João da Silva');
insert into cliente (id, nome) values (2, 'Maria da Silva');

insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 100.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 5.0, 2);

insert into categoria (id, nome) values (1, 'Eletrônicos');