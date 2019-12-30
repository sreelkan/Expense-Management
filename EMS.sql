use sreedb
create schema slca

create table slca.Employee(
EmployeeId int identity primary key,
Name varchar(30),
DateOfJoining date,
Location varchar(30),
Department varchar(30),
Experience int,
Role varchar(20),
Username varchar(20)
)


drop table slca.Employee
insert into slca.Employee values('Sreelaxmi','2018-12-12','Mumbai','ProductDevelopment',1,'Analyst','sreelaxmi@gmail.com')
insert into slca.Employee values('Swetha','2017-12-10','Banglore','L&D',3,'SeniorAnalyst','swetha@gmail.com')
insert into slca.Employee values('Jayasree','2015-12-10','Banglore','R&D',3,'Developer','jayasree@gmail.com')


create table slca.Supervisor(
SupervisorId int identity(1000,1) primary key,
SupervisorName varchar(20),
EmployeeId int foreign key references slca.Employee(EmployeeId),
ReceiptNumber  int foreign key references slca.Receipts(ReceiptNumber),
ReceiptAmount float,
Username varchar(20)
)


insert into slca.Supervisor(SupervisorName) values ('Ayushi')
drop table slca.Supervisor

create table slca.Receipts(
ReceiptNumber int primary key,
EmployeeId int foreign key references slca.Employee(EmployeeId),
ReceiptDate date,
ReceiptAmount float,
ReceiptUrl varchar(50),
Status varchar(30),
ApprovedName varchar(20),
ApprovedDate date)

drop table slca.Receipts

select * from slca.Employee
select * from slca.Supervisor
select * from slca.Receipts
select * from slca.MapSupervisorEmp


create table slca.MapSupervisorEmp(
MapSupervisorEmpId int identity primary key,
EmployeeId int foreign key references slca.Employee(EmployeeId),
SupervisorId int foreign key references slca.Supervisor(SupervisorId))
drop table slca.MapSupervisorEmp

insert into slca.MapSupervisorEmp values (1,1000),(2,1000)

insert into slca.Supervisor (SupervisorName) values ('Ayushi')
update slca.Supervisor set Username='ayushi@gmail.com' where SupervisorId=1000






CREATE TRIGGER 
    supervisor_insert
ON 
    slca.Employee 
FOR INSERT, UPDATE 
AS
  BEGIN
  from slca.Employee as Emp join slca.Supervisor 
  if(select Role  from slca.Employee) like 'Supervisor' 
       INSERT INTO slca.Supervisor 
      (
        SupervisorId,
        SupervisorName
      )
    SELECT 
      EmployeeId,
      Name  
    FROM slca.Employee  
END

drop Trigger supervisor_insert