USE [baza_prv_cas]
GO

/****** Object:  Table [dbo].[students]    Script Date: 11/24/2024 3:32:01 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[students](
	[student_id] [int] NOT NULL,
	[first_name] [varchar](50) NULL,
	[last_name] [varchar](50) NULL,
	[birth_date] [varchar](50) NULL,
	[enrollment_year] [varchar](4) NULL,
PRIMARY KEY CLUSTERED 
(
	[student_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



USE [baza_prv_cas]
GO

/****** Object:  Table [dbo].[professors]    Script Date: 11/24/2024 6:16:29 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[professors](
	[professor_id] [int] NOT NULL,
	[first_name] [varchar](50) NOT NULL,
	[last_name] [varchar](50) NOT NULL,
	[department] [varchar](50) NULL,
	[hire_date] [varchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[professor_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

USE [baza_prv_cas]
GO

/****** Object:  Table [dbo].[subjects]    Script Date: 11/24/2024 6:23:54 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE Subjects(
subject_id INT PRIMARY KEY NOT NULL,
subject_name VARCHAR (50),
professor_id INT NOT NULL,
student_id INT ,

FOREIGN KEY (student_id) REFERENCES Students (student_id),
FOREIGN KEY (professor_id) REFERENCES Professors (professor_id)
);


INSERT INTO subjects(subject_id ,subject_name,professor_id,student_id) VALUES
(1,'Ekonometrija',1,1),
(2,'Osiguruvanje',2,2),
(3,'Matematika',3,3),
(4,'Bankarstvo',4,4),
(5,'Statistika',5,5);

--Query 1: Retrieve a list of all students enrolled after a specific year (e.g., 2020).

SELECT * FROM Students;

SELECT * FROM Students WHERE enrollment_year > '2018';

--Query 2: Find the subjects taught by a particular professor by using the professor's ID.

SELECT * FROM professors;

SELECT * FROM subjects;

SELECT s.subject_name,p.first_name,p.last_name,p.department FROM subjects as s
LEFT JOIN
professors as p
ON p.professor_id = s.professor_id;

--Query 3: List all students' names and enrollment years, filtered by department (for example, list all students under a department where professors belong).

SELECT * FROM Students;

SELECT s.first_name,s.last_name,s.enrollment_year, su.subject_name,p.first_name,p.last_name,p.department FROM Students as s
LEFT JOIN
subjects as su
ON s.student_id = su.student_id
LEFT JOIN
professors as P 
ON p.professor_id = su.professor_id
WHERE department = 'student affairs';