import cx_Oracle
from dotenv import load_dotenv
import os


def connect():

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

        return connection,cursor

    except:
        print("Erro ao carregar conexao com base de dados")

    return 1


   


def disconnect(connection,cursor):
    cursor.close()
    connection.close()



connect()