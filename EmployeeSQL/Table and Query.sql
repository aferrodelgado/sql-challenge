CREATE TABLE Departments (
    dept_no VARCHAR(15)   NOT NULL,
    dept_name VARCHAR(50)   NOT NULL,
    CONSTRAINT pk_Departments PRIMARY KEY (
        dept_no
     )
);

CREATE TABLE Dept_Emp (
    emp_no INT   NOT NULL,
    dept_no VARCHAR(15)   NOT NULL,
    CONSTRAINT pk_Dept_Emp PRIMARY KEY (
        emp_no,dept_no
     )
);

CREATE TABLE Dept_Manager (
    dept_no VARCHAR(15)   NOT NULL,
    emp_no INT   NOT NULL,
    CONSTRAINT pk_Dept_Manager PRIMARY KEY (
        dept_no,emp_no
     )
);

CREATE TABLE Employees (
    emp_no INT   NOT NULL,
    emp_title_id VARCHAR(15)   NOT NULL,
    birth_date DATE   NOT NULL,
    first_name VARCHAR(50)   NOT NULL,
    last_name VARCHAR(50)   NOT NULL,
    sex VARCHAR(1)   NOT NULL,
    hire_date DATE   NOT NULL,
    CONSTRAINT pk_Employees PRIMARY KEY (
        emp_no
     )
);

CREATE TABLE Salaries (
    emp_no INT   NOT NULL,
    salary INT   NOT NULL,
    CONSTRAINT pk_Salaries PRIMARY KEY (
        emp_no,salary
     )
);

CREATE TABLE Titles (
    title_id VARCHAR(15)   NOT NULL,
    title VARCHAR(50)   NOT NULL,
    CONSTRAINT pk_Titles PRIMARY KEY (
        title_id
     )
);

ALTER TABLE Dept_Emp ADD CONSTRAINT fk_Dept_Emp_emp_no FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);

ALTER TABLE Dept_Emp ADD CONSTRAINT fk_Dept_Emp_dept_no FOREIGN KEY(dept_no)
REFERENCES Departments (dept_no);

ALTER TABLE Dept_Manager ADD CONSTRAINT fk_Dept_Manager_dept_no FOREIGN KEY(dept_no)
REFERENCES Departments (dept_no);

ALTER TABLE Dept_Manager ADD CONSTRAINT fk_Dept_Manager_emp_no FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);

ALTER TABLE Employees ADD CONSTRAINT fk_Employees_emp_title_id FOREIGN KEY(emp_title_id)
REFERENCES Titles (title_id);

ALTER TABLE Salaries ADD CONSTRAINT fk_Salaries_emp_no FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);

--List the employee number, last name, first name, sex, and salary of each employee.
Select e.emp_no, e.last_name, e.first_name, e.sex, s.salary
from employees as e
inner join salaries as s on
e.emp_no = s.emp_no;

--List the first name, last name, and hire date for the employees who were hired in 1986.
Select e.first_name, e.last_name, e.hire_date
from employees as e
where date_part('year', hire_date) = 1986;

--List the manager of each department along with their department number, 
--department name, employee number, last name, and first name.
Select d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
from dept_manager as dm
inner join departments as d on
dm.dept_no = d.dept_no
inner join employees as e on
dm.emp_no = e.emp_no;

--List the department number for each employee along with that employee’s 
--employee number, last name, first name, and department name.
Select de.dept_no, de.emp_no, e.last_name, e.first_name, d.dept_name
from dept_emp as de
inner join employees as e on
de.emp_no = e.emp_no
inner join departments as d on
de.dept_no = d.dept_no;

--List first name, last name, and sex of each employee whose first name is 
--Hercules and whose last name begins with the letter B.
Select e.first_name, e.last_name, e.sex
from employees as e
where e.first_name = 'Hercules'
and e.last_name like 'B%';

--List each employee in the Sales department, including their
--employee number, last name, and first name.
Select d.dept_name, de.emp_no, e.last_name, e.first_name
from dept_emp as de
inner join departments as d on
de.dept_no = d.dept_no
inner join employees as e on
de.emp_no = e.emp_no
where d.dept_name = 'Sales';

--List each employee in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.
Select d.dept_name, de.emp_no, e.last_name, e.first_name
from dept_emp as de
inner join departments as d on
de.dept_no = d.dept_no
inner join employees as e on
de.emp_no = e.emp_no
where (d.dept_name = 'Sales' or d.dept_name = 'Development')

--List the frequency counts, in descending order, 
--of all the employee last names (that is, how many employees share each last name).
Select last_name, count(last_name) as "Employees with last name"
from employees
group by last_name
order by count(last_name) DESC;

