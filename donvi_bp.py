from flask import Blueprint, render_template
from db import get_db_connection

donvi_bp = Blueprint('donvi', __name__)


@donvi_bp.route('/don-vi/<int:id>')
def detail(id):
    conn = get_db_connection()
    cursor = conn.cursor()

    # ĐÃ SỬA: Lấy toàn bộ thông tin (*) bao gồm cả Địa điểm, Email, SĐT, Mô tả
    cursor.execute("SELECT * FROM DonVi WHERE IDDonVi = ?", id)
    unit = cursor.fetchone()

    # Lấy danh sách các đơn vị trực thuộc (nếu đây là Trường/Viện cấp 1)
    cursor.execute("SELECT * FROM DonVi WHERE ParentID = ?", id)
    children = cursor.fetchall()

    conn.close()

    if not unit:
        return "Không tìm thấy thông tin đơn vị này!", 404

    return render_template('donvi_detail.html', unit=unit, children=children)