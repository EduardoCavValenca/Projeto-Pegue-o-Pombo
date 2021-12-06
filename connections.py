import cx_Oracle
from dotenv import load_dotenv
import os


def connect():

    try:
        #Carrega dados para conexao
        #feito em arquivo separado por seguranca
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
        exit(0)


def disconnect(connection,cursor):
    try:
        #Fecha conexoes
        cursor.close()
        connection.close()
    
    except:

        print("Erro ao desconectar da  base de dados")
