from flask import Flask

# Nhập (Import) tất cả các Blueprint vừa tạo
from main_bp import main_bp
from auth_bp import auth_bp
from admin_bp import admin_bp
from donvi_bp import donvi_bp

app = Flask(__name__)
app.secret_key = 'chìa_khóa_bảo_mật_admin_neu_123'

# Đăng ký các Blueprint vào hệ thống
app.register_blueprint(main_bp)
app.register_blueprint(auth_bp)
app.register_blueprint(admin_bp)
app.register_blueprint(donvi_bp)

if __name__ == '__main__':
    app.run(debug=True)