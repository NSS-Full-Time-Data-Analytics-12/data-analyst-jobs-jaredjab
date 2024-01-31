-- Data Analyst Project -- Jared Baker
SELECT * FROM data_analyst_jobs;

/* Task 1
How many rows are in the data_analyst_jobs table?
*/
SELECT COUNT(*) AS num_rows
FROM data_analyst_jobs;
-- 1793


/* Task 2
Write a query to look at just the first 10 rows. 
What company is associated with the job posting on the 10th row?
*/
SELECT company FROM data_analyst_jobs
LIMIT 10;
-- ExxonMobil


/* Task 3
How many postings are in Tennessee? 
How many are there in either Tennessee or Kentucky?
*/
SELECT location,
   COUNT(location) AS num_jobs
FROM data_analyst_jobs
WHERE location IN ('TN', 'KY')
GROUP BY location;
-- TN: 21, TN or KY: 27


/* Task 4
How many postings in Tennessee have a star rating above 4?
*/
SELECT COUNT(star_rating) AS TN_over_4_stars
FROM data_analyst_jobs
WHERE star_rating > 4 AND location = 'TN';
-- 3

/* Task 5
How many postings in the dataset have a review count between 500 and 1000?
*/
SELECT COUNT(review_count) AS num_reviews_500_to_1000
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;
-- 151


/* Task 6
Show the average star rating for companies in each state. 
The output should show the state as state and the average rating for the state as avg_rating. 
Which state shows the highest average rating?
*/
SELECT location AS state,
   ROUND(AVG(star_rating), 2) AS avg_rating
FROM data_analyst_jobs
WHERE 
   LENGTH(location) = 2 
   AND star_rating IS NOT NULL
GROUP BY location
ORDER BY avg_rating DESC;
-- NE


/* Task 7
Select unique job titles from the data_analyst_jobs table.
How many are there?
*/
SELECT COUNT(DISTINCT title) AS num_unique_titles
FROM data_analyst_jobs;
-- 881


/* Task 8
How many unique job titles are there for California companies?
*/
SELECT COUNT(DISTINCT title) AS num_unique_CA_titles
FROM data_analyst_jobs
WHERE location = 'CA';
-- 230


/* Task 9
Find the name of each company and its average star rating for all companies that have 
more than 5000 reviews across all locations. 
How many companies are there with more that 5000 reviews across all locations?
*/
SELECT company,
   ROUND(AVG(star_rating), 1) AS avg_star_rating
FROM data_analyst_jobs
WHERE company IS NOT NULL
GROUP BY company
HAVING SUM(review_count) > 5000;
-- 70


/* Task 10
Add the code to order the query in #9 from highest to lowest average star rating. 
Which company with more than 5000 reviews across all locations in the dataset has 
the highest star rating? What is that rating?
*/
SELECT company,
   ROUND(AVG(star_rating), 1) AS avg_star_rating
FROM data_analyst_jobs
WHERE company IS NOT NULL
GROUP BY company
HAVING SUM(review_count) > 5000
ORDER BY avg_star_rating DESC;
-- Google: 4.3


/* Task 11
Find all the job titles that contain the word ‘Analyst’.
How many different job titles are there?
*/
SELECT COUNT(DISTINCT title) AS num_analyst_titles
FROM data_analyst_jobs
WHERE title ILIKE '%analyst%';
-- 774


/* Task 12
How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’?
What word do these positions have in common?
*/
SELECT COUNT(DISTINCT title) AS num_not_analyst_titles
FROM data_analyst_jobs
WHERE title NOT ILIKE '%analyst%'
   AND title NOT ILIKE '%analytics%';
-- 4

SELECT DISTINCT title
FROM data_analyst_jobs
WHERE title NOT ILIKE '%analyst%'
   AND title NOT ILIKE '%analytics%';
-- Tableau


/* BONUS
- You want to understand which jobs requiring SQL are hard to fill. 
- Find the number of jobs by industry (domain) that require SQL and have 
been posted longer than 3 weeks.
- Disregard any postings where the domain is NULL.
- Order your results so that the domain with the greatest number of 
hard to fill jobs is at the top.
- Which four industries are in the top 4 on this list? 
- How many jobs have been listed for more than 3 weeks for each of the top 4?
*/
SELECT domain,
   COUNT(title) AS num_sql_jobs_over_3w
FROM data_analyst_jobs
WHERE
   domain IS NOT NULL
   AND skill ILIKE '%sql%'
   AND days_since_posting > 21
GROUP BY domain
ORDER BY num_sql_jobs_over_3w DESC
LIMIT 4;
/*
   Internet and Software: 62
   Banks and Financial Services: 61
   Consulting and Business Servies: 57 
   Health Care: 52
*/
