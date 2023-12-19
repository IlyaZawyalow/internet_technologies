-- Select vacancies
SELECT vacancy_id, title, salary_from, salary_to, salary_currency, salary_gross, created_at, company_name, experience_type_name
FROM vacancies
JOIN employer ON employer.employer_id = vacancies.employer_id
JOIN experience_type ON experience_type.experience_type_id = vacancies.experience_type_id
WHERE area_id = $area_id AND role_id = $role_id AND status_id = 2;