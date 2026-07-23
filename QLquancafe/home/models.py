from django.db import models

# Create your models here.

# 1. Vai trò (Role): 1. Nhân viên, 2. Admin, 3. Quản lý, 4. Khách hàng
class Role(models.Model):
    role_name = models.CharField(max_length=50, unique=True)
    description = models.TextField(blank=True, null=True)

    def __str__(self):
        return self.role_name

# 2. Người dùng (User / Tài khoản)
class User(models.Model):
    username = models.CharField(max_length=150, unique=True)
    email = models.EmailField(unique=True)
    password = models.CharField(max_length=255)
    full_name = models.CharField(max_length=150)
    phone = models.CharField(max_length=20, blank=True, null=True)
    role = models.ForeignKey(Role, on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.full_name} ({self.username})"

# 3. Nhà cung cấp
class Supplier(models.Model):
    supplier_name = models.CharField(max_length=200)
    contact_person = models.CharField(max_length=100, blank=True, null=True)
    phone = models.CharField(max_length=20, blank=True, null=True)
    address = models.TextField(blank=True, null=True)

    def __str__(self):
        return self.supplier_name

# 4. Kho nguyên liệu
class Ingredient(models.Model):
    ingredient_name = models.CharField(max_length=150)
    unit = models.CharField(max_length=50) # kg, thùng, lít...
    stock_quantity = models.FloatField(default=0.0)
    min_threshold = models.FloatField(default=0.0)

    def __str__(self):
        return self.ingredient_name

# 5. Danh mục món
class Category(models.Model):
    category_name = models.CharField(max_length=100)
    description = models.TextField(blank=True, null=True)

    def __str__(self):
        return self.category_name

# 6. Menu / Món ăn
class MenuItem(models.Model):
    category = models.ForeignKey(Category, on_delete=models.CASCADE)
    item_name = models.CharField(max_length=150)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    description = models.TextField(blank=True, null=True)
    is_available = models.BooleanField(default=True)

    def __str__(self):
        return self.item_name

# 7. Quản lý bàn
class Table(models.Model):
    table_number = models.CharField(max_length=50, unique=True)
    capacity = models.IntegerField(default=4)
    status = models.CharField(max_length=50, default='Trống') # Trống, Đang phục vụ, Đã đặt

    def __str__(self):
        return self.table_number

# 8. Khuyến mãi / Giảm giá
class Promotion(models.Model):
    code_name = models.CharField(max_length=50, unique=True)
    discount_percent = models.DecimalField(max_digits=5, decimal_places=2)
    start_date = models.DateField()
    end_date = models.DateField()
    is_active = models.BooleanField(default=True)

    def __str__(self):
        return self.code_name

# 9. Đơn hàng
class Order(models.Model):
    customer = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, related_name='customer_orders')
    staff = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, related_name='staff_orders')
    table = models.ForeignKey(Table, on_delete=models.SET_NULL, null=True)
    order_status = models.CharField(max_length=50, default='Đang xử lý')
    total_amount = models.DecimalField(max_digits=12, decimal_places=2, default=0.00)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Đơn hàng #{self.id}"

# 10. Chi tiết đơn hàng
class OrderItem(models.Model):
    order = models.ForeignKey(Order, on_delete=models.CASCADE, related_name='items')
    menu_item = models.ForeignKey(MenuItem, on_delete=models.CASCADE)
    quantity = models.IntegerField(default=1)
    subtotal = models.DecimalField(max_digits=10, decimal_places=2)

# 11. Hóa đơn
class Invoice(models.Model):
    order = models.ForeignKey(Order, on_delete=models.CASCADE)
    payment_method = models.CharField(max_length=50) # Tiền mặt, Chuyển khoản...
    payment_status = models.CharField(max_length=50, default='Chưa thanh toán')
    final_amount = models.DecimalField(max_digits=12, decimal_places=2)
    created_at = models.DateTimeField(auto_now_add=True)

# 12. Nhật ký hoạt động (Activity Log)
class ActivityLog(models.Model):
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    action_description = models.TextField()
    ip_address = models.CharField(max_length=50, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)