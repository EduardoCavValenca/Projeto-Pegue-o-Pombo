import cx_Oracle

def RealizaConsulta(cursor):

    tipo_consulta = input("Digite 1 para uma consulta geral, 2 para consulta especifica ou outro numero para retornar ao menu: ")

    if tipo_consulta == '1' or tipo_consulta == '2':

        if tipo_consulta =='1':
            ConsultaGeral(cursor)

        if tipo_consulta=='2':
            ConsultaEspecifica(cursor)



def ConsultaGeral(cursor):

    Possibilidades=["Pesquisador","Informante","Zelador",
            "Matador_pombos","Central_Pombos","Coco_Pombo",
            "Amostra","Regiao","Bairro","Celular","Informa_Coco",
            "Laboratorio","Notificacao_Matador","Notificacao_Pesquisador",
            "Notificacao_Zelador","Relatorio", "Sensor_Densidade_Pombo",
            "Dados_Densidade","Tipo_Pessoa"] 
        

    print("Digite o digito da tabela correspondente desejada, caso queria desistir digite qualquer numero nao presente")

    for i in range(len(Possibilidades)):
        print((i+1),"- ",Possibilidades[i])

    escolha = input("Digite o numero de entrada: ")

    try:
        escolha = int(escolha)
    except:
        return

    if escolha >= 1 and escolha <= len(Possibilidades):
        
        string_busca = "SELECT * FROM " + Possibilidades[escolha-1]

        try:
            cursor.execute(string_busca)
        except cx_Oracle.DatabaseError as error:
            print("Erro ao consultar tabela: ", error)
            return


        for result in cursor:
            print(result)
    

def ConsultaEspecifica(cursor):

    Possibilidades=["Regioes com Densidade acima de X",
                    "Historico de Zelador X",
                    "Historico de Pesquisador X",
                    "Historico completo de Pesquisador X",
                    "Historico de Matador de Pombo X",] 

    print("Digite o digito da consulta correspondente desejada, caso queria desistir digite qualquer numero nao presente")

    for i in range(len(Possibilidades)):
        print((i+1),"- ",Possibilidades[i])

    escolha = input("Digite o numero de entrada: ")

    try:
        escolha = int(escolha)
    except:
        return

    if escolha >= 1 and escolha <= len(Possibilidades):

        if escolha == 1:
            escolha = input("Digite a densidade de pombos minima (Recomendado ser < 10): ")
            try:
                escolha = int(escolha)
            except:
                return

            string_busca = "SELECT * FROM TABLE(Densidade_Regiao("+str(escolha)+"))"

            try:
                print(string_busca)
                cursor.execute(string_busca)

            except cx_Oracle.DatabaseError as error:

                print("Erro ao consultar tabela: ", error)
                return

            for result in cursor:
                print(result)

        else:

            CPF = input("Digite o CPF do trabalhador (apenas os 11 numeros): ")

            string_busca = "SELECT * FROM TABLE"

            if escolha == 2 : string_busca += "(Historico_Zelador("+str(CPF)+"))"
            if escolha == 3 : string_busca += "(Historico_Pesquisador("+str(CPF)+"))"
            if escolha == 4 : string_busca += "(Historico_Pesquisador_Full("+str(CPF)+"))"
            if escolha == 5 : string_busca += "(Historico_Matador("+str(CPF)+"))"

            cursor.execute(string_busca)
            
            for result in cursor:
                print(result)