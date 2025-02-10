-- Tabela de Instrutor
CREATE TABLE instrutor (
    idinstrutor SERIAL PRIMARY KEY,
    RG BIGINT NOT NULL UNIQUE,  -- Alterado para BIGINT
    nome VARCHAR(45) NOT NULL,
    nascimento DATE NOT NULL,
    titulacao INT NOT NULL
);

-- Tabela de Telefone do Instrutor
CREATE TABLE telefone_instrutor (
    idtelefone SERIAL PRIMARY KEY,
    numero BIGINT NOT NULL,  -- Alterado para BIGINT
    tipo VARCHAR(45),
    instrutor_idinstrutor INT NOT NULL,
    FOREIGN KEY (instrutor_idinstrutor) REFERENCES instrutor(idinstrutor)
);

-- Tabela de Atividade
CREATE TABLE atividade (
    idatividade SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

-- Tabela de Turma
CREATE TABLE turma (
    idturma SERIAL PRIMARY KEY,
    horario TIME NOT NULL,
    duracao INT NOT NULL,
    dataInicio DATE NOT NULL,
    dataFim DATE NOT NULL,
    atividade_idatividade INT NOT NULL,
    instrutor_idinstrutor INT NOT NULL,
    FOREIGN KEY (atividade_idatividade) REFERENCES atividade(idatividade),
    FOREIGN KEY (instrutor_idinstrutor) REFERENCES instrutor(idinstrutor)
);

-- Tabela de Aluno
CREATE TABLE aluno (
    codMatricula SERIAL PRIMARY KEY,
    dataMatricula DATE NOT NULL,
    nome VARCHAR(45) NOT NULL,
    endereco TEXT NOT NULL,
    telefone BIGINT NOT NULL,  -- Alterado para BIGINT
    dataNascimento DATE NOT NULL,
    altura FLOAT,
    peso INT
);

-- Tabela de Chamada
CREATE TABLE chamada (
    idchamada SERIAL PRIMARY KEY,
    data DATE NOT NULL,
    presente BOOL NOT NULL,
    aluno_codMatricula INT NOT NULL,
    turma_idturma INT NOT NULL,
    FOREIGN KEY (aluno_codMatricula) REFERENCES aluno(codMatricula),
    FOREIGN KEY (turma_idturma) REFERENCES turma(idturma)
);




INSERT INTO instrutor (RG, nome, nascimento, titulacao) VALUES
(123456789, 'Carlos Silva', '1980-05-10', 1),
(987654321, 'Mariana Souza', '1985-08-15', 2),
(111222333, 'João Pereira', '1990-03-20', 3),
(444555666, 'Ana Beatriz', '1982-12-05', 1),
(777888999, 'Felipe Martins', '1995-07-30', 2);


INSERT INTO telefone_instrutor (numero, tipo, instrutor_idinstrutor) VALUES
(11987654321, 'Celular', 1),
(11923456789, 'Residencial', 2),
(11911112222, 'Celular', 3),
(11933334444, 'Comercial', 4),
(11955556666, 'Celular', 5);


INSERT INTO atividade (nome) VALUES
('Musculação'),
('Pilates'),
('Crossfit'),
('Yoga'),
('Dança');


INSERT INTO turma (horario, duracao, dataInicio, dataFim, atividade_idatividade, instrutor_idinstrutor) VALUES
('08:00:00', 60, '2024-01-10', '2024-06-10', 1, 1),
('10:00:00', 45, '2024-02-15', '2024-07-15', 2, 2),
('14:00:00', 90, '2024-03-20', '2024-08-20', 3, 3),
('16:00:00', 60, '2024-04-05', '2024-09-05', 4, 4),
('18:00:00', 75, '2024-05-10', '2024-10-10', 5, 5);


INSERT INTO aluno (dataMatricula, nome, endereco, telefone, dataNascimento, altura, peso) VALUES
('2024-01-15', 'Gabriel Rocha', 'Rua A, 123', 11998765432, '2000-06-20', 1.75, 70),
('2024-02-18', 'Fernanda Lima', 'Rua B, 456', 11987654321, '1998-09-10', 1.65, 60),
('2024-03-25', 'Lucas Almeida', 'Rua C, 789', 11976543210, '1995-12-05', 1.80, 85),
('2024-04-08', 'Juliana Costa', 'Rua D, 321', 11965432109, '1999-03-15', 1.70, 55),
('2024-05-12', 'Ricardo Mendes', 'Rua E, 654', 11954321098, '2001-01-25', 1.78, 75);

INSERT INTO aluno (dataMatricula, nome, endereco, telefone, dataNascimento, altura, peso) VALUES
('2024-01-15', 'Gabriel fas', 'Rua A, 123', 11998765433, '2000-06-24', 1.85, 80),

INSERT INTO chamada (data, presente, aluno_codMatricula, turma_idturma) VALUES
('2024-06-01', TRUE, 1, 1),
('2024-06-02', FALSE, 2, 2),
('2024-06-03', TRUE, 3, 3),
('2024-06-04', TRUE, 4, 4),
('2024-06-05', FALSE, 5, 5);

INSERT INTO chamada (data, presente, aluno_codMatricula, turma_idturma) VALUES
('2025-02-01', TRUE, 1, 1);


-- 8. Listar os alunos que estão matriculados em mais de uma turma 
--  or raplace é quando cria uma nova viel ou subtitui a existente 
-- create or replace view aluno_turma as 
create view aluno_turma as 
select a.nome as aluno, count(distinct t.idturma) as qtd_turmas
from aluno a
join chamada c on a.codMatricula = c.aluno_codMatricula
join turma t on c.turma_idturma = t.idturma
group by a.codMatricula, a.nome
Having count(distinct t.idturma) > 1;

-- Chamar as View
select * from aluno_turma;
select aluno from aluno_turma; -- to chamando somente a coluna da view

-- Excluir view
drop view aluno_turma;

-- Editar
create or replace view aluno_turma as 
select a.nome as aluno, count(distinct t.idturma) as qtd_turmas
from aluno a
join chamada c on a.codMatricula = c.aluno_codMatricula
join turma t on c.turma_idturma = t.idturma
group by a.codMatricula, a.nome
Having count(distinct t.idturma) > 2;


-- View Materiazada é de fato a criação de uma tabela de acordo com a consulta
    create MATERIALIZED view mv_total_presencas as
    select nome, round(avg(extract (year from age (current_date, dataNascimento))), 2) as idade
    from aluno group by nome;

refresh MATERIALIZED view mv_total_presencas;

-- Simular view materializada no MySql
create table mv_total_presencas1 (
    aluno VARCHAR(200),
    idade numeric
);

-- Vou inserir os dados de acordo com uma consulta
insert into mv_total_presencas1
select nome, round(avg(extract (year from age (current_date, dataNascimento))), 2) as idade
    from aluno group by nome;
    