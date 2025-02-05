-- 1. Criar a tabela EMPREGADO primeiro
create table Empregado (
    Nome varchar(50),
    Endereco varchar(500),
    CPF int primary key not null,
    DataNasc date,
    Sexo char(10),
    CartTrab int,
    Salario float,
    NumDep int,
    CPFSup int,
    foreign key (CPFSup) references Empregado(CPF) -- Auto-relacionamento (supervisor)
);

-- 2. Criar a tabela DEPARTAMENTO
create table Departamento (
    NomeDep varchar(50),
    NumDep int primary key not null,
    CPFGer int,
    DataInicioGer date,
    foreign key (CPFGer) references Empregado(CPF) -- FK para o gerente do departamento
);

-- 3. Adicionar a FK em EMPREGADO para referenciar o Departamento
alter table Empregado 
    add constraint fk_numdep foreign key (NumDep) references Departamento(NumDep);

-- 4. Criar a tabela PROJETO (já pode ser criada porque Departamento já existe)
create table Projeto (
    NomeProj varchar(50),
    NumProj int primary key not null,
    Localizacao varchar(50),
    NumDep int,
    foreign key (NumDep) references Departamento(NumDep) -- FK para o departamento responsável pelo projeto
);

-- 5. Criar a tabela TRABALHA_EM (precisa de EMPREGADO e PROJETO)
create table Trabalha_Em (
    CPF int,
    NumProj int,
    HorasSemana int,
    foreign key (CPF) references Empregado(CPF),
    foreign key (NumProj) references Projeto(NumProj)
);

-- 6. Criar a tabela DEPENDENTE (precisa de EMPREGADO)
create table Dependente (
    idDependente int primary key not null,
    CPFE int,
    NomeDep varchar(50),
    Sexo char(10),
    Parentesco varchar(50),
    foreign key (CPFE) references Empregado(CPF) -- FK para o empregado responsável pelo dependente
);

-- Inseriri os dados
insert into Departamento values ('Dep1', 1, null, '1990-01-01'); 
insert into Departamento values ('Dep2', 2, null, '1990-01-01');
insert into Departamento values ('Dep3', 3, null, '1990-01-01');

insert into Empregado values ('Joao', 'Rua 1', 123, '1990-01-01', 'M', 123, 1000, 1, null);
insert into Empregado values ('Maria', 'Rua 2', 456, '1990-01-01', 'F', 456, 2000, 2, null);
insert into Empregado values ('Jose', 'Rua 3', 789, '1990-01-01', 'M', 789, 3000, 3, null);

-- Fazer o update para atualizar o CPFGer dos departamentos
update Departamento set CPFGer = 123 where NumDep = 1;
update Departamento set CPFGer = 456 where NumDep = 2;
update Departamento set CPFGer = 789 where NumDep = 3;

insert into Projeto values ('Proj1', 1, 'Local1', 1);
insert into Projeto values ('Proj2', 2, 'Local2', 2);
insert into Projeto values ('Proj3', 3, 'Local3', 3);

insert into Dependente values (1, 123, 'Dep1', 'M', 'Filho');
insert into Dependente values (2, 456, 'Dep2', 'F', 'Filha');
insert into Dependente values (3, 789, 'Dep3', 'M', 'Filho');

insert into Trabalha_Em values (123, 1, 40);
insert into Trabalha_Em values (456, 2, 40);
insert into Trabalha_Em values (789, 3, 40);

-- Consulta de tudo 
select * from Trabalha_Em, Departamento, Dependente, Projeto, Empregado;

-- Substrings, com posições especificas de caracteres
select NomeProj from Projeto where NomeProj Like 'P____';

-- Diferença de Aspas Simples e Duplas 
-- As simples pegam Strings 
-- As duplas são para identificar o nome da tabela, coluna, etc..
select e.Nome from Empregado e where e.Nome like 'J%';
select "nome" from Empregado where "nome" like 'J%';


-- Operadores na propia coluna
-- Já vou calcular o almento de 10% nos salarios dos funciionarios
select e.Nome, e.Salario * 1.1 from Empregado e; 
-- Colocar nome referencia na operacao usando o As
select e.Nome, e.Salario * 1.1 as SalarioAtualizado from Empregado e; 

-- O uso do Distinct é para evitar duplicações 
-- Se ouver 2 linhas iguais ela retorna uma
select Distinct e.Nome, e.CPF from Empregado e, Trabalha_Em t
where e.CPF = t.CPF;

-- Utilizar UNION que é união de 2 consultas
-- 2.  Listar os números de projetos nos quais esteja envolvido o empregado ‘João da Silva’ 
-- como empregado ou como gerente responsável pelo departamento que 
-- controla o projeto.
(select Distinct p.NumProj From
Projeto p, Departamento d, Empregado e 
where p.NumDep = d.NumDep and d.CPFGer = e.CPF and e.Nome = 'Joao') --que ele ta como Gerente
UNION 
(select p.NumProj from
Projeto p, Empregado e, Trabalha_Em t
where p.NumProj = t.NumProj and t.CPF = e.CPF and e.Nome = 'Joao'); -- Procura como apenas um empregado

-- Uso do Intersect 
-- Listando os nomes dos empregados que também são gerentes de departamento
select e.Nome from Empregado e
Intersect
select e.Nome from Empregado e, Departamento d where d.CPFGer = e.CPF;

--  Utilizar o is Null, para imprimir registros que tem nulo em certa coluna
select e.Nome from Empregado e where e.CPFSup is null; -- que é nulo
select e.Nome from Empregado e where e.CPFSup is not null; -- que não é nulo

-- Funções que já estão nativas 
-- Média dos salarios dos empregados
select AVG(salario) from Empregado; 
-- O maximo dos salarios dos empregados, ou que é o salario maximo que esta nos emprgados
select MAX(salario) from Empregado; 
select MIN(salario) from Empregado; 
-- A soma total dos salarios dos empregados
select SUM(salario) from Empregado; 

--  Selecionar o CPF de todos os empregados que trabalham no mesmo 
-- projeto e com a mesma quantidade de horas que o empregado cujo 
--  CPF é 123.

select Distinct CPF
from Trabalha_Em
where (NumProj, HorasSemana) in -- o in para verifcar se o resultado esta na subconsulta
(select NumProj, HorasSemana from Trabalha_Em where cpf = 123);

--  Selecionar o nome de todos os empregados que têm salário maior do que
--  todos os salários dos empregados do departamento 2
select nome from Empregado
where salario > all (select salario from Empregado where NumDep = 2);