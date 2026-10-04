# Course Management System – Database Testing Project

A beginner-friendly **Database Testing project using MySQL and MySQL Workbench**.

This project demonstrates how to create a relational database, insert test data, and perform database testing using SQL queries. It covers database structure validation, constraints, CRUD operations, data integrity, relationships, JOIN queries, positive testing, and negative testing.

---

## 📌 Project Overview

The **Course Management System** manages students, instructors, courses, enrollments, payments, and course reviews.

The main purpose of this project is to practice **SQL-based database testing** and understand how a QA Engineer validates backend data and database relationships.

### Project Objectives

- Create and validate a relational database
- Create tables with appropriate constraints
- Insert and verify test data
- Validate Primary Keys and Foreign Keys
- Test UNIQUE and NOT NULL constraints
- Perform CRUD testing
- Validate relationships using JOIN queries
- Perform data integrity and consistency testing
- Execute positive and negative test scenarios
- Record expected and actual results

---

## 🛠️ Tools & Technologies

| Tool / Technology | Purpose                               |
| ----------------- | ------------------------------------- |
| MySQL             | Database                              |
| MySQL Workbench   | Database management and SQL execution |
| SQL               | Database queries and testing          |
| Git               | Version control                       |
| GitHub            | Project repository                    |

---

## 🗄️ Database Information

**Database Name:**

```text
course_management_db
```

### Database Tables

| Table            | Description                                  |
| ---------------- | -------------------------------------------- |
| `students`       | Stores student information                   |
| `instructors`    | Stores instructor information                |
| `courses`        | Stores course information                    |
| `enrollments`    | Stores student-course enrollment information |
| `payments`       | Stores course payment information            |
| `course_reviews` | Stores student reviews and ratings           |

---

## 🔗 Database Relationships

```text
                    instructors
                         │
                         │
                         ▼
                      courses
                     ▲       ▲
                     │       │
                     │       │
                enrollments  │
                  ▲    ▲     │
                  │    │     │
                  │    │     │
              students       │
                  │          │
                  ├── payments
                  │
                  └── course_reviews
```

### Main Relationships

- One instructor can teach multiple courses.
- One student can enroll in multiple courses.
- One course can have multiple students.
- Students can make payments for courses.
- Students can submit reviews for courses.

---

## 📂 Project Structure

```text
Course-Management-Database-Testing/
│
├── README.md
│
├── sql/
│   ├── 01_create_database.sql
│   ├── 02_create_tables.sql
│   ├── 03_insert_test_data.sql
│   └── 04_database_test_queries.sql
│
└── docs/
    └── Database_Testing_Project.docx
```

---

# 🚀 How to Run the Project

Open **MySQL Workbench** and execute the SQL files in the following order.

### Step 1 — Create Database

Open:

```text
sql/01_create_database.sql
```

This script creates the database:

```sql
CREATE DATABASE course_management_db;

USE course_management_db;
```

---

### Step 2 — Create Tables

Open:

```text
sql/02_create_tables.sql
```

This creates:

```text
students
instructors
courses
enrollments
payments
course_reviews
```

Verify the tables:

```sql
SHOW TABLES;
```

---

### Step 3 — Insert Test Data

Open:

```text
sql/03_insert_test_data.sql
```

This inserts sample data into all tables.

Verify the data:

```sql
SELECT * FROM students;
SELECT * FROM instructors;
SELECT * FROM courses;
SELECT * FROM enrollments;
SELECT * FROM payments;
SELECT * FROM course_reviews;
```

---

# 🧪 Database Testing

The main testing queries are available in:

```text
sql/04_database_test_queries.sql
```

The test script covers the following areas.

---

## 1. Database & Table Validation

Verify that the correct database and tables exist.

```sql
SHOW TABLES;

SELECT DATABASE();
```

**Expected Result:**\
The database should be `course_management_db` and all required tables should exist.

---

## 2. Table Structure Testing

Verify column names, data types, NULL settings, keys, and default values.

```sql
DESCRIBE students;
```

The same validation is performed for all tables.

**Expected Result:**\
Table structure should match the defined database requirements.

---

## 3. Row Count Testing

Verify the number of records stored in each table.

```sql
SELECT COUNT(*) AS total_students
FROM students;
```

Example initial test data:

| Table           | Expected Records |
| --------------- | ---------------: |
| students        |                5 |
| instructors     |                3 |
| courses         |                4 |
| enrollments     |                6 |
| payments        |                5 |
| course\_reviews |                4 |

---

# 🔑 4. Primary Key Testing

Verify that primary keys are unique.

### Test Query

```sql
SELECT student_id, COUNT(*)
FROM students
GROUP BY student_id
HAVING COUNT(*) > 1;
```

**Expected Result:**

```text
0 rows
```

### Negative Test

```sql
INSERT INTO students
(student_id, first_name, email)
VALUES
(1, 'Test', 'test@example.com');
```

**Expected Result:**\
The database should reject the duplicate primary key.

---

# 🔗 5. Foreign Key Testing

Verify that invalid relationships cannot be inserted.

### Invalid Student ID

```sql
INSERT INTO enrollments
(student_id, course_id)
VALUES
(999, 1);
```

**Expected Result:**\
Foreign key constraint error.

### Invalid Course ID

```sql
INSERT INTO enrollments
(student_id, course_id)
VALUES
(1, 999);
```

**Expected Result:**\
Foreign key constraint error.

A rejected invalid record means the negative test **passes**.

---

# 🚫 6. NOT NULL Constraint Testing

Verify that mandatory fields cannot be empty.

```sql
INSERT INTO students
(last_name)
VALUES
('Test');
```

**Expected Result:**\
The insert should fail because `first_name` and `email` are required.

---

# 📧 7. UNIQUE Constraint Testing

Verify that duplicate email addresses are rejected.

```sql
INSERT INTO students
(first_name, email)
VALUES
('Test', 'rahim@gmail.com');
```

**Expected Result:**\
The insert should fail because the email already exists.

---

# 📅 8. Data Type Testing

Verify that valid values are stored correctly according to their data type.

```sql
INSERT INTO students
(first_name, email, date_of_birth)
VALUES
('DataTypeTest', 'datatype_test@example.com', '2000-01-15');
```

Verify:

```sql
SELECT
    student_id,
    first_name,
    email,
    date_of_birth
FROM students
WHERE email = 'datatype_test@example.com';
```

**Expected Result:**\
The valid date should be stored correctly.

---

# ⚙️ 9. Default Value Testing

Verify that default values are automatically applied.

```sql
INSERT INTO students
(first_name, email)
VALUES
('DefaultTest', 'default_test@example.com');
```

Verify:

```sql
SELECT
    first_name,
    email,
    status,
    registration_date
FROM students
WHERE email = 'default_test@example.com';
```

**Expected Result:**

```text
status = Active
registration_date = automatically generated
```

---

# 🔄 10. CRUD Testing

CRUD stands for:

- **C**reate
- **R**ead
- **U**pdate
- **D**elete

### Create

```sql
INSERT INTO students
(first_name, email)
VALUES
('CRUD', 'crud_test@example.com');
```

### Read

```sql
SELECT *
FROM students
WHERE email = 'crud_test@example.com';
```

### Update

```sql
UPDATE students
SET phone = '01799999999'
WHERE email = 'crud_test@example.com';
```

### Delete

```sql
DELETE FROM students
WHERE email = 'crud_test@example.com';
```

Verify:

```sql
SELECT *
FROM students
WHERE email = 'crud_test@example.com';
```

**Expected Result:**\
The deleted record should no longer exist.

---

# 🔀 11. JOIN Testing

Verify the relationship between students, enrollments, and courses.

```sql
SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    c.course_name,
    e.enrollment_status
FROM students s
JOIN enrollments e
    ON s.student_id = e.student_id
JOIN courses c
    ON e.course_id = c.course_id
ORDER BY s.student_id;
```

**Expected Result:**\
The query should return the correct student, course, and enrollment status.

---

# 👨‍🏫 12. Instructor & Course Validation

```sql
SELECT
    c.course_name,
    CONCAT(i.first_name, ' ', i.last_name) AS instructor_name,
    c.price,
    c.level
FROM courses c
JOIN instructors i
    ON c.instructor_id = i.instructor_id;
```

**Expected Result:**\
Each course should display its correct instructor.

---

# 💰 13. Payment Validation

Verify payment information against course information.

```sql
SELECT
    p.payment_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    c.course_name,
    c.price AS course_price,
    p.amount AS paid_amount,
    p.payment_status
FROM payments p
JOIN students s
    ON p.student_id = s.student_id
JOIN courses c
    ON p.course_id = c.course_id;
```

This query helps identify differences between the course price and payment amount.

---

# 🔍 14. Data Consistency Testing

Check whether a payment has a matching enrollment.

```sql
SELECT
    p.payment_id,
    p.student_id,
    p.course_id,
    p.amount
FROM payments p
LEFT JOIN enrollments e
    ON p.student_id = e.student_id
    AND p.course_id = e.course_id
WHERE e.enrollment_id IS NULL;
```

**Expected Result:**

```text
0 rows
```

if every payment should have a corresponding enrollment.

---

# 📊 15. Aggregate Query Testing

### Number of students per course

```sql
SELECT
    c.course_name,
    COUNT(e.enrollment_id) AS total_enrolled
FROM courses c
LEFT JOIN enrollments e
    ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;
```

### Total completed payments

```sql
SELECT
    SUM(amount) AS total_completed_payment
FROM payments
WHERE payment_status = 'Completed';
```

### Average course price

```sql
SELECT
    AVG(price) AS average_course_price
FROM courses;
```

---

# ⭐ 16. Review Rating Validation

Verify that ratings remain within the expected range of 1–5.

```sql
SELECT *
FROM course_reviews
WHERE rating < 1
   OR rating > 5;
```

**Expected Result:**

```text
0 rows
```

---

# 🔍 17. Filter Testing

### Active students

```sql
SELECT *
FROM students
WHERE status = 'Active';
```

### Courses between 150 and 250

```sql
SELECT *
FROM courses
WHERE price BETWEEN 150 AND 250;
```

---

# ↕️ 18. Sorting Testing

Verify that course prices are sorted correctly.

```sql
SELECT
    course_name,
    price
FROM courses
ORDER BY price DESC;
```

**Expected Result:**\
Courses should be displayed from highest price to lowest price.

---

# 🔄 19. Transaction & Rollback Testing

Verify that changes can be rolled back.

```sql
START TRANSACTION;

UPDATE students
SET status = 'Inactive'
WHERE student_id = 1;

SELECT student_id, status
FROM students
WHERE student_id = 1;

ROLLBACK;

SELECT student_id, status
FROM students
WHERE student_id = 1;
```

**Expected Result:**\
After `ROLLBACK`, the original value should be restored.


---

# ✅ Testing Coverage

This project covers:

- [x] Database Testing
- [x] Schema Testing
- [x] Table Structure Testing
- [x] Data Validation
- [x] Primary Key Testing
- [x] Foreign Key Testing
- [x] UNIQUE Constraint Testing
- [x] NOT NULL Constraint Testing
- [x] Default Value Testing
- [x] Data Type Testing
- [x] CRUD Testing
- [x] JOIN Testing
- [x] Data Integrity Testing
- [x] Data Consistency Testing
- [x] Aggregate Query Testing
- [x] Filter Testing
- [x] Sorting Testing
- [x] Transaction Testing
- [x] Positive Testing
- [x] Negative Testing

---

# 🎯 Learning Outcome

After completing this project, I can:

- Create and manage relational databases using MySQL.
- Write SQL queries for database validation.
- Understand Primary Key and Foreign Key relationships.
- Test database constraints.
- Perform CRUD operations.
- Validate relationships using JOIN queries.
- Identify inconsistent or invalid data.
- Execute positive and negative database test cases.
- Document database test execution results.

---

## 👤 Author

**Database Testing Practice Project**

Built with **MySQL + MySQL Workbench + SQL + GitHub**.
