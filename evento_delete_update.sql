
-- a) Atualize o número de telefone do cliente de nome 'Vitor', para 998080809;

UPDATE Cliente
SET telefone = '998080809'
WHERE nome = 'Vitor';

-- b) Atualize a descrição do local de nome 'Downtown' para 'Downtown pub Recife';

UPDATE local_evento
SET descricao = 'Downtown pub Recife'
WHERE nome_local = 'Downtown';

-- c) Delete todos os clientes cujo 'complemento' do endereço esteja vazio;

DELETE FROM Cliente
WHERE complemento IS NULL OR complemento = '';

-- d) Delete todas as reservas que aconteceram entre os dias 01/11/2018 e 29/12/2018;
delete from reserva
where data between '2018-11-01' and '2018-12-29';

/* e) Atualize a descrição dos eventos que ainda não tem reserva para 'Ainda
precisa ser reservado';*/

update evento
set descricao = 'Ainda precisa ser reservado'
where cod_evento not in (select Evento_cod_Evento from reserva);

-- f) delete todos os locais que não possuem reserva
delete from evento where cod_evento not in (select reserva.Evento_cod_Evento from reserva);
delete from local_evento where cod_local not in (select distinct evento.Local_cod_Local1 from evento);



