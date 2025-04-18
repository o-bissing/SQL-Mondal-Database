# SQL-Mondal-Database

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

## Database Tables and Columns

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

![Power BI Report Preview](https://github.com/o-bissing/SQL-Mondial-Database/blob/main/report.png)
