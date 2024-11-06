-- File: 02_functions.sql
-- Purpose: Common functions for Student Management System
-- Description: Utility functions for common operations

-- Function to enroll student in a course
CREATE OR REPLACE FUNCTION enroll_student(
    p_student_id INTEGER,
    p_course_id INTEGER,
    p_teacher_id INTEGER,
    p_semester VARCHAR,
    p_year INTEGER
)
RETURNS INTEGER AS $$
DECLARE
    new_enrollment_id INTEGER;
BEGIN
    -- Check if student is active
    IF NOT EXISTS (
        SELECT 1 FROM students 
        WHERE student_id = p_student_id AND status = 'active'
    ) THEN
        RAISE EXCEPTION 'Student is not active';
    END IF;

    -- Insert new enrollment
    INSERT INTO enrollments (
        student_id, course_id, teacher_id, semester, year
    ) VALUES (
        p_student_id, p_course_id, p_teacher_id, p_semester, p_year
    ) RETURNING enrollment_id INTO new_enrollment_id;

    RETURN new_enrollment_id;
EXCEPTION
    WHEN unique_violation THEN
        RAISE EXCEPTION 'Student is already enrolled in this course for the semester';
END;
$$ LANGUAGE plpgsql;

-- Function to calculate student's GPA
CREATE OR REPLACE FUNCTION calculate_student_gpa(p_student_id INTEGER)
RETURNS DECIMAL(4,2) AS $$
DECLARE
    total_grade DECIMAL(10,2) := 0;
    total_credits INTEGER := 0;
    gpa DECIMAL(4,2);
BEGIN
    SELECT 
        SUM(g.grade_value * c.credits) as grade_points,
        SUM(c.credits) as credits
    INTO total_grade, total_credits
    FROM enrollments e
    JOIN grades g ON e.enrollment_id = g.enrollment_id
    JOIN courses c ON e.course_id = c.course_id
    WHERE e.student_id = p_student_id
    AND e.status = 'completed';

    IF total_credits = 0 THEN
        RETURN 0;
    END IF;

    RETURN ROUND((total_grade / total_credits) / 25, 2);
END;
$$ LANGUAGE plpgsql;

-- Function to get student attendance percentage
CREATE OR REPLACE FUNCTION get_attendance_percentage(
    p_student_id INTEGER,
    p_course_id INTEGER,
    p_semester VARCHAR,
    p_year INTEGER
)
RETURNS DECIMAL(5,2) AS $$
DECLARE
    total_classes INTEGER;
    attended_classes INTEGER;
BEGIN
    SELECT 
        COUNT(*) as total,
        COUNT(CASE WHEN a.status = 'present' THEN 1 END) as attended
    INTO total_classes, attended_classes
    FROM enrollments e
    JOIN attendance a ON e.enrollment_id = a.enrollment_id
    WHERE e.student_id = p_student_id
    AND e.course_id = p_course_id
    AND e.semester = p_semester
    AND e.year = p_year;

    IF total_classes = 0 THEN
        RETURN 0;
    END IF;

    RETURN (attended_classes::DECIMAL / total_classes) * 100;
END;
$$ LANGUAGE plpgsql;