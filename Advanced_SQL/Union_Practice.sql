-- Get the corresponding skill and skill type for 
-- each job posting in the first quarter.
-- Include those without any skills, too.
-- For jobs in the first quarter with salary > $70,000 
-- return the skills and the type of each job.


SELECT 
  quarter1_jobs.job_title_short AS job_description,
  skills.skills AS skill_name,
  skills.type AS type_of_skill,
  quarter1_jobs.job_schedule_type AS type_of_job
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

LEFT JOIN skills_job_dim AS skills_job
ON skills_job.job_id = quarter1_jobs.job_id

LEFT JOIN skills_dim AS skills
ON skills.skill_id = skills_job.skill_id

WHERE quarter1_jobs.salary_year_avg > 70000

SELECT 
  job_id,
  EXTRACT(QUARTER FROM job_posted_date) AS quarter
FROM
  job_postings_fact AS jobs
WHERE
  EXTRACT(QUARTER FROM job_posted_date) = 1