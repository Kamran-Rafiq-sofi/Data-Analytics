create database library_management_system;
use library_management_system;
create table books(
book_id INT,
book_name VARCHAR(25),
book_author VARCHAR(25),
book_spec VARCHAR(200),
book_rating INT ,
constraint check_rating CHECK(book_rating >0 AND book_rating <=5)
);
alter table books add primary key (book_id);
insert into books values(1,'maths','jindal','good',1),
                        (2,'s','jindalp','good',2),
                        (3,'ss','jindal','good',3),
                        (4,'polity','laxmikant','excellent',5);
                    
select * from books;  

-- create table students(
-- student_id INT ,
-- student_name VARCHAR(50),
-- student_department VARCHAR(25),
-- student_section  char,
-- book_id INT,
-- foreign key (book_id)references books(book_id)

-- ); 
-- alter table students drop column book_id;

create table students(
student_id INT PRIMARY KEY ,
student_name VARCHAR(50),
student_department VARCHAR(25),
student_section  char

);  

create table student_books  (
student_id int,
book_id INT,

foreign key(student_id)references students(student_id),
foreign key(book_id)references books(book_id)


) 
            