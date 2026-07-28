import duckdb

con = duckdb.connect("brasileirao.duckdb")

con.sql("""
    CREATE OR REPLACE TABLE partidas AS
    SELECT * FROM read_csv_auto('data/campeonato-brasileiro-full.csv',
    types = {'data': 'VARCHAR'}
    )
""")

print(con.sql("SELECT * FROM partidas LIMIT 5"))
con.close()
