SELECT
time,
mando,
COUNT(*) AS jogos,
ROUND(AVG (gols_pro), 2) AS media_de_gols_feitos,
ROUND(AVG (gols_contra), 2) AS media_de_gols_sofridos
FROM jogos_por_time
WHERE temporada = 2017
GROUP BY time, mando
ORDER BY time, mando;