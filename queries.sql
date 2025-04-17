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

## 🟡 Intermediate Level (10 Questions)

### 11. List countries that border exactly 5 other countries.

SELECT c.name
FROM borders AS b
JOIN country AS c
ON b.country1 = c.code
GROUP BY b.country1, c.name
HAVING COUNT(b.country1) = 5
ORDER BY c.name ASC;

### 12. Which continent has the most countries?

SELECT continent, COUNT(continent)
FROM encompasses
GROUP BY continent
ORDER BY continent ASC
LIMIT 1;

### 13. Show all religions that are dominant in at least 5 countries.

SELECT name, COUNT(name)
FROM religion
WHERE percentage > 50
GROUP BY name
HAVING COUNT(name) >= 5
ORDER BY count DESC;

### 14. Find countries with more than one official language.

SELECT country.name, COUNT(spoken.country)
FROM spoken
JOIN country
ON spoken.country = country.code
GROUP BY spoken.country, country.name
HAVING COUNT(spoken.country) > 1
ORDER BY count DESC;

### 15. Show all countries with a GDP per capita over $30,000.

SELECT country.name, economy.gdp, (gdp * 1000000) / country.population AS per_capita
FROM economy
JOIN country
ON economy.country = country.code
WHERE (gdp * 1000000) / country.population > 30000
ORDER BY (gdp * 1000000) / country.population DESC;

### 16. List lakes larger than 10,000 sq km.

SELECT name, area
FROM lake
WHERE area > 10000
ORDER BY area DESC;

### 17. Find the longest river and all the countries it passes through.

SELECT DISTINCT country.name
FROM geo_river
JOIN country
ON geo_river.country = country.code
WHERE geo_river.river = (
  SELECT name
  FROM river
  WHERE length != 0
  ORDER BY length DESC
  LIMIT 1
);

### 18. Find the country with the largest population density.

SELECT name, (population / area)
FROM country
ORDER BY (population / area) DESC;

### 19. List all countries where Islam is the dominant religion and population exceeds 100 million.

SELECT country.name, religion.percentage, country.population
FROM religion
JOIN country
ON religion.country = country.code
WHERE religion.percentage > 50 AND religion.name = 'Muslim' AND country.population > 100000000
ORDER BY religion.percentage DESC;

### 20. Show countries that gained independence after 1950.

SELECT country.name, politics.independence
FROM politics
JOIN country
ON politics.country = country.code
WHERE politics.independence > '01-01-1950'
ORDER BY politics.independence DESC;

## 🔴 Advanced Level (10 Questions)

### 21. Find all countries that share a border with at least 3 countries and have a coastline.

SELECT country.name
FROM borders
JOIN country
ON borders.country1 = country.code
GROUP BY country.name, borders.country1
HAVING (COUNT(borders.country1)) >= 3 AND (borders.country1 IN (
  SELECT country
  FROM geo_sea
  GROUP BY country))
ORDER BY country.name;

### 22. Which language is spoken by the most people (across all countries)?

SELECT spoken.language, ((country.population / 100) * spoken.percentage) AS people_count
FROM spoken
JOIN country
ON spoken.country = country.code
GROUP BY spoken.language, people_count
HAVING ((country.population / 100) * spoken.percentage) IS NOT NULL
ORDER BY people_count DESC
LIMIT 1;

### 23. Find all landlocked countries in Asia with population > 10 million.

SELECT country.name, sea, continent
FROM country
LEFT JOIN geo_sea
ON country.code = geo_sea.country
LEFT JOIN encompasses
ON country.code = encompasses.country
WHERE population > 10000000
GROUP BY country.name, sea, continent
HAVING sea IS NULL AND continent = 'Asia'

### 24. List the capitals of countries where the population of the capital is more than half the population of the country.

SELECT citypops.city, country.name, citypops.year, citypops.population 
  AS city_population, country.population AS country_population 
FROM citypops
LEFT JOIN country
ON citypops.country = country.code
WHERE citypops.city = country.capital
  AND (citypops.population > (country.population / 2))

### 25. Show country pairs that share a border and both have "Republic" in their name.

SELECT c1.name, c2.name, borders.length FROM borders
JOIN country AS c1
ON borders.country1 = c1.code
JOIN country AS c2
ON borders.country2 = c2.code
WHERE country1 IN (
  SELECT code 
  FROM country
  WHERE name LIKE '%Republic' OR name LIKE '%Rep%'
) AND country2 IN (
  SELECT code 
  FROM country
  WHERE name LIKE '%Republic' OR name LIKE '%Rep%'
)

### 26. Which river flows through the most countries?

SELECT river, COUNT(DISTINCT country) FROM geo_river
GROUP BY river
ORDER BY count DESC

### 27. Show the average area of countries by continent, sorted descending.

SELECT encompasses.continent, SUM(country.area) 
FROM encompasses
JOIN country
ON encompasses.country = country.code
GROUP BY encompasses.continent
ORDER BY SUM(country.area) DESC

### 28. Find all cities that are capitals and also the largest city in their country.

