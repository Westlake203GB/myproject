--List all users along with their session information 

SELECT 
    u.user_id,
    u.user_username,
    u.user_email,
    s.ses_token,
    s.ses_createdat as session_created_at,
    s.ses_expiresat
FROM users u
LEFT JOIN sessions s ON u.user_id = s.user_id
ORDER BY u.user_id, s.ses_createdat DESC;




-- Show all users with their sessions including those without sessions. Use NVL to show 'N/A' for missing tokens

SELECT 
    u.user_id,
    u.user_firstname,
    u.user_lastname,
    u.user_username,
    u.user_email,
    NVL(s.ses_token, 'N/A') AS session_token
FROM 
    users u
LEFT JOIN 
    sessions s ON u.user_id = s.user_id
ORDER BY 
    u.user_id, s.ses_createdat DESC;




-- Show all users with their sessions including those without sessions. Use COALESCE to show 'N/A' for missing tokens
SELECT 
    u.user_id,
    u.user_firstname,
    u.user_lastname,
    u.user_username,
    u.user_email,
    COALESCE(s.ses_token, 'N/A') AS session_token,
    s.ses_createdat,
    s.ses_expiresat,
    s.ses_eventtype,
    s.ses_caller_ip
FROM 
    users u
LEFT JOIN 
    sessions s ON u.user_id = s.user_id
ORDER BY 
    u.user_id, s.ses_createdat DESC;


-- List all users and their accounts, including users without accounts

SELECT 
    u.user_id,
    u.user_firstname,
    u.user_lastname,
    u.user_username,
    u.user_email,
    u.user_role,
    a.acc_id,
    a.acc_startdate,
    a.acc_isactive AS account_active,
    a.reg_id,
    a.type_id
FROM 
    users u
RIGHT OUTER JOIN 
    accounts a ON u.user_id = a.user_id
ORDER BY 
    u.user_id, a.acc_startdate DESC;


--List accounts with their type and addresses, keeping accounts even if no address exists

SELECT 
    a.acc_id,
    a.acc_startdate,
    a.acc_isactive,
    a.reg_id AS account_region_id,
    a.user_id,
    at.type_name AS account_type,
    at.type_description AS account_type_description,
    addr.add_id,
    addr.add_street,
    addr.add_city,
    addr.add_postalcode,
    addr.reg_id AS address_region_id
FROM 
    accounts a
INNER JOIN 
    account_type at ON a.type_id = at.type_id
LEFT JOIN 
    addresses addr ON a.acc_id = addr.acc_id
ORDER BY 
    a.acc_id, addr.add_id;


