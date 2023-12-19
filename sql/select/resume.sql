-- Select resume
SELECT resume_id, title, salary, salary_currency, first_name, last_name, age, total_experience
FROM resume
JOIN users ON users.user_id = resume.applicant_id
WHERE area_id = $area_id AND role_id = $role_id AND status_id = 2;