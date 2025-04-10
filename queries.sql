SELECT table_name, column_name
FROM information_schema.columns
WHERE table_schema = 'public'
ORDER BY table_name, ordinal_position;

COPY (
  SELECT table_name, column_name
  FROM information_schema.columns
  WHERE table_schema = 'public'
  ORDER BY table_name, ordinal_position
) TO 'D:\SQL\SQL-Mondial-Database\tables_info.csv' WITH CSV HEADER;

## 🔹 Beginner Level (10 Questions)

### 1. List all countries and their capital cities.

SELECT name, capital
FROM country
ORDER BY name ASC;