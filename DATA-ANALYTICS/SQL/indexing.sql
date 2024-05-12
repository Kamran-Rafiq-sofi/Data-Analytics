CREATE DATABASE INDEXING;
USE INDEXING;
CREATE TABLE CUSTOMERS(
customer_id INT,
customer_Fname VARCHAR(50),
customer_Lname VARCHAR(50),
customer_address VARCHAR(50)




);
INSERT INTO CUSTOMERS VALUES(1,'ZAIN','RAFIQ','BONIYAR'),
                             (2,'SAMEENA','WANI','BARAMULLA'),
                             (3,'KAMRAN','R','TRIKANJAN');
-- primary indexing						
SELECT * FROM CUSTOMERS;    
SELECT * FROM CUSTOMERS WHERE CUSTOMER_ID=1; 
ALTER TABLE CUSTOMERS ADD PRIMARY KEY(CUSTOMER_ID);
CREATE UNIQUE INDEX idx_customer_id ON CUSTOMERS(customer_id);





CREATE TABLE STUDENTS(
student_id INT,
student_name VARCHAR(30),
course_id  INT,
student_phone BIGINT

);

INSERT INTO STUDENTS VALUES(1,'zain',101,111),
                           (2,'samy',101,112),
                           (3,'saimy',101,113),
                           (4,'kamran',102,114),
                           (5,'sameena',102,115);
SELECT * FROM STUDENTS;
ALTER TABLE STUDENTS ADD PRIMARY KEY (student_id);
-- CREATE CLUSTERED

-- CREATE TABLE OLD_STUDENTS (
--     student_id INT,
--     student_name VARCHAR(30),
--     course_id INT,
--     student_phone BIGINT,
--     -- Creating a clustered index on the course_id column
--     PRIMARY KEY (student_id),
--     INDEX idx_course_id  (course_id)
-- );
-- CREATE TABLE NEW_STUDENTS (
--     student_id INT,
--     student_name VARCHAR(30),
--     course_id INT,
--     student_phone BIGINT,
--     PRIMARY KEY (course_id)
--     -- Additional columns as needed
-- );
-- DROP TABLE NEW_STUDENTS;
-- -- Error Code: 1062. Duplicate entry '101' for key 'new_students.PRIMARY'

-- INSERT INTO NEW_STUDENTS SELECT * FROM STUDENTS;




CREATE TABLE NEW_STUDENTS (
    student_id INT,
    student_name VARCHAR(30),
    course_id INT,
    student_phone BIGINT,
    PRIMARY KEY (student_id)
    -- Additional columns as needed
);
-- DROP TABLE NEW_STUDENTS;
-- Error Code: 1062. Duplicate entry '101' for key 'new_students.PRIMARY'

INSERT INTO NEW_STUDENTS SELECT * FROM STUDENTS;
SELECT * FROM STUDENTS;
SELECT * FROM NEW_STUDENTS;

RENAME TABLE STUDENTS TO TEMP_TABLE, NEW_STUDENTS TO STUDENTS, TEMP_TABLE TO NEW_STUDENTS;
-- NO CLUSTERING KEY FOR MYSQL PRIMARY INDEX ACTS AS SO FOR INNODB STORAGE ENGINEIN MYSQL



                      
                           
                            