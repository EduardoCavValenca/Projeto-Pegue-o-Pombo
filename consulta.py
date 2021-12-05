import cx_Oracle
from printfunctions import *

def RealizaConsulta(cursor):

    tipo_consulta = input("\n\nDigite: \n1 para uma consulta geral \n2 para consulta especifica \noutro numero para retornar ao menu\nEntrada:")

    if tipo_consulta == '1' or tipo_consulta == '2':

        if tipo_consulta =='1':
            ConsultaGeral(cursor)

        if tipo_consulta=='2':
            ConsultaEspecifica(cursor)



def ConsultaGeral(cursor):

    Possibilidades=["Pesquisador","Informante","Zelador",
            "Matador_pombos","Central_Pombos","Coco_Pombo"] 
        

    print("\n\nDigite o digito da tabela correspondente desejada, caso queria desistir digite qualquer numero nao presente")

    for i in range(len(Possibilidades)):
        print((i+1),"- ",Possibilidades[i])

    escolha = input("\nDigite o numero de entrada: ")

    try:
        escolha = int(escolha)
    except:
        return

    if escolha >= 1 and escolha <= len(Possibilidades):
        
        string_busca=""

        if escolha == 1 : string_busca= busca_Pesquisador()
        if escolha == 2 : string_busca= busca_Informante()
        if escolha == 3 : string_busca= busca_Zelador()
        if escolha == 4 : string_busca= busca_Matador()
        if escolha == 5 : string_busca= busca_Central()
        if escolha == 6 : string_busca= busca_Cocos()

        try:
            cursor.execute(string_busca)
        except cx_Oracle.DatabaseError as error:
            print("Erro ao consultar tabela: ", error)
            return

        if escolha == 1 : string_busca= print_pesquisador(cursor)
        if escolha == 2 : string_busca= print_informante(cursor)
        if escolha == 3 : string_busca= print_zelador(cursor)
        if escolha == 4 : string_busca= print_matador(cursor)
        if escolha == 5 : string_busca= print_central(cursor)
        if escolha == 6 : string_busca= print_coco(cursor)
        
    

def ConsultaEspecifica(cursor):

    Possibilidades=["Regioes com Densidade acima de X",
                    "Historico de Zelador X",
                    "Historico de Pesquisador X",
                    "Historico completo de Pesquisador X",
                    "Historico de Matador de Pombo X",] 

    print("\n\nDigite o digito da consulta correspondente desejada, caso queria desistir digite qualquer numero nao presente")

    for i in range(len(Possibilidades)):
        print((i+1),"- ",Possibilidades[i])

    escolha = input("\nDigite o numero de entrada: ")

    try:
        escolha = int(escolha)
    except:
        return

    if escolha >= 1 and escolha <= len(Possibilidades):

        if escolha == 1:
            escolha = input("\nDigite a densidade de pombos minima (Recomendado ser < 10): ")
            try:
                escolha = float(escolha)
            except:
                return

            string_busca = "SELECT * FROM TABLE(Densidade_Regiao("+str(escolha)+"))"

            try:
                cursor.execute(string_busca)

            except cx_Oracle.DatabaseError as error:

                print("Erro ao consultar tabela: ", error)
                return

            print("\n")
            for result in cursor:
                print("Regiao:",result[0],", Densidade de Pombos:",result[1])

        else:

            CPF = input("\nDigite o CPF do trabalhador (apenas os 11 numeros): ")

            string_busca = "SELECT * FROM TABLE"

            if escolha == 2 : string_busca += "(Historico_Zelador("+str(CPF)+"))"
            if escolha == 3 : string_busca += "(Historico_Pesquisador("+str(CPF)+"))"
            if escolha == 4 : string_busca += "(Historico_Pesquisador_Full("+str(CPF)+"))"
            if escolha == 5 : string_busca += "(Historico_Matador("+str(CPF)+"))"
            
            try:
                cursor.execute(string_busca)

            except cx_Oracle.DatabaseError as error:

                print("Erro ao consultar Funcao: ", error)
                return

            CPF_encontrado = False

            if escolha == 2 : CPF_encontrado = print_historico_zelador(cursor)
            if escolha == 3 : CPF_encontrado = print_historico_pesquisador(cursor)
            if escolha == 4 : CPF_encontrado = print_historico_pesquisador_full(cursor)
            if escolha == 5 : CPF_encontrado = print_historico_matador(cursor)


            if not CPF_encontrado:
                print("\nCPF nao foi encontrado no banco de dados")


def busca_Pesquisador():
    busca = """SELECT CPF,NOME,TO_CHAR(DATANASC, 'DD/MM/YYYY'),
    CEP,RUA,NUMERO,FORMACAO FROM PESQUISADOR"""
    
    return busca

def busca_Zelador():
    busca = """SELECT CPF,NOME,TO_CHAR(DATANASC, 'DD/MM/YYYY'),
    CEP,RUA,NUMERO,CARTEIRATRAB FROM ZELADOR"""
    
    return busca

def busca_Informante():
    busca = """SELECT CPF,NOME,TO_CHAR(DATANASC, 'DD/MM/YYYY'),
    CEP,RUA,NUMERO FROM INFORMANTE"""
    
    return busca

def busca_Matador():
    busca = """SELECT CPF,CENTRAL,NOME,TO_CHAR(DATANASC, 'DD/MM/YYYY'),
    CEP,RUA,NUMERO,NROLICENCA,MODELOARMA FROM MATADOR_POMBOS"""
    
    return busca

def busca_Central():
    busca = """SELECT * FROM CENTRAL_POMBOS"""

    return busca

def busca_Cocos():
    busca = """SELECT ID,LATITUDE,LONGITUDE, TO_CHAR(DATAHORA, 'DD/MM/YYYY HH24:MI:SS'),
    TO_CHAR(DATAHORARETIRADO, 'DD/MM/YYYY HH24:MI:SS'),CEP,BAIRRO,RUA,NUMERO FROM COCO_POMBO"""

    return busca