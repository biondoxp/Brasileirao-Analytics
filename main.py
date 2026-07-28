import duckdb
import matplotlib.pyplot as plt
import os

os.makedirs("output", exist_ok=True)
con = duckdb.connect("brasileirao.duckdb")


con.sql(open("sql/silver_jogos_por_time.sql").read())


def rodar_query(caminho):
    return con.sql(open(caminho).read()).df()


df_ranking = rodar_query("sql/ranking.sql")

fig, ax = plt.subplots(figsize=(8, 10))
ax.barh(df_ranking["time"], df_ranking["pontos"], color="#1f77b4")
ax.invert_yaxis()
ax.set_title("Classificação — Pontos por time")
ax.set_xlabel("Pontos")
fig.tight_layout()
fig.savefig("output/ranking.png")
plt.close(fig)


df_media_gols = rodar_query("sql/media_gols.sql")


pivot_pro = df_media_gols.pivot(
    index="time", columns="mando", values="media_de_gols_feitos")

fig, ax = plt.subplots(figsize=(10, 12))
pivot_pro.plot(kind="barh", ax=ax, color=["#ff7f0e", "#9467bd"])
ax.set_title("Média de gols marcados — Casa vs Fora")
ax.set_xlabel("Média de gols por partida")
ax.legend(title="Mando de campo")
fig.tight_layout()
fig.savefig("output/media_gols.png")
plt.close(fig)


con.close()
print("Gráficos gerados na pasta output/:")
print("- ranking.png")
print("- media_gols.png")
