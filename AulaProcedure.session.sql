CREATE TABLE time ( 
	id INTEGER PRIMARY KEY, 
	nome VARCHAR(50) 
	);

CREATE TABLE partida ( 
	id INTEGER PRIMARY KEY, 
	time_1 INTEGER, 
	time_2 INTEGER, 
	time_1_gols INTEGER, 
	time_2_gols INTEGER, 
	FOREIGN KEY(time_1) REFERENCES time(id), 
	FOREIGN KEY(time_2) REFERENCES time(id) 
	);

INSERT INTO time(id, nome) VALUES 
(1,'CORINTHIANS'), 
(2,'SÃO PAULO'), 
(3,'CRUZEIRO'), 
(4,'ATLETICO MINEIRO'),
(5,'PALMEIRAS');

INSERT INTO partida(id, time_1, time_2, time_1_gols, time_2_gols) 
VALUES 
(1,4,1,0,4), 
(2,3,2,0,1), 
(3,1,3,3,0), 
(4,3,4,0,1), 
(5,1,2,0,0), 
(6,2,4,2,2), 
(7,1,5,1,2),
(8,5,2,1,2);

-- Procedure é um conjunto de instruções SQL que podem ser executadas em conjunto.

-- Criando procedure no postgresql
CREATE OR REPLACE PROCEDURE inserir_partida(
    id INTEGER,
    time_1 INTEGER, 
    time_2 INTEGER, 
    time_1_gols INTEGER, 
    time_2_gols INTEGER
) 
AS $$
BEGIN
    INSERT INTO partida(id, time_1, time_2, time_1_gols, time_2_gols) 
    VALUES (id, time_1, time_2, time_1_gols, time_2_gols);
END;
$$ LANGUAGE plpgsql;
;
-- No mysql
create procedure inserir_partida(
    id int,
    time_1 int, 
    time_2 int, 
    time_1_gols int, 
    time_2_gols int
)
begin
    insert into partida(id, time_1, time_2, time_1_gols, time_2_gols) 
    values (id, time_1, time_2, time_1_gols, time_2_gols);
end;


-- Executando procedure
call inserir_partida(1, 1, 2, 2, 1);

-- faça a procedure update nome do time
-- Codigo Update PostgreSQL
CREATE PROCEDURE update_time(
    id_local INTEGER,
    v_nome VARCHAR(50)
)
AS $$
BEGIN
    UPDATE time SET nome = v_nome WHERE id = id_local;
    if not found then
        raise exception 'Time não encontrado';
    end if;
END;
$$ LANGUAGE plpgsql

-- As procedures são ser alteradas as suas assinaturas como os parametros e o retorno, mas corpo pode
drop procedure update_time; 

call update_time(1, 'Operario');

-- Faça uma procedure de excuir partida com execeção caso não encontre a partid