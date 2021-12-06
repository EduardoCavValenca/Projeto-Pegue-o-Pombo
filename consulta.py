import cx_Oracle
from printfunctions import *

def RealizaConsulta(cursor):

    #Verifica se qual é a consulta desejada
    tipo_consulta = input("\n\nDigite: \n1 para uma consulta geral \n2 para consulta especifica \noutro numero para retornar ao menu\nEntrada:")

    #Consultas Validas
    if tipo_consulta == '1' or tipo_consulta == '2':

        if tipo_consulta =='1':
            ConsultaGeral(cursor)

        if tipo_consulta=='2':
            ConsultaEspecifica(cursor)



def ConsultaGeral(cursor):

    #Tabelas disponiveis para consulta
    Possibilidades=["Pesquisador","Informante","Zelador",
            "Matador_pombos","Central_Pombos","Coco_Pombo"] 
        

    print("\n\nDigite o digito da tabela correspondente desejada, caso queria desistir digite qualquer numero nao presente")

    #Printa possibilidades no terminal
    for i in range(len(Possibilidades)):
        print((i+1),"- ",Possibilidades[i])

    escolha = input("\nDigite o numero de entrada: ") #Entrada do usuario

    try:
        escolha = int(escolha) #Digitou um numero
    except:
        print("\n A escolha deve ser um numero")
        return

    #Numero dentro das possibilidades
    if escolha >= 1 and escolha <= len(Possibilidades):
        
        string_busca=""

        #Gerar a string (comando sql) baseado na entrada
        if escolha == 1 : string_busca= busca_Pesquisador()
        if escolha == 2 : string_busca= busca_Informante()
        if escolha == 3 : string_busca= busca_Zelador()
        if escolha == 4 : string_busca= busca_Matador()
        if escolha == 5 : string_busca= busca_Central()
        if escolha == 6 : string_busca= busca_Cocos()

        try:
            cursor.execute(string_busca) #Retorna tuplas
        except cx_Oracle.DatabaseError as error:
            print("Erro ao consultar tabela: ", error)
            return

        #Faz o print no terminal das tuplas de forma mais elegante
        if escolha == 1 : string_busca= print_pesquisador(cursor)
        if escolha == 2 : string_busca= print_informante(cursor)
        if escolha == 3 : string_busca= print_zelador(cursor)
        if escolha == 4 : string_busca= print_matador(cursor)
        if escolha == 5 : string_busca= print_central(cursor)
        if escolha == 6 : string_busca= print_coco(cursor)
        
    

def ConsultaEspecifica(cursor):

    #Opcoes de possibilidades
    Possibilidades=["Regioes com Densidade acima de X",
                    "Historico de Zelador X",
                    "Historico de Pesquisador X",
                    "Historico completo de Pesquisador X",
                    "Historico de Matador de Pombo X",] 

    print("\n\nDigite o digito da consulta correspondente desejada, caso queria desistir digite qualquer numero nao presente")

    #Printa possibilidades no temrinal
    for i in range(len(Possibilidades)):
        print((i+1),"- ",Possibilidades[i])

    escolha = input("\nDigite o numero de entrada: ")

    try:
        escolha = int(escolha) #Caso tenha digitado um numero
    except:
        return

    #Caso tenha sido um numero dentro das possibilidades
    if escolha >= 1 and escolha <= len(Possibilidades):

        if escolha == 1:
            Densidade_minima = input("\nDigite a densidade de pombos minima (Recomendado ser < 10): ")

            try:
                Densidade_minima = float(Densidade_minima) #Numero pode ser quebrado
            except:
                print("\n A escolha deve ser um numero")
                return

            string_busca = "SELECT * FROM TABLE(Densidade_Regiao("+str(Densidade_minima)+"))"

            try:
                cursor.execute(string_busca)
            except cx_Oracle.DatabaseError as error:
                print("Erro ao consultar Funcao: ", error)
                return


            print("\n")
            for result in cursor: #Printa resultado no terminal
                print("Regiao:",result[0],", Densidade de Pombos:",result[1])

        #Caso tenha escolhido historico de algum profissional
        else:

            CPF = input("\nDigite o CPF do trabalhador (apenas os 11 numeros): ")

            string_busca = "SELECT * FROM TABLE"
            #Altera string baseado na entrada
            if escolha == 2 : string_busca += "(Historico_Zelador("+str(CPF)+"))"
            if escolha == 3 : string_busca += "(Historico_Pesquisador("+str(CPF)+"))"
            if escolha == 4 : string_busca += "(Historico_Pesquisador_Full("+str(CPF)+"))"
            if escolha == 5 : string_busca += "(Historico_Matador("+str(CPF)+"))"
            
            try:
                #Busca dados no banco
                cursor.execute(string_busca)

            except cx_Oracle.DatabaseError as error:

                print("Erro ao consultar Funcao: ", error)
                return

            CPF_encontrado = False #Declara variavel

            #Printa de forma elegante o retorno do banco
            if escolha == 2 : CPF_encontrado = print_historico_zelador(cursor)
            if escolha == 3 : CPF_encontrado = print_historico_pesquisador(cursor)
            if escolha == 4 : CPF_encontrado = print_historico_pesquisador_full(cursor)
            if escolha == 5 : CPF_encontrado = print_historico_matador(cursor)

            #Caso n tenha dado encontrado
            if not CPF_encontrado:
                print("\nCPF nao foi encontrado no banco de dados")


#String para dados da tabela Pesquisador
def busca_Pesquisador():
    busca = """SELECT CPF,NOME,TO_CHAR(DATANASC, 'DD/MM/YYYY'),
    CEP,RUA,NUMERO,FORMACAO FROM PESQUISADOR"""
    
    return busca

#String para dados da tabela Zelador
def busca_Zelador():
    busca = """SELECT CPF,NOME,TO_CHAR(DATANASC, 'DD/MM/YYYY'),
    CEP,RUA,NUMERO,CARTEIRATRAB FROM ZELADOR"""
    
    return busca

#String para dados da tabela Informante
def busca_Informante():
    busca = """SELECT CPF,NOME,TO_CHAR(DATANASC, 'DD/MM/YYYY'),
    CEP,RUA,NUMERO FROM INFORMANTE"""
    
    return busca

#String para dados da tabela Matador_Pombos
def busca_Matador():
    busca = """SELECT CPF,CENTRAL,NOME,TO_CHAR(DATANASC, 'DD/MM/YYYY'),
    CEP,RUA,NUMERO,NROLICENCA,MODELOARMA FROM MATADOR_POMBOS"""
    
    return busca

#String para dados da tabela de Centrais
def busca_Central():
    busca = """SELECT * FROM CENTRAL_POMBOS"""

    return busca

#String para dados da tabela de Cocos
def busca_Cocos():
    busca = """SELECT ID,LATITUDE,LONGITUDE, TO_CHAR(DATAHORA, 'DD/MM/YYYY HH24:MI:SS'),
    TO_CHAR(DATAHORARETIRADO, 'DD/MM/YYYY HH24:MI:SS'),CEP,BAIRRO,RUA,NUMERO FROM COCO_POMBO"""

    return busca