-- File: 04_sample_data.sql
-- Purpose: Sample data for testing
-- Description: Insert test data into all tables

-- Insert sample students
INSERT INTO students (first_name, last_name, date_of_birth, email, phone) VALUES
('John', 'Doe', '2000-05-15', 'john.doe@email.com', '1234567890'),
('Jane', 'Smith', '2001-03-20', 'jane.smith@email.com', '1234567891'),
('Bob', 'Johnson', '1999-11-08', 'bob.johnson@email.com', '1234567892');

-- Insert sample courses
INSERT INTO courses (course_code, course_name, credits, description) VALUES
('CS101', 'Introduction to Programming', 3, 'Basic programming concepts'),
('MATH201', 'Calculus I', 4, 'Fundamental calculus concepts'),
('ENG101', 'English Composition', 3, 'Basic writing skills');

-- Insert sample teachers
INSERT INTO teachers (first_name, last_name, email, phone) VALUES
('Michael', 'Wilson', 'michael.wilson@email.com', '9876543210'),
('Sarah', 'Brown', 'sarah.brown@email.com', '9876543211'),
('David', 'Miller', 'david.miller@email.com', '9876543212');

-- Insert sample enrollments
INSERT INTO enrollments (student_id, course_id, teacher_id, semester, year) VALUES
(1, 1, 1, 'Fall', 2023),
(1, 2, 2, 'Fall', 2023),
(2, 1, 1, 'Fall', 2023),
(3, 3, 3, 'Fall', 2023);

-- Insert sample grades
INSERT INTO grades (enrollment_id, grade_value, comment) VALUES
(1, 85.5, 'Good performance'),
(2, 92.0, 'Excellent work'),
(3, 78.5, 'Needs improvement'),
(4, 88.0, 'Very good');

-- Insert sample attendance
INSERT INTO attendance (enrollment_id, date, status) VALUES
(1, '2023-09-01', 'present'),
(1, '2023-09-08', 'present'),
(1, '2023-09-15', 'absent'),
(2, '2023-09-01', 'present'),
(2, '2023-09-08', 'late'),
(3, '2023-09-01', 'present'),
(4, '2023-09-01', 'present');