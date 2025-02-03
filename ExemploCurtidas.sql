create table Maquina (
    Id-Maquina int primary key not null,
    Tipo varchar(255),
    Velocidade int,
    HardDisk int,
    Placa_Rede int
    Memoria_Ram int
    Fk_usuario int,
    Fk_Software int,
    foreign key(Fk_usuario) references Usuario(ID_Usuario),
    foreign key(Fk_Software) references Software(id)
);

create table Usuarios (
    ID_Usuario int primary key not null,
    Password varchar(255),
    Nome_Usuario varchar(255),
    Ramal int,
    Especialidade varchar(255),
    FK_Maquinas int,
    foreign key(FK_Maquinas) references Maquina(Id-Maquina)
);

create table Software (
    Id_Software int primary key not null,
    Produto varchar(255),
    HardDisk int,
    Memoria_Ram int,
    Fk_Maquina int,
    foreign key(Fk_Maquina) references Maquina(Id-Maquina)
);

-- Inserir os dados nas tabelas
insert into Maquina values(1, 'Desktop', 2.4, 500, 1, 4, 1, 1);
insert into Maquina values(2, 'Notebook', 2.0, 500, 1, 4, 2, 2);
insert into Maquina values(3, 'Servidor', 3.0, 1000, 1, 8, 3, 3);

insert into Usuarios values(1, '123', 'João', 1234, 'Analista de Sistemas', 1);
insert into Usuarios values(2, '456', 'Maria', 5678, 'Analista de Banco de Dados', 2);
insert into Usuarios values(3, '789', 'José', 9101, 'Analista de Redes', 3);

insert into Software values(1, 'Windows', 500, 4, 1);
insert into Software values(2, 'Linux', 500, 4, 2);
insert into Software values(3, 'Unix', 1000, 8, 3);


-- 16
select avg(HardDisk) from Software; 

-- 17
select Tipo, count(Id-Maquina) from Maquina group by Tipo;


-- 20
SELECT Maquina.[Id-Maquina], Maquina.[HardDisk] 
FROM Maquina 
WHERE [HardDisk] > ALL 
    (SELECT [HardDisk] 
     FROM Software); -- O All é usado para comparar com todos os valores de uma subconsulta
