import connections
import consulta
import insercao
# import cx_Oracle

def main():
    connection,cursor = connections.connect()


    while(1):
        escolha = input("Digite 1 para uma insercao, 2 para consulta e 3 para finalizar programa: ")
        if escolha=='1':
            insercao.RealizaInsercao(cursor)
            
        elif escolha=='2':
            consulta.RealizaConsulta(cursor)

        elif escolha=='3':
            connections.disconnect(connection,cursor)
            exit(0)

    

    return 0





main()
