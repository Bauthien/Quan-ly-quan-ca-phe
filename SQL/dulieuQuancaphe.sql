-- 1. Dữ liệu Vai trò (Roles) ứng với 4 quyền: Admin, Quản lý, Nhân viên, Khách hàng
INSERT INTO home_role (id, role_name, description) VALUES
(1, 'Admin', 'Quyền cao nhất quản lý toàn hệ thống'),
(2, 'QuanLy', 'Quyền quản lý vận hành, menu, kho, nhân sự'),
(3, 'NhanVien', 'Quyền nhân viên bán hàng, tạo đơn, thanh toán'),
(4, 'KhachHang', 'Quyền khách hàng đặt món, đặt bàn online');

-- 2. Dữ liệu Người dùng (Users / Tài khoản) tương ứng với các role
INSERT INTO home_user (username, email, password, full_name, phone, role_id, created_at) VALUES
('admin', 'admin@cafe.com', 'pbkdf2_sha256$600000$dummyhash...', 'Thiên Tân Admin', '0901111111', 1, NOW()),
('manager', 'ql@cafe.com', 'pbkdf2_sha256$600000$dummyhash...', 'Nguyễn Thị Lan', '0902222222', 2, NOW()),
('staff', 'nv@cafe.com', 'pbkdf2_sha256$600000$dummyhash...', 'Trần Văn Tuấn', '0903333333', 3, NOW()),
('customer', 'kh@gmail.com', 'pbkdf2_sha256$600000$dummyhash...', 'Lê Văn Hùng', '0904444444', 4, NOW());

-- 3. Dữ liệu Nhà cung cấp (Suppliers)
INSERT INTO home_supplier (supplier_name, contact_person, phone, address) VALUES
('Công ty Cà phê Trung Nguyên', 'Anh Bình', '02838111222', 'Bình Dương, Việt Nam'),
('Sữa tươi Vinamilk', 'Chị Mai', '02838333444', 'Quận 7, TP.HCM'),
('Đường Biên Hòa', 'Anh Nam', '02838555666', 'Đồng Nai, Việt Nam');

-- 4. Dữ liệu Kho nguyên liệu (Ingredients / Inventory)
INSERT INTO home_ingredient (ingredient_name, unit, stock_quantity, min_threshold) VALUES
('Hạt cà phê Robusta', 'kg', 50.5, 5.0),
('Sữa đặc có đường', 'thùng', 10.0, 2.0),
('Sữa tươi tiệt trùng', 'thùng', 15.0, 3.0),
('Đường cát trắng', 'kg', 30.0, 5.0),
('Trân châu đen', 'kg', 12.5, 3.0);

-- 5. Dữ liệu Danh mục món (Categories)
INSERT INTO home_category (category_name, description) VALUES
('Cà phê', 'Các loại cà phê truyền thống và máy'),
('Trà sữa', 'Các loại trà sữa topping trân châu'),
('Đồ uống đá xay', 'Thức uống giải khát đá xay mát lạnh'),
('Bánh ngọt', 'Bánh ăn kèm uống trà cà phê');

-- 6. Dữ liệu Menu / Món ăn (MenuItems)
INSERT INTO home_menuitem (category_id, item_name, price, description, is_available) VALUES
(1, 'Cà phê sữa đá', 25000.00, 'Cà phê rang xay nguyên chất kết hợp sữa đặc ngọt ngào', true),
(1, 'Cà phê đen đá', 20000.00, 'Cà phê nguyên chất đậm đà truyền thống', true),
(2, 'Trà sữa trân châu đường đen', 35000.00, 'Trà sữa thơm béo kèm trân châu dẻo dai', true),
(3, 'Matcha đá xay', 45000.00, 'Bột trà xanh Nhật Bản xay nhuyễn với đá và sữa tươi', true),
(4, 'Bánh Tiramisu', 30000.00, 'Bánh ngọt vị cà phê thơm ngậy', true);

-- 7. Dữ liệu Bàn (Tables)
INSERT INTO home_table (table_number, capacity, status) VALUES
('Bàn 01', 4, 'Trống'),
('Bàn 02', 2, 'Trống'),
('Bàn 03', 4, 'Đang phục vụ'),
('Bàn 04', 6, 'Đã đặt'),
('Bàn VIP 01', 10, 'Trống');

-- 8. Dữ liệu Khuyến mãi / Giảm giá (Discounts / Promotions)
INSERT INTO home_promotion (code_name, discount_percent, start_date, end_date, is_active) VALUES
('SUMMER2026', 15.00, '2026-06-01', '2026-08-31', true),
('WELCOME', 10.00, '2026-01-01', '2026-12-31', true);

-- 9. Dữ liệu Đơn hàng (Orders)
INSERT INTO home_order (customer_id, staff_id, table_id, order_status, total_amount, created_at) VALUES
(4, 3, 3, 'Đang xử lý', 60000.00, CURRENT_TIMESTAMP);

-- 10. Dữ liệu Chi tiết đơn hàng (OrderItems)
INSERT INTO home_orderitem (order_id, menu_item_id, quantity, subtotal) VALUES
(1, 1, 1, 25000.00), -- 1 Cà phê sữa đá
(1, 3, 1, 35000.00); -- 1 Trà sữa trân châu đường đen

-- 11. Dữ liệu Hóa đơn (Invoices)
INSERT INTO home_invoice (order_id, payment_method, payment_status, final_amount, created_at) VALUES
(1, 'Tiền mặt', 'Đã thanh toán', 60000.00, CURRENT_TIMESTAMP);

-- 12. Dữ liệu Nhật ký hoạt động (Activity Logs)
INSERT INTO home_activitylog (user_id, action_description, ip_address, created_at) VALUES
(2, 'Admin đăng nhập hệ thống và cấu hình lại thông số', '127.0.0.1', CURRENT_TIMESTAMP),
(4, 'Nhân viên tạo đơn hàng mới cho bàn số 03', '127.0.0.1', CURRENT_TIMESTAMP);

SELECT id, username FROM home_user;