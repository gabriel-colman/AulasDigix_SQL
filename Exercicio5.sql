create table Pessoa (
    cpf varchar(14) PRIMARY KEY,
    nome varchar(100) NOT NULL
);

create table Engenheiro (
    cpf varchar(14) PRIMARY KEY,
    crea varchar(10) NOT NULL,
    FOREIGN KEY (cpf) REFERENCES Pessoa(cpf) on delete CASCADE 
    -- on delete CASCADE: Se a pessoa for deletada, o engenheiro também será deletado
);

create table Edificacao (
    idEdificacao serial PRIMARY key,
    metragemTotal FLOAT not null,
    endereco varchar(255) not null,
    responsavelCpf varchar(14) not null,
    foreign key (responsavelCpf) references Engenheiro(cpf) on delete CASCADE
);

CREATE table UnidadeResidencial (
    idUnidade serial primary key,
    metragemUnidade float not null,
    numQuartos int not null,
    numBanheiros int not null,
    proprietarioCpf varchar(14) not null,
    idEdificacao int not null,
    foreign key (proprietarioCpf) references Pessoa(cpf) on delete CASCADE,
    foreign key (idEdificacao) references Edificacao(idEdificacao) on delete CASCADE
);


create table Predio (
    idEdificacao serial primary key,
    nome varchar(255) not null,
    numAndares int not null,
    aptPorAndar int not null,
    foreign key (idEdificacao) references Edificacao(idEdificacao) on delete CASCADE
);

create table Casa (
    idEdificacao serial primary key,
    condominio boolean not null,
    foreign key (idEdificacao) references Edificacao(idEdificacao) on delete CASCADE
);

create table CasaSobrado (
    idEdificacao serial primary key,
    numAndares int not null,
    foreign key (idEdificacao) references Casa(idEdificacao) on delete CASCADE
);

-- Inserindo dados
insert into Pessoa (cpf, nome) values ('12345678901', 'Carlos Silva');
insert into Pessoa (cpf, nome) values ('12345678902', 'João da Silva');
insert into Pessoa (cpf, nome) values ('12345678903', 'Maria da Silva');

insert into Engenheiro (cpf, crea) values ('12345678901', '123456');

Insert into Edificacao (metragemTotal, endereco, responsavelCpf) 
values (100.0, 'Rua 1', '12345678901');
Insert into Edificacao (metragemTotal, endereco, responsavelCpf)
values (200.0, 'Rua 2', '12345678901');
Insert into Edificacao (metragemTotal, endereco, responsavelCpf)
values (300.0, 'Rua 3', '12345678901');

Insert into Predio (nome, numAndares, aptPorAndar, idEdificacao)
values ('Predio 1', 10, 4, 1);

Insert into Casa (condominio, idEdificacao)
values (true, 2);

Insert into CasaSobrado (numAndares, idEdificacao)
values (2, 2);

Insert into UnidadeResidencial (metragemUnidade, numQuartos, numBanheiros, proprietarioCpf, idEdificacao)
values (100.0, 2, 1, '12345678902', 1);
Insert into UnidadeResidencial (metragemUnidade, numQuartos, numBanheiros, proprietarioCpf, idEdificacao)
values (200.0, 3, 2, '12345678903', 2);
Insert into UnidadeResidencial (metragemUnidade, numQuartos, numBanheiros, proprietarioCpf, idEdificacao)
values (300.0, 4, 3, '12345678902', 1);


-- 1. Listar todas as unidades residenciais com 
-- seus proprietários e endereços
select * from UnidadeResidencial u
join Pessoa p on u.proprietarioCpf = p.cpf
join Edificacao e on u.idEdificacao = e.idEdificacao;

-- 2. Listar todas as unidades residenciais com seus proprietários 
-- e endereços, ordenando por metragem da unidade
select * from UnidadeResidencial u
join Pessoa p on u.proprietarioCpf = p.cpf
join Edificacao e on u.idEdificacao = e.idEdificacao
order by u.metragemUnidade;