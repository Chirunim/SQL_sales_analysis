CREATE DATABASE CustomerData;
USE CustomerData;

CREATE TABLE CustomerPayments (
    ReferenceNo VARCHAR(20) PRIMARY KEY,
    Payment_Amount DECIMAL(10,2),
    Payment_Frequency INT,
    Days_Overdue INT,
    Account_Balance DECIMAL(10,2),
    CustomerAge VARCHAR(20),
    IncomeLevel VARCHAR(20),
    CustomerPreference VARCHAR(20)
);

USE CustomerData;
SELECT * FROM CustomerPayments;

-- ON-TIME VS LATE-PAYMENTS
SELECT 
    CASE 
        WHEN Days_Overdue BETWEEN 0 AND 7 THEN 'On-Time'
        WHEN Days_Overdue BETWEEN 8 AND 18 THEN 'Slightly Late'
        ELSE 'Late'
    END AS Payment_Status,
    COUNT(*) AS Total_Customers
FROM CustomerPayments
GROUP BY Payment_Status;

-- PAYMENT AMOUNT BY METHOD
SELECT 
    CustomerPreference AS Payment_Method,
    COUNT(*) AS Total_Transactions,
    SUM(Payment_Amount) AS Total_Amount,
    AVG(Payment_Amount) AS Avg_Amount
FROM CustomerPayments
GROUP BY Payment_Method;

-- ACCOUNT BALANCE VS SEGMENTS
SELECT 
    CustomerAge,
    AVG(Account_Balance) AS Avg_Balance,
    MAX(Account_Balance) AS Max_Balance,
    MIN(Account_Balance) AS Min_Balance
FROM CustomerPayments
GROUP BY CustomerAge;

--  Account Balance Distribution by Segment
SELECT 
    CASE 
        WHEN Account_Balance < 800 THEN 'Low Balance' 
        WHEN Account_Balance BETWEEN 801 AND 2500 THEN 'Medium Balance' 
        ELSE 'High Balance'
    END AS Balance_Segment,
    COUNT(*) AS Customer_Count
FROM CustomerPayments
GROUP BY Balance_Segment;

-- Effect on Age on Customer Payments
SELECT 
    CASE 
        WHEN CAST(CustomerAge AS UNSIGNED) BETWEEN 18 AND 25 THEN '18-25'
        WHEN CAST(CustomerAge AS UNSIGNED) BETWEEN 26 AND 35 THEN '26-35'
        WHEN CAST(CustomerAge AS UNSIGNED) BETWEEN 36 AND 45 THEN '36-45'
        WHEN CAST(CustomerAge AS UNSIGNED) BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+'
    END AS Age_Group,
    COUNT(*) AS Total_Customers,
    ROUND(AVG(Days_Overdue), 2) AS Avg_Days_Overdue
FROM CustomerPayments
WHERE CustomerAge REGEXP '^[0-9]+$'  -- ensures only numeric age values are considered
GROUP BY Age_Group
ORDER BY Age_Group;


-- 
SELECT 
  ROUND(AVG(Payment_Amount), 2) AS MeanPayment,
  ROUND(STDDEV(Payment_Amount), 2) AS StdDevPayment
FROM CustomerPayments;







