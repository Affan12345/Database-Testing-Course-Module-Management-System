-- Step 4: Database Test Execution
USE course_management_db;

-- DB-001: Database/table verification
SHOW TABLES;
SELECT DATABASE();

-- DB-002: Structure validation
DESCRIBE students;
DESCRIBE instructors;
DESCRIBE courses;
DESCRIBE enrollments;
DESCRIBE payments;
DESCRIBE course_reviews;

-- DB-003: Row count validation
SELECT COUNT(*) AS total_students FROM students;
SELECT COUNT(*) AS total_instructors FROM instructors;
SELECT COUNT(*) AS total_courses FROM courses;
SELECT COUNT(*) AS total_enrollments FROM enrollments;
SELECT COUNT(*) AS total_payments FROM payments;
SELECT COUNT(*) AS total_reviews FROM course_reviews;

-- DB-PK-001: Duplicate primary key; expected ERROR
INSERT INTO students (student_id, first_name, email)
VALUES (1, 'Test', 'test_pk@gmail.com');

-- DB-PK-002: Duplicate primary key check; expected 0 rows
SELECT student_id, COUNT(*) FROM students
GROUP BY student_id HAVING COUNT(*) > 1;

-- DB-NN-001: Missing NOT NULL fields; expected ERROR
INSERT INTO students (last_name) VALUES ('Test');

-- DB-UNIQUE-001: Duplicate email; expected ERROR
INSERT INTO students (first_name, email)
VALUES ('Test', 'rahim@gmail.com');

-- DB-FK-001: Invalid student ID; expected ERROR 1452
INSERT INTO enrollments (student_id, course_id)
VALUES (999, 1);

-- DB-FK-002: Invalid course ID; expected ERROR 1452
INSERT INTO enrollments (student_id, course_id)
VALUES (1, 999);

-- DB-DT-001: Valid DATE value
INSERT INTO students (first_name, email, date_of_birth)
VALUES ('DataTypeTest', 'datatype_test_02@gmail.com', '2000-01-15');

SELECT student_id, first_name, email, date_of_birth
FROM students WHERE email = 'datatype_test_02@gmail.com';

-- DB-DEFAULT-001: Default values
INSERT INTO students (first_name, email)
VALUES ('DefaultTest', 'default_test_02@gmail.com');

SELECT first_name, email, status, registration_date
FROM students WHERE email = 'default_test_02@gmail.com';

-- DB-CRUD-001: CRUD
INSERT INTO students (first_name, email)
VALUES ('CRUD', 'crud_test_02@gmail.com');

SELECT * FROM students WHERE email = 'crud_test_02@gmail.com';

UPDATE students
SET phone = '01799999999'
WHERE email = 'crud_test_02@gmail.com';

SELECT * FROM students WHERE email = 'crud_test_02@gmail.com';

DELETE FROM students
WHERE email = 'crud_test_02@gmail.com';

SELECT * FROM students WHERE email = 'crud_test_02@gmail.com';

-- DB-JOIN-001: Student + Enrollment + Course
SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    c.course_name,
    e.enrollment_status
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
ORDER BY s.student_id;

-- DB-JOIN-002: Course + Instructor
SELECT
    c.course_name,
    CONCAT(i.first_name, ' ', i.last_name) AS instructor_name,
    c.price,
    c.level
FROM courses c
JOIN instructors i ON c.instructor_id = i.instructor_id;

-- DB-PAY-001: Payment validation
SELECT
    p.payment_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    c.course_name,
    c.price AS course_price,
    p.amount AS paid_amount,
    p.payment_status
FROM payments p
JOIN students s ON p.student_id = s.student_id
JOIN courses c ON p.course_id = c.course_id;

-- DB-INT-001: Payment/enrollment consistency; expected 0 rows
SELECT p.payment_id, p.student_id, p.course_id, p.amount
FROM payments p
LEFT JOIN enrollments e
ON p.student_id = e.student_id AND p.course_id = e.course_id
WHERE e.enrollment_id IS NULL;

-- DB-AGG-001
SELECT c.course_name, COUNT(e.enrollment_id) AS total_enrolled
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
ORDER BY total_enrolled DESC;

-- DB-AGG-002
SELECT SUM(amount) AS total_completed_payment
FROM payments WHERE payment_status = 'Completed';

-- DB-AGG-003
SELECT AVG(price) AS average_course_price FROM courses;

-- DB-REVIEW-001: Rating range; expected 0 rows
SELECT * FROM course_reviews
WHERE rating < 1 OR rating > 5;

-- DB-STATUS-001
SELECT DISTINCT status FROM students;

-- DB-FILTER-001
SELECT * FROM students WHERE status = 'Active';

-- DB-FILTER-002
SELECT * FROM courses WHERE price BETWEEN 150 AND 250;

-- DB-SORT-001
SELECT course_name, price FROM courses ORDER BY price DESC;

-- DB-TRAN-001: Transaction/rollback
START TRANSACTION;
UPDATE students SET status = 'Inactive' WHERE student_id = 1;
SELECT student_id, status FROM students WHERE student_id = 1;
ROLLBACK;
SELECT student_id, status FROM students WHERE student_id = 1;

-- Final regression verification
SHOW TABLES;
SELECT COUNT(*) AS total_students FROM students;
SELECT COUNT(*) AS total_instructors FROM instructors;
SELECT COUNT(*) AS total_courses FROM courses;
SELECT COUNT(*) AS total_enrollments FROM enrollments;
SELECT COUNT(*) AS total_payments FROM payments;
SELECT COUNT(*) AS total_reviews FROM course_reviews;
