# ⚽ Brasileirão Analytics

Pipeline de dados que extrai, trata e analisa resultados históricos do Campeonato Brasileiro (2003–2025), gerando automaticamente gráficos de classificação e desempenho por time.

Projeto pessoal criado para aplicar conceitos de engenharia de dados (modelagem em camadas, SQL analítico, automação) em um domínio diferente do meu dia a dia profissional.

## 📊 O que o projeto responde

- **Ranking** — classificação por pontos, com saldo de gols como critério de desempate
- **Média de gols (casa vs. fora)** — compara o desempenho ofensivo/defensivo de cada time jogando em casa ou como visitante

> Em desenvolvimento: aproveitamento (%) e evolução de pontos por rodada.

## 🛠️ Stack

- **Python** — orquestração e geração dos gráficos
- **DuckDB** — banco analítico local, consultado via SQL
- **Pandas** — manipulação dos resultados das queries
- **Matplotlib** — visualização

## 📁 Estrutura do projeto

```
brasileirao-analytics/
├── data/                          # CSV de origem (não versionado)
├── sql/
│   ├── silver_jogos_por_time.sql  # view: 1 linha por time por partida
│   ├── ranking.sql
│   ├── media_gols.sql
│   ├── aproveitamento.sql         # ainda não usado no main.py
│   └── evolucao_rodada.sql        # ainda não usado no main.py
├── output/                        # gráficos gerados (não versionado)
├── setup_db.py                    # carrega o CSV no DuckDB
├── main.py                        # roda as queries e gera os gráficos
└── requirements.txt
```

## 🗃️ Fonte dos dados

Dataset ["Campeonato Brasileiro de Futebol"](https://www.kaggle.com/datasets/adaoduque/campeonato-brasileiro-de-futebol), disponível publicamente no Kaggle. Contém uma linha por partida, com placar, data, mandante/visitante e outros metadados, cobrindo as temporadas de 2003 a 2025.

## ▶️ Como rodar

```bash
# 1. Clone o repositório
git clone https://github.com/SEU_USUARIO/brasileirao-analytics.git
cd brasileirao-analytics

# 2. Crie e ative o ambiente virtual
python -m venv venv
source venv/bin/activate      # Windows: venv\Scripts\activate

# 3. Instale as dependências
pip install -r requirements.txt

# 4. Baixe o CSV do Kaggle e coloque em data/campeonato-brasileiro-full.csv

# 5. Carregue os dados no banco
python setup_db.py

# 6. Gere os gráficos
python main.py
```

Os resultados são salvos em `output/ranking.png` e `output/media_gols.png`.

## 📈 Exemplos de saída

*(adicione aqui os PNGs gerados, ex: `![Ranking](output/ranking.png)`)*

## 🧠 Decisões técnicas

- A coluna `rodata` do CSV original reinicia a cada temporada — por isso todas as consultas filtram por `temporada` (derivada da data da partida), evitando misturar anos diferentes.
- A view `jogos_por_time` transforma o formato "1 linha por partida" (mandante x visitante) em "1 linha por time por partida", o que simplifica drasticamente os agregados de pontos, saldo e médias.

