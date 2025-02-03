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



select * from cargo;
select * from usuario;

-- Imprimir somente o nome da tabela Cargo
select cargo.nome from cargo;
select cargo.id from cargo;

-- Abreviação da tabela
select c.nome from cargo c;
select u.nome, c.nome from cargo c, usuario u;

-- Aplicação de Condições
select c.nome from cargo c where id = 1; -- vai imprimir o nome do cargo com id 1
select u.id from usuario u where u.nome = 'Joao'; -- imprimir quando o id quando o nome é igual Joao

select u.nome from usuario u where u.id = 1 or u.id = 2; -- Operador ou que imprimir id 1 ou 2
select u.nome from usuario u where u.id = 1 and u.id = 2;
-- Selecionar uma lista id
select u.nome from usuario u where id in (1,2,3); -- in quer dizer dentro
select u.nome from usuario u where id not in (1,2,3); -- quer dizer que não para imprimir os valores desses ids

-- Utilizar o operado Between para ser usados o que esta entre os intervalos
select u.id from usuario u where nome between 'Joao' and 'Jose'; -- estou imprimindo os valores entre 1 e 3

-- Utilizar o operador Like que para perquisar partes de uma string(texto)
select u.id, u.nome from usuario u where nome like 'Jo%'; -- % qualquer coisa de caracter
select id, nome from usuario where nome like '%ao'; -- tudo que pode ser imprimido que termine com 'ao'

-- Operadores de Comparacao
select u.id, u.nome from usuario u where id > 1;
select u.id, u.nome from usuario u where id >= 1;

select u.id, u.nome from usuario u where id > 1 and id < 3;  -- operadore lógicos que imprimri entre as marcações

-- Operadores Ordenacao
select u.id, u.nome from usuario u order by id desc; -- order by ele ordena, e o desc ele estabece de forma descrente
select u.id, u.nome from usuario u order by id asc; -- asc de forma crescente
select u.id, u.nome from usuario u order by nome desc; -- é ordenado por indice de carateres

-- Limitar os resultados
select * from usuario limit 1;

-- Agrupamento
select c.nome, u.nome, count(c.id) from usuario u, cargo c
where u.id = c.fk_usuario group by c.nome, u.id ; -- group by = agrupado 
-- Operador count é para contar a quantidade de ocorrencia naquela coluna