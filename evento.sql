CREATE DATABASE evento;

CREATE TABLE Cliente (
  cod_cliente INT ,
  nome VARCHAR(45) ,
  telefone VARCHAR(45) ,
  rua VARCHAR(45) ,
  bairro VARCHAR(45) ,
  numero VARCHAR(45) ,
  complemento VARCHAR(45) ,
  CEP VARCHAR(45) ,
  PRIMARY KEY (cod_cliente));


CREATE TABLE local_evento (
  cod_local INT ,
  nome_local VARCHAR(45) ,
  descricao VARCHAR(45) ,
  PRIMARY KEY (cod_local));



CREATE TABLE Evento(
  cod_evento INT,
  descricao VARCHAR(45) ,
  data DATE,
  horario VARCHAR(45) ,
  valor FLOAT,
  Local_cod_Local1 INT,
  Cliente_cod_cliente INT ,
  PRIMARY KEY (cod_evento),
  CONSTRAINT fk_Evento_Local
    FOREIGN KEY (Local_cod_local1)
    REFERENCES local_evento (cod_local)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Evento_Cliente1
    FOREIGN KEY (Cliente_cod_cliente)
    REFERENCES Cliente (cod_cliente)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE  Reserva (
  cod_reserva INT,
  data DATE ,
  horario VARCHAR(45),
  Cliente_cod_cliente INT ,
  Evento_cod_Evento INT ,
  PRIMARY KEY (cod_reserva),
  CONSTRAINT fk_Reserva_Cliente1
    FOREIGN KEY (Cliente_cod_cliente)
    REFERENCES Cliente (cod_cliente)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Reserva_Evento
    FOREIGN KEY (Evento_cod_Evento)
    REFERENCES Evento (cod_evento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- insert

INSERT INTO cliente 
VALUES
(1, 'Pedro', '88281911', 'Rua 1', 'bairro 1', '232', 'casa', '233-23321'),
(2, 'Maria', '83829192', 'Rua 2', 'bairro 2', '232', 'casa', '233-23321'),
(3, 'João', '77488282', 'Rua da Luz', 'centro', '5944', 'sobrado', '233-23321'),
(4, 'José', '32090933', 'Rua Santo Antônio', 'Santo amaro', '1222', 'apto 302', '234-23321'),
(5, 'Severina', '99201011', 'Rua Dom Pedro', 'Nazaré', '2332', 'apto 90', '984-00911'),
(6, 'Antônio', '89282823', 'Rua José Alencar', 'cidade alta', '2002', NULL, '884-23321'),
(7, 'Paulo', '898998223', 'Rua São Paulo', 'jardim irene', '0032', 'casa', '903-39922'),
(8, 'Ana', '88292922', 'Rua Rio de Janeiro', 'iputinga', '232', NULL, '233-23321'),
(9, 'Luzia', '79292993', 'Rua Amazonas', 'cidade universitária', '232', 'casa', '230-34421'),
(10, 'Vitor', '32262727', 'Rua Pará', 'casa amarela', '232', 'apto 605', '402-22910');

INSERT INTO local_evento  
VALUES
(1, 'Parque de Exposições', 'descrição'),
(2, 'Parque Dona Lindu', 'parque a céu aberto'),
(3, 'Centro de Eventos', 'Local com área aberta e fechada'),
(4, 'Downtown', 'Bar fechado'),
(5, 'Pier', 'Pier no Marco zero');

INSERT INTO evento 
VALUES
(1, 'evento de rock direcionado a público jovem', '2018-08-03', '22hr', 2993.33, 1, 5),
(2, 'dia da saúde- exercicios', '2018-03-23', '09hr', 29.33, 5, 2),
(3, 'banda cover ac/dc', '2018-02-10', '23hr', 35.00, 4, 4),
(4, 'show da Shakira', '2018-09-12', '23:30hr', 70.00, 3, 3),
(5, 'Exposição de animais', '2019-01-03', '08hr', 10.00, 2, 1),
(6, 'Evento de musica', '2019-08-09', '18hr', 150.00, 4, 1);

INSERT INTO Reserva 
VALUES
(1, '2018-09-02', '17hrs', 2, 5),
(2, '2018-10-22', '17hrs', 2, 5),
(3, '2018-09-06', '17hrs', 2, 5),
(4, '2018-03-12', '17hrs', 2, 5),
(5, '2018-12-12', '17hrs', 2, 5),
(6, '2018-05-10', '17hrs', 2, 5),
(7, '2018-09-01', '17hrs', 2, 5),
(8, '2018-02-04', '17hrs', 2, 5),
(9, '2018-12-12', '17hrs', 2, 5),
(10, '2018-11-27', '17hrs', 2, 5),
(11, '2018-07-07', '17hrs', 2, 5),
(12, '2018-09-01', '10hrs', 4, 1),
(13, '2018-02-04', '23hrs', 1, 4),
(14, '2018-12-12', '22hrs', 1, 4),
(15, '2018-11-27', '23hrs', 3, 3),
(16, '2018-07-07', '11hrs', 4, 2);


-- atividades

-- a) Recupere a descrição, horário e valor de todos os eventos agendados para o dia 28/07/2018.
SELECT descricao, horario, valor
FROM Evento
WHERE data = '2018-08-03';

-- b) Recupere os dados de todos os locais que não possuem reserva.
SELECT *
FROM local_evento
WHERE cod_local NOT IN (SELECT DISTINCT Evento.Local_cod_Local1 FROM Evento);

-- c) Recupere os nomes dos clientes que realizaram ou reservaram eventos com um valor maior do que R$2.000,00 no local de nome "Parque de Exposições".

SELECT DISTINCT Cliente.nome
FROM Cliente
JOIN Evento ON Cliente.cod_cliente = Evento.Cliente_cod_cliente
WHERE Evento.valor > 2000 AND Evento.Local_cod_Local1 = 1
UNION
SELECT DISTINCT Cliente.nome
FROM Cliente
JOIN Reserva ON Cliente.cod_cliente = Reserva.Cliente_cod_cliente
JOIN Evento ON Reserva.Evento_cod_Evento = Evento.cod_evento
WHERE Evento.valor > 2000 AND Evento.Local_cod_Local1 = 1;

-- d) Recupere o nome e o telefone dos clientes que têm reservas para o dia 02/09/2018 para o local chamado "Pier".

SELECT Cliente.nome, Cliente.telefone
FROM Cliente
JOIN Reserva ON Cliente.cod_cliente = Reserva.Cliente_cod_cliente
JOIN local_evento ON Reserva.Evento_cod_Evento = local_evento.cod_local
WHERE Reserva.data = '2018-09-02' AND local_evento.nome_local = 'Pier';

-- e) Liste a quantidade de clientes que realizaram reservas no local "Centro de Eventos".
SELECT COUNT(DISTINCT reserva.Cliente_cod_cliente) AS quantidade_clientes
FROM reserva
JOIN Evento ON Reserva.Evento_cod_Evento = Evento.cod_evento
JOIN local_evento ON Evento.Local_cod_Local1 = local_evento.cod_local
WHERE local_evento.nome_local = 'Centro de Eventos';

-- f) Para cada cliente que realizou mais de 1 reserva no local "Downtown", liste o nome e o bairro.
SELECT Cliente.nome, Cliente.bairro
FROM Cliente
JOIN Reserva ON Cliente.cod_cliente = Reserva.Cliente_cod_cliente
JOIN Evento ON Reserva.Evento_cod_Evento = Evento.cod_evento
JOIN local_evento ON Evento.Local_cod_Local1 = local_evento.cod_local
WHERE local_evento.nome_local = 'Downtown'
GROUP BY Cliente.cod_cliente
HAVING COUNT(*) > 1;

-- g)  Liste a quantidade de eventos realizados por local.
SELECT local_evento.nome_local, COUNT(Evento.cod_evento) AS quantidade_eventos
FROM local_evento
LEFT JOIN Evento ON local_evento.cod_local = Evento.Local_cod_Local1
GROUP BY local_evento.cod_local, local_evento.nome_local;

-- h)  Para cada evento que teve menos que 2 reservas, recupere a descrição do evento e o valor.
SELECT Evento.descricao, Evento.valor
FROM Evento
LEFT JOIN Reserva ON Evento.cod_evento = Reserva.Evento_cod_Evento
GROUP BY Evento.cod_evento, Evento.descricao, Evento.valor
HAVING COUNT(Reserva.cod_reserva) < 2;

-- i)  Recupere o nome dos clientes, cujo somatório do valor pago por eventos ultrapassa R$200,00.
SELECT Cliente.nome
FROM Cliente
JOIN Reserva ON Cliente.cod_cliente = Reserva.Cliente_cod_cliente
JOIN Evento ON Reserva.Evento_cod_Evento = Evento.cod_evento
GROUP BY Cliente.cod_cliente, Cliente.nome
HAVING SUM(Evento.valor) > 200.00;

-- j) Retorne os clientes que fizeram reserva no dia 24/04/2018 do local "Salão Maracatu" OU os clientes que fizeram um evento no dia 24/04/2018 no local "Salão Ciranda".
SELECT DISTINCT Cliente.nome
FROM Cliente
LEFT JOIN Reserva ON Cliente.cod_cliente = Reserva.Cliente_cod_cliente
LEFT JOIN Evento ON Cliente.cod_cliente = Evento.Cliente_cod_cliente
LEFT JOIN local_evento ON Evento.Local_cod_Local1 = local_evento.cod_local
WHERE (Reserva.data = '2018-04-24' AND local_evento.nome_local = 'Salão Maracatu')
OR (Evento.data = '2018-04-24' AND local_evento.nome_local = 'Salão Ciranda');

-- k) Para cada evento que teve mais de 3 reservas, apresente o nome do evento e o valor arrecadado com os ingressos.
SELECT Evento.descricao, SUM(Evento.valor) AS valor_arrecadado
FROM Evento
JOIN Reserva ON Evento.cod_evento = Reserva.Evento_cod_Evento
GROUP BY Evento.cod_evento, Evento.descricao
HAVING COUNT(Reserva.cod_reserva) > 3;

-- l) Recupere o nome dos eventos cujo valor de ingresso é maior do que o valor da média dos eventos
SELECT Evento.descricao
FROM Evento
WHERE Evento.valor > (SELECT AVG(valor) FROM Evento);

-- m) Liste o nome dos locais que não receberam eventos no ano de 2018.
SELECT nome_local
FROM local_evento
WHERE cod_local NOT IN (SELECT DISTINCT Local_cod_Local1 FROM Evento WHERE YEAR(data) = 2018);

-- n) Recupere o nome dos locais que já sediaram pelo menos 2 eventos.
SELECT local_evento.nome_local
FROM local_evento
JOIN Evento ON local_evento.cod_local = Evento.Local_cod_Local1
GROUP BY local_evento.cod_local, local_evento.nome_local
HAVING COUNT(Evento.cod_evento) >= 2;

-- o) Retorne os eventos cuja quantidade de reservas foi maior que a média de reservas por evento.
SELECT Evento.descricao
FROM Evento
JOIN Reserva ON Evento.cod_evento = Reserva.Evento_cod_Evento
GROUP BY Evento.cod_evento, Evento.descricao
HAVING COUNT(Reserva.cod_reserva) > (SELECT AVG(reservas_por_evento) FROM (SELECT Evento.cod_evento, COUNT(Reserva.cod_reserva) AS reservas_por_evento FROM Evento JOIN Reserva ON Evento.cod_evento = Reserva.Evento_cod_Evento GROUP BY Evento.cod_evento) AS temp);

-- p) Liste o nome e telefone dos clientes que não efetuaram nenhuma reserva.
SELECT nome, telefone
FROM Cliente
WHERE cod_cliente NOT IN (SELECT DISTINCT Cliente_cod_cliente FROM Reserva);











