# SQL Data Analytics Portfolio Project

**Project:** Sales Analytics — SQL-only case study

---

## Project overview
This repository contains a complete SQL-only data analytics case study built from a multi-table sales dataset (customers, orders, order_details, products). The project demonstrates end-to-end SQL skills for a junior Data Analyst role: data cleaning, joins, aggregations, CTEs, window functions, ranking, and business insights.

## What’s included

- `DATASETS/` — raw CSV exports of the tables: `customers.csv`, `orders.csv`, `order_details.csv`, `products.csv`.
- `sql/` — a folder containing all polished SQL queries. Each file is named by the question category (e.g., `3. Product Insights.sql`).
- `DA_SQL_Case_Study.pdf` — the case study PDF generated from the analysis.
- `README.md` — this file.

## Repository structure
```
SQL-DA-Portfolio/
├── DATASETS/
│   ├── customers.csv
│   ├── orders.csv
│   ├── order_details.csv
│   └── products.csv
├── sql/
│   ├── 1. Basic Metrics
│   ├── 2. Customer Insights
│   ├── 3. Product Insights
│   ├── 4. Time-Based Analysis
│   └── 5. Advanced Ranking
├── reports/DA_SQL_Case_Study.pdf
└── README.md
```

## How to reproduce (local)
1. Create a local database (MySQL / PostgreSQL / SQLite) and import CSV files into tables named: `customers`, `orders`, `order_details`, `products`.

2. Run the SQL files in the `sql/` folder in order. Each file is self-contained and uses standard SQL constructs (CTEs, window functions). Minor syntax tweaks may be needed between MySQL and PostgreSQL (e.g., `LIMIT` vs `FETCH`), but queries are annotated.

3. Export query outputs as CSV (for visualization) or include them in the `results/` folder.

## Notes on data quality
- Missing `COUNTRY`/`TERRITORY` values are handled using `COALESCE(NULLIF(...), 'Unknown')` in the queries.
- Aggregations are validated by cross-checking totals between `orders` and `order_details`.
