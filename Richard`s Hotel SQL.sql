-- Table Creation
CREATE TABLE MsCustomer (
    CustomerID CHAR(15) PRIMARY KEY CHECK (CustomerID REGEXP '^CU[0-9]{3}$'),
    CustomerName CHAR(100) NOT NULL,
    CustomerAge INT,
    CustomerEmail VARCHAR(100) UNIQUE NOT NULL,
    CustomerTelp VARCHAR(30)
);

CREATE TABLE MsPaymentType (
    PaymentTypeID CHAR(5) PRIMARY KEY CHECK (PaymentTypeID REGEXP '^PT[0-9]{3}$'),
    PaymentTypeName VARCHAR(100) NOT NULL,
    PaymentFee INT
);

CREATE TABLE MsStaff (
    StaffID CHAR(5) PRIMARY KEY CHECK (StaffID REGEXP '^ST[0-9]{3}$'),
    StaffName VARCHAR(100) NOT NULL,
    StaffAge INT,
    StaffEmail VARCHAR(100) UNIQUE NOT NULL,
    StaffTelp VARCHAR(20)
);

CREATE TABLE MsRoomDetail (
    RoomTypeID CHAR(5) PRIMARY KEY CHECK (RoomTypeID REGEXP '^RT[0-9]{3}$'),
    RoomType VARCHAR(20) NOT NULL,
    RoomPrice DECIMAL(12,0) NOT NULL
);

CREATE TABLE MsRoom (
    RoomID CHAR(5) PRIMARY KEY CHECK (RoomID REGEXP '^RM[0-9]{3}$'),
    RoomTypeID CHAR(5) NOT NULL,
    RoomAvailability VARCHAR(50),
    -- FK 1: RoomTypeID ke MsRoomDetail
    FOREIGN KEY (RoomTypeID) REFERENCES MsRoomDetail(RoomTypeID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE MsTransaction (
    TransactionID CHAR(5) PRIMARY KEY CHECK (TransactionID REGEXP '^TR[0-9]{3}$'),
    PaymentTypeID CHAR(5) NOT NULL,
    TransactionDate DATE NOT NULL,
    CheckInDateTime DATETIME NOT NULL,
    CheckOutDateTime DATETIME NOT NULL,
    -- FK 2: PaymentTypeID ke MsPaymentType
    FOREIGN KEY (PaymentTypeID) REFERENCES MsPaymentType(PaymentTypeID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE TransactionHeader (
    HeaderID CHAR(5) PRIMARY KEY CHECK (HeaderID REGEXP '^TH[0-9]{3}$'),
    CustomerID CHAR(15) NOT NULL,
    StaffID CHAR(5) NOT NULL,
    RoomID CHAR(5) NOT NULL,
    TransactionID CHAR(5) NOT NULL,
    -- FK 3: CustomerID ke MsCustomer
    FOREIGN KEY (CustomerID) REFERENCES MsCustomer(CustomerID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    -- FK 4: StaffID ke MsStaff
    FOREIGN KEY (StaffID) REFERENCES MsStaff(StaffID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    -- FK 5: RoomID ke MsRoom
    FOREIGN KEY (RoomID) REFERENCES MsRoom(RoomID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    -- FK 6: TransactionID ke MsTransaction
    FOREIGN KEY (TransactionID) REFERENCES MsTransaction(TransactionID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- Inserting Value
INSERT INTO MsPaymentType (PaymentTypeID, PaymentTypeName, PaymentFee) 
VALUES
('PT001', 'Cash', 0),
('PT002', 'Credit Card', 1500),
('PT003', 'Debit Card', 1000),
('PT004', 'E-Wallet', 500),
('PT005', 'Qris', 0);

INSERT INTO MsRoomDetail (RoomTypeID, RoomType, RoomPrice) 
VALUES
('RT001', 'Single', 350000),
('RT002', 'Double', 500000),
('RT003', 'Suite', 900000),
('RT004', 'Deluxe', 1200000),
('RT005', 'Presidential Suite', 2400000);

INSERT INTO MsCustomer (CustomerID, CustomerName, CustomerAge, CustomerEmail, CustomerTelp) 
VALUES
('CU001', 'Laura Bennett', 49, 'laura.bennett@gmail.com', '08509734187'),
('CU002', 'Ryan Coleman', 22, 'ryan.coleman@gmail.com', '08732826597'),
('CU003', 'Sophia Ramirez', 35, 'sophia.ramirez@gmail.com', '08770727390'),
('CU004', 'James Mitchell', 29, 'james.mitchell@gmail.com', '08197978717'),
('CU005', 'Isabella Rogers', 27, 'isabella.rogers@gmail.com', '08520452472'),
('CU006', 'Lucas Morgan', 38, 'lucas.morgan@gmail.com', '08851878659'),
('CU007', 'Mia Simmons', 54, 'mia.simmons@gmail.com', '08439136046'),
('CU008', 'Alexander Foster', 53, 'alexander.foster@gmail.com', '08862390991'),
('CU009', 'Chloe Reed', 45, 'chloe.reed@gmail.com', '08888338341'),
('CU010', 'Daniel Hayes', 27, 'daniel.hayes@gmail.com', '08790574982');

INSERT INTO MsStaff (StaffID, StaffName, StaffAge, StaffEmail, StaffTelp) 
VALUES
('ST001', 'Grace Turner', 51, 'grace.turner@gmail.com', '08186704863'),
('ST002', 'Matthew Ross', 32, 'matthew.ross@gmail.com', '08891871026'),
('ST003', 'Ella Patterson', 54, 'ella.patterson@gmail.com', '08679643587'),
('ST004', 'Benjamin Brooks', 51, 'benjamin.brooks@gmail.com', '08469199586'),
('ST005', 'Ava Cooper', 58, 'ava.cooper@gmail.com', '08321900348'),
('ST006', 'Samuel Ward', 48, 'samuel.ward@gmail.com', '08974153389'),
('ST007', 'Lily Morgan', 31, 'lily.morgan@gmail.com', '08543524722'),
('ST008', 'David Bennett', 37, 'david.bennett@gmail.com', '08691714489');

INSERT INTO MsRoom (RoomID, RoomTypeID, RoomAvailability) 
VALUES
('RM001', 'RT003', 'Maintenance'),
('RM002', 'RT003', 'Maintenance'),
('RM003', 'RT004', 'Available'),
('RM004', 'RT005', 'Available'),
('RM005', 'RT001', 'Maintenance'),
('RM006', 'RT003', 'Available'),
('RM007', 'RT001', 'Available'),
('RM008', 'RT001', 'Occupied'),
('RM009', 'RT002', 'Occupied'),
('RM010', 'RT002', 'Occupied'),
('RM011', 'RT003', 'Maintenance'),
('RM012', 'RT002', 'Available'),
('RM013', 'RT003', 'Occupied'),
('RM014', 'RT005', 'Available'),
('RM015', 'RT003', 'Maintenance'),
('RM016', 'RT003', 'Occupied'),
('RM017', 'RT004', 'Occupied'),
('RM018', 'RT004', 'Available'),
('RM019', 'RT001', 'Occupied'),
('RM020', 'RT005', 'Occupied');

INSERT INTO MsTransaction (TransactionID, TransactionDate, CheckInDateTime, CheckOutDateTime, PaymentTypeID) 
VALUES
('TR001', '2025-09-01', '2025-09-01 02:00', '2025-09-05 02:00', 'PT005'),
('TR002', '2025-09-02', '2025-09-02 01:00', '2025-09-06 01:00', 'PT001'),
('TR003', '2025-09-03', '2025-09-03 04:00', '2025-09-06 04:00', 'PT002'),
('TR004', '2025-09-04', '2025-09-04 03:00', '2025-09-06 03:00', 'PT003'),
('TR005', '2025-09-05', '2025-09-05 01:00', '2025-09-11 01:00', 'PT005'),
('TR006', '2025-09-06', '2025-09-06 02:00', '2025-09-07 02:00', 'PT002'),
('TR007', '2025-09-07', '2025-09-07 00:00', '2025-09-08 00:00', 'PT004'),
('TR008', '2025-09-08', '2025-09-08 00:00', '2025-09-09 00:00', 'PT002'),
('TR009', '2025-09-09', '2025-09-09 03:00', '2025-09-12 03:00', 'PT005'),
('TR010', '2025-09-10', '2025-09-10 00:00', '2025-09-15 00:00', 'PT002'),
('TR011', '2025-09-11', '2025-09-11 00:00', '2025-09-15 00:00', 'PT001'),
('TR012', '2025-09-12', '2025-09-12 01:00', '2025-09-16 01:00', 'PT004'),
('TR013', '2025-09-13', '2025-09-13 03:00', '2025-09-16 03:00', 'PT001'),
('TR014', '2025-09-14', '2025-09-14 01:00', '2025-09-17 01:00', 'PT003'),
('TR015', '2025-09-15', '2025-09-15 04:00', '2025-09-17 04:00', 'PT001'),
('TR016', '2025-09-01', '2025-09-01 02:00', '2025-09-05 02:00', 'PT005'),
('TR017', '2025-09-02', '2025-09-02 01:00', '2025-09-06 01:00', 'PT001'),
('TR018', '2025-09-03', '2025-09-03 04:00', '2025-09-06 04:00', 'PT002'),
('TR019', '2025-09-04', '2025-09-04 03:00', '2025-09-06 03:00', 'PT003'),
('TR020', '2025-09-05', '2025-09-05 01:00', '2025-09-11 01:00', 'PT005'),
('TR021', '2025-09-06', '2025-09-06 02:00', '2025-09-07 02:00', 'PT002'),
('TR022', '2025-09-07', '2025-09-07 00:00', '2025-09-08 00:00', 'PT004'),
('TR023', '2025-09-08', '2025-09-08 00:00', '2025-09-09 00:00', 'PT002'),
('TR024', '2025-09-09', '2025-09-09 03:00', '2025-09-12 03:00', 'PT005'),
('TR025', '2025-09-10', '2025-09-10 00:00', '2025-09-15 00:00', 'PT002'),
('TR026', '2025-09-11', '2025-09-11 00:00', '2025-09-15 00:00', 'PT001');

INSERT INTO TransactionHeader (HeaderID, TransactionID, RoomID, StaffID, CustomerID) 
VALUES
('TH001', 'TR001', 'RM001', 'ST002', 'CU002'),
('TH002', 'TR002', 'RM012', 'ST001', 'CU010'),
('TH003', 'TR003', 'RM010', 'ST002', 'CU010'),
('TH004', 'TR004', 'RM016', 'ST008', 'CU009'),
('TH005', 'TR005', 'RM013', 'ST008', 'CU010'),
('TH006', 'TR006', 'RM001', 'ST004', 'CU007'),
('TH007', 'TR007', 'RM016', 'ST007', 'CU010'),
('TH008', 'TR008', 'RM016', 'ST002', 'CU010'),
('TH009', 'TR009', 'RM012', 'ST008', 'CU010'),
('TH010', 'TR010', 'RM011', 'ST005', 'CU010'),
('TH011', 'TR011', 'RM005', 'ST002', 'CU004'),
('TH012', 'TR012', 'RM011', 'ST005', 'CU010'),
('TH013', 'TR013', 'RM013', 'ST006', 'CU006'),
('TH014', 'TR014', 'RM003', 'ST001', 'CU003'),
('TH015', 'TR015', 'RM015', 'ST003', 'CU006'),
('TH016', 'TR016', 'RM002', 'ST002', 'CU002'),
('TH017', 'TR017', 'RM004', 'ST001', 'CU010'),
('TH018', 'TR018', 'RM006', 'ST002', 'CU010'),
('TH019', 'TR019', 'RM007', 'ST008', 'CU009'),
('TH020', 'TR020', 'RM008', 'ST008', 'CU010'),
('TH021', 'TR021', 'RM009', 'ST004', 'CU007'),
('TH022', 'TR022', 'RM014', 'ST007', 'CU010'),
('TH023', 'TR023', 'RM017', 'ST007', 'CU010'),
('TH024', 'TR024', 'RM018', 'ST008', 'CU010'),
('TH025', 'TR025', 'RM019', 'ST005', 'CU004'),
('TH026', 'TR026', 'RM020', 'ST002', 'CU004');
