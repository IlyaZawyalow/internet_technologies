-- Select all responses to the vacancy
SELECT response_id,
       resume.resume_id,
       title,
       response.created_at,
       salary,
       salary_currency,
       photo,
       total_experience,
       email,
       phone,
       first_name,
       last_name
FROM response
         JOIN resume ON resume.resume_id = response.resume_id
         JOIN users ON users.user_id = resume.applicant_id
WHERE vacancy_id = $vacancy_id;