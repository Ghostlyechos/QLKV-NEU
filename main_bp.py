from flask import Blueprint, render_template, request
from db import get_db_connection

main_bp = Blueprint('main', __name__)

@main_bp.route('/')
def index():
    conn = get_db_connection()
    cursor = conn.cursor()

    # ĐÃ SỬA DÒNG NÀY: Bổ sung WebsiteLink vào câu truy vấn
    cursor.execute("SELECT IDDonVi, TenDonVi, WebsiteLink FROM DonVi WHERE IsParent = 1")
    don_vi_cap_1 = cursor.fetchall()

    keyword = request.args.get('keyword', '')
    parent_id = request.args.get('parent_id', '')

    don_vi_cap_2 = []
    current_parent_id = None 

    if keyword:
        query = """
                SELECT IDDonVi, TenDonVi, WebsiteLink
                FROM DonVi
                WHERE IsParent = 0 AND (TenDonVi LIKE ? OR MoTa LIKE ?)
                """
        search_term = f"%{keyword}%"
        cursor.execute(query, search_term, search_term)
        don_vi_cap_2 = cursor.fetchall()
    elif parent_id:
        current_parent_id = int(parent_id)
        cursor.execute("SELECT IDDonVi, TenDonVi, WebsiteLink FROM DonVi WHERE ParentID = ?", current_parent_id)
        don_vi_cap_2 = cursor.fetchall()
    else:
        if don_vi_cap_1:
            current_parent_id = don_vi_cap_1[0].IDDonVi
            cursor.execute("SELECT IDDonVi, TenDonVi, WebsiteLink FROM DonVi WHERE ParentID = ?", current_parent_id)
            don_vi_cap_2 = cursor.fetchall()

    conn.close()

    return render_template('index.html',
                           cap1_list=don_vi_cap_1,
                           cap2_list=don_vi_cap_2,
                           keyword=keyword,
                           current_parent_id=current_parent_id)