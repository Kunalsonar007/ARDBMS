-- Practical 1: Demonstrate the use of GROUP BY and ORDER BY clause in RDBMS
CREATE TABLE Sales1 (
    id INT, 
    ProductName VARCHAR(50), 
    Quantity INT, 
    Price DECIMAL(10, 2)
);

INSERT INTO Sales1 VALUES(1, 'laptop', 2000, 2000);
INSERT INTO Sales1 VALUES(2, 'mobile', 100, 10000);
INSERT INTO Sales1 VALUES(3, 'tab', 200, 20000);

SELECT ProductName, SUM(Quantity) AS TotalQuantity 
FROM Sales1 
GROUP BY ProductName 
ORDER BY TotalQuantity DESC;

-- Practical 2: Hospital database queries
CREATE TABLE DOCTOR (
    Did INT PRIMARY KEY, 
    Dname VARCHAR2(100),
    DAddress VARCHAR2(255),
    Qualification VARCHAR(100)
);

INSERT INTO DOCTOR VALUES(1, 'kruti', 'jalgaon', 'mbbs');
INSERT INTO DOCTOR VALUES(2, 'pariniti', 'pune', 'md');
INSERT INTO DOCTOR VALUES(3, 'sonam', 'mumbai', 'biology');

CREATE TABLE PATIENTMASTERS (
    Prode INT PRIMARY KEY, 
    EntryDate DATE,
    DischargeDate DATE,
    WardNo INT,
    Disease VARCHAR(100)
);

INSERT INTO PATIENTMASTERS VALUES(111, '01-JAN-23', '10-JAN-23', 3, 'cancer');
INSERT INTO PATIENTMASTERS VALUES(112, '03-MAR-20', '09-MAR-20', 2, 'blood cancer');
INSERT INTO PATIENTMASTERS VALUES(114, '03-MAR-20', '25-MAY-20', 2, 'diabetes');
INSERT INTO PATIENTMASTERS VALUES(113, '05-FEB-20', '15-FEB-20', 1, 'flu');

-- a) Find the details of the doctor who is treating the patient of ward no 3
SELECT * FROM DOCTOR D 
WHERE EXISTS (SELECT 1 FROM PATIENTMASTERS P WHERE P.WardNo = 3);

-- b) Find the detail of patient who are admitted within period 03/03/2020 to 25/05/2020
SELECT * FROM PATIENTMASTERS 
WHERE EntryDate BETWEEN TO_DATE('2020-03-03', 'YYYY-MM-DD') AND TO_DATE('2020-05-25', 'YYYY-MM-DD');

-- c) Find the detail of patient who are suffered from blood cancer
SELECT * FROM PATIENTMASTERS WHERE Disease = 'blood cancer';

-- d) Create view on DOCTOR And PATIENTMASTER tables
CREATE VIEW DoctorPatientView1 AS
SELECT D.*, P.* 
FROM DOCTOR D 
JOIN PATIENTMASTERS P ON 1=1;

-- Practical 3: Department table operations
CREATE TABLE DEPARTMENT (
    DeptNo INT PRIMARY KEY, 
    DeptName VARCHAR(30), 
    Location VARCHAR(30)
);

-- a) Add column designation to the department table
ALTER TABLE DEPARTMENT ADD Designation VARCHAR(50);

-- b) Insert values into table
INSERT INTO DEPARTMENT VALUES(1, 'HR', 'New York', 'Manager');
INSERT INTO DEPARTMENT VALUES(2, 'Sales', 'San Francisco', 'Sales Executive');
INSERT INTO DEPARTMENT VALUES(3, 'IT', 'Chicago', 'Software Engineer');
INSERT INTO DEPARTMENT VALUES(4, 'Marketing', 'Los Angeles', 'Marketing Head');
INSERT INTO DEPARTMENT VALUES(5, 'Finance', 'Dallas', 'Accountant');
INSERT INTO DEPARTMENT VALUES(9, 'Manager', 'Delhi', 'software');

-- c) List the record of dept table grouped by deptno
SELECT * FROM DEPARTMENT 
GROUP BY DeptNo, DeptName, Location, Designation;

-- d) Update record where deptno is 9
UPDATE DEPARTMENT 
SET Location = 'Miami', Designation = 'Regional Manager' 
WHERE DeptNo = 9;

-- e) Delete any column data from the table
ALTER TABLE DEPARTMENT DROP COLUMN Location;

-- Practical 4: Database with integrity constraints
CREATE TABLE DOCTOR1 (
    Did INT PRIMARY KEY, 
    Dname VARCHAR(50) NOT NULL, 
    DAddress VARCHAR(100), 
    Qualification VARCHAR(50)
);

INSERT INTO DOCTOR1 VALUES(1, 'Dr. John Doe', 'jalgaon', 'MBBS');
INSERT INTO DOCTOR1 VALUES(2, 'Dr. Alice Smith', '456 Oak Ave', 'MD');
INSERT INTO DOCTOR1 VALUES(3, 'Dr. Robert Brown', '789 Pine Blvd', 'PhD');
INSERT INTO DOCTOR1 VALUES(4, 'Dr. Emily White', '321 Birch Rd', 'MDS');
INSERT INTO DOCTOR1 VALUES(5, 'Dr. Michael Lee', '654 Maple St', 'MD');
INSERT INTO DOCTOR1 VALUES(6, 'Dr. Laura Green', '876 Cedar Ln', 'MBBS');
INSERT INTO DOCTOR1 VALUES(7, 'Dr. Mark Adams', '234 Oak Dr', 'MS');
INSERT INTO DOCTOR1 VALUES(8, 'Dr. Sarah White', '987 Pine Ave', 'MD');
INSERT INTO DOCTOR1 VALUES(9, 'Dr. Tom Clark', '543 Elm Blvd', 'MBBS');
INSERT INTO DOCTOR1 VALUES(10, 'Dr. Olivia Harris', '678 Willow Dr', 'PhD');

CREATE TABLE PATIENT (
    Pid INT PRIMARY KEY, 
    Pname VARCHAR(50) NOT NULL, 
    Age INT CHECK (Age >= 0),
    Gender VARCHAR(10) CHECK (Gender IN ('Male', 'Female', 'Other'))
);

INSERT INTO PATIENT VALUES(101, 'James Wilson', 30, 'Male');
INSERT INTO PATIENT VALUES(102, 'aditi', 20, 'Female');
INSERT INTO PATIENT VALUES(103, 'babli', 25, 'Female');
INSERT INTO PATIENT VALUES(104, 'chotu', 30, 'Male');
INSERT INTO PATIENT VALUES(105, 'dhruv', 25, 'Male');
INSERT INTO PATIENT VALUES(106, 'eshan', 28, 'Male');
INSERT INTO PATIENT VALUES(107, 'hindvi', 24, 'Female');
INSERT INTO PATIENT VALUES(108, 'ishani', 22, 'Female');
INSERT INTO PATIENT VALUES(109, 'Jiyan', 27, 'Male');
INSERT INTO PATIENT VALUES(110, 'moni', 21, 'Female');

-- a) Insert at least 10 records in table (already done above)

-- b) Find detail of all tables
SELECT * FROM DOCTOR1;
SELECT * FROM PATIENT;

-- c) Delete record from DOCTORS where qualification is male or female
-- Note: This query was incorrect in original as it tried to delete from DOCTOR instead of DOCTOR1
-- Also, qualification wouldn't be 'Male' or 'Female' - this was likely meant for PATIENT table
DELETE FROM PATIENT WHERE Gender IN ('Male', 'Female');

-- d) Find detail of patient where age is less than 40
SELECT * FROM PATIENT WHERE Age < 40;

-- e) Update the patient name where patient id is 5
UPDATE PATIENT SET Pname = 'New Name' WHERE Pid = 105;

-- Practical 5: Employee database
CREATE TABLE Employee (
    emp_no INT PRIMARY KEY, 
    emp_name VARCHAR2(100) NOT NULL, 
    street VARCHAR2(100), 
    city VARCHAR2(100)
);

INSERT INTO Employee VALUES(101, 'pooja', '123 Main St', 'New York');
INSERT INTO Employee VALUES(102, 'Jane Smith', '456 Oak Rd', 'Los Angeles');

CREATE TABLE Works (
    emp_no INT,
    company_name VARCHAR2(100) NOT NULL, 
    joining_date DATE NOT NULL, 
    designation VARCHAR2(100),
    salary DECIMAL(10, 2),
    CONSTRAINT fk_emp_no FOREIGN KEY (emp_no) REFERENCES Employee(emp_no)
);

INSERT INTO Works VALUES(101, 'TechCorp', '10-JAN-22', 'Software Engineer', 75000);
INSERT INTO Works VALUES(102, 'DataSolutions', '19-MAY-22', 'Data Analyst', 68000);

CREATE TABLE Company (
    emp_no INT, 
    company_city VARCHAR2(100), 
    CONSTRAINT fk_emp_no_company FOREIGN KEY (emp_no) REFERENCES Employee(emp_no)
);

INSERT INTO Company VALUES(101, 'New York');
INSERT INTO Company VALUES(102, 'Los Angeles');

CREATE TABLE Manages (
    emp_no INT, 
    manager_name VARCHAR2(100), 
    mang_no INT, 
    CONSTRAINT fk_emp_no_manager FOREIGN KEY (emp_no) REFERENCES Employee(emp_no)
);

INSERT INTO Manages VALUES(101, 'Alice White', 201);
INSERT INTO Manages VALUES(102, 'Tom Green', 202);

-- Practical 6: Retrieve employee details
CREATE TABLE employee1 (
    emp_no NUMBER, 
    emp_name VARCHAR(30), 
    joining_d DATE, 
    designation VARCHAR(30), 
    salary NUMBER
);

INSERT INTO employee1 VALUES(1, 'Dipak', '30-dec-2022', 'manager', 20000);
INSERT INTO employee1 VALUES(2, 'Shivam', '22-july-2022', 'HR', 30000);
INSERT INTO employee1 VALUES(3, 'Mohit', '4-oct-2022', 'Tester', 40000);
INSERT INTO employee1 VALUES(4, 'Keshav', '12-jan-2022', 'designer', 50000);
INSERT INTO employee1 VALUES(5, 'Chetan', '22-feb-2022', 'developer', 22000);
INSERT INTO employee1 VALUES(6, 'Rahul', '11-june-2022', 'manager', 33000);

-- PL/SQL block to retrieve employee details
DECLARE
    eno employee1.emp_no%TYPE := 1; -- Default employee number
    emn employee1.emp_name%TYPE;
    joining_d employee1.joining_d%TYPE;
    ejob employee1.designation%TYPE;
BEGIN
    SELECT emp_name, joining_d, designation 
    INTO emn, joining_d, ejob 
    FROM employee1 
    WHERE emp_no = eno;
    
    DBMS_OUTPUT.PUT_LINE('Employee name: ' || emn);
    DBMS_OUTPUT.PUT_LINE('Joining date: ' || joining_d);
    DBMS_OUTPUT.PUT_LINE('Designation: ' || ejob);
END;
/

-- Practical 7: Update salary of employees earning less than average
CREATE TABLE emp9(
    empid NUMBER, 
    ename VARCHAR(30), 
    emp_salary NUMBER
);

INSERT INTO emp9 VALUES(1, 'Shivam', 10000);
INSERT INTO emp9 VALUES(2, 'Dipak', 30000);
INSERT INTO emp9 VALUES(3, 'Chetan', 35000);
INSERT INTO emp9 VALUES(5, 'Keshav', 40000);
INSERT INTO emp9 VALUES(6, 'Mohit', 45000);

-- PL/SQL block to update salaries
DECLARE
    avg_salary NUMBER;
    total_rows NUMBER(2);
BEGIN
    -- Calculate average salary
    SELECT AVG(emp_salary) INTO avg_salary FROM emp9;
    
    -- Update salaries below average
    UPDATE emp9
    SET emp_salary = emp_salary + 5000
    WHERE emp_salary < avg_salary;
    
    -- Get number of rows updated
    total_rows := SQL%ROWCOUNT;
    
    IF SQL%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('No employee salary updated');
    ELSIF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE(total_rows || ' salaries updated');
    END IF;
END;
/

-- Practical 8: Trigger for salary changes
CREATE TABLE EmployeeDetails (
    emp_no NUMBER PRIMARY KEY,
    emp_name VARCHAR2(100),
    street VARCHAR2(100),
    city VARCHAR2(50),
    company_name VARCHAR2(100),
    joining_date DATE,
    designation VARCHAR2(50),
    salary NUMBER(10,2)
);

INSERT INTO EmployeeDetails VALUES (1, 'John Doe', '123 Main St', 'New York', 'TechCorp', TO_DATE('2020-06-15', 'YYYY-MM-DD'), 'Software Engineer', 80000);
INSERT INTO EmployeeDetails VALUES (2, 'Jane Smith', '456 Elm St', 'Los Angeles', 'FinBank', TO_DATE('2018-04-23', 'YYYY-MM-DD'), 'Financial Analyst', 75000);
INSERT INTO EmployeeDetails VALUES (3, 'Alice Johnson', '789 Oak St', 'Chicago', 'HealthPlus', TO_DATE('2019-09-10', 'YYYY-MM-DD'), 'Data Scientist', 90000);

CREATE TABLE SalaryHistory(
    emp_no NUMBER, 
    old_salary NUMBER(10,2),
    change_date DATE,
    CONSTRAINT fk_salaryhistory_employee FOREIGN KEY (emp_no) REFERENCES EmployeeDetails(emp_no)
);

-- Create Trigger to Capture Salary Changes
CREATE OR REPLACE TRIGGER trg_salary_update
BEFORE UPDATE ON EmployeeDetails
FOR EACH ROW
BEGIN
    INSERT INTO SalaryHistory (emp_no, old_salary, change_date)
    VALUES (:OLD.emp_no, :OLD.salary, SYSDATE);
END;
/

-- Practical 9: Trigger for employee name changes
CREATE TABLE StaffRecords (
    emp_no NUMBER PRIMARY KEY, 
    emp_name VARCHAR2(100), 
    street VARCHAR2(100),
    city VARCHAR2(50),
    company_name VARCHAR2(100), 
    joining_date DATE,
    designation VARCHAR2(50),
    salary NUMBER(10,2)
);

INSERT INTO StaffRecords VALUES (1, 'John Doe', '123 Main St', 'New York', 'TechCorp', '15/JUN/22', 'Software Engineer', 80000);
INSERT INTO StaffRecords VALUES (2, 'Jane Smith', '456 Elm St', 'Los Angeles', 'FinBank', '23/APR/24', 'Financial Analyst', 75000);
INSERT INTO StaffRecords VALUES (3, 'Alice Johnson', '789 Oak St', 'Chicago', 'HealthPlus', '9/OCT/24', 'Data Scientist', 90000);

-- Create Trigger to Capture Name Changes
CREATE OR REPLACE TRIGGER trg_emp_name_update
BEFORE UPDATE OF emp_name ON StaffRecords
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Employee Name Changed: Old Value = ' || :OLD.emp_name || ', New Value = ' || :NEW.emp_name);
END;
/

-- Practical 10: Student percentage analysis
CREATE TABLE student_course (
    student_id NUMBER PRIMARY KEY, 
    student_name VARCHAR2(100), 
    course_name VARCHAR2(100), 
    percentage NUMBER(5,2)
);

INSERT INTO student_course VALUES (1, 'Alice Brown', 'Mathematics', 85);
INSERT INTO student_course VALUES (2, 'Bob Smith', 'Mathematics', 72);
INSERT INTO student_course VALUES (3, 'Charlie Johnson', 'Mathematics', 65);
INSERT INTO student_course VALUES (4, 'David Lee', 'Mathematics', 58);
INSERT INTO student_course VALUES (5, 'Eva Adams', 'Mathematics', 45);
INSERT INTO student_course VALUES (6, 'Frank White', 'Science', 90);
INSERT INTO student_course VALUES (7, 'Grace Hall', 'Science', 62);
INSERT INTO student_course VALUES (8, 'Henry King', 'Science', 50);
INSERT INTO student_course VALUES (9, 'Ivy Scott', 'Science', 40);
INSERT INTO student_course VALUES (10, 'Jack Wilson', 'Science', 75);

-- Create Procedure to Count Students in Percentage Ranges
CREATE OR REPLACE PROCEDURE Count_Students (p_course_name IN VARCHAR2)
IS
    v_high NUMBER := 0;
    v_mid NUMBER := 0;
    v_low NUMBER := 0;
    v_fail NUMBER := 0;
BEGIN
    SELECT
        COUNT(CASE WHEN percentage >= 70 THEN 1 END),
        COUNT(CASE WHEN percentage BETWEEN 60 AND 69 THEN 1 END),
        COUNT(CASE WHEN percentage BETWEEN 50 AND 59 THEN 1 END),
        COUNT(CASE WHEN percentage < 50 THEN 1 END)
    INTO v_high, v_mid, v_low, v_fail
    FROM student_course
    WHERE course_name = p_course_name;
    
    DBMS_OUTPUT.PUT_LINE('Course: ' || p_course_name);
    DBMS_OUTPUT.PUT_LINE('70% and above: ' || v_high);
    DBMS_OUTPUT.PUT_LINE('60-69%: ' || v_mid);
    DBMS_OUTPUT.PUT_LINE('50-59%: ' || v_low);
    DBMS_OUTPUT.PUT_LINE('Below 50%: ' || v_fail);
END;
/

-- Practical 11: Function to add two numbers
CREATE OR REPLACE FUNCTION add_numbers(
    num1 IN NUMBER,
    num2 IN NUMBER
) RETURN NUMBER IS
    result NUMBER;
BEGIN
    result := num1 + num2;
    RETURN result;
END add_numbers;
/

-- Calling the function
DECLARE
    sum_result NUMBER;
BEGIN
    sum_result := add_numbers(5, 10);
    DBMS_OUTPUT.PUT_LINE('The sum is: ' || sum_result);
END;
/

-- Practical 12: Function to return total salary of a department
CREATE TABLE staff (
    employee_id NUMBER PRIMARY KEY, 
    employee_name VARCHAR2(100), 
    salary NUMBER, 
    department_id NUMBER
);

INSERT INTO staff VALUES (1, 'John Doe', 5000, 10);
INSERT INTO staff VALUES (2, 'Jane Smith', 6000, 10);
INSERT INTO staff VALUES (3, 'Alice Johnson', 7000, 20);

-- Function to calculate total salary of a department
CREATE OR REPLACE FUNCTION get_total_salary(
    dept_no IN NUMBER
) RETURN NUMBER IS
    total_salary NUMBER := 0;
BEGIN
    SELECT SUM(salary) INTO total_salary 
    FROM staff 
    WHERE department_id = dept_no;
    
    RETURN NVL(total_salary, 0);
END get_total_salary;
/

-- Calling the function
DECLARE
    dept_salary NUMBER;
BEGIN
    dept_salary := get_total_salary(10);
    DBMS_OUTPUT.PUT_LINE('Total salary for department 10: ' || dept_salary);
END;
/

-- Practical 13: Package for student operations
CREATE TABLE student (
    student_id NUMBER PRIMARY KEY, 
    name VARCHAR2(100), 
    age NUMBER, 
    course VARCHAR2(100)
);

INSERT INTO student VALUES (1, 'john doe', 20, 'computer science');
INSERT INTO student VALUES (2, 'jane smith', 22, 'mathematics');
INSERT INTO student VALUES (3, 'robert brown', 21, 'physics');

-- Package Specification
CREATE OR REPLACE PACKAGE student_pkg AS
    PROCEDURE insert_student(p_id NUMBER, p_name VARCHAR2, p_age NUMBER, p_course VARCHAR2);
    PROCEDURE update_student(p_id NUMBER, p_name VARCHAR2, p_age NUMBER, p_course VARCHAR2);
    PROCEDURE delete_student(p_id NUMBER);
    PROCEDURE get_student(p_id NUMBER);
END student_pkg;
/

-- Package Body
CREATE OR REPLACE PACKAGE BODY student_pkg AS
    PROCEDURE insert_student(p_id NUMBER, p_name VARCHAR2, p_age NUMBER, p_course VARCHAR2) IS
    BEGIN
        INSERT INTO student (student_id, name, age, course)
        VALUES (p_id, p_name, p_age, p_course);
        COMMIT;
    END insert_student;

    PROCEDURE update_student(p_id NUMBER, p_name VARCHAR2, p_age NUMBER, p_course VARCHAR2) IS
    BEGIN
        UPDATE student
        SET name = p_name, age = p_age, course = p_course
        WHERE student_id = p_id;
        COMMIT;
    END update_student;

    PROCEDURE delete_student(p_id NUMBER) IS
    BEGIN
        DELETE FROM student WHERE student_id = p_id;
        COMMIT;
    END delete_student;

    PROCEDURE get_student(p_id NUMBER) IS
        v_name student.name%TYPE;
        v_age student.age%TYPE;
        v_course student.course%TYPE;
    BEGIN
        SELECT name, age, course INTO v_name, v_age, v_course
        FROM student WHERE student_id = p_id;
        
        DBMS_OUTPUT.PUT_LINE('ID: ' || p_id || ', Name: ' || v_name || 
                            ', Age: ' || v_age || ', Course: ' || v_course);
    END get_student;
END student_pkg;
/

-- Practical 14: Exception handling
DECLARE
    -- user-defined exception
    negative_value EXCEPTION;
    PRAGMA EXCEPTION_INIT(negative_value, -20001);

    -- built-in exception (for division by zero)
    v_divisor NUMBER := 0;

    -- variable to test exceptions
    v_value NUMBER := -5;
BEGIN
    -- handling built-in exception (zerodivisionerror equivalent)
    IF v_divisor = 0 THEN
        RAISE ZERO_DIVIDE;
    END IF;

    -- handling user-defined exception
    IF v_value < 0 THEN
        RAISE negative_value;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Valid input received: ' || v_value);

EXCEPTION
    WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('Caught a built-in exception: Division by zero is not allowed.');
    WHEN negative_value THEN
        DBMS_OUTPUT.PUT_LINE('Caught a user-defined exception: Negative values are not allowed.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
END;
/

-- Practical 15: Reverse a string
DECLARE
    v_input_string VARCHAR2(100) := 'PLSQLExample'; -- Input string
    v_reversed_string VARCHAR2(100) := '';
    v_length NUMBER;
BEGIN
    -- Get the length of the input string
    v_length := LENGTH(v_input_string);

    -- Loop through the string in reverse order
    FOR i IN REVERSE 1..v_length LOOP
        v_reversed_string := v_reversed_string || SUBSTR(v_input_string, i, 1);
    END LOOP;

    -- Output the reversed string
    DBMS_OUTPUT.PUT_LINE('Original String: ' || v_input_string);
    DBMS_OUTPUT.PUT_LINE('Reversed String: ' || v_reversed_string);
END;
/

-- Practical 16: Trigger for auditing table changes
CREATE TABLE employees_audit (
    audit_id NUMBER PRIMARY KEY, 
    employee_id NUMBER NOT NULL, 
    salary NUMBER, 
    operation_type VARCHAR2(10) NOT NULL, 
    operation_timestamp TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE SEQUENCE employees_audit_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Create a trigger to assign next sequence value to audit_id
CREATE OR REPLACE TRIGGER employees_audit_trg
BEFORE INSERT ON employees_audit
FOR EACH ROW
BEGIN
    SELECT employees_audit_seq.NEXTVAL INTO :NEW.audit_id FROM dual;
END;
/

-- Practical 17: Employee bonus calculation using cursor
CREATE TABLE employee_info (
    employee_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    salary NUMBER(10,2)
);

INSERT INTO employee_info VALUES (101, 'alice', 60000);
INSERT INTO employee_info VALUES (102, 'bob', 55000);
INSERT INTO employee_info VALUES (103, 'charlie', 48000);
INSERT INTO employee_info VALUES (104, 'david', 70000);

-- PL/SQL block to calculate bonus
DECLARE
    -- declare cursor
    CURSOR emp_cursor IS
        SELECT employee_id, name, salary 
        FROM employee_info 
        WHERE salary > 50000;

    -- declare variables to hold employee details
    v_emp_id employee_info.employee_id%TYPE;
    v_name employee_info.name%TYPE;
    v_salary employee_info.salary%TYPE;
    v_bonus NUMBER(10,2);
BEGIN
    -- open the cursor
    OPEN emp_cursor;

    LOOP
        -- fetch employee data
        FETCH emp_cursor INTO v_emp_id, v_name, v_salary;
        EXIT WHEN emp_cursor%NOTFOUND;

        -- calculate bonus (10% of salary)
        v_bonus := v_salary * 0.10;

        -- display the result
        DBMS_OUTPUT.PUT_LINE('Employee ID: ' || v_emp_id || 
                            ', Name: ' || v_name || 
                            ', Bonus: ' || v_bonus);
    END LOOP;

    -- close the cursor
    CLOSE emp_cursor;
END;
/

-- Practical 18: Aggregate functions
CREATE TABLE employeetable (
    employee_id NUMBER PRIMARY KEY, 
    name VARCHAR2(100), 
    salary NUMBER(10,2)
);

INSERT INTO employeetable VALUES (101, 'alice', 60000);
INSERT INTO employeetable VALUES (102, 'bob', 55000);
INSERT INTO employeetable VALUES (103, 'charlie', 48000);
INSERT INTO employeetable VALUES (104, 'david', 70000);

-- Aggregate functions
SELECT COUNT(*) AS total_employees FROM employeetable;
SELECT AVG(salary) AS average_salary FROM employeetable;
SELECT SUM(salary) AS total_salary FROM employeetable;
SELECT MAX(salary) AS highest_salary FROM employeetable;
SELECT MIN(salary) AS lowest_salary FROM employeetable;

-- Practical 19: Find even numbers
DECLARE
    v_start NUMBER := 1; -- starting number
    v_end NUMBER := 20; -- ending number
BEGIN
    DBMS_OUTPUT.PUT_LINE('Even numbers between ' || v_start || ' and ' || v_end || ':');

    FOR i IN v_start..v_end LOOP
        IF MOD(i, 2) = 0 THEN
            DBMS_OUTPUT.PUT_LINE(i);
        END IF;
    END LOOP;
END;
/

-- Practical 20: Find largest of three numbers
DECLARE
    num1 NUMBER := 15;
    num2 NUMBER := 25;
    num3 NUMBER := 10;
    largest NUMBER;
BEGIN
    IF num1 >= num2 AND num1 >= num3 THEN
        largest := num1;
    ELSIF num2 >= num1 AND num2 >= num3 THEN
        largest := num2;
    ELSE
        largest := num3;
    END IF;

    DBMS_OUTPUT.PUT_LINE('The largest number is: ' || largest);
END;
/

-- Practical 21: Check for palindrome
DECLARE
    v_text VARCHAR2(100) := 'madam';
    v_reversed_text VARCHAR2(100) := '';
    v_length NUMBER;
BEGIN
    v_length := LENGTH(v_text);

    -- reversing the text
    FOR i IN REVERSE 1..v_length LOOP
        v_reversed_text := v_reversed_text || SUBSTR(v_text, i, 1);
    END LOOP;

    -- checking if palindrome
    IF v_text = v_reversed_text THEN
        DBMS_OUTPUT.PUT_LINE('The given text "' || v_text || '" is a palindrome.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('The given text "' || v_text || '" is not a palindrome.');
    END IF;
END;
/

-- Practical 22: Insert values in table
CREATE TABLE employees (
    emp_id NUMBER PRIMARY KEY, 
    emp_name VARCHAR2(100), 
    salary NUMBER(10,2), 
    department_id NUMBER
);

INSERT INTO employees VALUES(1, 'pooja', 50000, 101);
INSERT INTO employees VALUES(2, 'siya', 40000, 102);
INSERT INTO employees VALUES(3, 'piya', 30000, 103);

-- PL/SQL block to insert values
DECLARE
    v_emp_id NUMBER := 4;
    v_emp_name VARCHAR2(100) := 'emma watson';
    v_salary NUMBER := 70000;
    v_department_id NUMBER := 30;
BEGIN
    INSERT INTO employees (emp_id, emp_name, salary, department_id)
    VALUES (v_emp_id, v_emp_name, v_salary, v_department_id);

    DBMS_OUTPUT.PUT_LINE('Record inserted successfully');
    COMMIT;
END;
/

-- Practical 23: Update values using implicit cursor
CREATE TABLE employees2 (
    emp_id NUMBER PRIMARY KEY, 
    emp_name VARCHAR2(100), 
    salary NUMBER(10,2), 
    department_id NUMBER
);

INSERT INTO employees2 VALUES(1, 'pooja', 50000, 101);
INSERT INTO employees2 VALUES(2, 'siya', 40000, 102);
INSERT INTO employees2 VALUES(3, 'piya', 30000, 103);

-- PL/SQL block to update using implicit cursor
DECLARE
    v_dept_id NUMBER := 101; -- update employees in this department
    v_increment NUMBER := 5000; -- salary increment amount
BEGIN
    -- implicit cursor for updating salary
    UPDATE employees2
    SET salary = salary + v_increment
    WHERE department_id = v_dept_id;

    -- display number of rows updated
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' record(s) updated.');
    COMMIT; -- save changes
END;
/

-- Practical 24: Display employee details using explicit cursor
CREATE TABLE emp (
    emp_id NUMBER PRIMARY KEY, 
    first_name VARCHAR2(50), 
    last_name VARCHAR2(50), 
    job_id VARCHAR2(20), 
    salary NUMBER(10,2)
);

INSERT INTO emp VALUES(1, 'pooja', 'bonde', 'hr', 50000);
INSERT INTO emp VALUES(2, 'siya', 'patil', 'programmer', 40000);
INSERT INTO emp VALUES(3, 'piya', 'mahajan', 'accountant', 30000);

-- PL/SQL block with explicit cursor
DECLARE
    -- declare an explicit cursor for selecting employee details
    CURSOR emp_cursor IS
        SELECT emp_id, first_name, last_name, job_id, salary FROM emp;

    -- declare variables to hold fetched data
    v_emp_id emp.emp_id%TYPE;
    v_first_name emp.first_name%TYPE;
    v_last_name emp.last_name%TYPE;
    v_job_id emp.job_id%TYPE;
    v_salary emp.salary%TYPE;
BEGIN
    -- open the cursor
    OPEN emp_cursor;

    LOOP
        -- fetch data into variables
        FETCH emp_cursor INTO v_emp_id, v_first_name, v_last_name, v_job_id, v_salary;
        EXIT WHEN emp_cursor%NOTFOUND;

        -- display employee details
        DBMS_OUTPUT.PUT_LINE('Employee ID: ' || v_emp_id ||
                            ', Name: ' || v_first_name || ' ' || v_last_name ||
                            ', Job ID: ' || v_job_id ||
                            ', Salary: ' || v_salary);
    END LOOP;

    -- close the cursor
    CLOSE emp_cursor;
END;
/

-- Practical 25: Display employee names and salary using cursor
CREATE TABLE cmpp(
    emp_id NUMBER PRIMARY KEY, 
    first_name VARCHAR2(50),
    last_name VARCHAR2(50), 
    salary NUMBER(10,2)
);

INSERT INTO cmpp VALUES(1, 'pooja', 'bonde', 800000);
INSERT INTO cmpp VALUES(2, 'reyansh', 'bonde', 500000);
INSERT INTO cmpp VALUES(3, 'khushi', 'mahajan', 70000);

-- PL/SQL block with cursor
DECLARE
    -- declare an explicit cursor to fetch employee names and salary
    CURSOR emp_cursor IS
        SELECT first_name, last_name, salary FROM cmpp;

    -- declare variables to hold the fetched data
    v_first_name cmpp.first_name%TYPE;
    v_last_name cmpp.last_name%TYPE;
    v_salary cmpp.salary%TYPE;
BEGIN
    -- open the cursor
    OPEN emp_cursor;

    LOOP
        -- fetch data into variables
        FETCH emp_cursor INTO v_first_name, v_last_name, v_salary;
        EXIT WHEN emp_cursor%NOTFOUND;

        -- display employee names and salary
        DBMS_OUTPUT.PUT_LINE('Employee: ' || v_first_name || ' ' || v_last_name || 
                            ', Salary: ' || v_salary);
    END LOOP;

    -- close the cursor
    CLOSE emp_cursor;
END;
/

-- Practical 26: Using two cursors at a time
CREATE TABLE DEPARTMENT28 (
    dept_id NUMBER PRIMARY KEY, 
    dept_name VARCHAR2(50)
);

CREATE TABLE EMPLOYEE28 (
    emp_id NUMBER PRIMARY KEY, 
    emp_name VARCHAR2(100), 
    dept_id NUMBER REFERENCES DEPARTMENT28(dept_id)
);

INSERT INTO DEPARTMENT28 VALUES (1, 'HR');
INSERT INTO DEPARTMENT28 VALUES (2, 'IT');

INSERT INTO EMPLOYEE28 VALUES (101, 'Alice', 1);
INSERT INTO EMPLOYEE28 VALUES (102, 'Bob', 1);
INSERT INTO EMPLOYEE28 VALUES (201, 'Charlie', 2);
INSERT INTO EMPLOYEE28 VALUES (202, 'David', 2);

-- PL/SQL block with two cursors
DECLARE
    -- Cursor for Department
    CURSOR dept_cursor IS
        SELECT dept_id, dept_name FROM DEPARTMENT28;

    -- Cursor for Employee (Parameterized Cursor)
    CURSOR emp_cursor (p_dept_id NUMBER) IS
        SELECT emp_name FROM EMPLOYEE28 WHERE dept_id = p_dept_id;

    v_dept_id NUMBER;
    v_dept_name VARCHAR2(50);
    v_emp_name VARCHAR2(100);
BEGIN
    OPEN dept_cursor;
    LOOP
        FETCH dept_cursor INTO v_dept_id, v_dept_name;
        EXIT WHEN dept_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Department: ' || v_dept_name);
        
        OPEN emp_cursor(v_dept_id);
        LOOP
            FETCH emp_cursor INTO v_emp_name;
            EXIT WHEN emp_cursor%NOTFOUND;

            DBMS_OUTPUT.PUT_LINE(' Employee: ' || v_emp_name);
        END LOOP;
        CLOSE emp_cursor;
        
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
    CLOSE dept_cursor;
END;
/

-- Practical 27: Procedure to find reverse number
CREATE OR REPLACE PROCEDURE reverse_number(
    p_input IN NUMBER,
    p_output OUT NUMBER
) IS
    v_temp NUMBER := p_input;
    v_reversed NUMBER := 0;
BEGIN
    WHILE v_temp > 0 LOOP
        v_reversed := v_reversed * 10 + MOD(v_temp, 10);
        v_temp := FLOOR(v_temp / 10);
    END LOOP;
    
    p_output := v_reversed;
END reverse_number;
/

-- Calling the procedure
DECLARE
    v_input NUMBER := 12345;
    v_output NUMBER;
BEGIN
    reverse_number(v_input, v_output);
    DBMS_OUTPUT.PUT_LINE('Reversed Number: ' || v_output);
END;
/

-- Practical 28: Procedure to find factorial
CREATE OR REPLACE PROCEDURE find_factorial(
    p_num IN NUMBER,
    p_result OUT NUMBER
) IS
BEGIN
    p_result := 1;
    FOR i IN 1..p_num LOOP
        p_result := p_result * i;
    END LOOP;
END find_factorial;
/

-- Calling the procedure
DECLARE
    v_input NUMBER := 5;
    v_output NUMBER;
BEGIN
    find_factorial(v_input, v_output);
    DBMS_OUTPUT.PUT_LINE('The factorial of ' || v_input || ' is ' || v_output);
END;
/

-- Practical 29 & 30 (Concise)

--*****************************************************************************************************************
-- Practical 29: PL/SQL Cursor to update and display employee details with salary increase
--*****************************************************************************************************************

CREATE TABLE EMPLOYEE_DETAILS (
    emp_id NUMBER PRIMARY KEY,
    emp_name VARCHAR2(100),
    salary NUMBER(10, 2),
    dept_id NUMBER
);

INSERT INTO EMPLOYEE_DETAILS (emp_id, emp_name, salary, dept_id) VALUES (101, 'John Doe', 50000, 10);
INSERT INTO EMPLOYEE_DETAILS (emp_id, emp_name, salary, dept_id) VALUES (102, 'Jane Smith', 60000, 20);
INSERT INTO EMPLOYEE_DETAILS (emp_id, emp_name, salary, dept_id) VALUES (103, 'Alice Kim', 55000, 10);
INSERT INTO EMPLOYEE_DETAILS (emp_id, emp_name, salary, dept_id) VALUES (104, 'Bob Lee', 70000, 20);

DECLARE
    CURSOR emp_cursor IS SELECT emp_id, emp_name, salary, dept_id FROM EMPLOYEE_DETAILS WHERE dept_id = 20;
    v_emp_id NUMBER;
    v_emp_name VARCHAR2(100);
    v_salary NUMBER(10, 2);
    v_dept_id NUMBER;    
    bonus_percentage NUMBER := 0.10;
BEGIN
    OPEN emp_cursor;
    DBMS_OUTPUT.PUT_LINE('Employee Details with 10% Bonus (Dept 20):');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');    
    LOOP
        FETCH emp_cursor INTO v_emp_id, v_emp_name, v_salary, v_dept_id;
        EXIT WHEN emp_cursor%NOTFOUND;        
        v_salary := v_salary * (1 + bonus_percentage);
        DBMS_OUTPUT.PUT_LINE('Emp ID: ' || v_emp_id || ', Name: ' || v_emp_name || ', Updated Salary: ' || v_salary);        
        UPDATE EMPLOYEE_DETAILS SET salary = v_salary WHERE emp_id = v_emp_id;        
    END LOOP;    
    CLOSE emp_cursor;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Salaries updated for employees in Department 20.');    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END;
/

-- Expected Output:
-- Employee Details with 10% Bonus (Department 20):
-- ------------------------------------------------------
-- Employee ID: 102, Name: Jane Smith, Updated Salary: 66000
-- Employee ID: 104, Name: Bob Lee, Updated Salary: 77000
-- ------------------------------------------------------
-- Salaries updated successfully for employees in Department 20.

--*****************************************************************************************************************
-- Practical 30: PL/SQL Function to Calculate Total Salary for a Department and Handle Exceptions
--*****************************************************************************************************************

CREATE TABLE EMPLOYEES (
    emp_id NUMBER PRIMARY KEY,
    emp_name VARCHAR2(100),
    salary NUMBER(10, 2),
    dept_id NUMBER
);

INSERT INTO EMPLOYEES (emp_id, emp_name, salary, dept_id) VALUES (1, 'Alice', 50000, 10);
INSERT INTO EMPLOYEES (emp_id, emp_name, salary, dept_id) VALUES (2, 'Bob', 60000, 10);
INSERT INTO EMPLOYEES (emp_id, emp_name, salary, dept_id) VALUES (3, 'Charlie', 55000, 20);
INSERT INTO EMPLOYEES (emp_id, emp_name, salary, dept_id) VALUES (4, 'David', 70000, 20);

CREATE OR REPLACE FUNCTION calculate_total_salary (p_dept_id NUMBER) RETURN NUMBER
IS
    total_salary NUMBER := 0;
    invalid_dept_id EXCEPTION;
    dept_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO dept_count FROM (SELECT DISTINCT dept_id FROM EMPLOYEES) WHERE dept_id = p_dept_id;
    IF dept_count = 0 THEN
        RAISE invalid_dept_id;
    END IF;

    SELECT SUM(salary) INTO total_salary FROM EMPLOYEES WHERE dept_id = p_dept_id;
    RETURN total_salary;

EXCEPTION
    WHEN invalid_dept_id THEN
        RAISE_APPLICATION_ERROR(-20001, 'Error: Invalid Department ID.');
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20002, 'Error: ' || SQLERRM);
END;
/

DECLARE
    v_total_salary NUMBER;
    v_dept_id NUMBER := 10;
BEGIN
    v_total_salary := calculate_total_salary(v_dept_id);
    DBMS_OUTPUT.PUT_LINE('Total salary for Dept ' || v_dept_id || ': ' || v_total_salary);

    v_dept_id := 30;
    v_total_salary := calculate_total_salary(v_dept_id);
    DBMS_OUTPUT.PUT_LINE('Total salary for Dept ' || v_dept_id || ': ' || v_total_salary);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

-- Expected Output:
-- Total salary for Department 10: 110000
-- Error: Invalid Department ID.