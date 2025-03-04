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
	FirstName nvarchar(50) null,
	LastName nvarchar(50) null,
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
	FirstName nvarchar(50) not null,
	LastName nvarchar(50) not null,
	Gender nvarchar(50) not null,
	Dob datetime not null,	
	Phone nvarchar(255) not null,
	[Address] nvarchar(max) not null,
	failAttempts int not null default 0,
	LockTime datetime null,
	Wallet decimal(10,2) not null default 50000.00
)

Create table IdentityInformation (
	Id int identity(1,1) primary key,
	CusId int references Customer(Id),
	IdentityCardFrontSide nvarchar(max),
	IdentityCardBackSide nvarchar(max),
	PortraitPhoto nvarchar(max),
	PendingStatus nvarchar(max) not null default 'Pending'
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

create table DepService (
	Id int identity(1,1) primary key,
	Description nvarchar(max) null,
	MinimumDep decimal(10,2) not null,	
	DuringTime int null,
	SavingRate decimal(10,2) null,
	SavingRateMinimum decimal(10,2) null,
	PendingStatus nvarchar(255) not null default 'Pending'
)

create table DepServiceUsed (
	Id int identity(1,1) primary key,	
	DepId int references DepService(Id),
	CusId int references Customer(Id),
	DepTypeId int references DepType(Id),
	Amount decimal(10,2) not null,
	StartDate datetime not null default getdate(),
	EndDate datetime null,
	DepStatus nvarchar(255) null
)

create table DepHistory (
	Id int identity(1,1) primary key,
	DSUId int references DepServiceUsed(Id),
	Discription nvarchar(max) not null
)

create table LoanService (
	Id int identity(1,1) primary key,
	Description nvarchar(max) null,
	DuringTime int null,
	PenaltyRate decimal(10,2) not null,
	MinimumLoan decimal(10,2) not null,
	MaximumLoan decimal(10,2) not null
)

create table LoanServiceUsed (
	Id int identity(1,1) primary key,
	LoanId int references LoanService(Id),
	CusId int references Customer(Id),
	Amount decimal(10,2) not null,
	StartDate datetime not null default getdate(),
	EndDate datetime null,
	DateExpiredCount int null,
	DebtRepayAmount decimal(10,2) null,
	LoanStatus nvarchar(255) null
)

create table LoanPayment(
	Id int identity(1,1) primary key,
	LSUId int references LoanServiceUsed(Id),
	PaymentAmount decimal(10,2) not null,
	PaidDate datetime not null default getdate()
)

create table LoanHistory (
	Id int identity(1,1) primary key,
	LSUId int references LoanServiceUsed(Id),
	Discription nvarchar(max) not null
);


