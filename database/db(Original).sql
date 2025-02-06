create table [Role] (
	Id int identity(1,1) primary key,
	[Name] nvarchar(50) not null
)

create table [Staff] (
	Id int identity(1,1) primary key,
	Username nvarchar(50) null,
	[Password] nvarchar(255) null,
	[Image] nvarchar(max) default 'assets/images/default.jpg',
	Email nvarchar(255) null,
	FirstName varchar(50) null,
	LastName varchar(50) null,
	Gender nvarchar(50) null,
	Dob datetime null,
	Phone nvarchar(255) null,
	[Address] nvarchar(max) null,
	Salary decimal(10,2) null default 0.00,
	failAttempts int null default 0,
	LockTime datetime null,
	RoleId int references [Role](Id)
)

create table Customer (
	Id int identity(1,1) primary key,
	Username nvarchar(50) not null,
	[Password] nvarchar(255) not null,
	[Image] nvarchar(max) default 'assets/images/default.jpg',
	Email nvarchar(255) not null,
	FirstName varchar(50) not null,
	LastName varchar(50) not null,
	Gender nvarchar(50) not null,
	Dob datetime not null,
	Phone nvarchar(255) not null,
	[Address] nvarchar(max) not null,
	failAttempts int not null default 0,
	LockTime datetime null,
	Wallet decimal(10,2) not null default 50000.00
)

Create Table tokenForgetPassword(
	id int IDENTITY(1,1) PRIMARY KEY,
	token VarCHAR(255) NOT NULL,
	expiryTime DATETIME NOT NULL,
	isUsed bit NOT NULL,
	userId int references Customer(Id)
)

create table DepType (
	Id int identity(1,1) primary key,
	DepType nvarchar(255) not null
)

create table DepMoney (
	Id int identity(1,1) primary key,
	CusId int references Customer(Id),
	DepAmount decimal(10,2) not null,
	StartDate datetime not null default getdate(),
	EndDate datetime null,
	SavingRate decimal(10,2) null,
	DepTypeId int references DepType(Id)
)

create table DepHistory (
	Id int identity(1,1) primary key,
	DepId int references DepMoney(Id),
	Discription nvarchar(max) not null
)

create table Loan (
	Id int identity(1,1) primary key,
	CusId int references Customer(Id),
	StartDate datetime not null default getdate(),
	EndDate datetime not null,
	DateExpired int null,
	LoanAmount decimal(10,2) not null,
	LoanStatus nvarchar(255) null
)

create table LoanPayment(
	Id int identity(1,1) primary key,
	LoanId int references Loan(Id),
	PaymentAmount decimal(10,2) not null,
	PaidDate datetime not null default getdate()
)

create table LoanHistory (
	Id int identity(1,1) primary key,
	LoanId int references Loan(Id),
	Discription nvarchar(max) not null
);


