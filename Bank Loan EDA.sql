SELECT * FROM bank_loan_data

--Total Loan Applications
SELECT COUNT(id) as Total_Loan_Applications 
FROM bank_loan_data

--MTD LOAN APPLICATIONS
SELECT COUNT(id) as MTD_Total_Loan_Applications 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

--PMTD LOAN APPLICATIONS
SELECT COUNT(id) as PMTD_Total_Loan_Applications 
FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

--TOTAL FUNDED AMOUNT
SELECT SUM(loan_amount) as Total_Funded_Amount 
FROM bank_loan_data

--MTD LOAN FUNDED AMOUNT
SELECT SUM(loan_amount) as MTD_Total_Funded_Amount 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

--PMTD LOAN FUNDED AMOUNT
SELECT SUM(loan_amount) as PMTD_Total_Funded_Amount 
FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

--TOTAL RECEIVED AMOUNT
SELECT SUM(total_payment) as Total_Amount_Received
FROM bank_loan_data

--MTD TOTAL AMOUNT RECEIVED
SELECT SUM(total_payment) as MTD_TOTAL_AMOUNT_RECEIVED
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

--PMTD LOAN FUNDED AMOUNT
SELECT SUM(total_payment) as PMTD_TOTAL_AMOUNT_RECEIVED 
FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

--AVERAGE INTEREST RATE
SELECT ROUND(AVG(int_rate),4) * 100 as Avg_Interest_Rate 
FROM bank_loan_data

-- MTD AVERAGE INTEREST RATE
SELECT ROUND(AVG(int_rate),4) * 100 as MTD_Avg_Interest_Rate 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- PMTD AVERAGE INTEREST RATE
SELECT ROUND(AVG(int_rate),4) * 100 as PMTD_Avg_Interest_Rate 
FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

--AVERAGE DTI
SELECT ROUND(AVG(dti),4) * 100 AS Avg_DTI 
FROM bank_loan_data

--MTD_Avg_DTI
SELECT ROUND(AVG(dti),4) * 100 AS MTD_Avg_DTI 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

--PMTD_Avg_DTI
SELECT ROUND(AVG(dti),4) * 100 AS PMTD_Avg_DTI 
FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

--Good Loan Percentage
SELECT 
	(COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100)
	/
	COUNT(id) AS Good_Loan_Percentage
FROM bank_loan_data

--Good Loan Application
SELECT COUNT(id) AS Good_Loan_Application
FROM bank_loan_data 
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

--GOOD LOAN FUNDED AMOUNT
SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount
FROM bank_loan_data 
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

--GOOD LOAN TOTAL AMOUNT RECEIVED
SELECT SUM(total_payment) AS GOOD_LOAN_TOTAL_AMOUNT_RECEIVED
FROM bank_loan_data 
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

--BAD LOAN PERCENTAGE
SELECT 
	(COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0)/
	COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data

--Bad Loan Application
SELECT COUNT(id) AS Bad_Loan_Application
FROM bank_loan_data 
WHERE loan_status = 'Charged Off'

--Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amount
FROM bank_loan_data 
WHERE loan_status = 'Charged Off'

--BAD LOAN TOTAL AMOUNT RECEIVED
SELECT SUM(total_payment) AS BAD_LOAN_TOTAL_AMOUNT_RECEIVED
FROM bank_loan_data 
WHERE loan_status = 'Charged Off'

--Loan Status Grid
SELECT
	loan_status,
	COUNT(id) as Loan_Count,
	SUM(total_payment) AS Total_Amount_Received,
	SUM(loan_amount) AS Total_Funded_Amount,
	AVG(int_rate * 100) AS Interest_Rate,
	AVG(dti * 100) AS DTI
FROM
	bank_loan_data
Group BY
	loan_status

--Loan status for December Month
SELECT 
	loan_status,
	SUM(total_payment) AS MTD_Total_Amount_Received,
	SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM bank_loan_data
WHERE MONTH(issue_date) = 12
GROUP BY loan_status

--Monthly Loan status
SELECT
	MONTH(issue_date) AS Month_Number,
	DATENAME(MONTH,issue_date) AS Month_Name,
	COUNT(id) AS Total_Loan_Applications,
	SUM(total_payment) AS Total_Amount_Received,
	SUM(loan_amount) AS Total_Funded_Amount
FROM
	bank_loan_data
GROUP BY MONTH(issue_date),DATENAME(MONTH,issue_date)
ORDER BY MONTH(issue_date)

-- LOAN STATUS GRID USING address_state
SELECT
	address_state,
	COUNT(id) as Total_Loan_Applications,
	SUM(total_payment) AS Total_Amount_Received,
	SUM(loan_amount) AS Total_Funded_Amount
FROM bank_loan_data
Group BY address_state
Order BY SUM(loan_amount) DESC

--Loan Status Grid using emp_length
SELECT
	emp_length,
	COUNT(id) as Total_Loan_Applications,
	SUM(total_payment) AS Total_Amount_Received,
	SUM(loan_amount) AS Total_Funded_Amount
FROM bank_loan_data
Group BY emp_length
Order BY emp_length

-- Loan Status WRT purpose
SELECT
	purpose,
	COUNT(id) as Total_Loan_Applications,
	SUM(total_payment) AS Total_Amount_Received,
	SUM(loan_amount) AS Total_Funded_Amount
FROM bank_loan_data
Group BY purpose
Order BY COUNT(id) DESC

--Loan Status WRT Home_Ownership
SELECT
	home_ownership,
	COUNT(id) as Total_Loan_Applications,
	SUM(total_payment) AS Total_Amount_Received,
	SUM(loan_amount) AS Total_Funded_Amount
FROM bank_loan_data
Group BY home_ownership
Order BY COUNT(id) DESC

--Loan staus WRT home ownership for grade 'A' AND address_state 'CA'
SELECT
	home_ownership,
	COUNT(id) as Total_Loan_Applications,
	SUM(total_payment) AS Total_Amount_Received,
	SUM(loan_amount) AS Total_Funded_Amount
FROM bank_loan_data
WHERE grade = 'A' AND address_state = 'CA'
Group BY home_ownership
Order BY COUNT(id) DESC
