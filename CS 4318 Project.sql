CREATE DATABASE RestaurantDB;
USE RestaurantDB;
CREATE TABLE Employee
(
EmployeeId int IDENTITY(101,1) PRIMARY KEY,
EmployeeFirstName varchar(30) NOT NULL,
EmployeeLastName varchar(30) NOT NULL,
Position varchar(30) NOT NULL,
Wage decimal NOT NULL,
EmployeeAddress varchar(100) NOT NULL,
EmployeePhoneNum varchar(10) NOT NULL,
EmployeeEmail varchar(100) NOT NULL
);

INSERT INTO Employee VALUES ('James','Harden','Manager','40000.00','123 Rocket st','8322388328','jharden@gmail.com');
INSERT INTO Employee VALUES ('Kevin','Durrant','Waiter','20000.00','123 Net st','8323828328','kdurrant@gmail.com');
INSERT INTO Employee VALUES ('Lebron','James','Assistant Manager','30000.00','123 Laker st','8328328328','ljames@gmail.com');
INSERT INTO Employee VALUES ('Russell','Westbrook','Waiter','20000.00','123 Thunder st','8322382388','rwestbrook@gmail.com');

SELECT * FROM Employee;

-----------------------------------------------------------------------------------------------

CREATE TABLE TableServ
(
TableId tinyint IDENTITY(1,1) PRIMARY KEY,
EmployeeId int FOREIGN KEY REFERENCES Employee(EmployeeId),
Seats tinyint NOT NULL,
IsIndoor bit NOT NULL
);

INSERT INTO TableServ VALUES ('102','4','0');
INSERT INTO TableServ VALUES ('104','6','1');
INSERT INTO TableServ VALUES ('104','2','0');
INSERT INTO TableServ VALUES ('102','6','0');

SELECT * FROM TableServ
-----------------------------------------------------------------------------------------------

CREATE TABLE Customer
(
CustomerId int IDENTITY(1001,1) PRIMARY KEY,
CustomerFirstName varchar(30) NOT NULL,
CustomerLastName varchar(30) NOT NULL,
CustomerPhone varchar(10) NOT NULL,
CustomerEmail varchar(100) NOT NULL,
DateOfBirth date NOT NULL,
JoinDate date NOT NULL,
TotalPoints smallint NOT NULL
);

INSERT INTO Customer VALUES ('Hakeem','Olajuwon','7133177133','holajuwan@gmail.com','1963-01-21','2002-01-21','18');
INSERT INTO Customer VALUES ('Larry','Bird','7137137133','lbird@gmail.com','1956-12-07','1992-12-07','28');
INSERT INTO Customer VALUES ('Magic','Johnson','7133173177','mjohnson@gmail.com','1959-06-14','1996-06-14','16');
INSERT INTO Customer VALUES ('Tim','Duncan','7133234133','tduncan@gmail.com','1976-04-25','2016-04-25','4');

SELECT * FROM Customer
------------------------------------------------------------------------------------------------

CREATE TABLE Reservation
(
ReservationId int IDENTITY(301,1) PRIMARY KEY,
ReserveDate date NOT NULL,
ReserveTime time NOT NULL,
NumOfPeople tinyint NOT NULL
);

INSERT INTO Reservation VALUES ('2020-05-02','15:00','2');
INSERT INTO Reservation VALUES ('2020-06-06','21:00','8');
INSERT INTO Reservation VALUES ('2020-05-27','18:00','4');

SELECT * FROM Reservation;
-----------------------------------------------------------------------------------------------

CREATE TABLE Service
(
ServiceId int IDENTITY(4001,1) PRIMARY KEY,
TableId tinyint FOREIGN KEY REFERENCES TableServ(TableId) NOT NULL,
CustomerId int FOREIGN KEY REFERENCES Customer(CustomerId),
ReservationId int FOREIGN KEY REFERENCES Reservation(ReservationId),
DateTake date NOT NULL,
TimeTaken time,
IsCompleted bit NOT NULL
);

INSERT INTO Service VALUES ('3','1001','302','2020-06-06','21:00','0');
INSERT INTO Service VALUES ('2','1003','301','2020-05-02','15:00','1');
INSERT INTO Service VALUES ('1','1002','303','2020-05-27','18:00','1');

SELECT * FROM Service;
------------------------------------------------------------------------------------------------

CREATE TABLE Menu
(
MenuId tinyint IDENTITY(1,1) PRIMARY KEY,
MenuName varchar(30) NOT NULL,
MenuCategory varchar(30) NOT NULL,
MenuCost decimal NOT NULL
);

INSERT INTO Menu VALUES ('8oz Steak','Entre','18.00');
INSERT INTO Menu VALUES ('6oz Steak','Entre','15.00');
INSERT INTO Menu VALUES ('Sampler','Appetizer','10.00');
INSERT INTO Menu VALUES ('Chips and Queso','Appetizer','7.00');
INSERT INTO Menu VALUES ('Chocolate Fudge Cake','Dessert','7.00');
INSERT INTO Menu VALUES ('Cheesecake','Dessert','8.00');

SELECT * FROM Menu;
--------------------------------------------------------------------------------------------------

CREATE TABLE Orders
(
OrderId int IDENTITY(1,1) PRIMARY KEY,
CustomerId int FOREIGN KEY REFERENCES Customer(CustomerId) NOT NULL,
OrderDate date NOT NULL,
OrderTime time,
BalanceDue decimal NOT NULL,
Gratuity decimal NOT NULL,
Discounts decimal NOT NULL,
Total decimal NOT NULL,
PointsEarned smallint NOT NULL
);

INSERT INTO Orders VALUES ('1004','2020-04-30','12:00','28.50','10.00','0.00','38.50','4');
INSERT INTO Orders VALUES ('1001','2020-05-14','21:00','18.27','5.00','6.00','17.27','2');
INSERT INTO Orders VALUES ('1003','2020-05-22','15:00','48.71','15.00','5.00','58.71','5');
INSERT INTO Orders VALUES ('1002','2020-06-01','19:00','32.32','7.68','1.00','39.00','4');

SELECT * FROM Orders
--------------------------------------------------------------------------------------------------

CREATE TABLE Menu_Order
(
MenuId tinyint FOREIGN KEY REFERENCES Menu(MenuId) NOT NULL,
OrderId int FOREIGN KEY REFERENCES Orders(OrderId) NOT NULL,
Quantity tinyint DEFAULT 1
);

INSERT INTO Menu_Order VALUES ('3','3','3');
INSERT INTO Menu_Order VALUES ('5','2', '1');
INSERT INTO Menu_Order VALUES ('2','1','5');
INSERT INTO Menu_Order VALUES ('4','4','2');
INSERT INTO Menu_Order VALUES ('2','3','2');

SELECT * FROM Menu_Order;
------------------------------------------------------------------------------------------------

CREATE TABLE Reward
(
RewardId tinyint IDENTITY(1,1) PRIMARY KEY,
RewardName varchar(50) NOT NULL,
MenuId tinyint FOREIGN KEY REFERENCES Menu(MenuId) NOT NULL,
PointsRequired smallint NOT NULL,
PriceDeducted smallint NOT NULL,
Available bit NOT NULL
);

INSERT INTO Reward VALUES ('Chocolate Fudge Cake','5','2','1','0');
INSERT INTO Reward VALUES ('8oz Steak','1','5','3','1');
INSERT INTO Reward VALUES ('Sampler','3','4','2','1');
INSERT INTO Reward VALUES ('Cheese Cake','6','3','1','0');

SELECT * FROM Reward;
--------------------------------------------------------------------------------------------------

CREATE TABLE Redemption
(
RedemptionId int IDENTITY(1,1) PRIMARY KEY,
RewardId tinyint FOREIGN KEY REFERENCES Reward(RewardId) NOT NULL,
CustomerId int FOREIGN KEY REFERENCES Customer(CustomerId) NOT NULL
);

INSERT INTO Redemption VALUES ('2','1003');
INSERT INTO Redemption VALUES ('4','1001');
INSERT INTO Redemption VALUES ('3','1004');

SELECT * FROM Redemption;