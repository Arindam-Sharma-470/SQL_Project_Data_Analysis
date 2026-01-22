# Introduction
Dive into the data job market! Focusing on data analyst roles, this project explores top-paying jobs, in-demand skills, and where high demand meets high salary in data analytics.

SQL Queries? Check them out here: [Project_SQL 
Folder](/Project_SQL/)

# Background
Driven by a quest to analyze the data analyst job market more effectively, this project was born from a desire to pin-point top-paid and in-demand skills, streamlining others work to find optimal jobs.

### Curiosity Powered by SQL 
- *Key questions explored through data analysis:*

1. What are the top-paying roles for data analysts?
2. Which skills are required for these high-paying roles?
3. Which skills are most in demand in the data analyst market?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn as a data analyst?

# Tools I used
For my deep dive into the data analyst job market, I harnessed the power of several key tools: 

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git and Github:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
Each query for this project is aimed at investigating specific aspects of the data analyst job market.
Here's how I approached each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying oppurtunities in the field. 

```sql
SELECT
  job_id,
  job_title,
  job_location,
  job_schedule_type,
  salary_year_avg,
  job_posted_date,
  name AS company_name
FROM  
  job_postings_fact
LEFT JOIN 
  company_dim
ON 
  job_postings_fact.company_id = company_dim.company_id
WHERE 
  job_title_short = 'Data Analyst' AND
  job_location = 'Anywhere' AND
  salary_year_avg IS NOT NULL 
ORDER BY
  salary_year_avg DESC
LIMIT 10;
```
Here's the breakdown of the top data analyst jobs:
- **Wide Salary Range:** Top 10 data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.
- **Diverse Employers:** Companies like SmartAsset, Meta and AT&T are among those offering high salaries, showing a broad interest across different industries.
- **Job Title Variety:** There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.

<img src = Assets\top_paying_jobs.png width = 70%>

*Bar graph visualizing the salary for the top 10 salaries for data analysts*

### 2. Skills for Top Paying Jobs

To understand what skills are required for top paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

```sql
WITH top_paying_jobs AS (
  SELECT
    job_id,
    job_title,
    salary_year_avg,
    name AS company_name
  FROM  
    job_postings_fact
  LEFT JOIN 
    company_dim
  ON 
    job_postings_fact.company_id = company_dim.company_id
  WHERE 
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL 
  ORDER BY
    salary_year_avg DESC
  LIMIT 10
)

SELECT 
    skills,
    COUNT(top_paying_jobs.*) AS count_of_skills
FROM
  top_paying_jobs
INNER JOIN
  skills_job_dim
ON
  skills_job_dim.job_id = top_paying_jobs.job_id
INNER JOIN
  skills_dim
ON
  skills_dim.skill_id = skills_job_dim.skill_id
GROUP BY
  skills
ORDER BY
  count_of_skills DESC
```

Here's the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs.
- **SQL** is leading with a bold count of 8.
- **Python** follows closely with a bold count of 7.
- **Tableau** is also highly sought after with a bold count of 6.
- Other skills like **R**, **SnowFlake**, **Pandas** and **Excel** show varying degrees of demand.

<img src = Images\top_paying_data_analyst_skills.png width = 70%>

*Bar graph visualizing the skill frequency for the top 10 data analysts roles*

### 3. In-Demand Skills for Data Analysts

This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```sql
SELECT 
  skills,
  COUNT(skills_job_dim.job_id) AS demand_count
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
  job_work_from_home = TRUE
GROUP BY
  skills
ORDER BY
  demand_count DESC
LIMIT 5
```

Here's the breakdown of the most demanded skills for data analysts 
- **SQL** and **Excel** remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
- **Programming** and **Visualization Tools** like **Python**, **Tableau**, and **Power BI** are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

| Skills   | Demand Count |
|----------|--------------|
| SQL      | 7291         |
| Excel    | 4611         |
| Python   | 4330         |
| Tableau  | 3745         |
| Power BI | 2609         |

*Table of the demand for the top 5 skills in data analyst job postings*

### 4. Skills Based on Salary

Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```sql
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
```

Here's a breakdown of the results for top paying skills for Data Analysts:
- **High Demand for Big Data & ML Skills:** Top salaries are commanded by analysts skilled in big data technologies (PySpark, Couchbase), machine learning tools (DataRobot, Jupyter), and Python libraries (Pandas, NumPy), reflecting the industry's high valuation of data processing and predictive modeling capabilities.
- **Software Development & Deployment Proficiency:** Knowledge in development and deployment tools (GitLab, Kubernetes, Airflow) indicates a lucrative crossover between data analysis and engineering, with a premium on skills that facilitate automation and efficient data pipeline management.
- **Cloud Computing Expertise:** Familiarity with cloud and data engineering tools (Elasticsearch, Databricks, GCP) underscores the growing importance of cloud-based analytics environments, suggesting that cloud proficiency significantly boosts earning potential in data analytics.

| Skills        | Average Salary ($) |
|---------------|-------------------:|
| pyspark       |            208,172 |
| bitbucket     |            189,155 |
| couchbase     |            160,515 |
| watson        |            160,515 |
| datarobot     |            155,486 |
| gitlab        |            154,500 |
| swift         |            153,750 |
| jupyter       |            152,777 |
| pandas        |            151,821 |
| elasticsearch |            145,000 |

*Table of the average salary for the top 10 paying skills for data analysts*

### 5. Most Optimal Skills to Learn

Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```sql
SELECT 
    skills_job_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 2) AS avg_yearly_salary
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
    job_postings_fact.job_title_short = 'Data Analyst' AND
    job_postings_fact.salary_year_avg IS NOT NULL AND
    job_postings_fact.job_work_from_home = TRUE
  GROUP BY
    skills_job_dim.skill_id,
    skills_dim.skills
  HAVING
    COUNT(skills_job_dim.job_id) > 10
  ORDER BY
  avg_yearly_salary DESC,
  demand_count DESC 
LIMIT 25;
```

| Skills     | Demand Count | Average Salary ($) |
|------------|--------------|-------------------:|
| go         |     27       |      115,320       |
| confluence |     11       |      114,210       |
| hadoop     |     22       |      113,193       |
| snowflake  |     37       |      112,948       |
| azure      |     34       |      111,225       |
| bigquery   |     13       |      109,654       |
| aws        |     32       |      108,317       |
| java       |     17       |      106,906       |
| ssis       |     12       |      106,683       |
| jira       |     20       |      104,918       |

*Table of the most optimal skills for data analyst sorted by salary*

Here's a breakdown of the most optimal skills for Data Analysts: 
- **High-Demand Programming Languages:** *Python* and *R* stand out for their high demand, with demand counts of *236* and *148* respectively. Despite their high demand, their **average salaries** are around **$101,397** for *Python* and **$100,499** for *R*, indicating that proficiency in these languages is highly valued but also widely available.
- **Cloud Tools and Technologies:** Skills in specialized technologies such as *Snowflake*, *Azure*, *AWS*, and *BigQuery* show significant demand with **relatively high average salaries**, pointing towards the growing importance of cloud platforms and big data technologies in data analysis.
- **Business Intelligence and Visualization Tools:** *Tableau* and *Looker*, with demand counts of **230** and **49** respectively, and **average salaries** around **$99,288** and **$103,795**, highlight the critical role of data visualization and business intelligence in deriving actionable insights from data.
- **Database Technologies:** The demand for skills in traditional and NoSQL databases (*Oracle*, *SQL Server*, *NoSQL*) with **average salaries** ranging from **$97,786** to **$104,534**, reflects the enduring need for data storage, retrieval, and management expertise.

# What I learned

Through this project, I strengthened my ***SQL skills*** and developed a structured approach to data analysis:

- **Advanced Query Design:** Gained hands-on experience in writing ***complex*** **SQL queries**, including *multi-table joins* and the use of *Common Table Expressions* ***(CTEs)*** to structure intermediate results effectively.

- **Data Aggregation and Summarization:** Applied *GROUP BY* along with *aggregate functions* such as **COUNT()** and **AVG()** to derive meaningful summaries from large datasets.

- **Analytical Problem-Solving:** Improved my ability to translate **business questions** into *precise* **SQL queries** and extract actionable insights from data.

# Conclusions

### Insights

From the analysis, the following key insights emerged:

1. **Top-Paying Data Analyst Jobs:** *Remote data analyst* roles exhibit a wide salary range, with top positions offering exceptionally high compensation, highlighting the strong earning potential within the field.

2. **Skills Required for Top-Paying Roles:** Advanced proficiency in *SQL* is consistently required for **high-paying data analyst** positions, underscoring its role as a core technical skill for top-tier roles.

3. **Most In-Demand Skills:** SQL remains the most frequently requested skill across data analyst job postings, confirming its fundamental importance in the job market.

4. **Skills Associated with Higher Salaries:** Specialized technical skills—particularly those related to *big data*, *cloud platforms*, and advanced analytics — are associated with **higher average salaries**, indicating a premium placed on niche and high-impact expertise.

5. **Most Optimal Skills to Learn:** Skills that balance *strong demand* with *high average salaries*, such as SQL and select cloud and data engineering tools, emerge as the most strategic areas for skill development.

### Closing Thoughts

This project strengthened my ability to apply SQL to *real-world labor market data* while uncovering meaningful trends in skill demand and compensation. The insights derived from this analysis provide practical guidance for prioritizing skill development and making informed career decisions. By focusing on high-demand and high-value skills, aspiring data analysts can position themselves more competitively in an evolving and increasingly technical job market.