SELECT  
  COUNT(job_id),
  CASE
    WHEN job_location = 'Anywhere' THEN 'Remote'
    WHEN job_location = 'New York, NY' THEN 'Local'
    ELSE 'Onsite'
  END AS location_category
FROM 
  job_postings_fact
WHERE 
  job_title_short = 'Data Analyst'
GROUP BY
  location_category;

/*

Label new column as follows:
-- 'Anywhere' jobs as 'Remote'
-- 'New York, NY' jobs as 'Local'
-- Otherwise 'Onsite'

*/

SELECT
  salary_year_avg AS average_yearly_salary,
  CASE
    WHEN salary_year_avg > 100000 THEN 'HIGH'
    WHEN salary_year_avg BETWEEN 10000 AND 100000 THEN 'STANDARD'
    WHEN salary_year_avg < 10000 THEN 'LOW'
  END AS salary_category
FROM
  job_postings_fact
WHERE 
  job_title_short = 'Data Analyst'
ORDER BY
  average_yearly_salary DESC NULLS LAST;