import cx_Oracle
from dotenv import load_dotenv
import os

try:
    load_dotenv()
    HOSTNAME = os.getenv("HOSTNAME")
    PORT = os.getenv("PORT")
    SID = os.getenv("SID")
    USER = os.getenv("USER")
    PASSWORD = os.getenv("PASSWORD")

except:
    print("Erro ao carregar dados para conexao")

try:
    dsn = cx_Oracle.makedsn(str(HOSTNAME), PORT,str(SID))
    connection = cx_Oracle.connect(user=str(USER), password=str(PASSWORD), dsn=dsn)
    cursor = connection.cursor()

except cx_Oracle.DatabaseError as e:
     print("Erro ao carregar conexao com base de dados", e)


cursor.execute("SELECT * FROM TABLE(Densidade_Regiao(0))")
for result in cursor:
    print(result[0])

