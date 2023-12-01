-- SELECT QUERIES 101

-- Find the title of each film
select title from movies;

-- find the director of each film
select director from movies;

-- find the title and director of each film
select title, director from movies;

-- find all the information about each film
select * from movies;

-- QUERIES WITH CONSTRAINTS PT-1

-- find the movie with a row id of 6
select * from movies where id = 6;

-- find the movies released in the years between 2000 and 2010
select * from movies where year between 2000 and 2010;

-- find the movies not released in the years between 2000 and 2010
select * from movies where year not between 2000 and 2010;

-- find the first 5 pixar movies and their release year
select * from movies where id between 1 and 5;

-- QUERIES WITH CONSTRAINTS

-- find all the toy story movies
select * from movies where title like "%Toy Story%";

-- find all the movies directed by John Lasseter
select * from movies where director = "John Lasseter";

-- find all the movies (and director) not directed by John Lasseter
select * from movies where director != "John Lasseter";

-- find all the WALL-* movies
select * from movies where title like "%wALL%";

-- FILTERING AND SORTING QUERY RESULTS

-- list all directors of Pixar movies (alphabetically), without duplicates
select distinct director from movies order by director;

-- list the last four pixxar movies released ( oredered from most recent to least)
select * from movies order by year desc limit 4;

-- list the first five pixar movies sorted alphabetically
select * from movies order by title asc limit 5;

-- list the next five pixar moies sorted alphabetically
select * from moveis order by title asc limit 5 offset 5;

-- REVIEW SIMPLE SELECT QUERIES

-- list all the canadian cities and their populations
select * from north_american_cities where country like "canada";

-- order all the cities in the united states by their latitude from north to south
select * from north_american_cities where country = "united states" order_by latitude desc;

-- list all thecities west of chicago, ordered from west to east
select * from north_american_cities where logitude < -87.69 order by longitude asc;

-- list the two largest cities in mexico (by population)
select * from north_american_cities where country = 'mexico' order by population desc limit 2;

-- list the third and fourth largest cities (by population) in the united states and ther population
select * from north_american_cities where country = 'united states' order by population desc limit 2 offset 2;

-- MULTITABLE QUERIES WITH JOINS

-- find the domestic and international sales for each movie
select title, international_sales, domestic_sales from movies join boxoffice on id = movie_id;

-- show the sales numbers for each movie that did better internationally raher than domestically
select title, international_sales, domestic_sales from movies join boxoffice on id = movie_id where international_sales > domestic_sales;

-- list all the movies by their ratings in descending order
select title, rating from movies join boxoffice on id=movie_id order by rating desc;

-- OUTER JOIN

-- find the list of all buldings that have employees
select distinct building from employees left join buildings on building = building_name where years_employed not null;

-- findthe list of all buildings and their capacity
select * from buildings;

-- list all buildings and the distinct employee roles in each building (including empty buildings)
select distinct building_name, role from buildings left join employees on building_name = building;

-- A SHORT NOTE ON NULLS

-- find the name and role of all employees who have not been assigned to a building
select * from employees left join buildings on building_name = building where building is null;

-- find the names of the buildings that hold no employees
select * from buildings left join employees on building_name = building where building is null;

-- QUERIES WITH EXPRESSIONS

-- list all movies an their commbined sales in millions of dollars
select title,(domestic_sales + international_sales)/1000000 as total_sales from movies left join bofoffice on id=movie_id;

-- list all movies and their ratings in percent
select title, rating*10 as percent from movies left join bofoffice on id=movie_id;

-- list all movies that were released on even number years
select title, year from movies left join boxoffice on id=movie_id where year %2=0;

-- QUERIES WITH AGGREGATES

-- find the longest time that an employee has been at the studio
select max(years_employed) from employees;

-- for each role, find the average number of years employed by empployees in that role
select role, avg(years_employed) from emplpoyees group by role;

-- find the total number of employee years worked in each building
select building, sum(years_employed) from employees group by building;

-- QUERIES WITH AGGREGATEES PT.2

-- find the number of artists in the studio (without a having clause)
select role, count(*) as number_of_artists froom employees where role="Artist";

-- find the number of employees of each role in the studio
select role, count(*) from employees group by roles;

-- find the total number of years employed by all engineers
select role, sum(years_employed) from employees group by role having role="engineer";

-- ORDER OF EXECUTION OF A QUERY

-- find the number of movies each director has directed
select *, count(title) from movies group by director;

-- find the total domestic and international sales that can be attributed to each director
select director, sum(domestic_sales + international_sales) as total_sales from movies left join boxoffice on id=movie_id group by girctor;

-- INSERING ROWS

-- add the studio's new production, toy story 4 to the list of movies.
insert into movies, values (4,"TOy Story 4","John Lasseter",2017,123);

-- toy story 4 has been released to critical acclaim.
insert into boxoffice values (4, 8.7,340000000,270000000);

-- UPDATING ROWS

-- the director for a bug life is incorrect it wan actually directed by john lasseter
update movies set director = "john Lasseter" where id=2;

-- the year that toy story 2 was released is incorrect.
update movies set year = "1999" where id=3;

-- both the title and directory for toy story 8 is incorrect
update movies set title ="toy story 3", director="lee unkrich" where id=11;

-- DELETING ROWS

-- this database is geeting too big, les remove all movies
delete from movies where year < 2005;

-- andrew stanton has also left the studio.
delete from movies where director ="Andrew Stanton";

-- CREATING TABLES

create table database (
    name text,
    version float,
    download_count integer
);

-- ALTERING TABLES

-- add a column named aspect_rattio with a float
alter table movies add coloumn aspect_ratio float default 3;

-- add another column named language with a text datatype
alter table movies add column language text default "english";

-- DROPPING TABLES

-- clean the table
drop table movies;

-- drop the boxoffice
drop table boxoffice;
