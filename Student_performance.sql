use e_sale;

select * from  stud_perf;

-- changing data type
alter table stud_perf
modify gender varchar(50),
modify parentaleducation varchar(50),
modify ethnicity varchar(50);

-- updating values
update stud_perf
set gender=case gender
when '0' then 'M'
when '1' then 'F'
else 'no'
end 
where gender in ('0','1');


update stud_perf
set ethnicity=case ethnicity
when '0' then 'Caucasian'
when '1' then 'African American'
when '2' then 'Asian'
else 'Other'
end 
where ethnicity in ('0','1','2','3');

update stud_perf
set ParentalEducation=case ParentalEducation
when '0' then 'None'
when '1' then 'High School'
when '2' then 'Some College'
when '3' then "Bachelor's"
else'Higher'
end
where ParentalEducation in ('0','1','2','3','4');

alter table stud_perf 
modify gradeclass varchar(50);

update stud_perf
set gradeclass=case gradeclass
when '0' then 'A'
when '1' then 'B'
when '2' then 'C'
when '3' then 'D'
else'F'
end
where Gradeclass in ('0','1','2','3','4');
    
select * from stud_perf;

-- effect of parentaleducation on student
select  parentalsupport ,gradeclass, count(studentid) as students
 from stud_perf
where parentalsupport in ('0','1','2','3','4 ') and gradeclass in ('A','B')
group by parentalsupport,gradeclass
order by parentalsupport;


-- gender wise absences 
select avg(absences)as absent ,gender from stud_perf 
group by  gender
order by absent desc;


-- 16-17 aged students having gpa greater thhan 3
select age,count(gpa) as gpa from stud_perf
where  gpa>3
group by age
order by gpa;


/* parentalsupport
0: None
1: Low
2: Moderate
3: High
4: Very High 
and are non-asian*/

select  parentalsupport , count(studentid) as students,ethnicity
 from stud_perf
group by ethnicity,parentalsupport
order by parentalsupport desc;


-- students having very high parentalsupport
select count(studentId) as students, ethnicity
from stud_perf
where parentalsupport ='4'
group by ethnicity
order by students;


-- students performance on the basis of sports
select count(studentid), GRADECLASS,sports from stud_perf
where gradeclass in ('A','B','C','D','F')
group by gradeclass,sports
order by gradeclass ;


select * from stud_perf;


-- asian students with graduated parents
select count(studentid) as students, gradeclass,parentaleducation, ethnicity from stud_perf
group by gradeclass,parentaleducation, ethnicity
order by students desc;


-- age wise female students max GPA
select count(studentid) as students,max(gpa),gender, age from stud_perf
where gender='F'
group by gender,age
order by students asc;


-- gender wise grades
select gradeclass, count(studentid) as students from stud_perf
group by gradeclass
order by gradeclass asc;


-- percentage of students got grade A
select round(((select count(studentid) from stud_perf where gradeclass ='A') / count(studentid)) *100,1)
 as percentage from stud_perf;


-- average of gpa on the basis of extracurricular
select count(extracurricular) as count_extracurricular,extracurricular, avg(gpa)  as gpa from stud_perf
where extracurricular in (0,1)
group by extracurricular
order by extracurricular desc;


-- average studytime
select gradeclass, tutoring,avg(studytimeweekly) as study_time from stud_perf
group by gradeclass,tutoring
order by gradeclass;


-- average study time of female and male
select avg(studytimeweekly) as study_time, gender from stud_perf
group by gender;


-- gender wise gpa
select gender, avg(gpa) from stud_perf 
group by  gender


