CREATE  TABLE areas (
	area_id              integer  NOT NULL  ,
	area_name            text  NOT NULL  ,
	CONSTRAINT pk_areas PRIMARY KEY ( area_id )
 );

CREATE  TABLE employer (
	employer_id          serial  NOT NULL  ,
	employer_name        text  NOT NULL  ,
	employer_email       text  NOT NULL  ,
	employer_password    text  NOT NULL  ,
	employer_url         text  NOT NULL  ,
	CONSTRAINT pk_employer PRIMARY KEY ( employer_id )
 );

CREATE  TABLE job_seeker (
	job_seeker_id        serial  NOT NULL  ,
	job_seeker_name      text  NOT NULL  ,
	job_seeker_url       text  NOT NULL  ,
	job_seeker_email     text  NOT NULL  ,
	job_seeker_password  text  NOT NULL  ,
	job_seeker_is_admin  boolean  NOT NULL  ,
	job_seeker_status    boolean  NOT NULL  ,
	CONSTRAINT pk_job_seeker PRIMARY KEY ( job_seeker_id )
 );

CREATE  TABLE key_skills (
	skill_id             integer  NOT NULL  ,
	skill_name           text  NOT NULL  ,
	CONSTRAINT pk_key_skills PRIMARY KEY ( skill_id )
 );

CREATE  TABLE massages (
	massage_id           serial  NOT NULL  ,
	massage_text         text  NOT NULL  ,
	massage_timestamp    timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL  ,
	employer_id          integer  NOT NULL  ,
	job_seeker_id        integer  NOT NULL  ,
	CONSTRAINT pk_massages PRIMARY KEY ( massage_id ),
	CONSTRAINT fk_massages_employer FOREIGN KEY ( employer_id ) REFERENCES employer( employer_id )   ,
	CONSTRAINT fk_massages_job_seeker FOREIGN KEY ( job_seeker_id ) REFERENCES job_seeker( job_seeker_id )
 );

CREATE  TABLE professional_roles (
	role_id              integer  NOT NULL  ,
	role_name            text  NOT NULL  ,
	CONSTRAINT pk_professional_roles PRIMARY KEY ( role_id )
 );

CREATE  TABLE resume (
	resume_id            serial  NOT NULL  ,
	resume_name          text  NOT NULL  ,
	resume_experience    text  NOT NULL  ,
	resume_description   text  NOT NULL  ,
	resume_created_at    timestamptz  NOT NULL  ,
	job_seeker_id        integer  NOT NULL  ,
	area_id              integer  NOT NULL  ,
	CONSTRAINT pk_resume PRIMARY KEY ( resume_id ),
	CONSTRAINT fk_resume_areas FOREIGN KEY ( area_id ) REFERENCES areas( area_id )   ,
	CONSTRAINT fk_resume_job_seeker FOREIGN KEY ( job_seeker_id ) REFERENCES job_seeker( job_seeker_id )
 );

CREATE  TABLE vacancies (
	vacancy_id           serial  NOT NULL  ,
	vacancy_name         text  NOT NULL  ,
	vacancy_salary_from  integer    ,
	vacancy_salary_to    integer    ,
	vacancy_salary_currency text    ,
	vacancy_experience   text    ,
	vacancy_description  text  NOT NULL  ,
	vacancy_created_at   timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL  ,
	vacancy_status       boolean  NOT NULL  ,
	employer_id          integer  NOT NULL  ,
	area_id              integer  NOT NULL  ,
	CONSTRAINT pk_vacancies PRIMARY KEY ( vacancy_id ),
	CONSTRAINT fk_vacancies_employer FOREIGN KEY ( employer_id ) REFERENCES employer( employer_id )   ,
	CONSTRAINT fk_vacancies_areas FOREIGN KEY ( area_id ) REFERENCES areas( area_id )
 );

CREATE  TABLE contract (
	contract_id          serial  NOT NULL  ,
	conditions           text  NOT NULL  ,
	cost                 integer  NOT NULL  ,
	create_at            timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL  ,
	end_date             timestamptz  NOT NULL  ,
	employer_id          integer  NOT NULL  ,
	CONSTRAINT pk_contract PRIMARY KEY ( contract_id ),
	CONSTRAINT fk_contract_employer FOREIGN KEY ( employer_id ) REFERENCES employer( employer_id )
 );

CREATE  TABLE key_skills_users (
	key_skill_user_id    serial  NOT NULL  ,
	vacancy_id           integer    ,
	resume_id            integer    ,
	skill_id             integer  NOT NULL  ,
	CONSTRAINT pk_key_skills_users PRIMARY KEY ( key_skill_user_id ),
	CONSTRAINT fk_key_skills_users_key_skills FOREIGN KEY ( skill_id ) REFERENCES key_skills( skill_id )   ,
	CONSTRAINT fk_key_skills_users_resume FOREIGN KEY ( resume_id ) REFERENCES resume( resume_id )   ,
	CONSTRAINT fk_key_skills_users_vacancies FOREIGN KEY ( vacancy_id ) REFERENCES vacancies( vacancy_id )
 );

CREATE  TABLE professional_roles_users (
	role_user_id         serial  NOT NULL  ,
	vacancy_id           integer    ,
	resume_id            integer    ,
	role_id              integer  NOT NULL  ,
	CONSTRAINT pk_professional_roles_users PRIMARY KEY ( role_user_id ),
	CONSTRAINT fk_professional_roles_users_professional_roles FOREIGN KEY ( role_id ) REFERENCES professional_roles( role_id )   ,
	CONSTRAINT fk_professional_roles_users_resume FOREIGN KEY ( resume_id ) REFERENCES resume( resume_id )   ,
	CONSTRAINT fk_professional_roles_users_vacancies FOREIGN KEY ( vacancy_id ) REFERENCES vacancies( vacancy_id )
 );

CREATE  TABLE response (
	response_id          serial  NOT NULL  ,
	response_created_at  timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL  ,
	resume_id            integer  NOT NULL  ,
	vacancy_id           integer  NOT NULL  ,
	CONSTRAINT pk_response PRIMARY KEY ( response_id ),
	CONSTRAINT fk_response_resume FOREIGN KEY ( resume_id ) REFERENCES resume( resume_id )   ,
	CONSTRAINT fk_response_vacancies FOREIGN KEY ( vacancy_id ) REFERENCES vacancies( vacancy_id )
 );
