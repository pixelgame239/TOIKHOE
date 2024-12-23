-- Tạo bảng Users
CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY, -- Auto Increment Primary Key
    name VARCHAR(255),                     -- Name of the user
    email VARCHAR(255),                    -- Email address
    phone_number VARCHAR(15),              -- Phone number
    address VARCHAR(255),                  -- Address
    status ENUM('active', 'inactive'),     -- Status (active or inactive)
    role ENUM('Patient', 'Doctor'),        -- Role (Patient or Doctor)
    province VARCHAR(100),                 -- Province
    password VARCHAR(255)                  -- Password
);


-- Tạo bảng Doctors (liên kết với Users)
CREATE TABLE Doctors (
    doctorID INT AUTO_INCREMENT PRIMARY KEY,
    userID INT NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    experience INT NOT NULL,
    working_hours VARCHAR(255),
    location VARCHAR(100),
    FOREIGN KEY (userID) REFERENCES Users(userID) ON DELETE CASCADE
);

-- Tạo bảng Appointments
CREATE TABLE Appointments (
    appointmentID INT AUTO_INCREMENT PRIMARY KEY,
    userID INT NOT NULL,
    doctorID INT NOT NULL,
    date DATE NOT NULL,
    time TIME NOT NULL,
    consultation_type ENUM('Online', 'In-Person') DEFAULT 'Online',
    note VARCHAR(100),
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (userID) REFERENCES Users(userID) ON DELETE CASCADE,
    FOREIGN KEY (doctorID) REFERENCES Doctors(doctorID) ON DELETE CASCADE
);

-- Tạo bảng Products
CREATE TABLE Products (
    productID INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(100),
    price DECIMAL(10, 2) NOT NULL,
    stock INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY, -- ID duy nhất cho mỗi bản ghi
    userID INT NOT NULL,                            -- ID người dùng
    productID INT NOT NULL,                         -- ID sản phẩm
    quantity INT NOT NULL,                          -- Số lượng sản phẩm
    price DECIMAL(10, 2) NOT NULL,                  -- Giá sản phẩm
    totalAmount DECIMAL(10, 2) NOT NULL,            -- Tổng số tiền
    shipping_fee DECIMAL(10, 2) DEFAULT 0.00,       -- Phí vận chuyển
    discount_code VARCHAR(50),                      -- Mã giảm giá (nếu có)
    paymentStatus ENUM('Pending', 'Paid', 'Failed') DEFAULT 'Pending', -- Trạng thái thanh toán
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Ngày tạo
    FOREIGN KEY (userID) REFERENCES Users(userID) ON DELETE CASCADE,  -- Liên kết với bảng Users
    FOREIGN KEY (productID) REFERENCES Products(productID) ON DELETE CASCADE -- Liên kết với bảng Products
);


-- Tạo bảng Feedbacks (Đánh giá sản phẩm và dịch vụ)
CREATE TABLE Feedbacks (
    feedbackID INT AUTO_INCREMENT PRIMARY KEY,
    userID INT NOT NULL,
    doctorID INT,
    productID INT,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (userID) REFERENCES Users(userID) ON DELETE CASCADE,
    FOREIGN KEY (doctorID) REFERENCES Doctors(doctorID) ON DELETE SET NULL,
    FOREIGN KEY (productID) REFERENCES Products(productID) ON DELETE SET NULL
);

-- Tạo bảng PaymentTransactions (Giao dịch thanh toán)
CREATE TABLE PaymentTransactions (
    transactionID INT AUTO_INCREMENT PRIMARY KEY,
    orderID INT NOT NULL,
    transaction_code VARCHAR(100) NOT NULL,
    payment_method ENUM('CreditCard', 'E-Wallet', 'BankTransfer') NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    status ENUM('Success', 'Failed') DEFAULT 'Success',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (orderID) REFERENCES Orders(orderID) ON DELETE CASCADE
);

-- Tạo bảng Notifications (Thông báo người dùng)
CREATE TABLE Notifications (
    notificationID INT AUTO_INCREMENT PRIMARY KEY,
    userID INT NOT NULL,
    message VARCHAR(100) NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (userID) REFERENCES Users(userID) ON DELETE CASCADE
);

INSERT INTO Users (id, username, email, password, created_at) VALUES
(1, 'john_doe', 'john.doe@example.com', 'password123', NOW()),
(2, 'jane_smith', 'jane.smith@example.com', 'password123', NOW()),
(3, 'michael_lee', 'michael.lee@example.com', 'password123', NOW()),
(4, 'susan_wong', 'susan.wong@example.com', 'password123', NOW()),
(5, 'alex_jones', 'alex.jones@example.com', 'password123', NOW());

INSERT INTO Doctors (id, name, specialty, phone, email, created_at) VALUES
(1, 'Dr. Emily Carter', 'Cardiologist', '123-456-7890', 'emily.carter@example.com', NOW()),
(2, 'Dr. Daniel Smith', 'Dentist', '123-456-7891', 'daniel.smith@example.com', NOW()),
(3, 'Dr. Sophia Johnson', 'Pediatrician', '123-456-7892', 'sophia.johnson@example.com', NOW()),
(4, 'Dr. Liam Brown', 'Orthopedic', '123-456-7893', 'liam.brown@example.com', NOW()),
(5, 'Dr. Olivia Martinez', 'Dermatologist', '123-456-7894', 'olivia.martinez@example.com', NOW());

INSERT INTO Products (name, description, price, stock) VALUES
('Blood Pressure Monitor', 'Accurate and easy-to-use device', 49.99, 100),
('Digital Thermometer', 'Quick temperature measurement', 14.99, 200),
('Vitamin C Tablets', 'Boost immunity and health', 19.99, 150),
('First Aid Kit', 'Compact and essential medical supplies', 29.99, 50),
('Face Mask (Pack of 50)', 'Protective and breathable', 9.99, 300);


