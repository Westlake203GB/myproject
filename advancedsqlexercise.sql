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