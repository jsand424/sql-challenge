Departments (dept_no, dept_name)
      |
      |---< Dept_emp (emp_no, dept_no)
      |                 |
      |                 |---< Employees (emp_no, emp_title_id, birth_date, first_name, last_name, sex, hire_date)
      |                 |                 |
      |                 |                 |---< Titles (title_id, title)
      |
      |---< Dept_manager (dept_no, emp_no)
      |
      |---< Salaries (emp_no, salary)

CREATE TABLE Departments (
    dept_no CHAR(4) PRIMARY KEY,
    dept_name VARCHAR(20000) NOT NULL
);

CREATE TABLE Employees (
    emp_no INT PRIMARY KEY,
    emp_title_id CHAR(5),
    birth_date DATE,
    first_name VARCHAR(20000),
    last_name VARCHAR(20000),
    sex CHAR(1),
    hire_date DATE,
    FOREIGN KEY (emp_title_id) REFERENCES Titles(title_id)
);

CREATE TABLE Titles (
    title_id CHAR(5) PRIMARY KEY,
    title VARCHAR(20000) NOT NULL
);

CREATE TABLE Salaries (
    emp_no INT PRIMARY KEY,
    salary INT NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES Employees(emp_no)
);

CREATE TABLE Dept_emp (
    emp_no INT,
    dept_no CHAR(4),
    PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES Departments(dept_no)
);

CREATE TABLE Dept_manager (
    dept_no CHAR(4),
    emp_no INT,
    PRIMARY KEY (dept_no, emp_no),
    FOREIGN KEY (dept_no) REFERENCES Departments(dept_no),
    FOREIGN KEY (emp_no) REFERENCES Employees(emp_no)
);

SELECT emp_no, last_name, first_name, sex, salary
FROM Employees
JOIN Salaries ON Employees.emp_no = Salaries.emp_no;

SELECT first_name, last_name, hire_date
FROM Employees
WHERE YEAR(hire_date) = 1986;

SELECT Dept_manager.dept_no, Departments.dept_name, Dept_manager.emp_no, Employees.last_name, Employees.first_name
FROM Dept_manager
JOIN Employees ON Dept_manager.emp_no = Employees.emp_no
JOIN Departments ON Dept_manager.dept_no = Departments.dept_no;

SELECT Dept_emp.dept_no, Employees.emp_no, Employees.last_name, Employees.first_name, Departments.dept_name
FROM Dept_emp
JOIN Employees ON Dept_emp.emp_no = Employees.emp_no
JOIN Departments ON Dept_emp.dept_no = Departments.dept_no;

SELECT first_name, last_name, sex
FROM Employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

SELECT Employees.emp_no, Employees.last_name, Employees.first_name
FROM Dept_emp
JOIN Employees ON Dept_emp.emp_no = Employees.emp_no
WHERE Dept_emp.dept_no = 'd007';

SELECT Employees.emp_no, Employees.last_name, Employees.first_name, Departments.dept_name
FROM Dept_emp
JOIN Employees ON Dept_emp.emp_no = Employees.emp_no
JOIN Departments ON Dept_emp.dept_no = Departments.dept_no
WHERE Dept_emp.dept_no IN ('d007', 'd005');

SELECT last_name, COUNT(*) as frequency
FROM Employees
GROUP BY last_name
ORDER BY frequency DESC;



