import connections
import consulta
import insercao
# import cx_Oracle

def main():
    connection,cursor = connections.connect()


    while(1):
        escolha = input("\n\nDigite:\n1 para Logar/Cadastrar\n2 para consulta\n3 para finalizar programa\nEntrada: ")
        if escolha=='1':
            insercao.RealizaInsercao(connection,cursor)
            
        elif escolha=='2':
            consulta.RealizaConsulta(cursor)

        elif escolha=='3':
            connections.disconnect(connection,cursor)
            print("Banco Desconectado")
            exit(0)

    

    return 0





main()
