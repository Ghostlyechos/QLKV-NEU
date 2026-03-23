from flask import Blueprint, render_template, request, redirect, url_for, session
from db import get_db_connection

admin_bp = Blueprint('admin', __name__)


@admin_bp.route('/admin')
def index():
    if not session.get('logged_in'): return redirect(url_for('auth.login'))

    keyword = request.args.get('keyword', '')
    parent_id = request.args.get('parent_id', '')

    conn = get_db_connection()
    cursor = conn.cursor()
    parent_name = None

    if keyword:
        query = """
                SELECT IDDonVi, TenDonVi, IsParent, WebsiteLink
                FROM DonVi
                WHERE TenDonVi LIKE ? \
                   OR MoTa LIKE ?
                ORDER BY IsParent DESC, IDDonVi ASC
                """
        search_term = f"%{keyword}%"
        cursor.execute(query, search_term, search_term)
    elif parent_id:
        cursor.execute("SELECT TenDonVi FROM DonVi WHERE IDDonVi = ?", parent_id)
        parent_info = cursor.fetchone()
        if parent_info: parent_name = parent_info.TenDonVi

        query = "SELECT IDDonVi, TenDonVi, IsParent, WebsiteLink FROM DonVi WHERE ParentID = ? ORDER BY IDDonVi ASC"
        cursor.execute(query, parent_id)
    else:
        query = "SELECT IDDonVi, TenDonVi, IsParent, WebsiteLink FROM DonVi WHERE IsParent = 1 ORDER BY IDDonVi ASC"
        cursor.execute(query)

    units = cursor.fetchall()
    conn.close()
    return render_template('admin.html', units=units, keyword=keyword, parent_id=parent_id, parent_name=parent_name)


@admin_bp.route('/admin/add', methods=['GET', 'POST'])
def add():
    if not session.get('logged_in'): return redirect(url_for('auth.login'))

    conn = get_db_connection()
    cursor = conn.cursor()

    if request.method == 'POST':
        ten_don_vi = request.form['TenDonVi']
        is_parent = request.form['IsParent']
        parent_id = None if is_parent == '1' else request.form['ParentID']

        loai_website = request.form.get('LoaiWebsite', 'external')
        website = None if loai_website == 'internal' else request.form.get('WebsiteLink')

        dia_diem = request.form.get('DiaDiem', '')
        email = request.form.get('Email', '')
        dien_thoai = request.form.get('DienThoai', '')
        mo_ta = request.form.get('MoTa', '')

        cursor.execute("""
                       INSERT INTO DonVi (TenDonVi, IsParent, ParentID, WebsiteLink, DiaDiem, Email, DienThoai, MoTa)
                       VALUES (?, ?, ?, ?, ?, ?, ?, ?)
                       """, (ten_don_vi, is_parent, parent_id, website, dia_diem, email, dien_thoai, mo_ta))
        conn.commit()
        conn.close()
        return redirect(url_for('admin.index'))

    cursor.execute("SELECT IDDonVi, TenDonVi FROM DonVi WHERE IsParent = 1")
    parents = cursor.fetchall()
    conn.close()
    return render_template('admin_form.html', parents=parents)


@admin_bp.route('/admin/edit/<int:id>', methods=['GET', 'POST'])
def edit(id):
    if not session.get('logged_in'): return redirect(url_for('auth.login'))

    conn = get_db_connection()
    cursor = conn.cursor()

    if request.method == 'POST':
        ten_don_vi = request.form['TenDonVi']
        is_parent = request.form['IsParent']
        parent_id = None if is_parent == '1' else request.form['ParentID']
        website = request.form.get('WebsiteLink')

        dia_diem = request.form.get('DiaDiem', '')
        email = request.form.get('Email', '')
        dien_thoai = request.form.get('DienThoai', '')
        mo_ta = request.form.get('MoTa', '')

        cursor.execute("""
                       UPDATE DonVi
                       SET TenDonVi    = ?,
                           IsParent    = ?,
                           ParentID    = ?,
                           WebsiteLink = ?,
                           DiaDiem     = ?,
                           Email       = ?,
                           DienThoai   = ?,
                           MoTa        = ?
                       WHERE IDDonVi = ?
                       """, (ten_don_vi, is_parent, parent_id, website, dia_diem, email, dien_thoai, mo_ta, id))
        conn.commit()
        conn.close()
        return redirect(url_for('admin.index'))

    cursor.execute("SELECT * FROM DonVi WHERE IDDonVi = ?", id)
    unit = cursor.fetchone()
    cursor.execute("SELECT IDDonVi, TenDonVi FROM DonVi WHERE IsParent = 1")
    parents = cursor.fetchall()
    conn.close()
    return render_template('admin_edit.html', unit=unit, parents=parents)


@admin_bp.route('/admin/delete/<int:id>')
def delete(id):
    if not session.get('logged_in'): return redirect(url_for('auth.login'))
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute("DELETE FROM DonVi WHERE IDDonVi = ?", id)
        conn.commit()
    except Exception as e:
        print("Lỗi xóa:", e)
    conn.close()
    return redirect(url_for('admin.index'))