-- Select information about the employer
SELECT employer_id, company_name, company_description, company_documents, logo_img, email
FROM employer
JOIN users ON users.user_id = employer.user_id
WHERE email = $user_email;