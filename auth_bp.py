from flask import Blueprint, render_template, request, redirect, url_for, session

auth_bp = Blueprint('auth', __name__)


@auth_bp.route('/login', methods=['GET', 'POST'])
def login():
    error = None
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        if username == 'admin' and password == '1':
            session['logged_in'] = True
            # Chuyển hướng tới trang admin (tên hàm index trong blueprint admin)
            return redirect(url_for('admin.index'))
        else:
            error = 'Sai tài khoản hoặc mật khẩu!'

    return render_template('login.html', error=error)


@auth_bp.route('/logout')
def logout():
    session.pop('logged_in', None)
    # Chuyển hướng tới trang chủ (tên hàm index trong blueprint main)
    return redirect(url_for('main.index'))