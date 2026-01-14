SELECT *
FROM(--Subquery starts here
  SELECT *
  FROM job_postings_fact
  WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs;

WITH january_jobs AS(--CTE definition starts here
  SELECT *
  FROM job_postings_fact
  WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)--CTE definition ends here

SELECT *
FROM january_jobs;


SELECT 
  company_id,
  name AS company_name
FROM 
  company_dim
WHERE company_id IN(
  SELECT 
    company_id
  FROM
    job_postings_fact
  WHERE 
    job_no_degree_mention = true
  ORDER BY
    company_id
);


/*
Find the companies with the most job openings
--Get total number of job postings per company id (job_posting_fact)
--Return the total number of jobs with the company name (company_dim)
*/

WITH company_job_count AS(
  SELECT
    company_id,
    COUNT(job_id) AS jobs_per_company
  FROM
    job_postings_fact 
  GROUP BY
    company_id
)

SELECT 
  company.company_id,
  company.name,
  job.jobs_per_company
FROM 
  company_dim AS company
LEFT JOIN
  company_job_count AS job  
ON 
  company.company_id = job.company_id
ORDER BY
  job.jobs_per_company DESC;

