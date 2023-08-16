-- 1. Encontre os nomes e as idades de todos os marinheiros
select nomeMarinheiro, idade from marinheiro;

-- 2. Encontre todos os marinheiros com uma avaliação igual à bom
select * from marinheiro where avaliacao = 'bom';

-- 3. Encontre os nomes de marinheiros que reservaram o barco 103
select m.nomeMarinheiro from marinheiro m
join reservas r on m.idMarinheiro = r.id_marinheiro
where r.id_barco = 103;

select nomeMarinheiro from marinheiro
where idMarinheiro in (select id_marinheiro from reservas where id_barco = 103);

-- 4 Encontre os idMarinheiro dos marinheiros que reservaram um barco vermelho
select m.idMarinheiro from marinheiro m
join reservas r on m.idMarinheiro = r.id_marinheiro
join barcos b on r.id_barco = b.idBarcos
where b.cor = 'vermelho';

-- 5 Encontre os nomes dos marinheiros que reservaram um barco vermelho
select m.nomeMarinheiro from marinheiro m
join reservas r on m.idMarinheiro = r.id_marinheiro
join barcos b on r.id_barco = b.idBarcos
where b.cor = 'vermelho';

-- 6 Encontre as cores dos barcos reservados por Lubber
select b.cor from barcos b

join reservas r on b.idBarcos = r.id_barco
join marinheiro m on r.id_marinheiro = m.idMarinheiro
where m.nomeMarinheiro = 'Lubber';

-- 7. Encontre os nomes dos marinheiros que reservaram pelo menos um barco
select distinct m.nomeMarinheiro from marinheiro m
join reservas r on m.idMarinheiro = r.id_marinheiro;

-- 8. Encontre as idades e o nome dos marinheiros cujos nomes começam ou terminam com B e têm no mínimo três caracteres.
select idade, nomeMarinheiro from marinheiro
where(nomeMarinheiro like 'B_B') and length(nomeMarinheiro >= 3);

-- 9. Encontre a idade média de todos os marinheiros
select AVG(idade) from marinheiro;

-- 10. Encontre a idade média dos marinheiros com idade maior que 27
select AVG(idade) from marinheiro where (idade > 27);

-- 11. Encontre o quantidade total de marinheiros
select count(*) as 'Quantidade de marinheiros' from marinheiro;

-- 12. Encontre o número de nomes diferentes de marinheiros
select distinct nomeMarinheiro from marinheiro;

-- 13. Encontre a idade do marinheiro mais jovem para cada nível de avaliação
select avaliacao, MIN(idade) as 'Idade mais jovem' from marinheiro
group by avaliacao;

/* 14. Encontre a idade do marinheiro mais jovem que tenha no mínimo 18 anos 
para cada nível de avaliação com no mínimo dois marinheiros desse tipo*/
select avaliacao, min(idade) as 'Idade mais jovem' from marinheiro
where idade >= 18
group by avaliacao
having count(*) >= 2;

-- 15. Para cada barco vermelho, encontre o número de reservas desse barco
SELECT b.nomeBarco, COUNT(r.id_barco) AS num_reservas
FROM barcos b
LEFT JOIN reservas r ON b.idBarcos = r.id_barco
WHERE b.cor = 'vermelho'
GROUP BY b.nomeBarco;

-- 16. Encontre a idade média dos marinheiros de cada nível de avaliação que tenha no mínimo dois marinheiros:
SELECT avaliacao, AVG(idade) AS idade_media
FROM marinheiro
GROUP BY avaliacao
HAVING COUNT(*) >= 2;

-- 17 Encontre o id dos marinheiros que tenham idade maior que a média:
SELECT idMarinheiro FROM marinheiro
WHERE idade > (SELECT AVG(idade) FROM marinheiro);

-- 18. Encontre o nome dos marinheiros que realizaram mais de 3 reservas de barcos, cujas cores estejam entre ('vermelho', 'verde', 'azul'):
SELECT m.nomeMarinheiro
FROM marinheiro m
JOIN reservas r ON m.idMarinheiro = r.id_marinheiro
JOIN barcos b ON r.id_barco = b.idBarcos
WHERE b.cor IN ('vermelho', 'verde', 'azul')
GROUP BY m.idMarinheiro, m.nomeMarinheiro
HAVING COUNT(*) > 3;

-- 19. De acordo com as cores dos barcos, selecione a média das idades dos marinheiros que os reservaram:
SELECT b.cor, AVG(m.idade) AS idade_media
FROM barcos b
JOIN reservas r ON b.idBarcos = r.id_barco
JOIN marinheiro m ON r.id_marinheiro = m.idMarinheiro
GROUP BY b.cor; 