-- Implementar tabelas de Concessionaria e carro
create table Concessionaria (
    -- Isso seria para MySQL
    -- id int primary key auto_increment, -- auto_increment é uma propriedade que faz com que o campo seja incrementado automaticamente
    -- Isso seria para PostgreSQL
    id serial primary key,
    nome varchar(255),
    cidade varchar(255),
    estado varchar(255)
);

create table Carro (
    -- id int primary key auto_increment,
    -- Para PostgreSQL
    id serial primary key,
    modelo varchar(255),
    ano int,
    cor varchar(255),
    concessionaria_id int,
    foreign key (concessionaria_id) references Concessionaria(id)
    -- codigoBarrra varchar(200) Default uuid_gereate(), -- exemplo que vai ser gerado: 123e4567-e89b-12d3-a456-426614174000
    -- codigoBarrra  Default uuid_gereate(),
);