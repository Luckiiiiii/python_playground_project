SQL Question 1: Compute Total Monthly Revenue per Product
Imagine you work at EPAM Systems and you are given a task where you have to analyze the company's monthly revenue for each product. ' ||
'The company has a sales database that logs every single sale transaction. Write a SQL query to calculate the total monthly revenue for each product.
' ||
'' ||
'create
sales Example Input:
sale_id	sale_date	product_id	unit_price	quantity
10	06/01/2020	1	100	5
20	06/02/2020	2	50	10
30	06/15/2020	1	100	15
40	07/01/2020	1	100	10
50	07/20/2020	2	50	20
Example Output:
month	product_id	total_revenue
6	1	2000
6	2	500
7	1	1000
7	2	1000
Answer:
SELECT
    EXTRACT(MONTH FROM sale_date) AS month,
    product_id,
    SUM(unit_price * quantity) as total_revenue
FROM
    sales
GROUP BY
    EXTRACT(MONTH FROM sale_date), product_id
ORDER BY
    month, product_id;
This query uses the window function SUM() to sum up all sales revenues per product (calculated as unit_price * quantity) per month, by grouping on the sale_date month and the product_id. EXTRACT(MONTH FROM sale_date) is used to extract the month part of the sale_date.

p.s. Window functions show up super frequently during SQL interviews, so practice the 27+ window function questions on DataLemur

SQL Interview Questions on DataLemur

SQL Question 2: Database Design for Employee Time Tracking
As an analyst in EPAM Systems, you are tasked to design and optimize a database for tracking employee working hours. The database should hold information about the employees, their daily check-in and check-out times, and their assigned projects. In addition, a query should be available to compute the total hours logged by each employee per project per month.

An important consideration while designing this system is the capability to process hundreds of check-in and check-out events per day, filter events for specific periods, as well as accommodate addition/modification of employee records and project assignments.

For this task, consider following tables: employees, projects, and time_logs

employees Example Input:
employee_id	first_name	last_name	position
123	John	Doe	Software Engineer
456	Jane	Smith	Quality Assurance Engineer
789	James	Brown	Project Manager
projects Example Input:
project_id	project_name	start_date	end_date
1000	Project Alpha	05/01/2022 00:00:00	07/01/2022 00:00:00
2000	Project Beta	06/15/2022 00:00:00	08/15/2022 00:00:00
3000	Project Gamma	08/01/2022 00:00:00	10/01/2022 00:00:00
time_logs Example Input:
log_id	employee_id	project_id	log_date	start_time	end_time
500	123	1000	06/21/2022 00:00:00	09:00:00	17:00:00
600	456	2000	06/22/2022 00:00:00	10:00:00	19:00:00
700	789	3000	08/03/2022 00:00:00	08:00:00	16:00:00
800	123	2000	06/23/2022 00:00:00	09:30:00	18:30:00
900	123	1000	06/24/2022 00:00:00	09:15:00	18:00:00
Answer:
SELECT e.employee_id, e.first_name, e.last_name,
       p.project_id, p.project_name,
       DATE_PART('month', t.log_date) AS log_month,
       SUM(EXTRACT(hour FROM t.end_time) - EXTRACT(hour FROM t.start_time)) AS total_hours
FROM employees e
JOIN time_logs t ON e.employee_id = t.employee_id
JOIN projects p ON t.project_id = p.project_id
GROUP BY e.employee_id, p.project_id, log_month
ORDER BY e.employee_id, p.project_id, log_month;
This query joins the employees,time_logs, and projects tables using employee_id and project_id, respectively. It then groups the results by employee_id, project_id, and log_month, computing the total hours worked by each employee for each project monthly. The extracted 'hour' from start_time and end_time calculates the difference in hours. The DATE_PART function in Postgres allows to extract the month from log_date. The GROUP BY clause ensures the total hours are calculated separately for each employee and each project every month.

SQL Question 3: Can you describe the meaning of a constraint in SQL in layman's terms?
Think of SQL constraints like the rules of a game. Just like a game needs rules to keep things fair and fun, a database needs constraints to keep things organized and accurate.

There are several types of SQL constraints like:

NOT NULL: This constraint is like a bouncer at a nightclub - it won't let anything NULL through the door. UNIQUE: This constraint is like a VIP list - only special, one-of-a-kind values get in. PRIMARY KEY: This constraint is like an elected official - it's made up of NOT NULL and UNIQUE values and helps identify each row in the table. FOREIGN KEY: This constraint is like a diplomatic ambassador - it helps establish relationships between tables. CHECK: This constraint is like a referee - it makes sure everything follows the rules. DEFAULT: This constraint is like a backup plan - it provides a default value if no other value is specified.

So, whether you're playing a game or organizing a database, constraints are an important part of the process!

EPAM Systems SQL Interview Questions

SQL Question 4: Filter Customers Based on Purchase History and Location
EPAM Systems has a wide range of customers. For an upcoming marketing campaign, they are interested in identifying customers living in New York (NY) who have purchased products worth more than 1000 USD in total and whose last purchase was not a 'Laptop'. You are given two tables, customers and purchases.

The customers table has the following fields:

customer_id: An identification number for the customer
first_name: The first name of the customer
last_name: The last name of the customer
city: The city where the customer lives
state: The state where the customer lives
The purchases table has the following fields:

purchase_id: An identification number for the purchase
customer_id: The identification number of the customer who made the purchase
product: The product that was purchased
price: The price of the product at the time of purchase
purchase_date: The date when the purchase was made
customers Example Input:
customer_id	first_name	last_name	city	state
1	John	Doe	New York	NY
2	Jane	Smith	Los Angeles	CA
3	Sam	Brown	New York	NY
4	Alice	Johnson	New York	NY
purchases Example Input:
purchase_id	customer_id	product	price	purchase_date
50001	1	Laptop	1200	06/08/2022
69852	2	Monitor	200	06/10/2022
50001	3	Laptop	1200	06/18/2022
69852	4	Keyboard	100	07/26/2022
69852	1	Mouse	50	07/05/2022
Answer:
SELECT c.customer_id, c.first_name, c.last_name
FROM customers c
JOIN (
    SELECT p.customer_id, SUM(p.price) total_spent,
    ROW_NUMBER() OVER (PARTITION BY p.customer_id ORDER BY p.purchase_date DESC) rn
    FROM purchases p
    GROUP BY p.customer_id
) pur ON c.customer_id = pur.customer_id
	AND pur.total_spent > 1000
	AND pur.rn = 1
	AND pur.product != 'Laptop'
WHERE c.state = 'NY'
This query first joins the customers table with a subquery of the purchases table. The subquery calculates the total amount spent by each customer and identifies the most recent product purchased by each customer. The ROW_NUMBER() function is used to rank purchases for each customer by purchase_date in descending order (most recent purchase first). We filter out the customers who have a total spent more than 1000. The last conditions in the join ensure that only customers from 'NY' who did not purchase 'Laptop' as their last product are selected.

SQL Question 5: Why would you use the CHECK SQL constraint?
The CHECK constraint is used to specify a condition that the data in a column must meet. If a row is inserted or updated and the data in the column doesn't meet the condition specified by the CHECK constraint, the operation will sadly fail.

For example, you might use a CHECK constraint to ensure that a column contains only positive numbers, or that a date is within a certain range.

For example, if you had a table of EPAM Systems employees, here's an example of how to use the CHECK constraint in a CREATE TABLE statement:

CREATE TABLE epam_systems_employees (
  id INT PRIMARY KEY,
  salary INT CHECK (salary > 0),
  hire_date DATE CHECK (hire_date >= '
1970-01-01
')
);
SQL Question 6: Calculate the average bug resolution time
In EPAM Systems, a software consulting and product development company, bug resolution is of utmost importance. As a staff member of the software testing team, you are asked to write a SQL query to find the average time (in days) it takes to resolve bugs.

The database has a table called "bugs" which contains the following columns: bug_id (ID of the bug), creation_date (date when the bug was raised), resolution_date (date when the bug was resolved), project_id (id of the project the bug belongs to).

bugs Example Input:
bug_id	creation_date	resolution_date	project_id
101	2022-01-01	2022-01-03	1
102	2022-01-05	2022-01-09	1
103	2022-02-01	2022-02-05	2
104	2022-02-10	2022-02-15	2
105	2022-03-01	2022-03-05	1
We need to find the average resolution time for each project.

Example Output:
project_id	average_resolution_days
1	3
2	5
Answer:
SELECT
    project_id,
    AVG(EXTRACT(DAY FROM (resolution_date - creation_date))) AS average_resolution_days
FROM
    bugs
GROUP BY
    project_id;
This query first calculates the difference in days between the resolution date and creation date for each bug, then it takes the average of these differences grouped by the project id. The EXTRACT function is used to get the number of days from the date interval. The result is the average bug resolution time for each project.

To practice a very similar question try this interactive Google Median Google Search Frequency Question which is similar for calculating average with date components or this Facebook Average Post Hiatus (Part 1) Question which is similar for calculating difference between dates.

SQL Question 7: What is the difference between SQL operators ‘BETWEEN’ and ‘IN’?
While both the BETWEEN and IN operators are used to filter data based on some criteria, BETWEEN selects for values within a given range, whereas for IN it checks if the value is in a given list of values.

For example, say you had a table called epam_systems_employees, which had the salary of the employee, along with the country in which they reside.

To find all employees who made between
80
k
a
n
d
80kand120k, you could use the BETWEEN operator:

SELECT *
FROM epam_systems_employees
WHERE salary BETWEEN 80000 AND 120000;
To find all employees that reside in the US or Canada, you could use the IN operator:

SELECT *
FROM epam_systems_employees
WHERE country IN ("USA", "Canada");
SQL Question 8: Click-Through-Rate for EPAM Systems
We have two tables - ad_clicks and purchases. The ad_clicks table records every time a customer clicks on an advertisement. The purchases table tracks every time a product has been added to the cart after viewing an advertisement.

Calculate the click-through conversion rate, which is the number of click events that resulted in a purchase, divided by the total number of click events, expressed as a percentage.

ad_clicks Example Input:
click_id	user_id	click_date	product_id
0001	123	06/01/2022	587
0002	265	06/02/2022	724
0003	182	06/02/2022	587
0004	265	06/03/2022	724
0005	178	06/04/2022	587
purchases Example Input:
purchase_id	user_id	purchase_date	product_id
560	182	06/02/2022	587
589	265	06/03/2022	724
721	262	06/05/2022	724
Answer:
SELECT
ROUND(
    (SELECT COUNT(*) FROM purchases WHERE purchases.product_id = ad_clicks.product_id AND purchases.user_id = ad_clicks.user_id)::DECIMAL
    / (SELECT COUNT(*) FROM ad_clicks)::DECIMAL
    * 100, 2) AS clk_through_conv_rate
FROM ad_clicks;
Here, we're calculating the click-through conversion rate by dividing the count of purchase events after an add click for the same product by the user by the total number of click events, and then expressing the result as a percentage.

To solve a similar problem about calculating rates, try this TikTok SQL question within DataLemur's online SQL coding environment:TikTok SQL question

SQL Question 9: Highest Paid Project in each Month
EPAM Systems is a globally recognized provider of software engineering and IT consulting services. They work with clients from different sectors and handle multiple projects at any given time.

Assume you are given a database with information about all the ongoing projects worked on each month. The database tracks the project's ID, the client's name, the first date the project was worked on (start_date), the last date it was worked on (finish_date), and the total cost charged to clients ('price'). You need to write a SQL query to find the project with the highest fee for each month in the year 2022.

projects Example Input:
project_id	client_name	start_date	finish_date	price
101	Walmart	01/05/2022 00:00:00	01/22/2022 00:00:00	70000
102	Microsoft	01/15/2022 00:00:00	02/10/2022 00:00:00	120000
103	Google	02/10/2022 00:00:00	02/25/2022 00:00:00	130000
104	Walmart	03/02/2022 00:00:00	04/01/2022 00:00:00	150000
105	Microsoft	03/20/2022 00:00:00	04/15/2022 00:00:00	160000
Example Output:
month	project_id	client_name	price
1	102	Microsoft	120000
2	103	Google	130000
3	105	Microsoft	160000
Answer:
SELECT
    DATE_PART('month', start_date) AS month,
    project_id,
    client_name,
    price
FROM
    (
    SELECT
        project_id,
        client_name,
        start_date,
        price,
        ROW_NUMBER() OVER (PARTITION BY DATE_PART('month', start_date) ORDER BY price DESC) rn
    FROM
        projects
    WHERE
        start_date >= '
2022-01-01
' AND start_date < '2023-01-01
'
    ) t
WHERE
    rn = 1
ORDER BY
    month;
This PostgreSQL query uses the ROW_NUMBER() function to assign a unique row number to each row. The row number is reset for each month, based on the start_date of the project (extracted using DATE_PART). Projects are ordered in descending order of price inside each month. The outer query then filters for the first row in each month, i.e., the one with the highest price.

SQL Question 10: What does the SQL command INTERSECT do?
When using INTERSECT, only rows that are identical in both sets will be returned.

For a concrete example, say you were a Data Analyst supporting the Sales Analytics team at EPAM Systems, and data on potential sales leads lived in both Salesforce and Hubspot CRMs. To write a query to analyze leads created before 2023 started, that show up in BOTH CRMs, you would use the INTERSECT command:

SELECT email, job_title, company_id
FROM epam_systems_sfdc_leads
WHERE created_at < '2023-01-01
';

INTERSECT

SELECT email, job_title, company_id
FROM epam_systems_hubspot_leads
WHERE created_at < '2023-01-01'
How To Prepare for the EPAM Systems SQL Interview
The best way to prepare for a EPAM Systems SQL interview is to practice, practice, practice. Beyond just solving the earlier EPAM Systems SQL interview questions, you should also solve the 200+ tricky sql questions on DataLemur which come from companies like Facebook, Google, and VC-backed startups.