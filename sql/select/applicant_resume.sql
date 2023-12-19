-- list of the applicant's resume
SELECT resume_id
FROM resume
WHERE applicant_id = (SELECT user_id FROM users WHERE email = $email);