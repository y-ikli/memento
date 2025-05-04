## Introduction to dbt (Data Build Tool)
**What is dbt?**
- dbt is a command-line tool that enables data analysts and engineers to transform data in their warehouse more effectively.
- It helps manage data transformations using SQL and software engineering best practices like modularity, testing, and documentation.
- Commonly used with data warehouses like Snowflake, BigQuery, Redshift, and Databricks.
## Prerequisites
**Before starting, you’ll need:**
- Python (3.7+)
- Access to a supported data warehouse (e.g., Snowflake, BigQuery)
- Basic knowledge of SQL and command-line interface
- Docker (for containerized dbt setup, optional)
## Setting Up dbt with Docker
**Why use Docker?**
- Isolates dependencies
- Ensures reproducibility
- Easy setup for teams
**Run dbt with Docker:**
```
docker run -it --rm \
  --name dbt \
  -v $(pwd):/usr/app \
  -w /usr/app \
  ghcr.io/dbt-labs/dbt-core:1.7.0 debug
```
## Creating a dbt Project
**Initialize a new project:**
```
dbt init my_project
```
- Creates a directory structure with dbt_config, models, tests, and documentation folders
## Configure Your Connection
**Edit `profiles.yml`:**
- Located at `~/.dbt/profiles.yml`
- Configure according to your warehouse (example for Snowflake):
```yaml
my_project:
  target: dev
  outputs:
    dev:
      type: snowflake
      account: your_account
      user: your_user
      password: your_password
      role: your_role
      database: your_database
      warehouse: your_warehouse
      schema: your_schema
```
## Building Your First Model
**Create a SQL file in `models/`:**
- Example: `models/my_first_model.sql`
```sql
SELECT *
FROM {{ ref('raw_customers') }}
WHERE is_active = TRUE
```
- `ref()` is a dbt macro that manages dependencies between models
**Run dbt models:**
```
dbt run
```
## Testing Your Models
**Create a test in `models/tests/`:**
```yaml
version: 2
models:
  - name: my_first_model
    tests:
      - unique:
          column_name: id
      - not_null:
          column_name: id
```
**Run tests:**
```
dbt test
```
## Documenting Models
**Add descriptions in YAML:**
```yaml
models:
  - name: my_first_model
    description: "This model filters active customers."
    columns:
      - name: id
        description: "Unique identifier for each customer"
```
**Generate docs:**
```
dbt docs generate
dbt docs serve
```
## Using Sources
**Define raw tables as sources:**
```yaml
version: 2
sources:
  - name: raw
    database: your_database
    schema: raw_schema
    tables:
      - name: customers
```
**Refer to source in SQL:**
```sql
SELECT *
FROM {{ source('raw', 'customers') }}
```
## Deployment & Scheduling
**Use dbt Cloud or orchestrators like Airflow or Prefect to:**
- Schedule dbt runs
- Monitor job health
- Handle dependencies
## Conclusion
**Key Takeaways:**
- dbt transforms data using modular SQL models and best practices
- Use `ref()` and `source()` for maintainability
- Automate testing and documentation
- Docker helps keep dbt environments reproducible
**Next Steps:**
- Explore dbt packages: https://hub.getdbt.com
- Learn about snapshots and incremental models
- Connect dbt with your BI tools


Last update : 2025-05-04T19:26:13Z
