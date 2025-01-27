create table usuario(
    id int,
    nome varchar(50),
    email varchar(50),
    primary key(id)
);

-- Cargo
create table cargo(
    id int primary key not null,
    nome varchar(50),
    fk_usuario int,
    primary key(id),
    constraint fk_cargo_usuario foreign key(fk_usuario) references usuario(id)
);

insert into usuario values(1, 'João', 'joao@email.com');
insert into usuario values(2, 'Maria', 'maria@email.com');
insert into usuario values(3, 'José', 'jose@email.com');

insert into cargo values(1, 'Analista de Sistemas', 1, 5000.00);
insert into cargo values(2, 'Analista de Banco de Dados', 1, 6000.00);
insert into cargo values(3, 'Analista de Redes', 2, 7000.00);
-- Consulta total
select * from usuario;
select * from cargo;

-- Left Join que retorna todos os usuários e seus cargos, ou seja
--  os registros da tabela da esquerda (usuario) e os registros da tabela da direita (cargo)
select * from usuario left join cargo on usuario.id = cargo.fk_usuario; -- Começa a pesquisa pela esquerda

-- Right Join que retorna todos os cargos e seus usuários, ou seja,
--  os registros da tabela da direita (cargo) e os registros da tabela da esquerda (usuario)
select * from usuario right join cargo on usuario.id = cargo.fk_usuario; -- Começa a pesquisa pela direita

-- Inner Join que retorna todos os registros quando houver uma correspondência entre as tabelas
select * from usuario inner join cargo on usuario.id = cargo.fk_usuario; -- Começa a pesquisa pela esquerda