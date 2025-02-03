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
