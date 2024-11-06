-- File: 03_views.sql
-- Purpose: Useful views for Student Management System
-- Description: Common queries wrapped as views

-- View for student course summary
CREATE OR REPLACE VIEW student_course_summary AS
SELECT 
    s.student_id,
    s.first_name || ' ' || s.last_name as student_name,
    c.course_code,
    c.course_name,
    e.semester,
    e.year,
    g.grade_value,
    t.first_name || ' ' || t.last_name as teacher_name,
    e.status
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
JOIN teachers t ON e.teacher_id = t.teacher_id
LEFT JOIN grades g ON e.enrollment_id = g.enrollment_id;

-- View for student attendance summary
CREATE OR REPLACE VIEW student_attendance_summary AS
SELECT 
    s.student_id,
    s.first_name || ' ' || s.last_name as student_name,
    c.course_code,
    e.semester,
    e.year,
    COUNT(*) as total_classes,
    COUNT(CASE WHEN a.status = 'present' THEN 1 END) as classes_attended,
    ROUND(COUNT(CASE WHEN a.status = 'present' THEN 1 END)::DECIMAL / COUNT(*) * 100, 2) as attendance_percentage
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
JOIN attendance a ON e.enrollment_id = a.enrollment_id
GROUP BY s.student_id, s.first_name, s.last_name, c.course_code, e.semester, e.year;

-- View for course statistics
CREATE OR REPLACE VIEW course_statistics AS
SELECT 
    c.course_id,
    c.course_code,
    c.course_name,
    COUNT(DISTINCT e.student_id) as enrolled_students,
    ROUND(AVG(g.grade_value), 2) as average_grade,
    COUNT(DISTINCT t.teacher_id) as teachers_assigned
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
LEFT JOIN grades g ON e.enrollment_id = g.enrollment_id
LEFT JOIN teachers t ON e.teacher_id = t.teacher_id
WHERE c.active = true
GROUP BY c.course_id, c.course_code, c.course_name;