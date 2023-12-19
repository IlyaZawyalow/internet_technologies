-- Select areas where the employer has active vacancies
SELECT DISTINCT area_id
FROM vacancies
WHERE employer_id =
      (SELECT employer_id FROM employer WHERE user_id = (SELECT user_id FROM users WHERE email = $user_email))
  AND status_id = 2;