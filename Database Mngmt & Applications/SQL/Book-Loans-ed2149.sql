drop database if exists `bookloan`; 
create database `bookloan`; 
use `bookloan`; 

CREATE TABLE IF NOT EXISTS `book` (
  `Book_ISBN` int(5) NOT NULL DEFAULT '0',
  `Book_Title` varchar(19) DEFAULT NULL,
  `Book_First_Author` varchar(9) DEFAULT NULL,
  `Pub_Year` int(4) DEFAULT NULL,
  PRIMARY KEY (`Book_ISBN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `book` (`Book_ISBN`, `Book_Title`, `Book_First_Author`, `Pub_Year`) VALUES
(23201, 'Game Theory', 'Nigel, T.', 2005),
(25622, 'Bayesian Statistics', 'Sato, F.', 2009),
(70598, 'Advanced Chemistry', 'Rudy, H.', 2006),
(50462, 'Basic Chemistry', 'Rudy, H.', 2004),
(50465, 'Basic Chemistry', 'Parth, H.', 2002);

CREATE TABLE IF NOT EXISTS `copy` (
  `Book_Call_No` varchar(6) NOT NULL DEFAULT '',
  `Book_ISBN` int(5) DEFAULT NULL,
  PRIMARY KEY (`Book_Call_No`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO `copy` (`Book_Call_No`, `Book_ISBN`) VALUES
('A00001', 23201),
('A01203', 25622),
('A00107', 23201),
('A31730', 70598),
('A31254', 50462),
('A31717', 70598),
('A31294', 50465);


CREATE TABLE IF NOT EXISTS `loan` (
  `Borrow_ID` int(2) NOT NULL DEFAULT '0',
  `Stu_ID` int(4) DEFAULT NULL,
  `Book_Call_No` varchar(6) DEFAULT NULL,
  `Borrow_Date` date DEFAULT NULL,
  `Due_Date` date DEFAULT NULL,
  `Return_Date` date DEFAULT NULL,
  PRIMARY KEY (`Borrow_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `loan` (`Borrow_ID`, `Stu_ID`, `Book_Call_No`, `Borrow_Date`, `Due_Date`, `Return_Date`) VALUES
(1, 9123, 'A00001', '2012-03-05', '2012-06-03', '1900-01-01'),
(2, 9123, 'A01203', '2012-03-07', '2012-09-03', '1900-01-01'),
(3, 9123, 'A00001', '2012-02-05', '2012-05-06', '2012-03-03'),
(4, 9118, 'A01203', '2012-02-12', '2012-05-13', '2012-03-01'),
(5, 9118, 'A00107', '2012-03-08', '2012-06-06', '1900-01-01'),
(6, 9192, 'A01203', '2012-01-10', '2012-04-10', '2012-02-07'),
(7, 9331, 'A31730', '2012-01-19', '2012-04-30', '1900-01-01'),
(8, 9251, 'A31254', '2011-12-22', '2012-06-20', '1900-01-01'),
(9, 9251, 'A31717', '2012-01-17', '2012-04-01', '1900-01-01'),
(10, 9521, 'A31294', '2011-11-07', '2012-11-02', '2011-12-18'),
(11, 9662, 'A31717', '2012-01-04', '2012-07-03', '2012-01-15'),
(12, 9323, 'A00001', '2011-09-21', '2011-10-21', '2011-10-21'),
(13, 9323, 'A01203', '2011-08-21', '2011-09-21', '2011-09-21'),
(14, 9323, 'A31294', '2012-08-30', '2012-09-30', '1900-01-01'),
(15, 9313, 'A00107', '2011-10-22', '2011-10-29', '2011-10-29'),
(16, 9313, 'A01203', '2011-07-21', '2011-08-20', '2011-08-20');


CREATE TABLE IF NOT EXISTS `student` (
  `Stu_ID` int(4) NOT NULL DEFAULT '0',
  `Stu_Name` varchar(10) DEFAULT NULL,
  `Stu_Dep` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`Stu_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO `student` (`Stu_ID`, `Stu_Name`, `Stu_Dep`) VALUES
(9123, 'Marks, D.', 'MGT'),
(9118, 'Perry, H.', 'CS'),
(9192, 'Ronald, T.', 'MGT'),
(9331, 'Niven, B.', 'BIO'),
(9251, 'Stone, S.', 'CHEM'),
(9521, 'Bin, N.', 'BIO'),
(9662, 'Glenn, H.', 'CHEM'),
(9323, 'Lynn, S.', 'ECON'),
(9313, 'Yao, M.', 'ECON');

select * from book; 
select * from copy;
select * from loan; 
select * from student;


-- Task 8 Use the book loan database.
-- Extract the most popular author in the university (borrowed the most often by students)
-- In case of a tie, list all of them.
 with library_summary as (
	select 
		b.Book_ISBN,
        b.Book_Title,
        b.Book_First_Author,
        c.Book_Call_No
	from book b inner join copy c
    on b.Book_ISBN = c.Book_ISBN
    inner join loan l
    on c.Book_Call_No = l.Book_Call_No
 )
 
select Most_Pop_Authors
 from
 (select
	distinct Book_First_Author as Most_Pop_Authors,
    dense_rank() over(order by count(Book_Call_no) desc) as rnk
from library_summary
group by Book_First_Author) auth_rank
where auth_rank.rnk = 1;
 
 
-- Task 9 Use the book loan database.
-- Use the loan table, for each student, calculate the total payment due for all books he/she borrowed.
-- Assume that the university charges $0.1 per book per day for book loans.
with student_loan as (
	select
		s.Stu_ID,
        s.Stu_Name,
        s.Stu_Dep,
        l.Borrow_Date,
        l.Due_Date,
        l.Return_Date
	from student s inner join loan l
    on s.Stu_ID = l.Stu_ID		
)

-- Q: what to do with negative values?
select
	distinct Stu_ID,
    sum(datediff(Borrow_Date, Return_Date)) * .10 as payment_due
from student_loan
group by Stu_ID
having payment_due > 0
order by payment_due desc;
    
