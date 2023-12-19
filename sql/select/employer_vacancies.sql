-- Select all vacancies of the employer
SELECT vacancy_id, title, created_at, status_name
FROM vacancies
         JOIN status ON status.status_id = vacancies.status_id
         JOIN employer ON employer.employer_id = vacancies.employer_id
WHERE user_id = (SELECT user_id FROM users WHERE email = $user_email);
