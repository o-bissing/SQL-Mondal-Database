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

### 2. Find all countries in Europe with a population greater than 50 million.

SELECT c.name, c.population
FROM country AS c
JOIN encompasses AS e
ON c.code = e.country
WHERE e.continent = 'Europe' AND c.population > 50000000;

### 3. How many countries are there in the world?

SELECT COUNT(*)
FROM country;

### 4. List the top 5 most populous cities in the world.

SELECT name, country, population
FROM city
WHERE population IS NOT NULL
ORDER BY population DESC
LIMIT 5;

### 5. Show all distinct continents listed in the database.

SELECT DISTINCT name
FROM continent;

### 6. Find the population of the capital city of Argentina.

SELECT city.city, city.year, city.population
FROM citypops AS city
JOIN country
ON city.country = country.code
WHERE country.name = 'Argentina' AND city.city = country.capital
ORDER BY city.year DESC
LIMIT 1;

### 7. Show countries where the official language is French.

SELECT name
FROM country
JOIN spoken
ON country.code = spoken.country
WHERE language = 'French';

### 8. List the 10 largest countries by area.

SELECT name, area
FROM country
ORDER BY area DESC
LIMIT 10;

### 9. Which country has "Kingdom" in its name?

SELECT name
FROM country
WHERE name LIKE '%Kingdom%';

### 10. How many cities are listed in the database?

SELECT COUNT(*)
FROM city;