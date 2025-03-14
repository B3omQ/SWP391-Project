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
	Salary decimal(18,0) not null default 50000,
	failAttempts int null default 0,
	LockTime datetime null,
	RoleId int references [Role](Id)
)

CREATE TABLE [dbo].[Articles] (
    [Id] INT IDENTITY(1,1) PRIMARY KEY,           -- Khóa chính, tự động tăng
    [Title] NVARCHAR(255) NOT NULL,              -- Tiêu đề bài viết
    [Description] NVARCHAR(MAX) NOT NULL,        -- Mô tả, cho phép nội dung dài
    [Category] NVARCHAR(100) NOT NULL,           -- Thể loại bài viết
    [PublishDate] DATETIME NULL,                 -- Ngày xuất bản, có thể null
    [AuthorId] INT NOT NULL,                     -- ID tác giả, liên kết với bảng Staff
    [ImageUrl] NVARCHAR(255) NULL,               -- Đường dẫn ảnh, có thể null
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(), -- Thời gian tạo, mặc định là hiện tại
    [UpdatedAt] DATETIME NULL,                   -- Thời gian cập nhật, có thể null

    -- Ràng buộc khóa ngoại với bảng Staff
    CONSTRAINT FK_Articles_Staff FOREIGN KEY ([AuthorId]) 
    REFERENCES [dbo].[Staff] ([Id]) 
    ON DELETE NO ACTION ON UPDATE NO ACTION
);

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
	Wallet decimal(18,0) not null default 50000,
	isAutoProfitEnabled BIT DEFAULT 0
)

CREATE TABLE CustomerReview (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    CusId INT NOT NULL,
    Rate INT CHECK (Rate BETWEEN 1 AND 5) NOT NULL,
    Review NVARCHAR(MAX) NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CusId) REFERENCES Customer(Id) ON DELETE CASCADE
);

create table NotifyType (
	Id int primary key,
	NotifyName nvarchar(255) not null
)

create table Notification (
	Id int identity(1,1) primary key,
	CusId int references Customer(Id) null,
	StaffId int references Staff(Id) null,
	NotifyType int references NotifyType(Id),
	Description nvarchar(max) null,
	CreateTime datetime default getdate(),
	isRead bit not null default 0
)

Create table verifyIdentityInformation (
	Id int identity(1,1) primary key,
	CusId int references Customer(Id),
	IdentityCardNumber nvarchar(255) not null,
	IdentityCardFrontSide nvarchar(max) not null,
	IdentityCardBackSide nvarchar(max) not null,
	ReasonReject nvarchar(max) null,
	PortraitPhoto nvarchar(max) not null,
	PendingStatus nvarchar(max) not null default 'Pending'
)

Create Table tokenForgetPassword(
	id int IDENTITY(1,1) PRIMARY KEY,
	token VarCHAR(255) NOT NULL,
	expiryTime DATETIME NOT NULL,
	isUsed bit NOT NULL,
	userId int references Customer(Id)
)

create table DepService (
	Id int identity(1,1) primary key,
	DepServiceName nvarchar(max) null,
	Description nvarchar(max) null,
	MinimumDep decimal(18,0) not null,	
	DuringTime int null,
	SavingRate float null,
	SavingRateMinimum float null,
	ReasonReject nvarchar(255) null,
	PendingStatus nvarchar(255) not null default 'Pending'
)

create table DepServiceUsed (
	Id int identity(1,1) primary key,	
	DepId int references DepService(Id),
	CusId int references Customer(Id),
	DepTypeId int references DepType(Id),
	Amount decimal(18,0) not null,
	StartDate datetime not null default getdate(),
	EndDate datetime null,
	MaturityOption VARCHAR(50),
	DepStatus nvarchar(255) null
)

create table DepHistory (
	Id int identity(1,1) primary key,
	DSUId int references DepServiceUsed(Id) null,
	Discription nvarchar(max) not null,
	CreatedAt DATETIME,
	Amount DECIMAL(15, 0)
)

create table LoanService (
	Id int identity(1,1) primary key,
	LoanServiceName nvarchar(max) null,
	Description nvarchar(max) null,
	LoanTypeRepay nvarchar(255) not null,
	DuringTime int not null,
	GracePeriod int not null,
	OnTermRate float not null,
	AfterTermRate float not null,
	PenaltyRate float not null,	
	MinimumLoan decimal(18,0) not null,
	MaximumLoan decimal(18,0) not null,
	ReasonReject nvarchar(255) null,
	PendingStatus nvarchar(255) not null default 'Pending'
)

create table LoanServiceUsed (
	Id int identity(1,1) primary key,
	LoanId int references LoanService(Id),
	CusId int references Customer(Id),
	Amount decimal(18,0) not null,
	StartDate datetime null,
	EndDate datetime null,
	DateExpiredCount int null,
	DebtRepayAmount decimal(18,0) null,
	IncomeVertification nvarchar(max) not null,
	LoanStatus nvarchar(255) null -- 1.Pending (chờ duyệt) ; 
									--2.Denied (Từ chối) ; 
									--3.Approved (Duyệt thành công từ manager) ; 
									--4.InProcessing (Trong trạng thái vay) ; 
									--5.Done (Thanh toán hoàn thành gói vay) ; 
									--6.PastDue (quá hạn trả tiền)
)


create table LoanPayment(
	Id int identity(1,1) primary key,
	LSUId int references LoanServiceUsed(Id),
	PaymentAmount decimal(18,0) not null,
	PaidDate datetime not null default getdate()
)

create table LoanHistory (
	Id int identity(1,1) primary key,
	LSUId int references LoanServiceUsed(Id),
	Discription nvarchar(max) not null
);


