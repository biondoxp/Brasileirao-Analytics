CREATE OR REPLACE VIEW jogos_por_time AS
WITH partidas_tratadas AS (
    SELECT
        rodata AS rodada,
        strptime(data, '%d/%m/%Y')::DATE AS data,
        YEAR(strptime(data, '%d/%m/%Y')::DATE) AS temporada,
        mandante,
        visitante,
        mandante_Placar AS mandante_placar,
        visitante_Placar AS visitante_placar
    FROM partidas
)
SELECT
    temporada, rodada, data, mandante AS time, visitante AS adversario,
    mandante_placar AS gols_pro, visitante_placar AS gols_contra,
    CASE WHEN mandante_placar > visitante_placar THEN 3
         WHEN mandante_placar = visitante_placar THEN 1 ELSE 0 END AS pontos,
    'casa' AS mando
FROM partidas_tratadas
UNION ALL
SELECT
    temporada, rodada, data, visitante AS time, mandante AS adversario,
    visitante_placar AS gols_pro, mandante_placar AS gols_contra,
    CASE WHEN visitante_placar > mandante_placar THEN 3
         WHEN visitante_placar = mandante_placar THEN 1 ELSE 0 END AS pontos,
    'fora' AS mando
FROM partidas_tratadas;
