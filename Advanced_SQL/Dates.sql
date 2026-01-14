SELECT 
  COUNT(job_id) AS job_posted_count,
  EXTRACT(MONTH FROM job_posted_date) AS month
FROM
  job_postings_fact
WHERE
  job_title_short = 'Data Analyst'
GROUP BY
  month  
ORDER BY
  job_posted_count DESC;


SELECT
  job_schedule_type,
  ROUND(AVG(salary_year_avg), 2) AS average_yearly_salary,
  ROUND(AVG(salary_hour_avg), 2) AS average_hourly_salary
FROM 
  job_postings_fact
WHERE
  job_posted_date > '2023-06-01'
GROUP BY
  job_schedule_type;

SELECT
  COUNT(job_id) AS job_count,
  EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS month 
FROM 
  job_postings_fact
GROUP BY
  month
ORDER BY
  month;


SELECT
  company.name
FROM 
  company_dim AS company
INNER JOIN  
  job_postings_fact AS jobs
ON
  company.company_id = jobs.company_id
WHERE 
  jobs.job_health_insurance = TRUE AND
  EXTRACT(QUARTER FROM jobs.job_posted_date) = 2;