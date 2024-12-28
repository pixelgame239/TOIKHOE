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


CREATE TABLE BenhAn (
    id INT AUTO_INCREMENT PRIMARY KEY,         -- Mã bệnh án (tự tăng)
    ten VARCHAR(255) NOT NULL,                 -- Tên bệnh nhân
    dan_toc VARCHAR(100),                      -- Dân tộc
    ngay_sinh DATE NOT NULL,                   -- Ngày sinh
    tuoi INT,                                  -- Tuổi
    gioi_tinh ENUM('Nam', 'Nữ') NOT NULL,      -- Giới tính
    so_nha VARCHAR(255),                       -- Số nhà
    thon_pho VARCHAR(255),                     -- Thôn, phố
    xa_phuong VARCHAR(255),                    -- Xã, phường
    huyen VARCHAR(255),                        -- Huyện
    tinh_thanh_pho VARCHAR(255),               -- Tỉnh, thành phố
    so_the_bhyt VARCHAR(20),                   -- Số thẻ BHYT
    ngay_nhap_vien DATE,                       -- Ngày nhập viện
    ngay_ra_vien DATE,                         -- Ngày ra viện
    chan_doan_vao_vien VARCHAR(500),           -- Chẩn đoán vào viện
    chan_doan_ra_vien VARCHAR(500),            -- Chẩn đoán ra viện
    ly_do_vao_vien VARCHAR(500),               -- Lý do vào viện
    tom_tat_qua_trinh_benh_ly VARCHAR(2000),   -- Tóm tắt quá trình bệnh lý và diễn biến lâm sàng
    ngay_tao TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Ngày tạo bản ghi
    ngay_cap_nhat TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP -- Ngày cập nhật bản ghi
);

CREATE TABLE phong_kham (
    id_phong_kham INT AUTO_INCREMENT PRIMARY KEY,
    ten_phong_kham VARCHAR(255) NOT NULL,
    so_luong_review INT DEFAULT 0,
    sdt VARCHAR(15) NOT NULL,
    email VARCHAR(255) NOT NULL,
    mo_ta VARCHAR(500)
);

CREATE TABLE LichKhamBenh (
    LichKhamID INT AUTO_INCREMENT PRIMARY KEY, -- Khóa chính, tự tăng
    NgayDatLich DATE NOT NULL,                 -- Ngày đặt lịch khám
    GioDatLich TIME NOT NULL,                  -- Giờ đặt lịch khám
    UserID INT NOT NULL,                       -- ID người dùng (liên kết với bảng Users)
    DiaChi VARCHAR(255) NOT NULL,              -- Địa chỉ khám bệnh
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Thời gian tạo bản ghi
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- Thời gian cập nhật bản ghi
    CONSTRAINT FK_UserID FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE ON UPDATE CASCADE
);


INSERT INTO BenhAn (
    ten, dan_toc, ngay_sinh, tuoi, gioi_tinh, so_nha, thon_pho, xa_phuong, huyen, tinh_thanh_pho,
    so_the_bhyt, ngay_nhap_vien, ngay_ra_vien, chan_doan_vao_vien, chan_doan_ra_vien,
    ly_do_vao_vien, tom_tat_qua_trinh_benh_ly, hinh_anh
) VALUES (
    'Nguyen Van A', 'Kinh', '1990-05-20', 34, 'Nam', '123', 'Thon X', 'Phuong Y', 'Huyen Z', 'Thanh pho H',
    '1234567890', '2023-12-01', '2023-12-15', 'Viêm phổi', 'Khỏi bệnh',
    'Ho khan kéo dài', 'Bệnh nhân đã đáp ứng tốt với thuốc', '/path/to/image.jpg'
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


