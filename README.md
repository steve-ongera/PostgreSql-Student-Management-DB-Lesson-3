# Postgresql DB Student Management System

The Student Management System is a comprehensive database-driven application for managing student information, course enrollments, grades, and attendance records. This project includes all the necessary SQL scripts to set up the database schema, utility functions, reporting views, and sample test data.

## Features
- **Student Management**: Ability to create, update, and view student profiles, including personal details, enrollment status, and contact information.
- **Course Management**: Maintain a catalog of available courses, including course code, name, credits, description, and active/inactive status.
- **Teacher Management**: Track teacher personal details, hire dates, and employment status.
- **Enrollment Management**: Record student enrollments in courses, including the assigned teacher, semester, and year. Monitor enrollment status (e.g., enrolled, dropped, completed).
- **Grade Management**: Store grades earned by students in their course enrollments, along with optional comments.
- **Attendance Tracking**: Record student attendance for each course enrollment, tracking presence, absences, and tardiness.
- **Reporting and Analytics**: Generate reports and summary views for student course summaries, attendance statistics, and course-level metrics.
- **GPA Calculation**: Automatically calculate a student's grade point average (GPA) based on completed courses and earned grades.

## Database Schema
The database schema consists of the following tables:

1. **students**:
   - `student_id`: Unique identifier for each student
   - `first_name`, `last_name`: Student's name
   - `date_of_birth`: Student's date of birth
   - `email`, `phone`, `address`: Student's contact information
   - `enrollment_date`: Date the student enrolled
   - `status`: Student's enrollment status (active, inactive, graduated, suspended)
   - `created_at`: Timestamp of when the student record was created

2. **courses**:
   - `course_id`: Unique identifier for each course
   - `course_code`, `course_name`: Course code and title
   - `credits`: Number of credits the course is worth
   - `description`: Course description
   - `active`: Flag indicating if the course is currently offered

3. **teachers**:
   - `teacher_id`: Unique identifier for each teacher
   - `first_name`, `last_name`: Teacher's name
   - `email`, `phone`: Teacher's contact information
   - `hire_date`: Date the teacher was hired
   - `status`: Teacher's employment status (active, inactive)
   - `created_at`: Timestamp of when the teacher record was created

4. **enrollments**:
   - `enrollment_id`: Unique identifier for each enrollment
   - `student_id`: Foreign key referencing the `students` table
   - `course_id`: Foreign key referencing the `courses` table
   - `teacher_id`: Foreign key referencing the `teachers` table
   - `semester`, `year`: Enrollment semester and year
   - `enrollment_date`: Date the student enrolled in the course
   - `status`: Enrollment status (enrolled, dropped, completed)

5. **grades**:
   - `grade_id`: Unique identifier for each grade record
   - `enrollment_id`: Foreign key referencing the `enrollments` table
   - `grade_value`: Numeric grade value (0-100)
   - `comment`: Optional comment about the grade
   - `date_graded`: Date the grade was recorded

6. **attendance**:
   - `attendance_id`: Unique identifier for each attendance record
   - `enrollment_id`: Foreign key referencing the `enrollments` table
   - `date`: Date of the class session
   - `status`: Attendance status (present, absent, late)

The schema also includes several utility functions and views to simplify common operations and reporting tasks.

## Setup
1. Create a new PostgreSQL database.
2. Run the following SQL scripts in order:
   - `01_schema.sql`: Creates the database tables.
   - `02_functions.sql`: Adds the utility functions.
   - `03_views.sql`: Creates the reporting views.
   - `04_sample_data.sql`: Populates the tables with test data.

## Usage
The Student Management System supports the following key functionalities:

### Student Management
- **Add New Student**: Insert a new student record with personal details and enrollment status.
- **Update Student**: Modify a student's information, such as contact details or enrollment status.
- **View Student Profile**: Retrieve a student's full record, including enrollment history.

### Course Management
- **Add New Course**: Create a new course with details like course code, name, credits, and description.
- **Update Course**: Modify course information, such as credits or active/inactive status.
- **View Course Details**: Retrieve full details about a specific course.

### Teacher Management
- **Add New Teacher**: Insert a new teacher record with personal details and hire date.
- **Update Teacher**: Modify a teacher's information, such as contact details or employment status.
- **View Teacher Profile**: Retrieve a teacher's full record, including employment history.

### Enrollment Management
- **Enroll Student**: Add a new enrollment record, linking a student to a course and assigning a teacher.
- **Update Enrollment**: Change the status of an enrollment (e.g., from enrolled to dropped or completed).
- **View Enrollments**: Retrieve all enrollments for a student, course, or teacher.

### Grade Management
- **Record Grade**: Add a new grade record for a student's course enrollment, including the numeric grade and an optional comment.
- **Update Grade**: Modify the grade value or comment for an existing grade record.
- **View Grades**: Retrieve the grade history for a student's course enrollments.

### Attendance Tracking
- **Record Attendance**: Add a new attendance record for a student's course enrollment, tracking presence, absence, or tardiness.
- **View Attendance**: Retrieve the attendance summary for a student's course enrollments.

### Reporting and Analytics
- **Student Course Summary**: Generate a report showing all courses taken by a student, including grades and teacher information.
- **Student Attendance Summary**: View the attendance statistics for a student across all their course enrollments.
- **Course Statistics**: Retrieve aggregated metrics for each course, such as enrolled students, average grade, and number of assigned teachers.

### GPA Calculation
- **Calculate Student GPA**: Automatically compute a student's grade point average based on their completed course enrollments and earned grades.

For more detailed usage examples and SQL code samples, please refer to the comments within each of the provided SQL scripts.

## Contributing
If you would like to contribute to the Student Management System project, please feel free to submit a pull request. We welcome bug fixes, feature enhancements, and additional reporting capabilities.

## License
This project is licensed under the [MIT License](LICENSE).