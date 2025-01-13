create database BankingSystem

use BankingSystem;

go


create table Role(
	role_id INT PRIMARY KEY,
	role_name NVARCHAR(50) NOT NULL,
)

create table Account(
	id INT IDENTITY(1, 1) PRIMARY KEY,
	email NVARCHAR(100) unique,
	password NVARCHAR(50) NOT NULL,
	full_name NVARCHAR(50) NOT NULL,
	gender NVARCHAR(10),
    phone_number NVARCHAR(15),
	address NVARCHAR(200),
	role_id INT,
	FOREIGN KEY (role_id) REFERENCES Role(role_id),
)

INSERT INTO Role(role_id, role_name) 
VALUES 
	(1, 'Admin'),
	(2, 'Customer'),
	(3, 'Accountant'),
	(4, 'Consultant'),
	(5, 'CRMSpecialist')



