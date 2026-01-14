-- Identify the top five skills that are most frequently mentioned in job postings.
-- Use a subquery to find the skill ids with the highest count in the skills_job_dim
-- table and then join this result with the skills_dim table to get the skill names.

SELECT 
  skills.skills,
  top_skills.skill_count
FROM(
  SELECT 
    skill_id,
    COUNT(*) AS skill_count
  FROM 
    skills_job_dim
  GROUP BY 
    skill_id
  ORDER BY 
    skill_count DESC
  LIMIT 5
) AS top_skills
JOIN
  skills_dim AS skills
ON
  skills.skill_id = top_skills.skill_id
ORDER BY
  top_skills.skill_count DESC;



-- Determine the size category ('Small', 'Medium' or 'Large') for each company
-- by first identifying the number of job postings they have. Use a subquery
-- to calculate the total job postings per company. A company is considered
-- 'Small' if it has less than 10 job postings, 'Medium' if the number of job 
-- postings is between 10 and 50, and 'Large' if it has more than 50 job 
-- postings. Implement a subquery to aggregate job counts per company before
-- classifying them based on size.

SELECT 
  company_dim.name AS company_name,
  query_table.number_of_job_postings,
  CASE
    WHEN query_table.number_of_job_postings < 10 THEN 'Small'
    WHEN query_table.number_of_job_postings BETWEEN 10 AND 50 THEN 'Medium'
    WHEN query_table.number_of_job_postings > 50 THEN 'Large'
  END AS classified_as
FROM (
  SELECT 
    company_id,
    COUNT(*) AS number_of_job_postings
  FROM 
    job_postings_fact 
  GROUP BY
    company_id
) AS query_table
JOIN company_dim
ON company_dim.company_id = query_table.company_id;

SELECT 
  COUNT(*) 
FROM
  company_dim;