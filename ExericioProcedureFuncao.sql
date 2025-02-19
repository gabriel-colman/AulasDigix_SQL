CREATE TABLE Usuarios (
    ID_Usuario INT PRIMARY KEY NOT NULL,
    Password VARCHAR(255),
    Nome_Usuario VARCHAR(255),
    Ramal INT,
    Especialidade VARCHAR(255)
);

CREATE TABLE Maquina (
    Id_Maquina INT PRIMARY KEY NOT NULL,
    Tipo VARCHAR(255),
    Velocidade INT,
    HardDisk INT,
    Placa_Rede INT,
    Memoria_Ram INT,
    Fk_Usuario INT,
    FOREIGN KEY(Fk_Usuario) REFERENCES Usuarios(ID_Usuario)
);


CREATE TABLE Software (
    Id_Software INT PRIMARY KEY NOT NULL,
    Produto VARCHAR(255),
    HardDisk INT,
    Memoria_Ram INT,
    Fk_Maquina INT,
    FOREIGN KEY(Fk_Maquina) REFERENCES Maquina(Id_Maquina)
);


-- Inserindo primeiro os usuários
INSERT INTO Usuarios VALUES (1, '123', 'Joao', 123, 'TI');
INSERT INTO Usuarios VALUES (2, '456', 'Maria', 456, 'RH');
INSERT INTO Usuarios VALUES (3, '789', 'Jose', 789, 'Financeiro');
INSERT INTO Usuarios VALUES (4, '101', 'Ana', 101, 'TI');

-- Agora sim, inserindo as máquinas, pois os usuários já existem
INSERT INTO Maquina VALUES (1, 'Desktop', 2, 500, 1, 4, 1);
INSERT INTO Maquina VALUES (2, 'Notebook', 1, 250, 1, 2, 2);
INSERT INTO Maquina VALUES (3, 'Desktop', 3, 1000, 1, 8, 3);
INSERT INTO Maquina VALUES (4, 'Notebook', 2, 500, 1, 4, 4);


insert into Software values (1, 'Windows', 100, 2, 1);
insert into Software values (2, 'Linux', 50, 1, 2);
insert into Software values (3, 'Windows', 200, 4, 3);
insert into Software values (4, 'Linux', 100, 2, 4);


-- 1. Resposta
create or REPLACE function Espaco_Disponivel(Id_Maquina1 integer, Id_Software1 integer) returns integer as $$
declare 
    Disco_livre integer,
    Espaco_Necessario integer;
begin
    select HardDisk into Disco_livre from Maquina where Id_Maquina = Id_Maquina1;

    select HardDisk into Espaco_Necessario from Software where Id_Software = Id_Software1;

    if Disco_livre >= Espaco_Necessario then
        return true;
    else
        return false;
    end if;
end;

$$ language plpgsql;

-- 5. Resposta
create or REPLACE Procedure Transferir_Software(Id_Software1 integer, Id_Maquina_Origem1 integer, Id_Maquina_Destino1 integer) as $$
declare 
    Possivel boolean;
begin
    -- veficicar se a maquina de destino tem espaço suficiente
    select Espaco_Disponivel(Id_Maquina_Destino1, Id_Software1) into Possivel;

    if Possivel then
        update Software set Fk_Maquina = Id_Maquina_Destino1 where Id_Software = Id_Software1 and Fk_Maquina = Id_Maquina_Origem1;

        if not found then
            raise notice 'Software não encontrado na maquina de origem';
        end if;
    else
        raise notice 'Maquina de destino não tem espaço suficiente';
    end if;
end;
$$ language plpgsql;

-- 7 Resposta
create or Replace Procedure Diagnostico_Maquina(Id_Maquina1 integer) as $$
declare 
    Total_Ram_Requerida integer;
    Total_HardDisk_Requerido integer;
    Ram_Ataul integer;
    HardDisk_Ataul integer;
    Ram_Upgrade integer;
    HardDisk_Upgrade integer;
begin
    -- Obetr a soma dos requisitos minimos dos sofwares instalados na maquina
    select 
        coalesce(sum(Memoria_Ram), 0) 
        coalesce(sum(HardDisk), 0) 
    into
        Total_Ram_Requerida,
        Total_HardDisk_Requerido
    from
        Software
    where
        Fk_Maquina = Id_Maquina1;
    
    -- Obter a quantidade de ram e harddisk atuais
    select 
        Memoria_Ram,
        HardDisk 
    into
        Ram_Ataul,
        HardDisk_Ataul
    from
        Maquina
    where
        Id_Maquina = Id_Maquina1;

    --  Se a maquina não for encontrada, lançar um erro
    if not found then
        raise notice 'Maquina não encontrada';
    end if;

    -- Verficar se a maquina tem recursos suficientes
    if Ram_Ataul >= Total_HardDisk_Requerido and HardDisk_Ataul >= Total_HardDisk_Requerido then
        raise notice 'Maquina % tem recursos suficientes e não precisa de upgrade', Id_Maquina1;
    else
        -- Calcula a nescessidade do upgrade
        Ram_Upgrade := Greatest(0, Total_Ram_Requerida - Ram_Ataul); -- ele ta retornando o maior valor
        HardDisk_Upgrade := Greatest(0, Total_HardDisk_Requerido - HardDisk_Ataul);  -- esse 0 é para não retornar valores negativos

        raise notice 'Maquna % precisa de upgrade', Id_Maquina1;

        -- Sugere upgrade de Ram, se nescessario
        if Ram_Upgrade > 0 then
            raise notice 'Sugere upgrade de % GB de Ram', Ram_Upgrade;
        end if;

        -- Sugere upgrade de HardDisk, se nescessario
        if HardDisk_Upgrade > 0 then
            raise notice 'Sugere upgrade de % GB de HardDisk', HardDisk_Upgrade;
        end if;
    end if;
end;
$$ language plpgsql;