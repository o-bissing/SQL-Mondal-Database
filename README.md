# SQL-Mondial-Database

## Introduction

Goal of this project is to enchance my SQL and Power BI skills.

## Tools I used

To create this project I worked with the following tools/technologies:

- **Python** as a main programming language
- **SQL** as a main data language
- **ChatGPT** to create questions to the database which I then answered using SQL
- **PostgreSQL** database for storing data
- **pgAdmin** for managing the database
- **Power BI** to create a report
- **JSON** file format for storing SQL-query output to use it later in Power BI
- **Bash** for interaction with OS, doing terminal based tasks and working with GitHub
- **Git** for version control

## Database Tables and Columns

Mondial Database has been generated in 1998 at Freiburg University, and since 2002 maintained at Göttingen University from geographical Web data sources. Further information and links are down below.

| Table Name        | Columns                                                                                             |
| ----------------- | --------------------------------------------------------------------------------------------------- |
| airport           | iatacode, name, country, city, province, island, latitude, longitude, elevation, gmtoffset          |
| borders           | country1, country2, length                                                                          |
| city              | name, country, province, population, latitude, longitude, elevation                                 |
| citylocalname     | city, country, province, localname                                                                  |
| cityothername     | city, country, province, othername                                                                  |
| citypops          | city, country, province, year, population                                                           |
| continent         | name, area                                                                                          |
| country           | name, code, capital, province, area, population                                                     |
| countrylocalname  | country, localname                                                                                  |
| countryothername  | country, othername                                                                                  |
| countrypops       | country, year, population                                                                           |
| desert            | name, area, coordinates                                                                             |
| economy           | country, gdp, agriculture, service, industry, inflation, unemployment                               |
| encompasses       | country, continent, percentage                                                                      |
| ethnicgroup       | country, name, percentage                                                                           |
| geo_desert        | desert, country, province                                                                           |
| geo_estuary       | river, country, province                                                                            |
| geo_island        | island, country, province                                                                           |
| geo_lake          | lake, country, province                                                                             |
| geo_mountain      | mountain, country, province                                                                         |
| geo_river         | river, country, province                                                                            |
| geo_sea           | sea, country, province                                                                              |
| geo_source        | river, country, province                                                                            |
| island            | name, islands, area, elevation, type, coordinates                                                   |
| islandin          | island, sea, lake, river                                                                            |
| ismember          | country, organization, type                                                                         |
| lake              | name, river, area, elevation, depth, height, type, coordinates                                      |
| lakeonisland      | lake, island                                                                                        |
| language          | name, superlanguage                                                                                 |
| located           | city, province, country, river, lake, sea                                                           |
| locatedon         | city, province, country, island                                                                     |
| mergeswith        | sea1, sea2                                                                                          |
| mountain          | name, mountains, elevation, type, coordinates                                                       |
| mountainonisland  | mountain, island                                                                                    |
| organization      | abbreviation, name, city, country, province, established                                            |
| politics          | country, independence, wasdependent, dependent, government                                          |
| population        | country, population_growth, infant_mortality                                                        |
| province          | name, country, population, area, capital, capprov                                                   |
| provincelocalname | province, country, localname                                                                        |
| provinceothername | province, country, othername                                                                        |
| provpops          | province, country, year, population                                                                 |
| religion          | country, name, percentage                                                                           |
| river             | name, river, lake, sea, length, area, source, mountains, sourceelevation, estuary, estuaryelevation |
| riveronisland     | river, island                                                                                       |
| riverthrough      | river, lake                                                                                         |
| sea               | name, area, depth                                                                                   |
| spoken            | country, language, percentage                                                                       |

## 30 questions to answer

I asked ChatGPT to create 30 questions about this data, which I then answered using SQL. There are 3 categories of questions: Beginner, Intermediate and Advanced. Full list of the questions: ![Questions](questions.md). All corresponding SQL queries I came up with: ![Answers](queries.sql).

Examples of questions and corresponding SQL queries:

```sql
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

### 28. Find all cities that are capitals and also the largest city in their country.

WITH CityRanking AS (
  SELECT name, country, population,
    ROW_NUMBER() OVER (PARTITION BY country
    ORDER BY population DESC) AS rn
  FROM city
)

SELECT country.name AS country, CityRanking.name AS city, CityRanking.population
FROM CityRanking
JOIN country
ON CityRanking.country = country.code
WHERE CityRanking.rn = 1 AND CityRanking.population IS NOT NULL AND CityRanking.name = country.capital;
```

## Power BI report

For the visualisation answers to four questions were chosen:

- 8. List the 10 largest countries by area.
- 13. Show all religions that are dominant in at least 5 countries.
- 20. Show countries that gained independence after 1950.
- 28. Find all cities that are capitals and also the largest city in their country.

To create these visualisations some data preparation and DAX-scripting were necessary. Here is the final result:

![Power BI Report Preview](https://github.com/o-bissing/SQL-Mondial-Database/blob/main/report.png)

## Reference

@TechReport{may-MONDIAL-report-99,
author = {Wolfgang May},
title = {Information Extraction and Integration with \textsc{Florid}:
The \textsc{Mondial} Case Study},
institution = {Universit\"at Freiburg, Institut f\"ur Informatik},
year = 1999,
number = 131,
note = "Available from
\url{http://dbis.informatik.uni-goettingen.de/Mondial}
}
