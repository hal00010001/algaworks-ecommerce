
    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo enum ('FEMININO','MASCULINO','OUTRO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclusao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(38,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao longtext,
        foto longblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on categoria (nome);

    alter table if exists categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table if exists cliente 
       add constraint unq_cpf unique (cpf);

    alter table if exists estoque 
       add constraint UKg72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table if exists produto 
       add constraint unq_nome unique (nome);

    alter table if exists categoria 
       add constraint fk_categoria_categoria_pai 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table if exists cliente_contato 
       add constraint fk_cliente_cliente_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists cliente_detalhe 
       add constraint FKm3dk45rdf6omp7m7cc37ngfqr 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists produto_atributo 
       add constraint fk_produto_produto_atributo 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_tag 
       add constraint fk_produto_produto_tag 
       foreign key (produto_id) 
       references produto (id);
insert into produto (id, nome, preco, data_criacao, descricao) values (1, 'Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle');
insert into produto (id, nome, preco, data_criacao, descricao) values (3, 'Câmera GoPro Hero 7', 1400.0, date_sub(sysdate(), interval 1 day), 'Desempenho 2x melhor');
insert into cliente (id, nome, cpf) values (1, 'João da Silva', '5678');
insert into cliente (id, nome, cpf) values (2, 'Maria da Silva', '9012');
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (1, 'MASCULINO', date_sub(sysdate(), interval 27 year));
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (2, 'FEMININO', date_sub(sysdate(), interval 30 year));
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 499.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499, 2);
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499, 1);
insert into pagamento (pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '1234', 'cartao');
insert into categoria (id, nome) values (1, 'Eletrônicos');

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo enum ('FEMININO','MASCULINO','OUTRO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclusao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(38,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao longtext,
        foto longblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on categoria (nome);

    alter table if exists categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table if exists cliente 
       add constraint unq_cpf unique (cpf);

    alter table if exists estoque 
       add constraint UKg72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table if exists produto 
       add constraint unq_nome unique (nome);

    alter table if exists categoria 
       add constraint fk_categoria_categoria_pai 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table if exists cliente_contato 
       add constraint fk_cliente_cliente_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists cliente_detalhe 
       add constraint FKm3dk45rdf6omp7m7cc37ngfqr 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists produto_atributo 
       add constraint fk_produto_produto_atributo 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_tag 
       add constraint fk_produto_produto_tag 
       foreign key (produto_id) 
       references produto (id);
insert into produto (id, nome, preco, data_criacao, descricao) values (1, 'Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle');
insert into produto (id, nome, preco, data_criacao, descricao) values (3, 'Câmera GoPro Hero 7', 1400.0, date_sub(sysdate(), interval 1 day), 'Desempenho 2x melhor');
insert into cliente (id, nome, cpf) values (1, 'João da Silva', '5678');
insert into cliente (id, nome, cpf) values (2, 'Maria da Silva', '9012');
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (1, 'MASCULINO', date_sub(sysdate(), interval 27 year));
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (2, 'FEMININO', date_sub(sysdate(), interval 30 year));
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 499.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499, 2);
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499, 1);
insert into pagamento (pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '1234', 'cartao');
insert into categoria (id, nome) values (1, 'Eletrônicos');

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo enum ('FEMININO','MASCULINO','OUTRO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclusao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(38,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao longtext,
        foto longblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on categoria (nome);

    alter table if exists categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table if exists cliente 
       add constraint unq_cpf unique (cpf);

    alter table if exists estoque 
       add constraint UKg72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table if exists produto 
       add constraint unq_nome unique (nome);

    alter table if exists categoria 
       add constraint fk_categoria_categoria_pai 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table if exists cliente_contato 
       add constraint fk_cliente_cliente_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists cliente_detalhe 
       add constraint FKm3dk45rdf6omp7m7cc37ngfqr 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists produto_atributo 
       add constraint fk_produto_produto_atributo 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_tag 
       add constraint fk_produto_produto_tag 
       foreign key (produto_id) 
       references produto (id);
insert into produto (id, nome, preco, data_criacao, descricao) values (1, 'Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle');
insert into produto (id, nome, preco, data_criacao, descricao) values (3, 'Câmera GoPro Hero 7', 1400.0, date_sub(sysdate(), interval 1 day), 'Desempenho 2x melhor');
insert into cliente (id, nome, cpf) values (1, 'João da Silva', '5678');
insert into cliente (id, nome, cpf) values (2, 'Maria da Silva', '9012');
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (1, 'MASCULINO', date_sub(sysdate(), interval 27 year));
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (2, 'FEMININO', date_sub(sysdate(), interval 30 year));
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 499.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499, 2);
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499, 1);
insert into pagamento (pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '1234', 'cartao');
insert into categoria (id, nome) values (1, 'Eletrônicos');

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo enum ('FEMININO','MASCULINO','OUTRO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclusao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(38,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao longtext,
        foto longblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on categoria (nome);

    alter table if exists categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table if exists cliente 
       add constraint unq_cpf unique (cpf);

    alter table if exists estoque 
       add constraint UKg72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table if exists produto 
       add constraint unq_nome unique (nome);

    alter table if exists categoria 
       add constraint fk_categoria_categoria_pai 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table if exists cliente_contato 
       add constraint fk_cliente_cliente_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists cliente_detalhe 
       add constraint FKm3dk45rdf6omp7m7cc37ngfqr 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists produto_atributo 
       add constraint fk_produto_produto_atributo 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_tag 
       add constraint fk_produto_produto_tag 
       foreign key (produto_id) 
       references produto (id);
insert into produto (id, nome, preco, data_criacao, descricao) values (1, 'Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle');
insert into produto (id, nome, preco, data_criacao, descricao) values (3, 'Câmera GoPro Hero 7', 1400.0, date_sub(sysdate(), interval 1 day), 'Desempenho 2x melhor');
insert into cliente (id, nome, cpf) values (1, 'João da Silva', '5678');
insert into cliente (id, nome, cpf) values (2, 'Maria da Silva', '9012');
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (1, 'MASCULINO', date_sub(sysdate(), interval 27 year));
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (2, 'FEMININO', date_sub(sysdate(), interval 30 year));
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 499.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499, 2);
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499, 1);
insert into pagamento (pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '1234', 'cartao');
insert into categoria (id, nome) values (1, 'Eletrônicos');

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo enum ('FEMININO','MASCULINO','OUTRO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclusao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(38,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao longtext,
        foto longblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on categoria (nome);

    alter table if exists categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table if exists cliente 
       add constraint unq_cpf unique (cpf);

    alter table if exists estoque 
       add constraint UKg72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table if exists produto 
       add constraint unq_nome unique (nome);

    alter table if exists categoria 
       add constraint fk_categoria_categoria_pai 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table if exists cliente_contato 
       add constraint fk_cliente_cliente_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists cliente_detalhe 
       add constraint FKm3dk45rdf6omp7m7cc37ngfqr 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists produto_atributo 
       add constraint fk_produto_produto_atributo 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_tag 
       add constraint fk_produto_produto_tag 
       foreign key (produto_id) 
       references produto (id);
insert into produto (id, nome, preco, data_criacao, descricao) values (1, 'Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle');
insert into produto (id, nome, preco, data_criacao, descricao) values (3, 'Câmera GoPro Hero 7', 1400.0, date_sub(sysdate(), interval 1 day), 'Desempenho 2x melhor');
insert into cliente (id, nome, cpf) values (1, 'João da Silva', '5678');
insert into cliente (id, nome, cpf) values (2, 'Maria da Silva', '9012');
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (1, 'MASCULINO', date_sub(sysdate(), interval 27 year));
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (2, 'FEMININO', date_sub(sysdate(), interval 30 year));
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 499.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499, 2);
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499, 1);
insert into pagamento (pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '1234', 'cartao');
insert into categoria (id, nome) values (1, 'Eletrônicos');

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo enum ('FEMININO','MASCULINO','OUTRO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclusao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(38,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao longtext,
        foto longblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on categoria (nome);

    alter table if exists categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table if exists cliente 
       add constraint unq_cpf unique (cpf);

    alter table if exists estoque 
       add constraint UKg72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table if exists produto 
       add constraint unq_nome unique (nome);

    alter table if exists categoria 
       add constraint fk_categoria_categoria_pai 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table if exists cliente_contato 
       add constraint fk_cliente_cliente_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists cliente_detalhe 
       add constraint FKm3dk45rdf6omp7m7cc37ngfqr 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists produto_atributo 
       add constraint fk_produto_produto_atributo 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_tag 
       add constraint fk_produto_produto_tag 
       foreign key (produto_id) 
       references produto (id);
insert into produto (id, nome, preco, data_criacao, descricao) values (1, 'Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle');
insert into produto (id, nome, preco, data_criacao, descricao) values (3, 'Câmera GoPro Hero 7', 1400.0, date_sub(sysdate(), interval 1 day), 'Desempenho 2x melhor');
insert into cliente (id, nome, cpf) values (1, 'João da Silva', '5678');
insert into cliente (id, nome, cpf) values (2, 'Maria da Silva', '9012');
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (1, 'MASCULINO', date_sub(sysdate(), interval 27 year));
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (2, 'FEMININO', date_sub(sysdate(), interval 30 year));
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 499.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499, 2);
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499, 1);
insert into pagamento (pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '1234', 'cartao');
insert into categoria (id, nome) values (1, 'Eletrônicos');

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo enum ('FEMININO','MASCULINO','OUTRO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclusao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(38,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao longtext,
        foto longblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on categoria (nome);

    alter table if exists categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table if exists cliente 
       add constraint unq_cpf unique (cpf);

    alter table if exists estoque 
       add constraint UKg72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table if exists produto 
       add constraint unq_nome unique (nome);

    alter table if exists categoria 
       add constraint fk_categoria_categoria_pai 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table if exists cliente_contato 
       add constraint fk_cliente_cliente_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists cliente_detalhe 
       add constraint FKm3dk45rdf6omp7m7cc37ngfqr 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists produto_atributo 
       add constraint fk_produto_produto_atributo 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_tag 
       add constraint fk_produto_produto_tag 
       foreign key (produto_id) 
       references produto (id);
insert into produto (id, nome, preco, data_criacao, descricao) values (1, 'Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle');
insert into produto (id, nome, preco, data_criacao, descricao) values (3, 'Câmera GoPro Hero 7', 1400.0, date_sub(sysdate(), interval 1 day), 'Desempenho 2x melhor');
insert into cliente (id, nome, cpf) values (1, 'João da Silva', '5678');
insert into cliente (id, nome, cpf) values (2, 'Maria da Silva', '9012');
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (1, 'MASCULINO', date_sub(sysdate(), interval 27 year));
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (2, 'FEMININO', date_sub(sysdate(), interval 30 year));
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 499.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499, 2);
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499, 1);
insert into pagamento (pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '1234', 'cartao');
insert into categoria (id, nome) values (1, 'Eletrônicos');

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo enum ('FEMININO','MASCULINO','OUTRO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclusao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(38,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao longtext,
        foto longblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on categoria (nome);

    alter table if exists categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table if exists cliente 
       add constraint unq_cpf unique (cpf);

    alter table if exists estoque 
       add constraint UKg72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table if exists produto 
       add constraint unq_nome unique (nome);

    alter table if exists categoria 
       add constraint fk_categoria_categoria_pai 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table if exists cliente_contato 
       add constraint fk_cliente_cliente_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists cliente_detalhe 
       add constraint FKm3dk45rdf6omp7m7cc37ngfqr 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists produto_atributo 
       add constraint fk_produto_produto_atributo 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_tag 
       add constraint fk_produto_produto_tag 
       foreign key (produto_id) 
       references produto (id);
insert into produto (id, nome, preco, data_criacao, descricao) values (1, 'Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle');
insert into produto (id, nome, preco, data_criacao, descricao) values (3, 'Câmera GoPro Hero 7', 1400.0, date_sub(sysdate(), interval 1 day), 'Desempenho 2x melhor');
insert into cliente (id, nome, cpf) values (1, 'João da Silva', '5678');
insert into cliente (id, nome, cpf) values (2, 'Maria da Silva', '9012');
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (1, 'MASCULINO', date_sub(sysdate(), interval 27 year));
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (2, 'FEMININO', date_sub(sysdate(), interval 30 year));
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 499.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499, 2);
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499, 1);
insert into pagamento (pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '1234', 'cartao');
insert into categoria (id, nome) values (1, 'Eletrônicos');

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo enum ('FEMININO','MASCULINO','OUTRO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclusao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(38,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao longtext,
        foto longblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on categoria (nome);

    alter table if exists categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table if exists cliente 
       add constraint unq_cpf unique (cpf);

    alter table if exists estoque 
       add constraint UKg72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table if exists produto 
       add constraint unq_nome unique (nome);

    alter table if exists categoria 
       add constraint fk_categoria_categoria_pai 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table if exists cliente_contato 
       add constraint fk_cliente_cliente_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists cliente_detalhe 
       add constraint FKm3dk45rdf6omp7m7cc37ngfqr 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists produto_atributo 
       add constraint fk_produto_produto_atributo 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_tag 
       add constraint fk_produto_produto_tag 
       foreign key (produto_id) 
       references produto (id);
insert into produto (id, nome, preco, data_criacao, descricao) values (1, 'Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle');
insert into produto (id, nome, preco, data_criacao, descricao) values (3, 'Câmera GoPro Hero 7', 1400.0, date_sub(sysdate(), interval 1 day), 'Desempenho 2x melhor');
insert into cliente (id, nome, cpf) values (1, 'João da Silva', '5678');
insert into cliente (id, nome, cpf) values (2, 'Maria da Silva', '9012');
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (1, 'MASCULINO', date_sub(sysdate(), interval 27 year));
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (2, 'FEMININO', date_sub(sysdate(), interval 30 year));
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 499.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499, 2);
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499, 1);
insert into pagamento (pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '1234', 'cartao');
insert into categoria (id, nome) values (1, 'Eletrônicos');

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo enum ('FEMININO','MASCULINO','OUTRO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclusao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(38,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao longtext,
        foto longblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on categoria (nome);

    alter table if exists categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table if exists cliente 
       add constraint unq_cpf unique (cpf);

    alter table if exists estoque 
       add constraint UKg72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table if exists produto 
       add constraint unq_nome unique (nome);

    alter table if exists categoria 
       add constraint fk_categoria_categoria_pai 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table if exists cliente_contato 
       add constraint fk_cliente_cliente_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists cliente_detalhe 
       add constraint FKm3dk45rdf6omp7m7cc37ngfqr 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists produto_atributo 
       add constraint fk_produto_produto_atributo 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_tag 
       add constraint fk_produto_produto_tag 
       foreign key (produto_id) 
       references produto (id);
insert into produto (id, nome, preco, data_criacao, descricao) values (1, 'Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle');
insert into produto (id, nome, preco, data_criacao, descricao) values (3, 'Câmera GoPro Hero 7', 1400.0, date_sub(sysdate(), interval 1 day), 'Desempenho 2x melhor');
insert into cliente (id, nome, cpf) values (1, 'João da Silva', '5678');
insert into cliente (id, nome, cpf) values (2, 'Maria da Silva', '9012');
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (1, 'MASCULINO', date_sub(sysdate(), interval 27 year));
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (2, 'FEMININO', date_sub(sysdate(), interval 30 year));
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 499.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499, 2);
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499, 1);
insert into pagamento (pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '1234', 'cartao');
insert into categoria (id, nome) values (1, 'Eletrônicos');

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo enum ('FEMININO','MASCULINO','OUTRO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclusao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(38,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao longtext,
        foto longblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on categoria (nome);

    alter table if exists categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table if exists cliente 
       add constraint unq_cpf unique (cpf);

    alter table if exists estoque 
       add constraint UKg72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table if exists produto 
       add constraint unq_nome unique (nome);

    alter table if exists categoria 
       add constraint fk_categoria_categoria_pai 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table if exists cliente_contato 
       add constraint fk_cliente_cliente_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists cliente_detalhe 
       add constraint FKm3dk45rdf6omp7m7cc37ngfqr 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists produto_atributo 
       add constraint fk_produto_produto_atributo 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_tag 
       add constraint fk_produto_produto_tag 
       foreign key (produto_id) 
       references produto (id);
insert into produto (id, nome, preco, data_criacao, descricao) values (1, 'Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle');
insert into produto (id, nome, preco, data_criacao, descricao) values (3, 'Câmera GoPro Hero 7', 1400.0, date_sub(sysdate(), interval 1 day), 'Desempenho 2x melhor');
insert into cliente (id, nome, cpf) values (1, 'João da Silva', '5678');
insert into cliente (id, nome, cpf) values (2, 'Maria da Silva', '9012');
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (1, 'MASCULINO', date_sub(sysdate(), interval 27 year));
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (2, 'FEMININO', date_sub(sysdate(), interval 30 year));
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 499.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499, 2);
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499, 1);
insert into pagamento (pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '1234', 'cartao');
insert into categoria (id, nome) values (1, 'Eletrônicos');

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo enum ('FEMININO','MASCULINO','OUTRO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclusao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(38,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao longtext,
        foto longblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on categoria (nome);

    alter table if exists categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table if exists cliente 
       add constraint unq_cpf unique (cpf);

    alter table if exists estoque 
       add constraint UKg72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table if exists produto 
       add constraint unq_nome unique (nome);

    alter table if exists categoria 
       add constraint fk_categoria_categoria_pai 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table if exists cliente_contato 
       add constraint fk_cliente_cliente_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists cliente_detalhe 
       add constraint FKm3dk45rdf6omp7m7cc37ngfqr 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists produto_atributo 
       add constraint fk_produto_produto_atributo 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_tag 
       add constraint fk_produto_produto_tag 
       foreign key (produto_id) 
       references produto (id);
insert into produto (id, nome, preco, data_criacao, descricao) values (1, 'Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle');
insert into produto (id, nome, preco, data_criacao, descricao) values (3, 'Câmera GoPro Hero 7', 1400.0, date_sub(sysdate(), interval 1 day), 'Desempenho 2x melhor');
insert into cliente (id, nome, cpf) values (1, 'João da Silva', '5678');
insert into cliente (id, nome, cpf) values (2, 'Maria da Silva', '9012');
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (1, 'MASCULINO', date_sub(sysdate(), interval 27 year));
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (2, 'FEMININO', date_sub(sysdate(), interval 30 year));
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 499.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499, 2);
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499, 1);
insert into pagamento (pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '1234', 'cartao');
insert into categoria (id, nome) values (1, 'Eletrônicos');

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo enum ('FEMININO','MASCULINO','OUTRO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclusao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(38,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao longtext,
        foto longblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on categoria (nome);

    alter table if exists categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table if exists cliente 
       add constraint unq_cpf unique (cpf);

    alter table if exists estoque 
       add constraint UKg72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table if exists produto 
       add constraint unq_nome unique (nome);

    alter table if exists categoria 
       add constraint fk_categoria_categoria_pai 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table if exists cliente_contato 
       add constraint fk_cliente_cliente_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists cliente_detalhe 
       add constraint FKm3dk45rdf6omp7m7cc37ngfqr 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists produto_atributo 
       add constraint fk_produto_produto_atributo 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_tag 
       add constraint fk_produto_produto_tag 
       foreign key (produto_id) 
       references produto (id);
insert into produto (id, nome, preco, data_criacao, descricao) values (1, 'Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle');
insert into produto (id, nome, preco, data_criacao, descricao) values (3, 'Câmera GoPro Hero 7', 1400.0, date_sub(sysdate(), interval 1 day), 'Desempenho 2x melhor');
insert into cliente (id, nome, cpf) values (1, 'João da Silva', '5678');
insert into cliente (id, nome, cpf) values (2, 'Maria da Silva', '9012');
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (1, 'MASCULINO', date_sub(sysdate(), interval 27 year));
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (2, 'FEMININO', date_sub(sysdate(), interval 30 year));
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 499.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499, 2);
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499, 1);
insert into pagamento (pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '1234', 'cartao');
insert into categoria (id, nome) values (1, 'Eletrônicos');

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo enum ('FEMININO','MASCULINO','OUTRO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclusao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(38,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao longtext,
        foto longblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on categoria (nome);

    alter table if exists categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table if exists cliente 
       add constraint unq_cpf unique (cpf);

    alter table if exists estoque 
       add constraint UKg72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table if exists produto 
       add constraint unq_nome unique (nome);

    alter table if exists categoria 
       add constraint fk_categoria_categoria_pai 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table if exists cliente_contato 
       add constraint fk_cliente_cliente_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists cliente_detalhe 
       add constraint FKm3dk45rdf6omp7m7cc37ngfqr 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists produto_atributo 
       add constraint fk_produto_produto_atributo 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_tag 
       add constraint fk_produto_produto_tag 
       foreign key (produto_id) 
       references produto (id);
insert into produto (id, nome, preco, data_criacao, descricao) values (1, 'Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle');
insert into produto (id, nome, preco, data_criacao, descricao) values (3, 'Câmera GoPro Hero 7', 1400.0, date_sub(sysdate(), interval 1 day), 'Desempenho 2x melhor');
insert into cliente (id, nome, cpf) values (1, 'João da Silva', '5678');
insert into cliente (id, nome, cpf) values (2, 'Maria da Silva', '9012');
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (1, 'MASCULINO', date_sub(sysdate(), interval 27 year));
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (2, 'FEMININO', date_sub(sysdate(), interval 30 year));
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 499.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499, 2);
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499, 1);
insert into pagamento (pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '1234', 'cartao');
insert into categoria (id, nome) values (1, 'Eletrônicos');

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo enum ('FEMININO','MASCULINO','OUTRO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclusao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(38,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao longtext,
        foto longblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on categoria (nome);

    alter table if exists categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table if exists cliente 
       add constraint unq_cpf unique (cpf);

    alter table if exists estoque 
       add constraint UKg72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table if exists produto 
       add constraint unq_nome unique (nome);

    alter table if exists categoria 
       add constraint fk_categoria_categoria_pai 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table if exists cliente_contato 
       add constraint fk_cliente_cliente_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists cliente_detalhe 
       add constraint FKm3dk45rdf6omp7m7cc37ngfqr 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists produto_atributo 
       add constraint fk_produto_produto_atributo 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_tag 
       add constraint fk_produto_produto_tag 
       foreign key (produto_id) 
       references produto (id);
insert into produto (id, nome, preco, data_criacao, descricao) values (1, 'Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle');
insert into produto (id, nome, preco, data_criacao, descricao) values (3, 'Câmera GoPro Hero 7', 1400.0, date_sub(sysdate(), interval 1 day), 'Desempenho 2x melhor');
insert into cliente (id, nome, cpf) values (1, 'João da Silva', '5678');
insert into cliente (id, nome, cpf) values (2, 'Maria da Silva', '9012');
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (1, 'MASCULINO', date_sub(sysdate(), interval 27 year));
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (2, 'FEMININO', date_sub(sysdate(), interval 30 year));
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 499.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499, 2);
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499, 1);
insert into pagamento (pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '1234', 'cartao');
insert into categoria (id, nome) values (1, 'Eletrônicos');

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo enum ('FEMININO','MASCULINO','OUTRO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclusao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(38,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao longtext,
        foto longblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on categoria (nome);

    alter table if exists categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table if exists cliente 
       add constraint unq_cpf unique (cpf);

    alter table if exists estoque 
       add constraint UKg72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table if exists produto 
       add constraint unq_nome unique (nome);

    alter table if exists categoria 
       add constraint fk_categoria_categoria_pai 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table if exists cliente_contato 
       add constraint fk_cliente_cliente_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists cliente_detalhe 
       add constraint FKm3dk45rdf6omp7m7cc37ngfqr 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists produto_atributo 
       add constraint fk_produto_produto_atributo 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_tag 
       add constraint fk_produto_produto_tag 
       foreign key (produto_id) 
       references produto (id);
insert into produto (id, nome, preco, data_criacao, descricao) values (1, 'Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle');
insert into produto (id, nome, preco, data_criacao, descricao) values (3, 'Câmera GoPro Hero 7', 1400.0, date_sub(sysdate(), interval 1 day), 'Desempenho 2x melhor');
insert into cliente (id, nome, cpf) values (1, 'João da Silva', '5678');
insert into cliente (id, nome, cpf) values (2, 'Maria da Silva', '9012');
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (1, 'MASCULINO', date_sub(sysdate(), interval 27 year));
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (2, 'FEMININO', date_sub(sysdate(), interval 30 year));
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 499.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499, 2);
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499, 1);
insert into pagamento (pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '1234', 'cartao');
insert into categoria (id, nome) values (1, 'Eletrônicos');

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo enum ('FEMININO','MASCULINO','OUTRO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclusao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(38,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao longtext,
        foto longblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on categoria (nome);

    alter table if exists categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table if exists cliente 
       add constraint unq_cpf unique (cpf);

    alter table if exists estoque 
       add constraint UKg72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table if exists produto 
       add constraint unq_nome unique (nome);

    alter table if exists categoria 
       add constraint fk_categoria_categoria_pai 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table if exists cliente_contato 
       add constraint fk_cliente_cliente_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists cliente_detalhe 
       add constraint FKm3dk45rdf6omp7m7cc37ngfqr 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists produto_atributo 
       add constraint fk_produto_produto_atributo 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_tag 
       add constraint fk_produto_produto_tag 
       foreign key (produto_id) 
       references produto (id);
insert into produto (id, nome, preco, data_criacao, descricao) values (1, 'Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle');
insert into produto (id, nome, preco, data_criacao, descricao) values (3, 'Câmera GoPro Hero 7', 1400.0, date_sub(sysdate(), interval 1 day), 'Desempenho 2x melhor');
insert into cliente (id, nome, cpf) values (1, 'João da Silva', '5678');
insert into cliente (id, nome, cpf) values (2, 'Maria da Silva', '9012');
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (1, 'MASCULINO', date_sub(sysdate(), interval 27 year));
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (2, 'FEMININO', date_sub(sysdate(), interval 30 year));
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 499.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499, 2);
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499, 1);
insert into pagamento (pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '1234', 'cartao');
insert into categoria (id, nome) values (1, 'Eletrônicos');

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo enum ('FEMININO','MASCULINO','OUTRO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclusao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(38,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao longtext,
        foto longblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on categoria (nome);

    alter table if exists categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table if exists cliente 
       add constraint unq_cpf unique (cpf);

    alter table if exists estoque 
       add constraint UKg72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table if exists produto 
       add constraint unq_nome unique (nome);

    alter table if exists categoria 
       add constraint fk_categoria_categoria_pai 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table if exists cliente_contato 
       add constraint fk_cliente_cliente_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists cliente_detalhe 
       add constraint FKm3dk45rdf6omp7m7cc37ngfqr 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists produto_atributo 
       add constraint fk_produto_produto_atributo 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_tag 
       add constraint fk_produto_produto_tag 
       foreign key (produto_id) 
       references produto (id);
insert into produto (id, nome, preco, data_criacao, descricao) values (1, 'Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle');
insert into produto (id, nome, preco, data_criacao, descricao) values (3, 'Câmera GoPro Hero 7', 1400.0, date_sub(sysdate(), interval 1 day), 'Desempenho 2x melhor');
insert into cliente (id, nome, cpf) values (1, 'João da Silva', '5678');
insert into cliente (id, nome, cpf) values (2, 'Maria da Silva', '9012');
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (1, 'MASCULINO', date_sub(sysdate(), interval 27 year));
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (2, 'FEMININO', date_sub(sysdate(), interval 30 year));
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 499.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499, 2);
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499, 1);
insert into pagamento (pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '1234', 'cartao');
insert into categoria (id, nome) values (1, 'Eletrônicos');

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo enum ('FEMININO','MASCULINO','OUTRO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclusao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(38,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao longtext,
        foto longblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on categoria (nome);

    alter table if exists categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table if exists cliente 
       add constraint unq_cpf unique (cpf);

    alter table if exists estoque 
       add constraint UKg72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table if exists produto 
       add constraint unq_nome unique (nome);

    alter table if exists categoria 
       add constraint fk_categoria_categoria_pai 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table if exists cliente_contato 
       add constraint fk_cliente_cliente_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists cliente_detalhe 
       add constraint FKm3dk45rdf6omp7m7cc37ngfqr 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists produto_atributo 
       add constraint fk_produto_produto_atributo 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_tag 
       add constraint fk_produto_produto_tag 
       foreign key (produto_id) 
       references produto (id);
insert into produto (id, nome, preco, data_criacao, descricao) values (1, 'Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle');
insert into produto (id, nome, preco, data_criacao, descricao) values (3, 'Câmera GoPro Hero 7', 1400.0, date_sub(sysdate(), interval 1 day), 'Desempenho 2x melhor');
insert into cliente (id, nome, cpf) values (1, 'João da Silva', '5678');
insert into cliente (id, nome, cpf) values (2, 'Maria da Silva', '9012');
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (1, 'MASCULINO', date_sub(sysdate(), interval 27 year));
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (2, 'FEMININO', date_sub(sysdate(), interval 30 year));
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 499.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499, 2);
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499, 1);
insert into pagamento (pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '1234', 'cartao');
insert into categoria (id, nome) values (1, 'Eletrônicos');

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo enum ('FEMININO','MASCULINO','OUTRO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclusao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(38,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao longtext,
        foto longblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on categoria (nome);

    alter table if exists categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table if exists cliente 
       add constraint unq_cpf unique (cpf);

    alter table if exists estoque 
       add constraint UKg72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table if exists produto 
       add constraint unq_nome unique (nome);

    alter table if exists categoria 
       add constraint fk_categoria_categoria_pai 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table if exists cliente_contato 
       add constraint fk_cliente_cliente_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists cliente_detalhe 
       add constraint FKm3dk45rdf6omp7m7cc37ngfqr 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists produto_atributo 
       add constraint fk_produto_produto_atributo 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_tag 
       add constraint fk_produto_produto_tag 
       foreign key (produto_id) 
       references produto (id);
insert into produto (id, nome, preco, data_criacao, descricao) values (1, 'Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle');
insert into produto (id, nome, preco, data_criacao, descricao) values (3, 'Câmera GoPro Hero 7', 1400.0, date_sub(sysdate(), interval 1 day), 'Desempenho 2x melhor');
insert into cliente (id, nome, cpf) values (1, 'João da Silva', '5678');
insert into cliente (id, nome, cpf) values (2, 'Maria da Silva', '9012');
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (1, 'MASCULINO', date_sub(sysdate(), interval 27 year));
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (2, 'FEMININO', date_sub(sysdate(), interval 30 year));
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 499.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499, 2);
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499, 1);
insert into pagamento (pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '1234', 'cartao');
insert into categoria (id, nome) values (1, 'Eletrônicos');

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo enum ('FEMININO','MASCULINO','OUTRO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclusao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(38,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao longtext,
        foto longblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on categoria (nome);

    alter table if exists categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table if exists cliente 
       add constraint unq_cpf unique (cpf);

    alter table if exists estoque 
       add constraint UKg72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table if exists produto 
       add constraint unq_nome unique (nome);

    alter table if exists categoria 
       add constraint fk_categoria_categoria_pai 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table if exists cliente_contato 
       add constraint fk_cliente_cliente_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists cliente_detalhe 
       add constraint FKm3dk45rdf6omp7m7cc37ngfqr 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists produto_atributo 
       add constraint fk_produto_produto_atributo 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_tag 
       add constraint fk_produto_produto_tag 
       foreign key (produto_id) 
       references produto (id);
insert into produto (id, nome, preco, data_criacao, descricao) values (1, 'Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle');
insert into produto (id, nome, preco, data_criacao, descricao) values (3, 'Câmera GoPro Hero 7', 1400.0, date_sub(sysdate(), interval 1 day), 'Desempenho 2x melhor');
insert into cliente (id, nome, cpf) values (1, 'João da Silva', '5678');
insert into cliente (id, nome, cpf) values (2, 'Maria da Silva', '9012');
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (1, 'MASCULINO', date_sub(sysdate(), interval 27 year));
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (2, 'FEMININO', date_sub(sysdate(), interval 30 year));
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 499.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499, 2);
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499, 1);
insert into pagamento (pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '1234', 'cartao');
insert into categoria (id, nome) values (1, 'Eletrônicos');

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo enum ('FEMININO','MASCULINO','OUTRO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclusao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(38,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao longtext,
        foto longblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on categoria (nome);

    alter table if exists categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table if exists cliente 
       add constraint unq_cpf unique (cpf);

    alter table if exists estoque 
       add constraint UKg72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table if exists produto 
       add constraint unq_nome unique (nome);

    alter table if exists categoria 
       add constraint fk_categoria_categoria_pai 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table if exists cliente_contato 
       add constraint fk_cliente_cliente_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists cliente_detalhe 
       add constraint FKm3dk45rdf6omp7m7cc37ngfqr 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists produto_atributo 
       add constraint fk_produto_produto_atributo 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_tag 
       add constraint fk_produto_produto_tag 
       foreign key (produto_id) 
       references produto (id);
insert into produto (id, nome, preco, data_criacao, descricao) values (1, 'Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle');
insert into produto (id, nome, preco, data_criacao, descricao) values (3, 'Câmera GoPro Hero 7', 1400.0, date_sub(sysdate(), interval 1 day), 'Desempenho 2x melhor');
insert into cliente (id, nome, cpf) values (1, 'João da Silva', '5678');
insert into cliente (id, nome, cpf) values (2, 'Maria da Silva', '9012');
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (1, 'MASCULINO', date_sub(sysdate(), interval 27 year));
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (2, 'FEMININO', date_sub(sysdate(), interval 30 year));
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 499.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499, 2);
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499, 1);
insert into pagamento (pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '1234', 'cartao');
insert into categoria (id, nome) values (1, 'Eletrônicos');

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo enum ('FEMININO','MASCULINO','OUTRO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclusao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(38,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao longtext,
        foto longblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on categoria (nome);

    alter table if exists categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table if exists cliente 
       add constraint unq_cpf unique (cpf);

    alter table if exists estoque 
       add constraint UKg72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table if exists produto 
       add constraint unq_nome unique (nome);

    alter table if exists categoria 
       add constraint fk_categoria_categoria_pai 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table if exists cliente_contato 
       add constraint fk_cliente_cliente_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists cliente_detalhe 
       add constraint FKm3dk45rdf6omp7m7cc37ngfqr 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists produto_atributo 
       add constraint fk_produto_produto_atributo 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_tag 
       add constraint fk_produto_produto_tag 
       foreign key (produto_id) 
       references produto (id);
insert into produto (id, nome, preco, data_criacao, descricao) values (1, 'Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle');
insert into produto (id, nome, preco, data_criacao, descricao) values (3, 'Câmera GoPro Hero 7', 1400.0, date_sub(sysdate(), interval 1 day), 'Desempenho 2x melhor');
insert into cliente (id, nome, cpf) values (1, 'João da Silva', '5678');
insert into cliente (id, nome, cpf) values (2, 'Maria da Silva', '9012');
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (1, 'MASCULINO', date_sub(sysdate(), interval 27 year));
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (2, 'FEMININO', date_sub(sysdate(), interval 30 year));
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 499.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499, 2);
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499, 1);
insert into pagamento (pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '1234', 'cartao');
insert into categoria (id, nome) values (1, 'Eletrônicos');

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo enum ('FEMININO','MASCULINO','OUTRO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclusao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(38,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao longtext,
        foto longblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on categoria (nome);

    alter table if exists categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table if exists cliente 
       add constraint unq_cpf unique (cpf);

    alter table if exists estoque 
       add constraint UKg72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table if exists produto 
       add constraint unq_nome unique (nome);

    alter table if exists categoria 
       add constraint fk_categoria_categoria_pai 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table if exists cliente_contato 
       add constraint fk_cliente_cliente_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists cliente_detalhe 
       add constraint FKm3dk45rdf6omp7m7cc37ngfqr 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists produto_atributo 
       add constraint fk_produto_produto_atributo 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_tag 
       add constraint fk_produto_produto_tag 
       foreign key (produto_id) 
       references produto (id);
insert into produto (id, nome, preco, data_criacao, descricao) values (1, 'Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle');
insert into produto (id, nome, preco, data_criacao, descricao) values (3, 'Câmera GoPro Hero 7', 1400.0, date_sub(sysdate(), interval 1 day), 'Desempenho 2x melhor');
insert into cliente (id, nome, cpf) values (1, 'João da Silva', '5678');
insert into cliente (id, nome, cpf) values (2, 'Maria da Silva', '9012');
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (1, 'MASCULINO', date_sub(sysdate(), interval 27 year));
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (2, 'FEMININO', date_sub(sysdate(), interval 30 year));
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 499.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499, 2);
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499, 1);
insert into pagamento (pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '1234', 'cartao');
insert into categoria (id, nome) values (1, 'Eletrônicos');

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo enum ('FEMININO','MASCULINO','OUTRO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclusao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(38,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao longtext,
        foto longblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on categoria (nome);

    alter table if exists categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table if exists cliente 
       add constraint unq_cpf unique (cpf);

    alter table if exists estoque 
       add constraint UKg72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table if exists produto 
       add constraint unq_nome unique (nome);

    alter table if exists categoria 
       add constraint fk_categoria_categoria_pai 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table if exists cliente_contato 
       add constraint fk_cliente_cliente_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists cliente_detalhe 
       add constraint FKm3dk45rdf6omp7m7cc37ngfqr 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists produto_atributo 
       add constraint fk_produto_produto_atributo 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_tag 
       add constraint fk_produto_produto_tag 
       foreign key (produto_id) 
       references produto (id);
insert into produto (id, nome, preco, data_criacao, descricao) values (1, 'Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle');
insert into produto (id, nome, preco, data_criacao, descricao) values (3, 'Câmera GoPro Hero 7', 1400.0, date_sub(sysdate(), interval 1 day), 'Desempenho 2x melhor');
insert into cliente (id, nome, cpf) values (1, 'João da Silva', '5678');
insert into cliente (id, nome, cpf) values (2, 'Maria da Silva', '9012');
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (1, 'MASCULINO', date_sub(sysdate(), interval 27 year));
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (2, 'FEMININO', date_sub(sysdate(), interval 30 year));
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 499.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499, 2);
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499, 1);
insert into pagamento (pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '1234', 'cartao');
insert into categoria (id, nome) values (1, 'Eletrônicos');

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo enum ('FEMININO','MASCULINO','OUTRO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclusao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(38,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao longtext,
        foto longblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on categoria (nome);

    alter table if exists categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table if exists cliente 
       add constraint unq_cpf unique (cpf);

    alter table if exists estoque 
       add constraint UKg72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table if exists produto 
       add constraint unq_nome unique (nome);

    alter table if exists categoria 
       add constraint fk_categoria_categoria_pai 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table if exists cliente_contato 
       add constraint fk_cliente_cliente_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists cliente_detalhe 
       add constraint FKm3dk45rdf6omp7m7cc37ngfqr 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table if exists pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table if exists produto_atributo 
       add constraint fk_produto_produto_atributo 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table if exists produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table if exists produto_tag 
       add constraint fk_produto_produto_tag 
       foreign key (produto_id) 
       references produto (id);
insert into produto (id, nome, preco, data_criacao, descricao) values (1, 'Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle');
insert into produto (id, nome, preco, data_criacao, descricao) values (3, 'Câmera GoPro Hero 7', 1400.0, date_sub(sysdate(), interval 1 day), 'Desempenho 2x melhor');
insert into cliente (id, nome, cpf) values (1, 'João da Silva', '5678');
insert into cliente (id, nome, cpf) values (2, 'Maria da Silva', '9012');
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (1, 'MASCULINO', date_sub(sysdate(), interval 27 year));
insert into cliente_detalhe (cliente_id, sexo, data_nascimento) values (2, 'FEMININO', date_sub(sysdate(), interval 30 year));
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 499.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499, 2);
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499, 1);
insert into pagamento (pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '1234', 'cartao');
insert into categoria (id, nome) values (1, 'Eletrônicos');
