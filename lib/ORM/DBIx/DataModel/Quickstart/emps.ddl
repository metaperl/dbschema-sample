DROP TABLE t_employee ;
  DROP TABLE t_department ;
  DROP TABLE t_department ;
  DROP TABLE t_activity ;
  DROP TABLE t_skill ;
  DROP TABLE t_employee_skill ;

CREATE TABLE t_employee (
    emp_id     INTEGER AUTO_INCREMENT PRIMARY KEY,
    lastname   TEXT    NOT NULL,
    firstname  TEXT,
    d_birth    DATE 
  ); 
  CREATE TABLE t_department (
    dpt_code   VARCHAR(5) PRIMARY KEY,
    dpt_name   TEXT    NOT NULL 
  );
  CREATE TABLE t_activity (
    act_id     INTEGER AUTO_INCREMENT PRIMARY KEY,
    emp_id     INTEGER NOT NULL REFERENCES t_employee(emp_id),
    dpt_code   VARCHAR(5) NOT NULL REFERENCES t_department(dpt_code),
    d_begin    DATE    NOT NULL,
    d_end      DATE
  );
  CREATE TABLE t_skill (
    skill_code VARCHAR(2) PRIMARY KEY,
    skill_name TEXT    NOT NULL 
  );
  CREATE TABLE t_employee_skill (
    emp_id         INTEGER NOT NULL REFERENCES t_employee(emp_id),
    skill_code     VARCHAR(2)  NOT NULL REFERENCES t_skill(skill_code)

  );