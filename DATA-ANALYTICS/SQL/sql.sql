CREATE DATABASE MOVIE_LIBRARY;
USE MOVIE_LIBRARY;
CREATE TABLE CUSTOMERS_TABLE(
Customer_name  VARCHAR(250),
TITLE  VARCHAR(25),
Address  VARCHAR(250),
Movie_rented  VARCHAR(250)

);
INSERT INTO CUSTOMERS_TABLE VALUES('Lokesh Daga', 'Mr.'  ,'403-B marwadi nagar,Nokha, Rajasthan'   ,'Race 2, Radhe,Bharat'),
                                   ('Neelabh Shukla', 'Mr.'  ,'419-M kota nagar,Nokha, Rajasthan'   ,' Daddys Little Girls'),
                                   ('Lokesh Daga', 'Mr.'  ,' 57 Ashok Nagar,Bikaner, Rajasthan'   ,'The Notebook'),
                                   ('Rashi Sharma', 'Ms.'  ,'109 Ram Nagar,Napasar, Rajasthan'   ,'Fanna, The Notebook');
                                   

SELECT * FROM CUSTOMERS_TABLE;


-- QI. Identify the basic issue with the table currently and convert it into INF normal form and explain your reasons for doing this. Also show how
-- the new table looks ?

-- ANS:  The basic issue with this table is it contains an attribute which contains multiple values which is aginst 1NF rule
--       now we will convert it into a new tablw with only single attributes

CREATE TABLE CUSTOMERS_TABLE_NEW(
Customer_name  VARCHAR(250),
TITLE  VARCHAR(25),
Address  VARCHAR(250),
Movie_rented  VARCHAR(250)

);
INSERT INTO CUSTOMERS_TABLE_NEW VALUES('Lokesh Daga', 'Mr.'  ,'403-B marwadi nagar,Nokha, Rajasthan'   ,'Race 2'),
                                  ('Lokesh Daga', 'Mr.'  ,'403-B marwadi nagar,Nokha, Rajasthan'   ,'Radhe'),
                                  ('Lokesh Daga', 'Mr.'  ,'403-B marwadi nagar,Nokha, Rajasthan'   ,'Bharat'),
                                   ('Neelabh Shukla', 'Mr.'  ,'419-M kota nagar,Nokha, Rajasthan'   ,' Daddys Little Girls'),
                                   ('Lokesh Daga', 'Mr.'  ,' 57 Ashok Nagar,Bikaner, Rajasthan'   ,'The Notebook'),
                                   ('Rashi Sharma', 'Ms.'  ,'109 Ram Nagar,Napasar, Rajasthan'   ,'Fanna'),
								   ('Rashi Sharma', 'Ms.'  ,'109 Ram Nagar,Napasar, Rajasthan'   ,'The Notebook');

                                   

SELECT * FROM CUSTOMERS_TABLE_NEW;
-- Q2. Identify the keys that uniquely identify the tuples in the table you formulated in QI. ?

-- ANS:KEY IS{customer_name,address,movie_rented}


-- Q3. Convert thc table you formulated into its next normal form (2NF) and state your reason for doing so and also create the new tables.
-- Ans:   for 2nf it should be in 1NF that is true but it shouldnt be in partial dependency but movie rented is partailly depented on address 
-- or address or address on customer_name;  address--->movie_rented,customer_name---->address...so to reduce redundancy we will divide it into
-- two tables  customer_details and movie_rented;


CREATE TABLE CUSTOMERS_DETAILS(
Customer_id INT,
Customer_name  VARCHAR(250),
TITLE  VARCHAR(25),
Address  VARCHAR(250),
PRIMARY KEY(Customer_id)

);

INSERT INTO CUSTOMERS_DETAILS VALUES(1,'Lokesh daga','Mr.','403-B marwadi nagar,Nokha, Rajasthan'),
                                    (2,'Neelabh Shukla','Mr.','419-M kota nagar,Nokha, Rajasthan, Rajasthan'),
                                    (3,'Lokesh daga','Mr.','57 Ashok Nagar,Bikaner, Rajasthan'),
                                    (4,'Rashi Sharma','Mr.','109 Ram Nagar,Napasar, Rajasthan');
    SELECT * FROM CUSTOMERS_DETAILS;                                
                                    
 CREATE TABLE MOVIES_RENTED(
 Rental_id INT,
Customer_id INT,
Movies_rented  VARCHAR(250),

PRIMARY KEY(Rental_id),
FOREIGN KEY(Customer_id) REFERENCES CUSTOMERS_DETAILS(Customer_id)

);                                   
                                    
                                    
                                    
INSERT INTO Movies_rented VALUES  (1,1,'Race 2'),
                                  (2,1,'Radhe'),
                                  (3,1,'Bharat'),
								  (4,2,' Daddys Little Girls'),
								  (5,3,'The Notebook'),
								  (6,4,'Fanna'),
								  (7,4,'The Notebook');

                                   

SELECT * FROM Movies_rented;

SELECT c.Customer_id ,c.Customer_name,m.Rental_id,m.Movies_rented
FROM
CUSTOMERS_DETAILS AS c
INNER JOIN
MOVIES_RENTED AS m
ON
c.Customer_id=m.Customer_id;


-- Q4. Now suppose someone wants to add new movies like The Jungle Book, Fast and Furious 9 into the db , which are not yet rented to anyone.
-- can we do that?

-- ANS:  WE CAN ADD THEM IN MOVIES_RENTED TABLE BUT THEN RENTAL ID AND CUSTOMER_ID WILL BE NULLL so we will creste db
-- of movies with movie id and name and rental id as foreign key or movie id and name and change movies rented table with rental id as pk
-- movie id and customer id as foreign key ;
-- movie id    : movie_name
--   11        :  Race 2
--   21        :  Radhe
--   31        :  Bharat
--   41        :  Daddy little girl
--   51        :  The Notebook
--   61        :  Fanna
  


-- Q5. Convert thc tables you have formulated after converting to 2NF into its next possible Normal Form and state your reasons for doing so.
-- so in order to  convert it into 3NF we need to have alook that it must be in 2NF state and there should not be any
-- transitivity relation




CREATE TABLE CUSTOMERS_DETAILS(
Customer_id INT,
Customer_name  VARCHAR(250),
TITLE  VARCHAR(25),
Address  VARCHAR(250),
PRIMARY KEY(Customer_id)

);

INSERT INTO CUSTOMERS_DETAILS VALUES(1,'Lokesh daga','Mr.','403-B marwadi nagar,Nokha, Rajasthan'),
                                    (2,'Neelabh Shukla','Mr.','419-M kota nagar,Nokha, Rajasthan, Rajasthan'),
                                    (3,'Lokesh daga','Mr.','57 Ashok Nagar,Bikaner, Rajasthan'),
                                    (4,'Rashi Sharma','Mr.','109 Ram Nagar,Napasar, Rajasthan');
    SELECT * FROM CUSTOMERS_DETAILS;                                
                                    
 CREATE TABLE MOVIES_RENTED(
 Rental_id INT,
Customer_id INT,
Movies_rented  VARCHAR(250),

PRIMARY KEY(Rental_id),
FOREIGN KEY(Customer_id) REFERENCES CUSTOMERS_DETAILS(Customer_id)

);                                   
                                    
                                    
                                    
INSERT INTO Movies_rented VALUES  (1,1,'Race 2'),
                                  (2,1,'Radhe'),
                                  (3,1,'Bharat'),
								  (4,2,'Daddys Little Girls'),
								  (5,3,'The Notebook'),
								  (6,4,'Fanna'),
								  (7,4,'The Notebook');

                                   

SELECT * FROM MOVIES_RENTED;

SELECT c.Customer_id ,c.Customer_name,m.Rental_id,m.Movies_rented
FROM
CUSTOMERS_DETAILS AS c
INNER JOIN
MOVIES_RENTED AS m
ON
c.Customer_id=m.Customer_id;


CREATE TABLE MOVIES(
Movies_id INT,
Movie_name VARCHAR(250),
PRIMARY KEY(Movies_id)

) ;  
INSERT INTO MOVIES VALUES(1,'Race 2'),
                         (2,'Radhe'),
                         (3,'Bharat'),
                         (4,'Daddys Little Girls'),
                         (5,'The Notebook'),
                         (6,'Fanna');
SELECT * FROM MOVIES;




ALTER TABLE MOVIES_RENTED
		ADD COLUMN  Movies_id INT;
        
-- SAFE MODE ERROR   
      SET SQL_SAFE_UPDATES=0;
UPDATE MOVIES_RENTED
SET Movies_id = (SELECT Movies_id FROM MOVIES WHERE Movie_name = Movies_rented);
SELECT * FROM MOVIES_RENTED;


ALTER TABLE MOVIES_RENTED
DROP COLUMN Movies_rented;

ALTER TABLE MOVIES_RENTED
ADD CONSTRAINT FOREIGN KEY (Movies_id) REFERENCES MOVIES(Movies_id);
SELECT * FROM MOVIES_RENTED;

SELECT m.Movie_name,m.Movies_id ,Mr.Rental_id,Mr.customer_id
FROM
MOVIES AS m
INNER JOIN
MOVIES_RENTED AS mr
ON
m.Movies_id=Mr.Movies_id;

-- DROP TABLE MOVIES;
-- DROP TABLE MOVIES_RENTED;
-- Error Code: 1822. Failed to add the foreign key constraint. Missing index for constraint 'FK_Movie_id' in the referenced table 'movies'

-- CREATE INDEX idx_movies_movie_id ON Movies(movie_id);


-- UPDATE MOVIES_RENTED MR
-- INNER JOIN MOVIES M ON MR.Movies_rented = M.Movie_title
-- SET MR.Movie_id = M.Movie_id;


-- ALTER TABLE MOVIES_RENTED
--         CHANGE COLUMN Movies_rented Movies_id INT,
-- 		ADD CONSTRAINT  FOREIGN KEY(Movies_id) REFERENCES MOVIES(Movies_id);
-- ADD CONSTRAINT FK_Movie_id FOREIGN KEY(Movie_id) REFERENCES Movies(movie_id);
   
        



-- Q6. Convert thc tables you have formulated in the previous question into its next possible Normal Form and state your reasons for doing so.             
-- Ans:it is aleardy in 3nf as i believe it is in 2nf and has no partial depencdency and both tables have primary keys which 
-- are identifying tuples and are super keys

SET SQL_SAFE_UPDATES=1;
                                
 
                                

										
