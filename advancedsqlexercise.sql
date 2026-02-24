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