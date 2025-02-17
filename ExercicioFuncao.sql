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
    foreign key (NumDep) references Empregado(NumDep)
);

create table Departamento (
    NomeDep varchar(50),
    NumDep int primary key not null,
    CPFGer int,
    DataInicioGer date,
    foreign key (CPFGer) references Empregado(CPF)
);

create table Projeto (
    NomeProj varchar(50),
    NumProj int primary key not null,
    Localizacao varchar(50),
    NumDep int,
    foreign key (NumDep) references Departamento(NumDep)
);

create table Dependente (
    idDependente int primary key not null,
    CPFE int,
    NomeDep varchar(50),
    Sexo char(10),
    Parentesco varchar(50),
    foreign key (CPF) references Empregado(CPF)
);

create table Trabalha_Em (
    CPF int,
    NumProj int,
    HorasSemana int,
    foreign key (CPF) references Empregado(CPF),
    foreign key (NumProj) references Projeto(NumProj)
);

-- Inserir os dados

-- 1. Criar os departamentos primeiro (para garantir que NumDep existe antes de inserir empregados)
insert into Departamento values ('Dep1', 1, null, '1990-01-01'); 
insert into Departamento values ('Dep2', 2, null, '1990-01-01');
insert into Departamento values ('Dep3', 3, null, '1990-01-01');

insert into Empregado values ('Joao', 'Rua 1', 123, '1990-01-01', 'M', 123, 1000, 1, null);
insert into Empregado values ('Maria', 'Rua 2', 456, '1990-01-01', 'F', 456, 2000, 2, null);
insert into Empregado values ('Jose', 'Rua 3', 789, '1990-01-01', 'M', 789, 3000, 3, null);

-- 3. Atualizar o CPFGer dos departamentos agora que os empregados já existem
update Departamento set CPFGer = 123 where NumDep = 1;
update Departamento set CPFGer = 456 where NumDep = 2;
update Departamento set CPFGer = 789 where NumDep = 3;

-- 4. Inserir projetos (pois NumDep já foi inserido corretamente)
insert into Projeto values ('Proj1', 1, 'Local1', 1);
insert into Projeto values ('Proj2', 2, 'Local2', 2);
insert into Projeto values ('Proj3', 3, 'Local3', 3);

-- 5. Inserir dependentes (corrigido erro nos IDs)
insert into Dependente values (1, 123, 'Dep1', 'M', 'Filho');
insert into Dependente values (2, 456, 'Dep2', 'F', 'Filha');
insert into Dependente values (3, 789, 'Dep3', 'M', 'Filho');

-- 6. Inserir relação Trabalha_Em (pois Empregado e Projeto já existem)
insert into Trabalha_Em values (123, 1, 40);
insert into Trabalha_Em values (456, 2, 40);
insert into Trabalha_Em values (789, 3, 40);

alter table Dependente add foreign key (CPFE) references Empregado(CPF);
alter table Trabalha_Em add foreign key (CPF) references Empregado(CPF);

-- Resposta 8
create or replace function SalarioEmpregado(p_CPF integer) returns float as $$
declare 
    salario float;
begin
    begin
        select Salario into salario from Empregado where CPF = p_CPF;

        -- If salario is null then
        --     raise exception 'CPF não encontrado';
        -- end if;
    EXCEPTION
     when others then
        raise notice 'Erro ao buscar salario';
    
    end;
    return salario;
end;
$$ language plpgsql;