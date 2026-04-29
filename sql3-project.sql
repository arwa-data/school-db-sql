-- إنشاء قاعدة البيانات
CREATE DATABASE School_1;
USE SchoolDB;

-- جدول الطلاب
CREATE TABLE Studentt (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(100)
);

-- جدول المعلمين
CREATE TABLE Teacherss (
    teacher_id INT PRIMARY KEY AUTO_INCREMENT,
    teacher_name VARCHAR(100),
    office_number VARCHAR(20),
    subject_id INT
);

-- جدول المواد
CREATE TABLE Subjects (
    subject_id INT PRIMARY KEY AUTO_INCREMENT,
    subject_name VARCHAR(100)
);

-- العلاقة: معلم ↔ مادة (One to Many)
ALTER TABLE Teacherss
ADD CONSTRAINT fk_teacher_subject
FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id);

-- العلاقة: طالب ↔ معلم (Many to Many)
CREATE TABLE Student_Teacher (
    student_id INT,
    teacher_id INT,
    PRIMARY KEY (student_id, teacher_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id)
);

-- العلاقة: طالب ↔ مادة (Many to Many)
CREATE TABLE Student_Subject (
    student_id INT,
    subject_id INT,
    PRIMARY KEY (student_id, subject_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id)
);


-- إدخال بيانات تجريبية

INSERT INTO Subjects (subject_name) VALUES
('Math'),
('Science'),
('English');

INSERT INTO Studentt (student_name) VALUES
('Arwa'),
('Sara'),
('Lama');

INSERT INTO Teacherss (teacher_name, office_number, subject_id) VALUES
('Ahmed', 'A101', 1),
('Khalid', 'B202', 2),
('Mona', 'C303', 3);

-- ربط الطلاب بالمعلمين
INSERT INTO Student_Teacher VALUES
(1,1),
(1,2),
(2,1),
(3,3);

-- ربط الطلاب بالمواد
INSERT INTO Student_Subject VALUES
(1,1),
(1,2),
(2,1),
(3,3);


-- Procedure


DELIMITER //

CREATE PROCEDURE student_info()
BEGIN
    SELECT 
        Studentt.student_name,
        Subjects.subject_name
    FROM Studentt
    JOIN Student_Subject ON Studentt.student_id = Student_Subject.student_id
    JOIN Subjects ON Subjects.subject_id = Student_Subject.subject_id;
END //

DELIMITER ;

-- استدعاء الإجراء
CALL student_info();

-- View


CREATE VIEW teacher_info AS
SELECT 
    Teacherss.teacher_name,
    Teacherss.office_number,
    Subjects.subject_name
FROM Teacherss
JOIN Subjects ON Teacherss.subject_id = Subjects.subject_id;

-- عرض الفيو
SELECT * FROM teacher_info;

-- حذف الفيو
DROP VIEW teacher_info;

-- Index

CREATE INDEX idx_student_name
ON Studentt(student_name);

-- عرض الاندكس
SHOW INDEX FROM Studentt;

-- حذف الاندكس
DROP INDEX idx_student_name ON Studentt;