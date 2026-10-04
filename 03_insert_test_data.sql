-- Step 3: Insert test data
USE course_management_db;

INSERT INTO students
(first_name,last_name,email,phone,date_of_birth,gender,status)
VALUES
('Rahim','Ahmed','rahim@gmail.com','01711111111','2000-05-10','Male','Active'),
('Karim','Hasan','karim@gmail.com','01822222222','1999-08-15','Male','Active'),
('Nusrat','Jahan','nusrat@gmail.com','01933333333','2001-02-20','Female','Active'),
('Tamanna','Islam','tamanna@gmail.com','01644444444','1998-12-05','Female','Active'),
('Sakib','Khan','sakib@gmail.com','01555555555','2002-07-25','Male','Inactive');

INSERT INTO instructors
(first_name,last_name,email,phone,specialization,join_date,status)
VALUES
('John','Smith','john@gmail.com','01710000001','Web Development','2023-01-10','Active'),
('Sarah','Khan','sarah@gmail.com','01710000002','Database','2023-03-15','Active'),
('David','Miller','david@gmail.com','01710000003','Python Programming','2022-08-20','Active');

INSERT INTO courses
(course_name,course_description,instructor_id,price,duration_weeks,level)
VALUES
('MySQL Database Testing','Learn database testing with MySQL',2,150.00,8,'Beginner'),
('Python Automation','Learn Selenium automation using Python',3,250.00,12,'Intermediate'),
('Web Development','HTML CSS JavaScript Full Course',1,200.00,10,'Beginner'),
('Advanced SQL','Advanced SQL queries and database concepts',2,300.00,6,'Advanced');

INSERT INTO enrollments
(student_id,course_id,enrollment_status)
VALUES
(1,1,'Active'),
(1,2,'Completed'),
(2,1,'Active'),
(3,3,'Active'),
(4,2,'Active'),
(5,4,'Inactive');

INSERT INTO payments
(student_id,course_id,amount,payment_method,payment_status)
VALUES
(1,1,150.00,'Credit Card','Completed'),
(1,2,250.00,'PayPal','Completed'),
(2,1,150.00,'Credit Card','Pending'),
(3,3,200.00,'Bank Transfer','Completed'),
(4,2,250.00,'Credit Card','Completed');

INSERT INTO course_reviews
(student_id,course_id,rating,review_comment)
VALUES
(1,1,5,'Excellent database testing course'),
(2,1,4,'Very helpful and easy to understand'),
(3,3,5,'Great web development course'),
(4,2,5,'Python automation course was amazing');

SELECT * FROM students;
SELECT * FROM instructors;
SELECT * FROM courses;
SELECT * FROM enrollments;
SELECT * FROM payments;
SELECT * FROM course_reviews;
