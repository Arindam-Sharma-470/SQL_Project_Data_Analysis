-- Find the job postings from the first quarter 
-- that have a salary greater than $70K.
-- - Combine job posting tables from the first quarter.
-- - Get job postings with an average yearly salary > $70K.


SELECT 
  quarter1_jobs.job_title_short,
  quarter1_jobs.job_via,
  quarter1_jobs.job_posted_date::DATE,
  quarter1_jobs.salary_year_avg
FROM (
  SELECT *
  FROM january_jobs

  UNION

  SELECT *
  FROM february_jobs

  UNION

  SELECT *
  FROM march_jobs
) AS quarter1_jobs

WHERE
  quarter1_jobs.salary_year_avg > 70000 AND
  quarter1_jobS.job_title_short = 'Data Analyst'
ORDER BY
  quarter1_jobs.salary_year_avg DESC