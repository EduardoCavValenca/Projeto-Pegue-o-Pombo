import connections
import consulta
# import cx_Oracle

def main():
    connection,cursor = connections.connect()
    escolha = input("Digite 1 para uma insercao, 2 para consulta e 3 para finalizar programa: ")
    if escolha=='1':
        consulta.RealizaConsulta(cursor)
    

    return 0





main()
