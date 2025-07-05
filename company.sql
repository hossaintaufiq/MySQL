-- Create Tables

CREATE TABLE department (
  dname VARCHAR(20) NOT NULL,
  dnumber INT NOT NULL,
  mgrssn BIGINT NOT NULL,
  mgrstartdate DATE NOT NULL,
  PRIMARY KEY (dnumber),
  UNIQUE (dname)
);

CREATE TABLE employee (
  fname VARCHAR(10) NOT NULL,
  lname VARCHAR(20) NOT NULL,
  ssn BIGINT NOT NULL,
  bdate DATE NOT NULL,
  address VARCHAR(30) NOT NULL,
  sex VARCHAR(1) NOT NULL,
  salary INT NOT NULL,
  superssn BIGINT,
  dno INT NOT NULL,
  PRIMARY KEY (ssn),
  FOREIGN KEY (dno) REFERENCES department(dnumber)
);

CREATE TABLE project (
  pname VARCHAR(20) NOT NULL,
  pnumber INT NOT NULL,
  plocation VARCHAR(20) NOT NULL,
  dnum INT NOT NULL,
  PRIMARY KEY (pnumber),
  UNIQUE (pname),
  FOREIGN KEY (dnum) REFERENCES department(dnumber)
);

CREATE TABLE works_on (
  essn BIGINT NOT NULL,
  pno INT NOT NULL,
  hours DECIMAL(5,1),
  PRIMARY KEY (essn, pno),
  FOREIGN KEY (essn) REFERENCES employee(ssn),
  FOREIGN KEY (pno) REFERENCES project(pnumber)
);

CREATE TABLE dependent (
  essn BIGINT NOT NULL,
  dependent_name VARCHAR(10) NOT NULL,
  sex VARCHAR(1) NOT NULL,
  bdate DATE NOT NULL,
  relationship VARCHAR(30) NOT NULL,
  PRIMARY KEY (essn, dependent_name),
  FOREIGN KEY (essn) REFERENCES employee(ssn)
);

CREATE TABLE dept_locations (
  dnumber INT NOT NULL,
  dlocation VARCHAR(15) NOT NULL,
  PRIMARY KEY (dnumber, dlocation),
  FOREIGN KEY (dnumber) REFERENCES department(dnumber)
);

-- Insert data into department
INSERT INTO department (dname, dnumber, mgrssn, mgrstartdate) VALUES
  ('Research', 5, 333445555, '1988-05-22'),
  ('Administration', 4, 987654321, '1996-01-01'),
  ('Headquarters', 1, 888665555, '1981-06-19');

-- Insert data into employee
INSERT INTO employee (fname, lname, ssn, bdate, address, sex, salary, superssn, dno) VALUES
  ('John', 'Smith', 123456789, '1965-01-09', '731 Fondren, Houston TX', 'M', 30000, 333445555, 5),
  ('Franklin', 'Wong', 333445555, '1965-12-08', '638 Voss, Houston TX', 'M', 40000, 888665555, 5),
  ('Alicia', 'Zelaya', 999887777, '1968-01-19', '3321 Castle, Spring TX', 'F', 25000, 987654321, 4),
  ('Jennifer', 'Wallace', 987654321, '1941-06-20', '291 Berry, Bellaire TX', 'F', 43000, 888665555, 4),
  ('Ramesh', 'Narayan', 666884444, '1962-09-15', '975 Fire Oak, Humble TX', 'M', 38000, 333445555, 5),
  ('Joyce', 'English', 453453453, '1972-07-31', '5631 Rice, Houston TX', 'F', 25000, 333445555, 5),
  ('Ahmad', 'Jabbar', 987987987, '1969-03-29', '980 Dallas, Houston TX', 'M', 25000, 987654321, 4),
  ('James', 'Borg', 888665555, '1937-11-10', '450 Stone, Houston TX', 'M', 55000, NULL, 1);

-- Insert data into project
INSERT INTO project (pname, pnumber, plocation, dnum) VALUES
  ('ProductX', 1, 'Bellaire', 5),
  ('ProductY', 2, 'Sugarland', 5),
  ('ProductZ', 3, 'Houston', 5),
  ('Computerization', 10, 'Stafford', 4),
  ('Reorganization', 20, 'Houston', 1),
  ('Newbenefits', 30, 'Stafford', 4);

-- Insert data into works_on
INSERT INTO works_on (essn, pno, hours) VALUES
  (123456789, 1, 32.5),
  (123456789, 2, 7.5),
  (666884444, 3, 40.0),
  (453453453, 1, 20.0),
  (453453453, 2, 20.0),
  (333445555, 2, 10.0),
  (333445555, 3, 10.0),
  (333445555, 10, 10.0),
  (333445555, 20, 10.0),
  (999887777, 30, 30.0),
  (999887777, 10, 10.0),
  (987987987, 10, 35.0),
  (987987987, 30, 5.0),
  (987654321, 30, 20.0),
  (987654321, 20, 15.0),
  (888665555, 20, NULL);

-- Insert data into dependent
INSERT INTO dependent (essn, dependent_name, sex, bdate, relationship) VALUES
  (333445555, 'Alice', 'F', '1986-04-04', 'Daughter'),
  (333445555, 'Theodore', 'M', '1983-10-25', 'Son'),
  (333445555, 'Joy', 'F', '1958-05-03', 'Spouse'),
  (987654321, 'Abner', 'M', '1942-02-28', 'Spouse'),
  (123456789, 'Michael', 'M', '1988-01-04', 'Son'),
  (123456789, 'Alice', 'F', '1988-12-30', 'Daughter'),
  (123456789, 'Elizabeth', 'F', '1967-05-05', 'Spouse');

-- Insert data into dept_locations
INSERT INTO dept_locations (dnumber, dlocation) VALUES
  (1, 'Houston'),
  (4, 'Stafford'),
  (5, 'Bellaire'),
  (5, 'Sugarland'),
  (5, 'Houston');

-- Add foreign key constraints for mgrssn and superssn
ALTER TABLE department
  ADD CONSTRAINT depemp FOREIGN KEY (mgrssn) REFERENCES employee(ssn);

ALTER TABLE employee
  ADD CONSTRAINT empemp FOREIGN KEY (superssn) REFERENCES employee(ssn);
