CREATE TABLE departments (
	dept_no VARCHAR(4) NOT NULL PRIMARY KEY, 
	dept_name VARCHAR(30) NOT NULL);
	
CREATE TABLE titles (
	title_id VARCHAR(5) NOT NULL PRIMARY KEY,
	title VARCHAR(30) NOT NULL);

CREATE TABLE employees (
	emp_no INT NOT NULL PRIMARY KEY,
	emp_title_id VARCHAR(5) NOT NULL,
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id),
	birth_date DATE NOT NULL, 
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(20) NOT NULL,
	sex VARCHAR(2) NOT NULL,
	hire_date DATE NOT NULL
);

CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	dept_no VARCHAR(4) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

CREATE TABLE salaries (
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	salary INT NOT NULL
);

SELECT * FROM departments;
SELECT * FROM titles;
SELECT * FROM employees;
SELECT * FROM dept_manager;
SELECT * FROM dept_emp;
SELECT * FROM salaries;

SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees as e
INNER JOIN salaries as s ON
e.emp_no=s.emp_no;

SELECT e.first_name, e.last_name, e.hire_date
FROM employees as e
WHERE DATE_PART('year', hire_date) = 1986;

SELECT t.title, dm.dept_no, e.emp_no, e.first_name, e.last_name, d.dept_name
FROM titles as t
INNER JOIN employees as e ON
t.title_id=e.emp_title_id
INNER JOIN dept_manager as dm ON
dm.emp_no=e.emp_no
LEFT JOIN departments as d
ON dm.dept_no=d.dept_no
WHERE title = 'Manager';

SELECT de.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp as de
INNER JOIN employees as e ON
de.emp_no = e.emp_no
LEFT JOIN departments as d ON
de.dept_no = d.dept_no;

SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

SELECT d.dept_name, de.emp_no, e.last_name, e.first_name
FROM departments as d
INNER JOIN dept_emp as de ON
d.dept_no = de.dept_no
LEFT JOIN employees as e ON
de.emp_no = e.emp_no
WHERE dept_name = 'Sales';

SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp as de
INNER JOIN employees as e ON 
de.emp_no = e.emp_no
LEFT JOIN departments as d ON 
d.dept_no = de.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development';

SELECT last_name, COUNT(*) AS freq_count
FROM employees
GROUP BY last_name
ORDER BY freq_count DESC;
