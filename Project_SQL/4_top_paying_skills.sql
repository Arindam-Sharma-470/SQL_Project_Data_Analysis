/*
Question: What are the top-paying skills based on salary?
- Look at the average salary associated with each skill for Data Analyst position
- Focuses on roles with specified salaries, regardless of location
- It reveals how different skills impact salary levels for Data Analysts and
- helps identify the most financially rewarding skills to acquire or improve
*/

SELECT 
  skills,
  ROUND(AVG(salary_year_avg), 2) AS avg_yearly_salary
FROM
  job_postings_fact
INNER JOIN
  skills_job_dim
ON
  skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN
  skills_dim
ON
  skills_dim.skill_id = skills_job_dim.skill_id
WHERE 
  job_title_short = 'Data Analyst' AND
  salary_year_avg IS NOT NULL 
  -- job_work_from_home = TRUE
GROUP BY
  skills
ORDER BY
  avg_yearly_salary DESC 
LIMIT 25

SELECT 
  skills,
  ROUND(AVG(salary_year_avg), 2) AS avg_yearly_salary
FROM
  job_postings_fact
INNER JOIN
  skills_job_dim
ON
  skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN
  skills_dim
ON
  skills_dim.skill_id = skills_job_dim.skill_id
WHERE 
  job_title_short = 'Data Analyst' AND
  salary_year_avg IS NOT NULL AND
  job_work_from_home = TRUE
GROUP BY
  skills
ORDER BY
  avg_yearly_salary DESC 
LIMIT 25

/*
💰 Highest pay goes to Big-Data & Cloud Analysts
Tools like PySpark, Databricks, Kubernetes, Airflow, GCP 
show that companies pay most for analysts who can handle 
large-scale data pipelines and cloud systems, not just run queries.

🤖 Machine Learning skills multiply analyst salaries
Scikit-learn, DataRobot, Watson, Jupyter, Pandas, NumPy indicate 
that analysts who can build, test, and deploy ML models earn far 
more than those doing only reporting.

🧑‍💻 Modern “Data Analysts” are actually software engineers with data
Skills like GitLab, Bitbucket, Jenkins, Go, Scala, Linux show that 
the best-paid analysts are those who can code, version, deploy, and 
run analytics in production environments.

[
  {
    "skills": "pyspark",
    "avg_yearly_salary": "208172.25"
  },
  {
    "skills": "bitbucket",
    "avg_yearly_salary": "189154.50"
  },
  {
    "skills": "couchbase",
    "avg_yearly_salary": "160515.00"
  },
  {
    "skills": "watson",
    "avg_yearly_salary": "160515.00"
  },
  {
    "skills": "datarobot",
    "avg_yearly_salary": "155485.50"
  },
  {
    "skills": "gitlab",
    "avg_yearly_salary": "154500.00"
  },
  {
    "skills": "swift",
    "avg_yearly_salary": "153750.00"
  },
  {
    "skills": "jupyter",
    "avg_yearly_salary": "152776.50"
  },
  {
    "skills": "pandas",
    "avg_yearly_salary": "151821.33"
  },
  {
    "skills": "elasticsearch",
    "avg_yearly_salary": "145000.00"
  },
  {
    "skills": "golang",
    "avg_yearly_salary": "145000.00"
  },
  {
    "skills": "numpy",
    "avg_yearly_salary": "143512.50"
  },
  {
    "skills": "databricks",
    "avg_yearly_salary": "141906.60"
  },
  {
    "skills": "linux",
    "avg_yearly_salary": "136507.50"
  },
  {
    "skills": "kubernetes",
    "avg_yearly_salary": "132500.00"
  },
  {
    "skills": "atlassian",
    "avg_yearly_salary": "131161.80"
  },
  {
    "skills": "twilio",
    "avg_yearly_salary": "127000.00"
  },
  {
    "skills": "airflow",
    "avg_yearly_salary": "126103.00"
  },
  {
    "skills": "scikit-learn",
    "avg_yearly_salary": "125781.25"
  },
  {
    "skills": "jenkins",
    "avg_yearly_salary": "125436.33"
  },
  {
    "skills": "notion",
    "avg_yearly_salary": "125000.00"
  },
  {
    "skills": "scala",
    "avg_yearly_salary": "124903.00"
  },
  {
    "skills": "postgresql",
    "avg_yearly_salary": "123878.75"
  },
  {
    "skills": "gcp",
    "avg_yearly_salary": "122500.00"
  },
  {
    "skills": "microstrategy",
    "avg_yearly_salary": "121619.25"
  }
]
*/