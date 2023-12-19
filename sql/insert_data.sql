INSERT INTO areas (area_id, area_name)
VALUES (1, 'Москва'),
       (2, 'Санкт-Петербург'),
       (3, 'Томск'),
       (4, 'Омск');
INSERT INTO professional_roles (role_id, role_name)
VALUES (1, 'Маркетолог'),
       (2, 'Программист'),
       (3, 'Бариста'),
       (4, 'Аналитик');
INSERT INTO status (status_id, status_name)
VALUES (1, 'not_published'),
       (2, 'published'),
       (3, 'blocked'),
       (4, 'on_moderation'),
	   (5, 'after_moderation');
INSERT INTO schedule (schedule_id, schedule_name)
VALUES (1, 'Полный день'),
       (2, 'Удаленная работа'),
       (3, 'Сменный график'),
       (4, 'Гибкий график'),
	   (5, 'Вахтовый метод');
INSERT INTO employment (employment_id, employment_name)
VALUES (1, 'Полная занятость'),
       (2, 'Стажировка'),
       (3, 'Частичная занятость'),
       (4, 'Проектная работа'),
	   (5, 'Волонтерство');
INSERT INTO education_type (education_type_id, education_type_name)
VALUES (1, 'Среднее'),
       (2, 'Среднее специальное'),
       (3, 'Неоконченное высшее'),
       (4, 'Высшее'),
	   (5, 'Бакалавр'),
	   (6, 'Магистр'),
	   (7, 'Кандидат наук'),
	   (8, 'Доктор наук'),
	   (9, 'Среднее профессиональное'),
	   (10, 'Высшее'),
	   (11, 'Не требуется');
INSERT INTO experience_type (experience_type_id, experience_type_name)
VALUES (1, 'Нет опыта'),
       (2, 'От 1 года до 3 лет'),
       (3, 'От 3 до 6 лет'),
       (4, 'Более 6 лет');
INSERT INTO response_status (response_status_id, response_status_name)
VALUES (1, 'Не просмотрен'),
       (2, 'Просмотрен'),
       (3, 'Отказ'),
       (4, 'Приглашение');

INSERT INTO users (email, password, is_employer)
VALUES ('ivanov@org.org', crypt('aaAA00__', gen_salt('bf')), False),
       ('petrov@org.org', crypt('bbBB11', gen_salt('bf')), False),
       ('sergeev@org.org', crypt('ccCC22', gen_salt('bf')), False),
       ('vitaliev@org.org', crypt('ddDD33', gen_salt('bf')), False),
	   ('regsolution@org.org', crypt('bbBB11', gen_salt('bf')), True),
	   ('extremedevelopers@org.org', crypt('ccCC22', gen_salt('bf')), True),
	   ('smart_tec.com', crypt('cuuuuks22', gen_salt('bf')), True),
	   ('arba@org.org', crypt('ddDD33', gen_salt('bf')), True);

INSERT INTO resume (title, salary, salary_currency, applicant_id, role_id, area_id, age, gender_is_male, can_publish)
VALUES ('title1', 80000, 'RUR', (SELECT user_id FROM users WHERE email='ivanov@org.org'), 1, 1, 22, True, False),
       ('title2', 50000, 'RUR', (SELECT user_id FROM users WHERE email='petrov@org.org'), 2, 3, 23, True, True),
       ('title3', 75000, 'RUR', (SELECT user_id FROM users WHERE email='sergeev@org.org'), 3, 2, 31, True, True),
       ('title4', 35000, 'RUR', (SELECT user_id FROM users WHERE email='vitaliev@org.org'), 4, 4, 29, True, True);
INSERT INTO education (education_institution_name, education_type_id, resume_id)
VALUES ('СПбПУ', 5, (SELECT resume_id FROM resume WHERE title = 'title1' AND applicant_id = (SELECT user_id FROM users WHERE email='ivanov@org.org'))),
       ('БГТУ ВОЕНМЕХ', 5, (SELECT resume_id FROM resume WHERE title = 'title2' AND applicant_id = (SELECT user_id FROM users WHERE email='petrov@org.org'))),
       ('МФТИ', 6, (SELECT resume_id FROM resume WHERE title = 'title3' AND applicant_id = (SELECT user_id FROM users WHERE email='sergeev@org.org'))),
       ('МГУ', 6, (SELECT resume_id FROM resume WHERE title = 'title4' AND applicant_id = (SELECT user_id FROM users WHERE email='vitaliev@org.org')));
INSERT INTO experience (company_name, date_start, date_end, role_id, area_id, resume_id)
VALUES ('ООО Система', '2018-12-01', '2019-12-01', 1, 4, (SELECT resume_id FROM resume WHERE title = 'title1' AND applicant_id = (SELECT user_id FROM users WHERE email='ivanov@org.org'))),
       ('VK, ВКонтакте', '2019-12-05', '2023-08-23', 1, 4, (SELECT resume_id FROM resume WHERE title = 'title1' AND applicant_id = (SELECT user_id FROM users WHERE email='ivanov@org.org'))),
	   ('Рекруто', '2010-08-02', '2022-11-10', 2, 1, (SELECT resume_id FROM resume WHERE title = 'title2' AND applicant_id = (SELECT user_id FROM users WHERE email='petrov@org.org'))),
       ('MPSTATS', '2018-12-01', '2023-01-20', 3, 2, (SELECT resume_id FROM resume WHERE title = 'title3' AND applicant_id = (SELECT user_id FROM users WHERE email='sergeev@org.org'))),
       ('Сбер', '2022-12-23', '2023-02-15', 4, 4, (SELECT resume_id FROM resume WHERE title = 'title4' AND applicant_id = (SELECT user_id FROM users WHERE email='vitaliev@org.org')));

INSERT INTO employer (company_name, user_id)
VALUES ('RЕD Solution', (SELECT user_id FROM users WHERE email = 'regsolution@org.org')),
       ('Extreme Developers', (SELECT user_id FROM users WHERE email = 'extremedevelopers@org.org')),
       ('Смарт-Тек', (SELECT user_id FROM users WHERE email = 'smart_tec.com')),
       ('АРБА Дистрибьюшн', (SELECT user_id FROM users WHERE email = 'arba@org.org'));
INSERT INTO vacancies (title, description, salary_from, salary_to, salary_currency, schedule_id, employment_id, area_id, role_id, experience_type_id, paid_date, end_date, can_publish, employer_id)
VALUES ('title1', 'description1', 40000, 70000, 'RUR', 1, 1, 1, 1, 2, '2023-12-12 18:37:17+00', '2023-12-22 18:37:17+00', True, (SELECT employer_id FROM employer WHERE user_id = (SELECT user_id FROM users WHERE email = 'regsolution@org.org'))),
       ('title5', 'description5', 35000, 90000, 'RUR', 1, 1, 1, 1, 2, '2023-12-12 12:30:17+00', '2023-12-22 12:30:17+00', True, (SELECT employer_id FROM employer WHERE user_id = (SELECT user_id FROM users WHERE email = 'regsolution@org.org'))),
	   ('title2', 'description2', 80000, 120000, 'RUR', 1, 1, 2, 2, 2, '2023-12-04 15:12:17+00', '2023-1-14 15:12:17+00', True, (SELECT employer_id FROM employer WHERE user_id = (SELECT user_id FROM users WHERE email = 'extremedevelopers@org.org'))),
       ('title3', 'description3', 65000, 90000, 'RUR', 1, 1, 1, 3, 3, '2023-12-07 11:22:17+00', '2023-12-17 11:22:17+00', True, (SELECT employer_id FROM employer WHERE user_id = (SELECT user_id FROM users WHERE email = 'smart_tec.com'))),
       ('title4', 'description4', 70000, 150000, 'RUR', 1, 1, 1, 4, 3, '2023-12-10 19:11:17+00', '2023-12-10 19:11:17+00', True, (SELECT employer_id FROM employer WHERE user_id = (SELECT user_id FROM users WHERE email = 'arba@org.org')));

INSERT INTO response (resume_id, vacancy_id, user_id)
VALUES ((SELECT resume_id FROM resume WHERE title = 'title1' AND applicant_id = (SELECT user_id FROM users WHERE email='ivanov@org.org')), (SELECT vacancy_id FROM vacancies WHERE title = 'title1' AND employer_id = (SELECT employer_id FROM employer WHERE user_id = (SELECT user_id FROM users WHERE email = 'regsolution@org.org'))), (SELECT user_id FROM users WHERE email = 'ivanov@org.org')),
       ((SELECT resume_id FROM resume WHERE title = 'title2' AND applicant_id = (SELECT user_id FROM users WHERE email='petrov@org.org')), (SELECT vacancy_id FROM vacancies WHERE title = 'title1' AND employer_id = (SELECT employer_id FROM employer WHERE user_id = (SELECT user_id FROM users WHERE email = 'regsolution@org.org'))), (SELECT user_id FROM users WHERE email = 'petrov@org.org')),
       ((SELECT resume_id FROM resume WHERE title = 'title3' AND applicant_id = (SELECT user_id FROM users WHERE email='sergeev@org.org')), (SELECT vacancy_id FROM vacancies WHERE title = 'title4' AND employer_id = (SELECT employer_id FROM employer WHERE user_id = (SELECT user_id FROM users WHERE email = 'arba@org.org'))), (SELECT user_id FROM users WHERE email = 'sergeev@org.org')),
       ((SELECT resume_id FROM resume WHERE title = 'title4' AND applicant_id = (SELECT user_id FROM users WHERE email='vitaliev@org.org')), (SELECT vacancy_id FROM vacancies WHERE title = 'title3' AND employer_id = (SELECT employer_id FROM employer WHERE user_id = (SELECT user_id FROM users WHERE email = 'smart_tec.com'))), (SELECT user_id FROM users WHERE email = 'vitaliev@org.org'));
INSERT INTO massages (massage_text, response_id, sender_id, recipient_id)
VALUES ('text1', 13, 17, 21),
       ('text2', 14, 18, 21),
       ('text3', 15, 19, 24),
       ('text4', 16, 20, 23);













