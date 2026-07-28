SELECT
time, 
SUM(pontos) AS pontos, 
COUNT(*) AS jogos,
SUM(gols_contra) AS gols_contra,
SUM(gols_pro) AS gols_pro,
SUM(gols_pro) - SUM(gols_contra) AS saldo_de_gols
FROM jogos_por_time
WHERE temporada = 2017
GROUP BY time 
ORDER BY pontos DESC,
saldo_de_gols DESC;