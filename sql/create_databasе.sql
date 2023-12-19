
CREATE  TABLE areas (
	area_id              integer  NOT NULL  ,
	area_name            varchar(100)  NOT NULL  ,
	CONSTRAINT pk_areas PRIMARY KEY ( area_id )
 );

CREATE  TABLE education_type (
	education_type_id    integer  NOT NULL  ,
	education_type_name  varchar(100)  NOT NULL  ,
	CONSTRAINT pk_education_type PRIMARY KEY ( education_type_id )
 );

CREATE  TABLE employment (
	employment_id        integer  NOT NULL  ,
	employment_name      varchar(100)  NOT NULL  ,
	CONSTRAINT pk_employment PRIMARY KEY ( employment_id )
 );

CREATE  TABLE experience_type (
	experience_type_id   integer  NOT NULL  ,
	experience_type_name varchar(100)  NOT NULL  ,
	CONSTRAINT pk_experience_type PRIMARY KEY ( experience_type_id )
 );

CREATE  TABLE professional_roles (
	role_id              integer  NOT NULL  ,
	role_name            varchar(100)  NOT NULL  ,
	CONSTRAINT pk_professional_roles PRIMARY KEY ( role_id )
 );

CREATE  TABLE response_status (
	response_status_id   integer  NOT NULL  ,
	response_status_name varchar(100)  NOT NULL  ,
	CONSTRAINT pk_response_status PRIMARY KEY ( response_status_id )
 );

CREATE  TABLE schedule (
	schedule_id          integer  NOT NULL  ,
	schedule_name        varchar(100)  NOT NULL  ,
	CONSTRAINT pk_schedule PRIMARY KEY ( schedule_id )
 );

CREATE  TABLE status (
	status_id            integer  NOT NULL  ,
	status_name          varchar(100)  NOT NULL  ,
	CONSTRAINT pk_vacancy_status PRIMARY KEY ( status_id )
 );

CREATE  TABLE users (
	user_id              serial DEFAULT nextval('users_user_id_seq'::regclass) NOT NULL  ,
	is_admin             boolean DEFAULT false NOT NULL  ,
	is_employer          boolean DEFAULT false NOT NULL  ,
	email                varchar(129)  NOT NULL  ,
	"password"           varchar(64)  NOT NULL  ,
	first_name           varchar(100)    ,
	last_name            varchar(100)    ,
	middle_name          varchar(100)    ,
	phone                varchar(20)    ,
	CONSTRAINT pk_users PRIMARY KEY ( user_id )
 );

CREATE  TABLE employer (
	employer_id          serial DEFAULT nextval('employer_2_employer_id_seq'::regclass) NOT NULL  ,
	company_name         text  NOT NULL  ,
	company_is_verified  boolean DEFAULT false NOT NULL  ,
	company_documents    bytea    ,
	user_id              integer  NOT NULL  ,
	company_description  text    ,
	logo_img             bytea    ,
	CONSTRAINT pk_employer_2 PRIMARY KEY ( employer_id ),
	CONSTRAINT fk_employer_users FOREIGN KEY ( user_id ) REFERENCES users( user_id )
 );

CREATE  TABLE resume (
	resume_id            serial DEFAULT nextval('resume_resume_id_seq'::regclass) NOT NULL  ,
	title                text  NOT NULL  ,
	created_at           timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL  ,
	updated_at           timestamptz DEFAULT CURRENT_TIMESTAMP   ,
	salary               integer    ,
	salary_currency      char(3)    ,
	applicant_id         integer  NOT NULL  ,
	role_id              integer  NOT NULL  ,
	status_id            integer DEFAULT 1 NOT NULL  ,
	area_id              integer  NOT NULL  ,
	age                  integer    ,
	gender_is_male       boolean    ,
	can_publish          boolean DEFAULT false NOT NULL  ,
	photo                bytea    ,
	total_experience     integer    ,
	description          text    ,
	CONSTRAINT pk_resume PRIMARY KEY ( resume_id ),
	CONSTRAINT fk_resume_users FOREIGN KEY ( applicant_id ) REFERENCES users( user_id )   ,
	CONSTRAINT fk_resume_status FOREIGN KEY ( status_id ) REFERENCES status( status_id )   ,
	CONSTRAINT fk_resume_areas FOREIGN KEY ( area_id ) REFERENCES areas( area_id )   ,
	CONSTRAINT fk_resume_professional_roles FOREIGN KEY ( role_id ) REFERENCES professional_roles( role_id )
 );

CREATE  TABLE schedule_resume (
	schedule_resume_id   serial DEFAULT nextval('schedule_resume_schedule_resume_id_seq'::regclass) NOT NULL  ,
	resume_id            integer  NOT NULL  ,
	schedule_id          integer  NOT NULL  ,
	CONSTRAINT pk_schedule_resume PRIMARY KEY ( schedule_resume_id ),
	CONSTRAINT fk_schedule_resume_resume FOREIGN KEY ( resume_id ) REFERENCES resume( resume_id )   ,
	CONSTRAINT fk_schedule_resume_schedule FOREIGN KEY ( schedule_id ) REFERENCES schedule( schedule_id )
 );

CREATE  TABLE vacancies (
	vacancy_id           serial DEFAULT nextval('vacancies_vacancy_id_seq'::regclass) NOT NULL  ,
	title                text  NOT NULL  ,
	description          text  NOT NULL  ,
	salary_from          integer    ,
	salary_to            integer    ,
	salary_currency      char(3)    ,
	address              text    ,
	schedule_id          integer    ,
	employment_id        integer    ,
	created_at           timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL  ,
	updated_at           timestamptz    ,
	area_id              integer  NOT NULL  ,
	employer_id          integer  NOT NULL  ,
	role_id              integer  NOT NULL  ,
	experience_type_id   integer  NOT NULL  ,
	status_id            integer DEFAULT 1 NOT NULL  ,
	paid_date            timestamptz    ,
	end_date             timestamptz    ,
	can_publish          boolean    ,
	education_type_id    integer    ,
	salary_gross         boolean    ,
	CONSTRAINT pk_vacancies PRIMARY KEY ( vacancy_id ),
	CONSTRAINT fk_vacancies_education_type FOREIGN KEY ( education_type_id ) REFERENCES education_type( education_type_id )   ,
	CONSTRAINT fk_vacancies_employer FOREIGN KEY ( employer_id ) REFERENCES employer( employer_id )   ,
	CONSTRAINT fk_vacancies_schedule FOREIGN KEY ( schedule_id ) REFERENCES schedule( schedule_id )   ,
	CONSTRAINT fk_vacancies_employment FOREIGN KEY ( employment_id ) REFERENCES employment( employment_id )   ,
	CONSTRAINT fk_vacancies_areas FOREIGN KEY ( area_id ) REFERENCES areas( area_id )   ,
	CONSTRAINT fk_vacancies_professional_roles FOREIGN KEY ( role_id ) REFERENCES professional_roles( role_id )   ,
	CONSTRAINT fk_vacancies_experience_type FOREIGN KEY ( experience_type_id ) REFERENCES experience_type( experience_type_id )   ,
	CONSTRAINT fk_vacancies_vacancy_status FOREIGN KEY ( status_id ) REFERENCES status( status_id )
 );

CREATE  TABLE education (
	education_id         serial DEFAULT nextval('education_education_id_seq'::regclass) NOT NULL  ,
	education_institution_name text  NOT NULL  ,
	education_type_id    integer  NOT NULL  ,
	resume_id            integer  NOT NULL  ,
	CONSTRAINT pk_education PRIMARY KEY ( education_id ),
	CONSTRAINT fk_education_resume FOREIGN KEY ( resume_id ) REFERENCES resume( resume_id )   ,
	CONSTRAINT fk_education_education_type FOREIGN KEY ( education_type_id ) REFERENCES education_type( education_type_id )
 );

CREATE  TABLE employment_resume (
	employment_resume_id serial DEFAULT nextval('employment_resume_employment_resume_id_seq'::regclass) NOT NULL  ,
	resume_id            integer  NOT NULL  ,
	employment_id        integer  NOT NULL  ,
	CONSTRAINT pk_employment_resume PRIMARY KEY ( employment_resume_id ),
	CONSTRAINT fk_employment_resume_resume FOREIGN KEY ( resume_id ) REFERENCES resume( resume_id )   ,
	CONSTRAINT fk_employment_resume_employment FOREIGN KEY ( employment_id ) REFERENCES employment( employment_id )
 );

CREATE  TABLE experience (
	experience_id        serial DEFAULT nextval('experience_experience_id_seq'::regclass) NOT NULL  ,
	company_name         text  NOT NULL  ,
	date_start           date  NOT NULL  ,
	date_end             date    ,
	role_id              integer  NOT NULL  ,
	area_id              integer  NOT NULL  ,
	resume_id            integer  NOT NULL  ,
	CONSTRAINT pk_experience PRIMARY KEY ( experience_id ),
	CONSTRAINT fk_experience_professional_roles FOREIGN KEY ( role_id ) REFERENCES professional_roles( role_id )   ,
	CONSTRAINT fk_experience_areas FOREIGN KEY ( area_id ) REFERENCES areas( area_id )   ,
	CONSTRAINT fk_experience_resume FOREIGN KEY ( resume_id ) REFERENCES resume( resume_id )
 );

CREATE  TABLE response (
	response_id          serial DEFAULT nextval('response_response_id_seq'::regclass) NOT NULL  ,
	created_at           timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL  ,
	resume_id            integer  NOT NULL  ,
	vacancy_id           integer  NOT NULL  ,
	user_id              integer  NOT NULL  ,
	response_status_id   integer DEFAULT 1 NOT NULL  ,
	CONSTRAINT pk_response PRIMARY KEY ( response_id ),
	CONSTRAINT fk_response_response_status FOREIGN KEY ( response_status_id ) REFERENCES response_status( response_status_id )   ,
	CONSTRAINT fk_response_users FOREIGN KEY ( user_id ) REFERENCES users( user_id )   ,
	CONSTRAINT fk_response_resume FOREIGN KEY ( resume_id ) REFERENCES resume( resume_id )   ,
	CONSTRAINT fk_response_vacancies FOREIGN KEY ( vacancy_id ) REFERENCES vacancies( vacancy_id )
 );

CREATE  TABLE massages (
	massage_id           serial DEFAULT nextval('massages_massage_id_seq'::regclass) NOT NULL  ,
	massage_text         text  NOT NULL  ,
	massage_timestamp    timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL  ,
	is_viewed            boolean DEFAULT false NOT NULL  ,
	response_id          integer    ,
	sender_id            integer  NOT NULL  ,
	recipient_id         integer  NOT NULL  ,
	CONSTRAINT pk_massages PRIMARY KEY ( massage_id ),
	CONSTRAINT fk_massages_users_0 FOREIGN KEY ( recipient_id ) REFERENCES users( user_id )   ,
	CONSTRAINT fk_massages_users FOREIGN KEY ( sender_id ) REFERENCES users( user_id )   ,
	CONSTRAINT fk_massages_response FOREIGN KEY ( response_id ) REFERENCES response( response_id )
 );
CREATE EXTENSION IF NOT EXISTS pgcrypto;
