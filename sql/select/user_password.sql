-- Select user password
SELECT user_id FROM users
WHERE email = 'user_email' AND password = crypt('user_password', password);