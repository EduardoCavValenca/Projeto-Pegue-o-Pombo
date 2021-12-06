import connections
import consulta
import insercao

def main():
    connection,cursor = connections.connect() #Retorna dados da conexao

    #Opcoes do menu
    while(1):
        escolha = input("\n\nDigite:\n1 para Logar/Cadastrar\n2 para consulta\n3 para finalizar programa\nEntrada: ")
        if escolha=='1':
            insercao.RealizaInsercao(connection,cursor)
            
        elif escolha=='2':
            consulta.RealizaConsulta(cursor)

        elif escolha=='3':
            connections.disconnect(connection,cursor)
            print("\nBanco Desconectado")
            exit(0)

    

    return 0


main() #Roda o programa
