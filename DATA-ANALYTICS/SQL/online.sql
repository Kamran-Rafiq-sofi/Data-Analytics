-- Objective
-- Send feedback
-- Consider that you have got an intemship in an upcoming unicorn startup. The organisation wants to create an online survey feature for thc
-- different categories of the products sold by them to help with their business intelligence and make out useful strategies to improve.
-- Now, you are given the very first task which is to design a database schema for this scenario to store the necessary data.
-- Few of the requirements for the survey are as follows:
-- I, The survey can be reused to get feedback for multiple products, It would contain the ratings given by the buyer.
-- 2, A customer is the registered user to whom the shopping account belongs. A customer will take up a survey when he/she will purchase a
-- product
-- 3. A survey will have multiple questions. These questions are selected from a large dataset containing different types of questions. The questions
-- can be subjective as well as objective types of questions.
-- 4. Customers and buyers(the customers who have made a purchase) are stored separately
-- 5. Buyers have to answer the questions given in the feedback, some of which are mandatory and some are optional. These answers should also
-- be stored separately so that analysis can be done on all the answers received till date for the products.
-- 6. It should have all the details of the customer and the product bought with it's feedback.
-- Now keeping the above information in mind. design the Survey database schema by answering the following questions step by step:



-- I. Identify the entities
-- Entities are 
-- Customers,account_created,products ,surveys,questions,answers,buyers



-- 2. Identify the attributes for various entities.
create table CUSTOMERS(
customer_id INT PRIMARY KEY,
customer_name VARCHAR(255),
account_id INT,
phone_number BIGINT,
email VARCHAR(255) UNIQUE
);
create table ACCOUNT_CREATED(
account_id INT,
customers_id INT,
account_created_on DATE,
PRIMARY KEY(account_id),
FOREIGN KEY(customers_id) REFERENCES CUSTOMERS(customer_id)
);
create table PRODUCTS(
product_id INT PRIMARY KEY,
product_name VARCHAR(255),
product_category VARCHAR(255),
product_description TEXT

);

 create table BUYERS(
purchase_id INT,
customers_id INT,
product_id 	INT,
PRIMARY KEY(purchase_id),
FOREIGN KEY(customers_id)  REFERENCES CUSTOMERS(customer_id),
FOREIGN KEY(product_id) REFERENCES PRODUCTS(product_id)

) ;    

create table SURVEYS(
survey_id INT,
product_id INT,
survey_name VARCHAR(250),
create_on DATETIME,
PRIMARY KEY(survey_id),
FOREIGN KEY(product_id) REFERENCES PRODUCTS(product_id)
);

create table QUESTIONS(
question_id INT,
question_type ENUM('SUBJECTIVE','OBJECTIVE'),
survey_id INT,
question_text TEXT,
PRIMARY KEY(question_id),
FOREIGN KEY(survey_id) REFERENCES SURVEYS(survey_id)
  
);

create table ANSWERS(
answer_id INT,
survey_id INT,
question_id INT,
purchase_id INT,
answer_text TEXT,
choice_id INT,
PRIMARY KEY(answer_id),
FOREIGN KEY(survey_id) REFERENCES SURVEYS(survey_id),
FOREIGN KEY(question_id) REFERENCES QUESTIONS(question_id),
FOREIGN KEY(purchase_id) REFERENCES BUYERS(purchase_id)


);


-- 3. Identify the relationships with the cardinalities.
CUSTOMER ---ACCOUNT_CREATED
ONE Customer can have multiple accounts(1:N)

CUSTOMERS--BUYERS
one customer can be many buyers(1:N)

PRODUCTS----BUYERS
one product many buyers(1:N)

PRODUCTS----surveys
one product many surveys(1:N)


SURVEYS---QUESTIONS
one survey  many questions  (1:N)


ANSWER-------BUYRRS
one buyer can give one answer for each question(1:1)


ANSWEERS----QUESTION
many answers for one question(N:1)


-- 4. Create the ER diagram


-- 5. Create the Relational schema.


CREATE DATABASE ONLINE_STORE_STARTUP;
USE ONLINE_STORE_STARTUP;
CREATE TABLE CUSTOMERS(
customer_id INT PRIMARY KEY,
customer_name VARCHAR(255),
account_id INT,
phone_number BIGINT,
email VARCHAR(255) UNIQUE
);
INSERT INTO CUSTOMERS VALUES(0699,'ZAIN',684,1234567890,'ZAIN@GMAIL.COM'),
							(0495,'SAMEENA',485,0987654321,'SAMEENA@GMAIL.COM');
SELECT * FROM CUSTOMERS;

CREATE TABLE ACCOUNT_CREATED(
account_id INT,
customers_id INT,
account_created_on DATE,
PRIMARY KEY(account_id),
FOREIGN KEY(customers_id) REFERENCES CUSTOMERS(customer_id)


);


INSERT INTO ACCOUNT_CREATED VALUES(684,0699,'2024-01-06'),
                                  (485,0495,'2024-01-06');
SELECT * FROM ACCOUNT_CREATED; 

SELECT 
      c.customer_id,c.customer_name ,a.account_id,a.account_created_on 
FROM
      CUSTOMERS AS c
INNER JOIN
      ACCOUNT_CREATED AS a
ON 
c.customer_id=a.customers_id;



CREATE TABLE PRODUCTS(
product_id INT PRIMARY KEY,
product_name VARCHAR(255),
product_category VARCHAR(255),
product_description TEXT

);
ALTER TABLE PRODUCTS
ADD PRIMARY KEY (product_id);


INSERT INTO PRODUCTS VALUES(111,'MOBILE','ELECTRONICS','THIS IS AN ELECTRONIC PRODUCT'),
							(112,'PAPER','STATIONARY','THIS IS A STATIONARY PRODUCT');
   
CREATE TABLE BUYERS(
purchase_id INT,
customers_id INT,
product_id 	INT,
PRIMARY KEY(purchase_id),
FOREIGN KEY(customers_id)  REFERENCES CUSTOMERS(customer_id),
FOREIGN KEY(product_id) REFERENCES PRODUCTS(product_id)

);

INSERT INTO BUYERS VALUES(11213,0699,111),
							(11214,0495,112);
SELECT * FROM BUYERS; 

-- SELECT c.customer_id, c.customer_name,p.product_name,b.purchase_id
-- FROM CUSTOMERS AS c
-- INNER JOIN
--         PRODUCTS AS p
-- ON    
--     c.customer_id=p.product_id
-- INNER JOIN
--          BUYERS AS b
-- ON 
--    p.product_id=b.product_id; 


SELECT p.product_name,b.purchase_id
FROM PRODUCTS AS p
INNER JOIN
        BUYERS AS b
ON    
    p.product_id=b.product_id;
        
        
         

CREATE TABLE SURVEYS(
survey_id INT,
product_id INT,
survey_name VARCHAR(250),
create_on DATETIME,
PRIMARY KEY(survey_id),
FOREIGN KEY(product_id) REFERENCES PRODUCTS(product_id)
);
INSERT INTO SURVEYS VALUES(1221, 111 ,'QUALITY','2024-01-06 21:28:34'),
                           (1222, 111 ,'PRICE','2024-01-06 21:28:56'),
                           (1223, 112 ,'QUALITY','2024-01-06 21:30:34'),
                           (1224, 112 ,'PRICE','2024-01-06 21:31:34');
                           
                           
                          
SELECT * FROM SURVEYS WHERE survey_id=1221;
SELECT * FROM SURVEYS WHERE product_id=111;
-- UPDATE TABLE 


CREATE TABLE QUESTIONS(
question_id INT,
question_type ENUM('SUBJECTIVE','OBJECTIVE'),
survey_id INT,
question_text TEXT,
PRIMARY KEY(question_id),
FOREIGN KEY(survey_id) REFERENCES SURVEYS(survey_id)
  
);

INSERT INTO QUESTIONS VALUES
  ( 12211,'SUBJECTIVE', 1221, 'How would you rate the overall quality of the product?'),
  (12212,'OBJECTIVE', 1221, 'How likely are you satisfied with the quality of  product (1-5)'),
  ( 12213,'SUBJECTIVE', 1222, 'How would you rate the overall  price of the product?'),
  (12214,'OBJECTIVE', 1222, 'How likely are you satisfied with the price of  product (1-5)');
  SELECT * FROM QUESTIONS;
  
  -- ( 12214,'SUBJECTIVE', 1223, 'How would you rate the overall quality of the product?'),
--   (12216,'OBJECTIVE', 1223, 'How likely are you satisfied with the quality of  product (1-5)'),
--   ( 12217,'SUBJECTIVE', 1224, 'How would you rate the overall quality of the product?'),
--   (12218,'OBJECTIVE', 1224, 'How likely are you satisfied with the quality of  product (1-5)');


CREATE TABLE ANSWERS(
answer_id INT,
survey_id INT,
question_id INT,
purchase_id INT,
answer_text TEXT,
choice_id INT,
PRIMARY KEY(answer_id),
FOREIGN KEY(survey_id) REFERENCES SURVEYS(survey_id),
FOREIGN KEY(question_id) REFERENCES QUESTIONS(question_id),
FOREIGN KEY(purchase_id) REFERENCES BUYERS(purchase_id)


);


INSERT INTO ANSWERS VALUES
  ( 612211, 1221, 12211, 11213,'QUITE GOOD',3),
  (612212,1221, 12212, 11213,'YES', 5),
  ( 612213, 1222, 12213, 11213,'sati',1),
  (612214,1222, 12214, 11213,'pYES', 4),
( 612215, 1221, 12211, 11214,'QUITE GOOD',3),
  (612216,1221, 12212, 11214,'YES', 5),
  ( 612217, 1222, 12213, 11214,'sati',1),
  (612218,1222, 12214, 11214,'pYES', 4);
  SELECT * FROM ANSWERS;