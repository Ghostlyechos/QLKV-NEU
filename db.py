import pyodbc


CONN_STR = (
    r'DRIVER={ODBC Driver 17 for SQL Server};'
    r'SERVER=DESKTOP-QDT69GJ\SQLEXPRESS;' #Đổi tên server máy của m 
    r'DATABASE=QLKV;'
    r'Trusted_Connection=yes;'
)

def get_db_connection():
    conn = pyodbc.connect(CONN_STR)
    conn.setdecoding(pyodbc.SQL_CHAR, encoding='utf-8')
    conn.setdecoding(pyodbc.SQL_WCHAR, encoding='utf-16le')
    conn.setdecoding(pyodbc.SQL_WMETADATA, encoding='utf-16le')
    conn.setencoding(encoding='utf-16le')
    return conn