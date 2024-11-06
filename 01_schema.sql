-- File: 01_schema.sql
-- Purpose: Database schema for Student Management System
-- Description: Core tables for managing students, courses, and grades

-- Create Students Table
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    address TEXT,
    enrollment_date DATE DEFAULT CURRENT_DATE,
    status VARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'inactive', 'graduated', 'suspended')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Courses Table
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_code VARCHAR(10) UNIQUE NOT NULL,
    course_name VARCHAR(100) NOT NULL,
    credits INTEGER NOT NULL CHECK (credits > 0),
    description TEXT,
    active BOOLEAN DEFAULT true
);

-- Create Teachers Table
CREATE TABLE teachers (
    teacher_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    hire_date DATE DEFAULT CURRENT_DATE,
    status VARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'inactive')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Course Enrollments Table
CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES students(student_id),
    course_id INTEGER REFERENCES courses(course_id),
    teacher_id INTEGER REFERENCES teachers(teacher_id),
    semester VARCHAR(20) NOT NULL,
    year INTEGER NOT NULL CHECK (year > 2000),
    enrollment_date DATE DEFAULT CURRENT_DATE,
    status VARCHAR(20) DEFAULT 'enrolled' CHECK (status IN ('enrolled', 'dropped', 'completed')),
    UNIQUE(student_id, course_id, semester, year)
);

-- Create Grades Table
CREATE TABLE grades (
    grade_id SERIAL PRIMARY KEY,
    enrollment_id INTEGER REFERENCES enrollments(enrollment_id),
    grade_value DECIMAL(4,1) CHECK (grade_value >= 0 AND grade_value <= 100),
    comment TEXT,
    date_graded DATE DEFAULT CURRENT_DATE
);

-- Create Attendance Table
CREATE TABLE attendance (
    attendance_id SERIAL PRIMARY KEY,
    enrollment_id INTEGER REFERENCES enrollments(enrollment_id),
    date DATE NOT NULL,
    status VARCHAR(10) CHECK (status IN ('present', 'absent', 'late')),
    UNIQUE(enrollment_id, date)
);

-- Create indexes for frequently accessed columns
CREATE INDEX idx_student_email ON students(email);
CREATE INDEX idx_course_code ON courses(course_code);
CREATE INDEX idx_enrollment_student ON enrollments(student_id);
CREATE INDEX idx_enrollment_course ON enrollments(course_id);
CREATE INDEX idx_attendance_date ON attendance(date);