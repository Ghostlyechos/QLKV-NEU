
CREATE DATABASE QLKV;
 GO

USE QLKV;
GO

-- 1. Xóa bảng cũ nếu đã tồn tại để tránh lỗi khi chạy lại nhiều lần
IF OBJECT_ID('dbo.DonVi', 'U') IS NOT NULL 
  DROP TABLE dbo.DonVi; 
GO

-- 2. Tạo bảng DonVi với đầy đủ các trường
CREATE TABLE DonVi (
    IDDonVi INT IDENTITY(1,1) PRIMARY KEY, 
    TenDonVi NVARCHAR(255) NOT NULL,
    IsParent BIT DEFAULT 1,                
    ParentID INT NULL,
    MoTa NVARCHAR(MAX) NULL,               
    WebsiteLink VARCHAR(255) NULL,
    FOREIGN KEY (ParentID) REFERENCES DonVi(IDDonVi)
);
GO

-- =========================================================
-- 3. THÊM DỮ LIỆU CẤP 1 (TRƯỜNG/VIỆN/TRUNG TÂM/CÁC ĐƠN VỊ...)
-- =========================================================
INSERT INTO DonVi (TenDonVi, IsParent, ParentID) VALUES (N'TRƯỜNG KINH TẾ VÀ QUẢN LÝ CÔNG', 1, NULL); -- ID = 1
INSERT INTO DonVi (TenDonVi, IsParent, ParentID) VALUES (N'TRƯỜNG KINH DOANH', 1, NULL);             -- ID = 2
INSERT INTO DonVi (TenDonVi, IsParent, ParentID) VALUES (N'TRƯỜNG CÔNG NGHỆ', 1, NULL);              -- ID = 3
INSERT INTO DonVi (TenDonVi, IsParent, ParentID) VALUES (N'VIỆN KẾ TOÁN - KIỂM TOÁN', 1, NULL);      -- ID = 4
INSERT INTO DonVi (TenDonVi, IsParent, ParentID) VALUES (N'VIỆN NGÂN HÀNG - TÀI CHÍNH', 1, NULL);    -- ID = 5
INSERT INTO DonVi (TenDonVi, IsParent, ParentID) VALUES (N'CÁC ĐƠN VỊ CHỨC NĂNG', 1, NULL);          -- ID = 6
INSERT INTO DonVi (TenDonVi, IsParent, ParentID) VALUES (N'CÁC ĐƠN VỊ DỊCH VỤ HỖ TRỢ ĐÀO TẠO', 1, NULL); -- ID = 7
INSERT INTO DonVi (TenDonVi, IsParent, ParentID) VALUES (N'CÁC VIỆN NGHIÊN CỨU', 1, NULL);           -- ID = 8
INSERT INTO DonVi (TenDonVi, IsParent, ParentID) VALUES (N'CÁC ĐƠN VỊ GIẢNG DẠY CHUYÊN BIỆT', 1, NULL); -- ID = 9
INSERT INTO DonVi (TenDonVi, IsParent, ParentID) VALUES (N'CÁC ĐƠN VỊ TRỰC THUỘC', 1, NULL);         -- ID = 10

-- =========================================================
-- 4. THÊM DỮ LIỆU CẤP 2 (KHOA/PHÒNG BAN)
-- =========================================================

-- Thuộc TRƯỜNG KINH TẾ VÀ QUẢN LÝ CÔNG (ParentID = 1)
INSERT INTO DonVi (TenDonVi, IsParent, ParentID) VALUES 
(N'Khoa Đầu tư', 0, 1), 
(N'Khoa Kinh tế học', 0, 1), 
(N'Khoa Khoa học quản lý', 0, 1), 
(N'Khoa Kế hoạch và Phát triển', 0, 1), 
(N'Khoa Luật', 0, 1), 
(N'Khoa Lý luận chính trị', 0, 1), 
(N'Khoa Môi trường, Biến đổi khí hậu và Đô thị', 0, 1), 
(N'Khoa Ngoại ngữ kinh tế', 0, 1);

-- Thuộc TRƯỜNG KINH DOANH (ParentID = 2)
INSERT INTO DonVi (TenDonVi, IsParent, ParentID) VALUES 
(N'Khoa Bảo hiểm', 0, 2), 
(N'Khoa Bất động sản và Kinh tế tài nguyên', 0, 2), 
(N'Khoa Du lịch và Khách sạn', 0, 2), 
(N'Khoa Kinh tế và Quản lý nguồn nhân lực', 0, 2), 
(N'Khoa Marketing', 0, 2), 
(N'Khoa Quản trị kinh doanh', 0, 2), 
(N'Viện Quản trị kinh doanh', 0, 2), 
(N'Viện Thương mại và Kinh tế Quốc tế', 0, 2);

-- Thuộc TRƯỜNG CÔNG NGHỆ (ParentID = 3)
INSERT INTO DonVi (TenDonVi, IsParent, ParentID, WebsiteLink) VALUES 
(N'Khoa Công nghệ thông tin', 0, 3, 'https://fit.neu.edu.vn'), 
(N'Khoa Hệ thống thông tin quản lý', 0, 3, NULL), 
(N'Khoa Khoa học cơ sở', 0, 3, NULL), 
(N'Khoa Khoa học dữ liệu và Trí tuệ nhân tạo', 0, 3, NULL), 
(N'Khoa Thống kê', 0, 3, NULL), 
(N'Khoa Toán kinh tế', 0, 3, 'https://toankinhte.neu.edu.vn');

-- Thuộc VIỆN KẾ TOÁN - KIỂM TOÁN (ParentID = 4)
INSERT INTO DonVi (TenDonVi, IsParent, ParentID) VALUES 
(N'Viện Kế toán – Kiểm toán', 0, 4);

-- Thuộc VIỆN NGÂN HÀNG - TÀI CHÍNH (ParentID = 5)
INSERT INTO DonVi (TenDonVi, IsParent, ParentID) VALUES 
(N'Viện Ngân hàng – Tài chính', 0, 5);

-- Thuộc CÁC ĐƠN VỊ CHỨC NĂNG (ParentID = 6)
INSERT INTO DonVi (TenDonVi, IsParent, ParentID) VALUES 
(N'Phòng Tổng hợp', 0, 6), 
(N'Phòng Tổ chức cán bộ', 0, 6), 
(N'Phòng Quản lý đào tạo', 0, 6), 
(N'Phòng Quản lý khoa học', 0, 6), 
(N'Phòng Hợp tác quốc tế', 0, 6), 
(N'Phòng Khảo thí và Đảm bảo chất lượng giáo dục', 0, 6), 
(N'Phòng Công tác chính trị và Quản lý sinh viên', 0, 6), 
(N'Phòng Thanh tra – Pháp chế', 0, 6), 
(N'Phòng Tài chính – Kế toán', 0, 6), 
(N'Phòng Truyền thông', 0, 6), 
(N'Phòng Quản trị thiết bị', 0, 6), 
(N'Viện Đào tạo Tiên tiến, CLC & POHE', 0, 6), 
(N'Viện Đào tạo sau đại học', 0, 6), 
(N'Viện Đào tạo quốc tế', 0, 6), 
(N'Trung tâm Ứng dụng công nghệ thông tin', 0, 6), 
(N'Trung tâm Đào tạo từ xa', 0, 6), 
(N'Khoa Đại học tại chức', 0, 6);

-- Thuộc CÁC ĐƠN VỊ DỊCH VỤ HỖ TRỢ ĐÀO TẠO (ParentID = 7)
INSERT INTO DonVi (TenDonVi, IsParent, ParentID) VALUES 
(N'Trung tâm Đào tạo liên tục', 0, 7), 
(N'Trung tâm Thông tin Thư viện', 0, 7), 
(N'Trung tâm Dịch vụ hỗ trợ đào tạo', 0, 7), 
(N'Trung tâm Ngoại ngữ kinh tế', 0, 7), 
(N'Trung tâm Đào tạo và Tư vấn CNTT', 0, 7), 
(N'Trung tâm Nghiên cứu, Tư vấn kinh tế và kinh doanh', 0, 7), 
(N'Trung tâm Đổi mới sáng tạo và Hướng nghiệp', 0, 7), 
(N'Nhà Xuất bản Đại học Kinh tế Quốc dân', 0, 7), 
(N'Tạp chí Kinh tế và Phát triển', 0, 7), 
(N'Trạm Y tế', 0, 7);

-- Thuộc CÁC VIỆN NGHIÊN CỨU (ParentID = 8)
INSERT INTO DonVi (TenDonVi, IsParent, ParentID) VALUES 
(N'Viện Phát triển bền vững', 0, 8);

-- Thuộc CÁC ĐƠN VỊ GIẢNG DẠY CHUYÊN BIỆT (ParentID = 9)
INSERT INTO DonVi (TenDonVi, IsParent, ParentID) VALUES 
(N'Bộ môn Giáo dục thể chất', 0, 9);
GO

USE QLKV;
GO

-- Cập nhật Website cho các Khoa thuộc TRƯỜNG KINH TẾ VÀ QUẢN LÝ CÔNG
UPDATE DonVi SET WebsiteLink = 'https://khoadautu.neu.edu.vn' WHERE TenDonVi = N'Khoa Đầu tư';
UPDATE DonVi SET WebsiteLink = 'https://kinhtehoc.neu.edu.vn' WHERE TenDonVi = N'Khoa Kinh tế học';
UPDATE DonVi SET WebsiteLink = 'https://khoahocquanly.neu.edu.vn' WHERE TenDonVi = N'Khoa Khoa học quản lý';
UPDATE DonVi SET WebsiteLink = 'https://khpt.neu.edu.vn' WHERE TenDonVi = N'Khoa Kế hoạch và Phát triển';
UPDATE DonVi SET WebsiteLink = 'https://khoaluat.neu.edu.vn' WHERE TenDonVi = N'Khoa Luật';
UPDATE DonVi SET WebsiteLink = 'https://llct.neu.edu.vn' WHERE TenDonVi = N'Khoa Lý luận chính trị';
UPDATE DonVi SET WebsiteLink = 'https://khoamoitruong.neu.edu.vn' WHERE TenDonVi = N'Khoa Môi trường, Biến đổi khí hậu và Đô thị';
UPDATE DonVi SET WebsiteLink = 'https://nnkt.neu.edu.vn' WHERE TenDonVi = N'Khoa Ngoại ngữ kinh tế';

-- Cập nhật Website cho các Khoa thuộc TRƯỜNG KINH DOANH
UPDATE DonVi SET WebsiteLink = 'https://khoabaohiem.neu.edu.vn' WHERE TenDonVi = N'Khoa Bảo hiểm';
UPDATE DonVi SET WebsiteLink = 'https://batdongsan.neu.edu.vn' WHERE TenDonVi = N'Khoa Bất động sản và Kinh tế tài nguyên';
UPDATE DonVi SET WebsiteLink = 'https://dulich.neu.edu.vn' WHERE TenDonVi = N'Khoa Du lịch và Khách sạn';
UPDATE DonVi SET WebsiteLink = 'https://khoanguonnhanluc.neu.edu.vn' WHERE TenDonVi = N'Khoa Kinh tế và Quản lý nguồn nhân lực';
UPDATE DonVi SET WebsiteLink = 'https://khoamarketing.neu.edu.vn' WHERE TenDonVi = N'Khoa Marketing';
UPDATE DonVi SET WebsiteLink = 'https://qtkd.neu.edu.vn' WHERE TenDonVi = N'Khoa Quản trị kinh doanh';
UPDATE DonVi SET WebsiteLink = 'https://bsneu.edu.vn' WHERE TenDonVi = N'Viện Quản trị kinh doanh';
UPDATE DonVi SET WebsiteLink = 'https://stie.neu.edu.vn' WHERE TenDonVi = N'Viện Thương mại và Kinh tế Quốc tế';

-- Cập nhật Website cho các Khoa thuộc TRƯỜNG CÔNG NGHỆ
UPDATE DonVi SET WebsiteLink = 'https://fit.neu.edu.vn' WHERE TenDonVi = N'Khoa Công nghệ thông tin';
UPDATE DonVi SET WebsiteLink = 'https://misa.neu.edu.vn' WHERE TenDonVi = N'Khoa Hệ thống thông tin quản lý';
UPDATE DonVi SET WebsiteLink = 'https://khoathongke.neu.edu.vn' WHERE TenDonVi = N'Khoa Thống kê';
UPDATE DonVi SET WebsiteLink = 'https://toankinhte.neu.edu.vn' WHERE TenDonVi = N'Khoa Toán kinh tế';

-- Cập nhật Website cho các Viện lớn
UPDATE DonVi SET WebsiteLink = 'https://saaud.neu.edu.vn' WHERE TenDonVi = N'Viện Kế toán – Kiểm toán';
UPDATE DonVi SET WebsiteLink = 'https://sbf.neu.edu.vn' WHERE TenDonVi = N'Viện Ngân hàng – Tài chính';

-- Cập nhật Website cho các Viện Đào tạo
UPDATE DonVi SET WebsiteLink = 'https://aep.neu.edu.vn' WHERE TenDonVi = N'Viện Đào tạo Tiên tiến, CLC & POHE';
UPDATE DonVi SET WebsiteLink = 'https://sdh.neu.edu.vn' WHERE TenDonVi = N'Viện Đào tạo sau đại học';
UPDATE DonVi SET WebsiteLink = 'https://isme.neu.edu.vn' WHERE TenDonVi = N'Viện Đào tạo quốc tế';
UPDATE DonVi SET WebsiteLink = 'https://dec.neu.edu.vn' WHERE TenDonVi = N'Trung tâm Đào tạo từ xa';
GO

-- Thêm 3 cột mới vào bảng DonVi
ALTER TABLE DonVi ADD DiaDiem NVARCHAR(500) NULL;
ALTER TABLE DonVi ADD Email VARCHAR(100) NULL;
ALTER TABLE DonVi ADD DienThoai VARCHAR(50) NULL;
GO

USE QLKV;
GO

-- =======================================================
-- 1. CẬP NHẬT THÔNG TIN THỰC TẾ CHO 3 TRƯỜNG MỚI (CẤP 1)
-- =======================================================
UPDATE DonVi
SET DiaDiem = N'Tòa nhà A1, Đại học Kinh tế Quốc dân, 207 Giải Phóng, Hà Nội',
    Email = 'kinhtequanlycong@neu.edu.vn',
    DienThoai = '024.36.280.280',
    MoTa = N'Trường Kinh tế và Quản lý công (Đại học Kinh tế Quốc dân) là đơn vị đào tạo hàng đầu về kinh tế học, quản lý công và chính sách công. Trường hướng tới mục tiêu cung cấp nguồn nhân lực chất lượng cao, các nhà quản lý, hoạch định chính sách xuất sắc cho khu vực Nhà nước và tư nhân.'
WHERE TenDonVi = N'TRƯỜNG KINH TẾ VÀ QUẢN LÝ CÔNG';

UPDATE DonVi
SET DiaDiem = N'Tòa nhà A1, Đại học Kinh tế Quốc dân, 207 Giải Phóng, Hà Nội',
    Email = 'bsneu@neu.edu.vn',
    DienThoai = '024.36.280.280',
    MoTa = N'Trường Kinh doanh (NEU Business School) tập trung đào tạo các thế hệ doanh nhân, nhà quản trị xuất sắc. Chương trình đào tạo bám sát thực tiễn doanh nghiệp, hội nhập chuẩn quốc tế, trang bị tư duy khởi nghiệp và kỹ năng lãnh đạo toàn diện cho sinh viên.'
WHERE TenDonVi = N'TRƯỜNG KINH DOANH';

UPDATE DonVi
SET DiaDiem = N'Phòng 1310-1312, Toà A1, Đại học Kinh tế Quốc dân, 207 Giải Phóng, Hà Nội',
    Email = 'truongcongnghe@neu.edu.vn',
    DienThoai = '024.36.280.280 (Ext: 6323)',
    MoTa = N'Trường Công nghệ trực thuộc ĐH Kinh tế Quốc dân tập trung đào tạo và nghiên cứu các lĩnh vực mũi nhọn như Khoa học máy tính, Trí tuệ nhân tạo, Hệ thống thông tin, và Toán kinh tế, đáp ứng nhu cầu khát nhân lực chất lượng cao trong kỷ nguyên số 4.0.'
WHERE TenDonVi = N'TRƯỜNG CÔNG NGHỆ';


-- =======================================================
-- 2. CẬP NHẬT THÔNG TIN CHO CÁC VIỆN LỚN (CẤP 1)
-- =======================================================
UPDATE DonVi
SET DiaDiem = N'Phòng 1112, Tòa nhà A1, Đại học Kinh tế Quốc dân, 207 Giải Phóng',
    Email = 'vienktkt@neu.edu.vn',
    DienThoai = '024.36.280.280 (Ext: 6126)',
    MoTa = N'Viện Kế toán - Kiểm toán là đơn vị đào tạo kế toán, kiểm toán danh tiếng nhất Việt Nam. Viện đào tạo ra những chuyên gia tài chính, kiểm toán viên xuất sắc, có đạo đức nghề nghiệp, được nhiều tổ chức quốc tế (ACCA, CPA Australia) công nhận.'
WHERE TenDonVi = N'VIỆN KẾ TOÁN - KIỂM TOÁN';

UPDATE DonVi
SET DiaDiem = N'Phòng 910, Tòa nhà A1, Đại học Kinh tế Quốc dân, 207 Giải Phóng',
    Email = 'nhtc@neu.edu.vn',
    DienThoai = '024.36.280.280',
    MoTa = N'Viện Ngân hàng - Tài chính là cái nôi đào tạo ra các lãnh đạo, chuyên gia đầu ngành trong lĩnh vực ngân hàng, tài chính, đầu tư và chứng khoán. Đơn vị luôn duy trì quan hệ hợp tác sâu rộng với mạng lưới các ngân hàng thương mại và định chế tài chính lớn.'
WHERE TenDonVi = N'VIỆN NGÂN HÀNG - TÀI CHÍNH';


-- =======================================================
-- 3. CẬP NHẬT CHO CÁC KHOA TIÊU BIỂU (CẤP 2)
-- =======================================================
UPDATE DonVi
SET DiaDiem = N'Phòng 1310-1312, Toà A1, Đại học Kinh tế Quốc dân, 207 Giải Phóng',
    Email = 'kcntt@neu.edu.vn',
    DienThoai = '024.36.280.280 (Ext: 6323)',
    MoTa = N'Khoa Công nghệ thông tin có bề dày lịch sử trong việc đào tạo các Kỹ sư CNTT, Kỹ sư phần mềm. Khoa chú trọng thực hành, phát triển năng lực tư duy thuật toán và lập trình, tự hào là nguồn cung cấp nhân lực chất lượng cho các tập đoàn công nghệ lớn.'
WHERE TenDonVi = N'Khoa Công nghệ thông tin';

UPDATE DonVi
SET DiaDiem = N'Toà A1, Đại học Kinh tế Quốc dân, 207 Giải Phóng, Hà Nội',
    Email = 'khoamarketing@neu.edu.vn',
    DienThoai = '024.36.280.280',
    MoTa = N'Khoa Marketing đào tạo các chuyên gia truyền thông, marketing số và quản trị thương hiệu hàng đầu. Môi trường học tập năng động, gắn liền với các case-study thực tế từ thị trường trong nước và quốc tế.'
WHERE TenDonVi = N'Khoa Marketing';

UPDATE DonVi
SET DiaDiem = N'Toà A1, Đại học Kinh tế Quốc dân, 207 Giải Phóng, Hà Nội',
    Email = 'khoadautu@neu.edu.vn',
    DienThoai = '024.36.280.280',
    MoTa = N'Khoa Đầu tư chuyên đào tạo và nghiên cứu về kinh tế đầu tư, phân tích dự án và quản lý đầu tư công/tư. Nơi ươm mầm các chuyên gia phân tích và quản lý quỹ chuyên nghiệp.'
WHERE TenDonVi = N'Khoa Đầu tư';


-- =======================================================
-- 4. ĐIỀN DỮ LIỆU MẶC ĐỊNH CHO CÁC ĐƠN VỊ CÒN LẠI
-- =======================================================
-- Lệnh này sẽ tự động tìm các khoa/phòng ban chưa có dữ liệu và điền thông tin chung của NEU vào, 
-- giúp giao diện web của bạn không bị dính các khoảng trống "Đang cập nhật".
UPDATE DonVi
SET DiaDiem = N'Đại học Kinh tế Quốc dân, 207 Giải Phóng, Hai Bà Trưng, Hà Nội',
    Email = 'phongtonghop@neu.edu.vn',
    DienThoai = '024.36.280.280',
    MoTa = N'Đơn vị đóng vai trò quan trọng trong hệ thống tổ chức của Đại học Kinh tế Quốc dân, góp phần vào mục tiêu xây dựng trường đại học đa ngành, định hướng nghiên cứu và đào tạo chất lượng cao mang tầm cỡ khu vực và quốc tế.'
WHERE DiaDiem IS NULL OR DiaDiem = '';
GO