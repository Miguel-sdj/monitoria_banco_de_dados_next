create database marinha;

create table barcos(
	idBarcos integer primary key,
	nomeBarco varchar(45),
	cor varchar(45)
);

create table marinheiro(
	idMarinheiro integer primary key,
	nomeMarinheiro varchar(45),
	avaliacao varchar(45),
	idade int
);

create table reservas(
	id_marinheiro integer, 
	id_barco integer,
    data_reserva date,
	constraint fk_marinheiro foreign key(id_marinheiro) references barcos(idBarcos),
	constraint fk_barco foreign key(id_barco) references barcos(idBarcos),
	primary key (id_marinheiro, id_barco)
);


/* parte 2 */
ALTER TABLE marinheiro
ADD telefone varchar(20);

ALTER TABLE barcos
ADD quantidade_passageiros int;


/* parte 3 */
INSERT INTO barcos (idBarcos, nomeBarco, cor, quantidade_passageiros)
VALUES
    (101, 'Interlake', 'azul', 5),
    (102, 'Interlake', 'vermelho', 10),
    (103, 'Clipper', 'verde', 13),
    (104, 'Marine', 'vermelho', 4);
    
INSERT INTO marinheiro (idMarinheiro, nomeMarinheiro, avaliacao, idade, telefone)
VALUES
    (22, 'Dustin', 'ótimo', 45, '994489221'),
    (29, 'Brutus', 'ótimo', 33, '992209093'),
    (31, 'Lubber', 'bom', 55, '981222290'),
    (32, 'Andy', 'bom', 25, '988667373'),
    (58, 'Rusty', 'ótimo', 35, '991090202'),
    (64, 'Horatio', 'ótimo', 35, '981001023'),
    (71, 'Zorba', 'ótimo', 16, '999215490'),
    (74, 'Horatio', 'bom', 35, '991092234'),
    (85, 'Art', 'ótimo', 25, '988664737'),
    (95, 'Bob', 'ótimo', 63, '982334432');
    
INSERT INTO reservas (id_marinheiro, id_barco, data_reserva)
VALUES
    (22, 101, '1998-10-09'),
    (22, 102, '1998-10-10'),
    (22, 103, '1998-08-10'),
    (22, 104, '1998-07-10'),
    (31, 102, '1998-10-11'),
    (31, 103, '1998-11-06'),
    (31, 104, '1998-11-12'),
    (64, 101, '1998-05-09'),
    (64, 102, '1998-05-09'),
    (74, 103, '1998-06-09');
    
-- vamos alterar nome do id 71 para fred 
UPDATE marinheiro
SET nomeMarinheiro = 'Fred'
WHERE idMarinheiro = 71;

-- altere a avaliação do marinheiro com nome Bob para médio
update marinheiro
set avaliacao = 'Médio'
where nomeMarinheiro = 'Bob';

-- altere a cor do barco de nome Marine para amarelo
update barcos
set cor = 'amarelo'
where nomeBarco = 'Marine';

