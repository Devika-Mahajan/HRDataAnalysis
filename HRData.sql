Use HRAnalytics

-- Identifying the Highest Attrition Departments with Low Job Satisfaction

Select 
Count(*) As Total_Attrition,
Department
From hranalytics
Where JobSatisfaction <= 2 and Attrition = 'YES'
Group by
Department
Order by Total_Attrition DESC

-- Question: How does work-life balance impact performance ratings across different job roles?

Select 
JobRole,
WorkLifeBalance,
PerformanceRating,
Count(*) as Total_Count
From hranalytics
Group by WorkLifeBalance,
PerformanceRating,
JobRole
Order by WorkLifeBalance DESC,
PerformanceRating DESC

--  Who are the longest-tenured employees who worked overtime and eventually left the company?

Select 
EmpID,
YearsAtCompany
From hranalytics
Where OverTime = 'Yes' and Attrition = 'Yes'
Order by YearsAtCompany Desc

-- Does frequent business travel contribute to higher attrition rates?

SELECT BusinessTravel, COUNT(EmpID) AS TotalEmployees, 
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount,
       (SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(EmpID)) AS AttritionRate
FROM hranalytics
GROUP BY BusinessTravel
ORDER BY AttritionRate DESC

-- Analyzing Departmental Productivity Based on Overtime and Monthly Income

SELECT Department, OverTime, AVG(MonthlyIncome) AS AvgMonthlyIncome, COUNT(EmpID) AS TotalEmployees
FROM hranalytics
GROUP BY Department, OverTime
HAVING COUNT(EmpID) > 10
ORDER BY AvgMonthlyIncome DESC

-- Impact of Education Field and Job Level on Attrition

Select 
EducationField,
JobLevel,
Count(EmpID) Total_Emp,
SUM(Case When Attrition = 'Yes' Then 1 Else 0 End) Total_Attrition,
(SUM(Case When Attrition = 'Yes' Then 1 Else 0 End) * 100 / Count(EmpID)) as Attrition_Rate
FROM hranalytics
Group by EducationField, JobLevel
Order by Attrition_Rate Desc, JobLevel DESC

--  Effect of Stock Options on Employee Retention

SELECT
Count(EmpID) as total_Employee,
StockOptionLevel,
SUM(Case When Attrition = 'No' Then 1 Else 0 End) Total_Emp_Retention,
(SUM(Case When Attrition = 'No' Then 1 Else 0 End) * 100 / Count(EmpID)) as Emp_Retention_Rate
FROM hranalytics
Group by StockOptionLevel
Order by Emp_Retention_Rate DESC


-- Correlating Years with Current Manager and Job Satisfaction
/*(Is there a correlation between the number of years employees spend 
with their current manager and their job satisfaction?)*/

SELECT* FROM hranalytics

SELECT
YearsWithCurrManager,
AVG(JobSatisfaction) AS AvgJobSatisfaction,
Count(EmpID) Total_EMP
FROM hranalytics 
Group by YearsWithCurrManager,
JobSatisfaction
Order by AvgJobSatisfaction DESC

-- High Performers with Low Work-Life Balance
/* How many high performers (performance rating = 4) struggle 
with low work-life balance (work-life balance < 2 ) */

Select
Count(EmpID) Total_EMP,
PerformanceRating,
WorkLifeBalance
FROM hranalytics 
Where PerformanceRating = 4 
Group by PerformanceRating,
WorkLifeBalance


-- Relationship Satisfaction and Employee Performance
/* Is there a relationship between employee relationship 
satisfaction and their performance ratings?
 */
 
SELECT
	RelationshipSatisfaction,
	PerformanceRating,
    Count(EmpID) Total_EMP
FROM hranalytics 
Group by RelationshipSatisfaction,
		 PerformanceRating
Order By PerformanceRating DESC

--  Work-Life Balance vs. Monthly Income by Gender
/* How does work-life balance vary with monthly income across different genders?
 */
 
SELECT
Gender,
WorkLifeBalance,
AVG(MonthlyIncome) as AVG_MI,
Count(EmpID) as  Total_EMP
FROM hranalytics 
Group by Gender, WorkLifeBalance
Order by Gender, WorkLifeBalance Desc, AVG_MI Desc

SELECT Gender, AVG(WorkLifeBalance) AS AvgWorkLifeBalance, AVG(MonthlyIncome) AS AvgMonthlyIncome, COUNT(EmpID) AS TotalEmployees
FROM hranalytics
GROUP BY Gender
HAVING COUNT(EmpID) > 5
ORDER BY AvgMonthlyIncome DESC

