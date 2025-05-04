## Introduction to SQL
**What is SQL?**
- SQL (Structured Query Language) is the standard language used to interact with relational databases.
- SQL allows you to query, insert, update, and delete data from a database.
- It is used for database management and is supported by all major relational databases like MySQL, PostgreSQL, SQLite, and SQL Server.

## Prerequisites
**Before starting, you’ll need:**
- A basic understanding of databases and data structures.
- Access to a database (e.g., MySQL, PostgreSQL) and a SQL client or interface.

## Basic SQL Commands
**SELECT Query:**
- Retrieves data from one or more tables.
```sql
SELECT column1, column2 FROM table_name;
```
- To select all columns:
```sql
SELECT * FROM table_name;
```

**WHERE Clause:**
- Filters records based on a condition.
```sql
SELECT * FROM table_name WHERE condition;
```

**INSERT INTO:**
- Inserts new data into a table.
```sql
INSERT INTO table_name (column1, column2) 
VALUES (value1, value2);
```

**UPDATE:**
- Updates existing data in a table.
```sql
UPDATE table_name 
SET column1 = value1, column2 = value2 
WHERE condition;
```

**DELETE:**
- Deletes data from a table.
```sql
DELETE FROM table_name WHERE condition;
```

## Aggregate Functions
**COUNT:**
- Counts the number of rows in a table or a group.
```sql
SELECT COUNT(*) FROM table_name;
```

**SUM:**
- Sums up values in a numeric column.
```sql
SELECT SUM(column_name) FROM table_name;
```

**AVG:**
- Finds the average of numeric values.
```sql
SELECT AVG(column_name) FROM table_name;
```

**MIN & MAX:**
- Finds the minimum and maximum values in a column.
```sql
SELECT MIN(column_name), MAX(column_name) FROM table_name;
```

## Joins
**INNER JOIN:**
- Combines rows from two tables based on a related column.
```sql
SELECT column1, column2 
FROM table1
INNER JOIN table2 ON table1.common_column = table2.common_column;
```

**LEFT JOIN:**
- Retrieves all records from the left table and the matched records from the right table.
```sql
SELECT column1, column2
FROM table1
LEFT JOIN table2 ON table1.common_column = table2.common_column;
```

**RIGHT JOIN:**
- Retrieves all records from the right table and the matched records from the left table.
```sql
SELECT column1, column2
FROM table1
RIGHT JOIN table2 ON table1.common_column = table2.common_column;
```

**FULL JOIN:**
- Retrieves records when there is a match in either table.
```sql
SELECT column1, column2
FROM table1
FULL JOIN table2 ON table1.common_column = table2.common_column;
```

## Grouping and Sorting
**GROUP BY:**
- Groups rows that have the same values into summary rows.
```sql
SELECT column_name, COUNT(*)
FROM table_name
GROUP BY column_name;
```

**HAVING Clause:**
- Filters records after the `GROUP BY` operation.
```sql
SELECT column_name, COUNT(*)
FROM table_name
GROUP BY column_name
HAVING COUNT(*) > 1;
```

**ORDER BY:**
- Sorts the result set in ascending or descending order.
```sql
SELECT * FROM table_name ORDER BY column_name ASC;
SELECT * FROM table_name ORDER BY column_name DESC;
```

## Subqueries
**Subquery in SELECT:**
- A query inside another query to filter results.
```sql
SELECT column_name
FROM table_name
WHERE column_name IN (SELECT column_name FROM another_table WHERE condition);
```

**Subquery in FROM:**
- Using a subquery in the `FROM` clause.
```sql
SELECT alias.column_name
FROM (SELECT column_name FROM table_name) AS alias;
```

## Advanced SQL Concepts
**CASE Statement:**
- Performs conditional logic within a query.
```sql
SELECT column_name,
       CASE 
           WHEN condition THEN result1
           ELSE result2
       END AS alias_name
FROM table_name;
```

**Window Functions (OVER):**
- Allows calculation across a set of rows related to the current row.
```sql
SELECT column_name, 
       ROW_NUMBER() OVER (ORDER BY column_name) AS row_num
FROM table_name;
```

**Common Table Expressions (CTE):**
- A temporary result set that you can reference within a `SELECT`, `INSERT`, `UPDATE`, or `DELETE` statement.
```sql
WITH cte_name AS (
    SELECT column_name FROM table_name WHERE condition
)
SELECT * FROM cte_name;
```

**Recursive CTE:**
- A CTE that references itself to retrieve hierarchical data.
```sql
WITH RECURSIVE cte_name AS (
    SELECT column_name FROM table_name WHERE condition
    UNION ALL
    SELECT column_name FROM table_name WHERE condition
)
SELECT * FROM cte_name;
```

**Indexes:**
- A performance optimization for faster search and retrieval.
```sql
CREATE INDEX index_name ON table_name(column_name);
```

**Transactions:**
- Ensures a set of operations are completed successfully (or none at all).
```sql
BEGIN TRANSACTION;
UPDATE table_name SET column_name = value WHERE condition;
COMMIT;
```
**Rollback a Transaction:**
```sql
ROLLBACK;
```

## Conclusion
**Key Takeaways:**
- SQL allows you to interact with databases to retrieve, modify, and analyze data.
- Basic SQL includes querying, filtering, and modifying data.
- Advanced SQL features like joins, subqueries, window functions, and CTEs enhance query power.

**Next Steps:**
- Practice writing complex queries involving multiple joins, subqueries, and window functions.
- Learn about database optimization techniques like indexing and query optimization.
- Explore database design principles like normalization and denormalization.


Last update : 2025-05-04T19:34:16Z
