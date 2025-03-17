-- SQL Queries for Security Analysis

-- 1. View first 10 rows
SELECT * FROM login_attempts LIMIT 10;

-- 2. Count total login attempts
SELECT COUNT(*) AS total_attempts FROM login_attempts;

-- 3. Identify users with excessive failed logins
SELECT User_ID, COUNT(*) AS failed_attempts
FROM login_attempts
WHERE Status = 'Failed'
GROUP BY User_ID
HAVING COUNT(*) > 5
ORDER BY failed_attempts DESC;

-- 4. Find logins from multiple locations (potential compromise)
SELECT User_ID, COUNT(DISTINCT Location) AS location_count
FROM login_attempts
GROUP BY User_ID
HAVING COUNT(DISTINCT Location) > 1;

-- 5. Block suspicious IP addresses
INSERT INTO blocked_ips (IP_Address)
SELECT DISTINCT IP_Address FROM login_attempts
WHERE Status = 'Failed'
GROUP BY IP_Address
HAVING COUNT(*) > 20;
