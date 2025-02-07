-- Criação da tabela de Diretores
CREATE TABLE diretor (
    idDiretor serial PRIMARY KEY,
    nome VARCHAR(45) NOT NULL
);

-- Criação da tabela de Gêneros
CREATE TABLE genero (
    idgenero serial PRIMARY KEY,
    nome VARCHAR(45) NOT NULL
);

-- Criação da tabela de Filmes
CREATE TABLE filme (
    idfilme serial PRIMARY KEY,
    nomeBR VARCHAR(45) NOT NULL,
    nomeEN VARCHAR(45) NOT NULL,
    anoLancamento INT NOT NULL,
    diretor_idDiretor INT,
    genero_idgenero INT,
    sinopse TEXT,
    FOREIGN KEY (diretor_idDiretor) REFERENCES diretor(idDiretor),
    FOREIGN KEY (genero_idgenero) REFERENCES genero(idgenero)
);

-- Criação da tabela de Salas
CREATE TABLE sala (
    idSala serial PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    capacidade INT NOT NULL
);

-- Criação da tabela de Horários
CREATE TABLE horario (
    idhorario serial PRIMARY KEY,
    horario TIME NOT NULL
);

-- Criação da tabela Filme Exibido na Sala
CREATE TABLE filme_exibido_sala (
    filme_idfilme INT,
    sala_idSala INT,
    horario_idhorario INT,
    PRIMARY KEY (filme_idfilme, sala_idSala, horario_idhorario),
    FOREIGN KEY (filme_idfilme) REFERENCES filme(idfilme),
    FOREIGN KEY (sala_idSala) REFERENCES sala(idSala),
    FOREIGN KEY (horario_idhorario) REFERENCES horario(idhorario)
);

-- Criação da tabela de Premiações
CREATE TABLE premiacao (
    idpremiacao serial PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    ano INT NOT NULL
);

-- Criação da tabela de Filmes que receberam Premiação
CREATE TABLE filme_has_premiacao (
    filme_idfilme INT,
    premiacao_idpremiacao INT,
    ganhou BOOL NOT NULL,
    PRIMARY KEY (filme_idfilme, premiacao_idpremiacao),
    FOREIGN KEY (filme_idfilme) REFERENCES filme(idfilme),
    FOREIGN KEY (premiacao_idpremiacao) REFERENCES premiacao(idpremiacao)
);

-- Criação da tabela de Funções dos funcionários
CREATE TABLE funcao (
    idfuncao serial PRIMARY KEY,
    nome VARCHAR(45) NOT NULL
);

-- Criação da tabela de Funcionários
CREATE TABLE funcionario (
    idfuncionario serial PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    carteiraTrabalho INT NOT NULL UNIQUE,
    dataContratacao DATE NOT NULL,
    salario FLOAT NOT NULL
);

-- Criação da tabela de Horário de Trabalho do Funcionário
CREATE TABLE horario_trabalho_funcionario (
    horario_idhorario INT,
    funcionario_idfuncionario INT,
    funcao_idfuncao INT,
    PRIMARY KEY (horario_idhorario, funcionario_idfuncionario, funcao_idfuncao),
    FOREIGN KEY (horario_idhorario) REFERENCES horario(idhorario),
    FOREIGN KEY (funcionario_idfuncionario) REFERENCES funcionario(idfuncionario),
    FOREIGN KEY (funcao_idfuncao) REFERENCES funcao(idfuncao)
);

-- Inserir dados nas tabelas
INSERT INTO diretor (nome) VALUES 
('Christopher Nolan'),
('Steven Spielberg'),
('Quentin Tarantino'),
('Martin Scorsese'),
('James Cameron');

INSERT INTO genero (nome) VALUES 
('Ação'),
('Aventura'),
('Comédia'),
('Drama'),
('Ficção Científica');

INSERT INTO filme (nomeBR, nomeEN, anoLancamento, diretor_idDiretor, genero_idgenero, sinopse) VALUES 
('Batman: O Cavaleiro das Trevas', 'The Dark Knight', 2008, 1, 1, 'Batman, Gordon e Harvey Dent estão juntos para deter a organização criminosa de Gotham City, mas se deparam com um criminoso conhecido como Coringa.');
INSERT INTO filme (nomeBR, nomeEN, anoLancamento, diretor_idDiretor, genero_idgenero, sinopse) VALUES 
('O Resgate do Soldado Ryan', 'Saving Private Ryan', 1998, 2, 1, 'Durante a Segunda Guerra Mundial, o Capitão John Miller recebe a missão de resgatar o soldado James Ryan, cujos três irmãos já morreram em combate.');
INSERT INTO filme (nomeBR, nomeEN, anoLancamento, diretor_idDiretor, genero_idgenero, sinopse) VALUES 
('Pulp Fiction: Tempo de Violência', 'Pulp Fiction', 1994, 3, 3, 'Vincent Vega e Jules Winnfield são dois assassinos que saem para recuperar uma mala roubada para seu empregador, o gângster Marsellus Wallace.');
INSERT INTO filme (nomeBR, nomeEN, anoLancamento, diretor_idDiretor, genero_idgenero, sinopse) VALUES 
('O Lobo de Wall Street', 'The Wolf of Wall Street', 2013, 4, 3, 'Jordan Belfort é um corretor de ações de Nova York que serve à prisão por envolvimento em uma grande fraude de títulos do governo.');
INSERT INTO filme (nomeBR, nomeEN, anoLancamento, diretor_idDiretor, genero_idgenero, sinopse) VALUES 
('Avatar', 'Avatar', 2009, 5, 2, 'Em 2154, o paraplégico Marine Jake Sully é enviado a Pandora em uma missão única, mas se apaixona por Neytiri, uma nativa do planeta.');

INSERT INTO sala (nome, capacidade) VALUES 
('Sala 1', 100),
('Sala 2', 150),
('Sala 3', 200),
('Sala 4', 250),
('Sala 5', 300);

INSERT INTO horario (horario) VALUES 
('14:00:00'),
('16:00:00'),
('18:00:00'),
('20:00:00'),
('22:00:00');

INSERT INTO filme_exibido_sala (filme_idfilme, sala_idSala, horario_idhorario) VALUES 
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5);

INSERT INTO premiacao (nome, ano) VALUES 
('Oscar', 2009),
('Globo de Ouro', 2010),
('BAFTA', 2014),
('Festival de Cannes', 2014),
('Framboesa de Ouro', 2014);

INSERT INTO filme_has_premiacao (filme_idfilme, premiacao_idpremiacao, ganhou) VALUES 
(1, 1, TRUE),
(2, 2, TRUE),
(3, 3, TRUE),
(4, 4, TRUE),
(5, 5, FALSE);

INSERT INTO funcao (nome) VALUES 
('Atendente'),
('Bilheteiro'),
('Gerente'),
('Limpeza'),
('Segurança');

INSERT INTO funcionario (nome, carteiraTrabalho, dataContratacao, salario) VALUES 
('João', 123456, '2021-01-01', 1500.00),
('Maria', 654321, '2021-01-01', 1500.00),
('José', 456123, '2021-01-01', 1500.00),
('Ana', 321654, '2021-01-01', 1500.00),
('Carlos', 654123, '2021-01-01', 1500.00);

INSERT INTO horario_trabalho_funcionario (horario_idhorario, funcionario_idfuncionario, funcao_idfuncao) VALUES 
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5);

INSERT INTO horario_trabalho_funcionario (horario_idhorario, funcionario_idfuncionario, funcao_idfuncao) VALUES 
(3, 2, 1);

-- 1. Retornar a média dos salários dos funcionários
-- Mostre o salário médio dos funcionários cadastrados.

create view salario_medio as 
select avg(salario) as media_salario from funcionario;
-- Cramar a visao salario_medio
select * from salario_medio;

-- 2. Listar os funcionários e suas funções, incluindo aqueles sem função definida
-- Utilize LEFT JOIN para incluir funcionários que não possuem uma função associada.
select f.nome as funcionario, coalesce(func.nome, 'Sem Função') as funcao 
from funcionario f
LEFT join funcao func on f.idfuncionario = func.idfuncao;
-- Coalesce é usado para substituir valores nulos, ou seja aquele funcionario não tem função também é listado

-- 3. Retornar o nome de todos os funcionários que possuem 
-- o mesmo horário de trabalho que algum outro funcionário
select distinct f1.nome As funcionario, f2.nome As funcionario_2, h.horario
from horario_trabalho_funcionario ht1
join horario_trabalho_funcionario ht2 on ht1.horario_idhorario = ht2.horario_idhorario
and ht1.funcionario_idfuncionario <> ht2.funcionario_idfuncionario
join funcionario f1 on  ht1.funcionario_idfuncionario = f1.idfuncionario
join funcionario f2 on ht2.funcionario_idfuncionario = f2.idfuncionario
join horario h on ht1.horario_idhorario = h.idhorario;

-- 10. Listar os filmes que foram exibidos na mesma sala em horários diferentes
select f.nomeBR, s.nome as sala
from filme_exibido_sala fs1
join filme_exibido_sala fs2 on fs1.sala_idSala = fs2.sala_idSala
and fs1.filme_idfilme = fs2.filme_idfilme
and fs1.horario_idhorario <> fs2.horario_idhorario
join filme f on fs1.filme_idfilme = f.idfilme
join sala s on fs1.sala_idSala = s.idSala;

-- 12. Exibir todas as funções diferentes que os funcionários exercem 
-- e a quantidade de funcionários em cada uma.
select funcao.nome as funcao, Count(f.idfuncionario) as total_funcionario
from funcionario f
join funcao on f.idfuncionario = funcao.idfuncao
GROUP BY funcao.nome;
 -- Group by é usado para agrupar linhas com base em uma ou mais colunas

 -- 13. Encontrar os filmes que foram exibidos em salas com 
--   capacidade superior à média de todas as salas
select f.nomeBR, s.nome as sala, s.capacidade
from filme_exibido_sala fs
join sala s on fs.sala_idSala = s.idSala
join filme f on fs.filme_idfilme = f.idfilme
where s.capacidade > (select avg (capacidade) from sala);

-- 15. Exibir a relação entre a capacidade da sala e o número 
-- total de filmes exibidos nela
select s.nome as sala, s.capacidade, count (fs.filme_idfilme) as total__filmes,
(count(fs.filme_idfilme) / nullif(s.capacidade, 0)) as filems_por_assento
from sala s
LEFT join filme_exibido_sala fs on s.idSala = fs.sala_idSala
Group by s.idSala, s.capacidade;

SELECT S.nome, S.CAPACIDADE, COUNT(FES.filme_idfilme) AS QTD_FILMES,
(COUNT(FES.filme_idfilme) / NULLIF(S.CAPACIDADE, 0)) AS RATIO
FROM filme_exibido_sala FES
RIGHT JOIN SALA S ON FES.sala_idSala = S.idSala
GROUP BY S.nome, S.CAPACIDADE, S.idSala
ORDER BY RATIO ASC;


-- Altenrativa de DateDiff para Postgres é JUSTIFY_INTERVAL
-- Exemplo de uso
SELECT justify_interval('2021-01-01'::date - '2021-01-01'::date) as diferenca;