import cx_Oracle

def RealizaInsercao(connection,cursor):
    escolha = input("""\n\nDigite:
                    \n1 para logar com CPF
                    \n2 para se cadastrar como informante
                    \nEntrada:""")

    if escolha == '1':
        Login(connection,cursor)

    elif escolha == '2':
        Cadastro(connection,cursor)




def Login(connection,cursor):
    CPF = input("""\n\nDigite seu CPF (apenas os 11 digitos)
                    \nEntrada:""")

    #Verifica se CPF esta cadastrado na tabela de tipos
    busca_tipo = "SELECT TP.Tipo FROM Tipo_Pessoa TP WHERE TP.CPF = "+CPF

    try:
        cursor.execute(busca_tipo) #Busca na tabela
    except cx_Oracle.DatabaseError as error:

        print("Erro ao consultar cadastro de pessoas: ", error)
        return

    funcoes = []
    CPF_encontrado = False

    for result in cursor:
        CPF_encontrado = True
        funcoes.append(result[0].upper()) #Armazena todas as funcoes encontradas

    if not CPF_encontrado:
        print("\nCPF nao foi encontrado no banco de dados")
        return

    if "MATADOR" == funcoes[0]: #Pequenas alteracao para facilitar na busca da tabela
        funcoes[0]="MATADOR_POMBOS"

    try: #Caso tenha encontrado algum funcao, busca seu nome nessa tabela
        cursor.execute("SELECT NOME FROM "+str(funcoes[0])+" WHERE CPF = "+str(CPF))

    except cx_Oracle.DatabaseError as error:

        print("Erro ao consultar cadastro de pessoas: ", error)
        return

    Nome = ""
    for result in cursor:
        Nome = str(result[0]) #Armazena o nome encontrado

    #Printa mensagem
    print("Bem vindo,",Nome, ", suas funcoes cadastradas encontradas foram:")
    for funcao in funcoes:
        print(funcao.lower())


    #Caso ele seja informante, permite que insira um novo coco
    if "INFORMANTE" in funcoes:

        escolha = input("\n\nDeseja cadastrar um coco ?\n1 para sim\n2 para nao\nEntrada: ")

        if escolha == '1':
            Cadastra_coco(connection,cursor,CPF)


    

#Funcao para gerar novo coco
def Cadastra_coco(connection,cursor,CPF):

    ID=0
    Celular=""
    Latitude = input("\nLatitude do Coco (-90 a 90): ")
    Longitude = input("Longitude do Coco (-180 a 180): ")
    CEP = input("CEP: ")
    Rua = input("Rua: ")
    Numero = input("Numero: ")
    Bairro = input("Bairro: ")

    try:
        cursor.execute("SELECT MAX(ID) FROM COCO_POMBO") #Pega o proximo id disponive, deveria estar no banco
        for result in cursor:
            ID = int(result[0])+1

        cursor.execute("SELECT NUMERO FROM CELULAR WHERE INFORMANTE = "+str(CPF)) #Pega celular do informante
        for result in cursor:
            Celular = str(result[0])
            break

        if(len(Celular)<10): #CPF nao possui celular
            print("""\n Voce nao possui celular cadastrado para isso, aguarde a nova versao da aplicacao que liberara cadastrar apenas celulares""") 
            return

    except cx_Oracle.DatabaseError as error:

        print("Erro ao consultar tabela Coco_Pombo ou Celular: ", error)
        return


    #String para insercao do coco na tabela
    insert_coco = "INSERT INTO Coco_Pombo (ID, Latitude, Longitude, DataHora, DataHoraRetirado, CEP, Bairro, Rua, Numero)"
    insert_coco += "VALUES ("+str(ID)+","+str(Latitude)+","+str(Longitude)+",TO_DATE(SYSDATE,'YYYY/MM/DD HH24:MI:SS'),NULL,"
    insert_coco += str(CEP)+",'"+str(Bairro)+"',"+str(Rua)+","+str(Numero)+")"


    try:
        #Adiciona o coco na tabela
        cursor.execute(insert_coco)
        connection.commit()

    except cx_Oracle.DatabaseError as e:
        #Controle de erros de insercao

        error, = e.args

        if error.message.find("CK_COCO_POMBO_LATITUDE") != -1:
            print("\nLatitude precisa estar entre -90 e 90")
            return -1

        if error.message.find("CK_COCO_POMBO_LONGITUDE") != -1:
            print("\Longitude precisa estar entre -180 e 180")
            return -1


        if error.message.find("CK_COCO_POMBO_CEP") != -1:
            print("\CEP precisa ter 8 digitos")
            return -1

        if error.message.find("CK_COCO_POMBO_NUMERO") != -1:
            print("\nNumero precisa ser > 0")
            return -1

        if error.message.find("UN_COCO_POMBO") != -1:
            print("\n Lat,Long e Horario iguais a de outro coco")
            return -1
       

    except cx_Oracle.IntegrityError as e:
        error, = e.args

        #Controle de erros de insercao

        if error.code == 1:
            print("\nCoco ja foi cadastrado por outra pessoa porem agradecemos o aviso")
            return -1

        return -1


    print("\nCoco cadastrado com sucesso!!!")


    


def Cadastro(connection,cursor):

    CPF = input("\nInforme seu CPF: ")
    Nome = input("Nome: ")
    DataNasc = input("Data de nascimento (DD/MM/YYYY): ")
    CEP = input("CEP: ")
    Rua = input("Rua: ")
    Numero = input("Numero: ")
    Numero_cel = input("Numero de celular: ")
    Modelo_Cel = input("Modelo do celular: ")


    #Cadastra pessoa na tabela de tipos
    if Cadastra_tipo(connection,cursor,CPF) == -1: return

    #Cadastra pessoa na tabela de informantes
    if Cadastra_informante(connection,cursor,CPF,Nome,DataNasc,CEP,Rua,Numero) == -1: return

    #Cadastra celular da pessoa
    if Cadastra_celular(connection,cursor,CPF,Numero_cel,Modelo_Cel) == -1: return


    print("\nCadastro Realizado com sucesso!!!")



def Cadastra_celular(connection,cursor,CPF,Numero_cel,Modelo_Cel):

    #String para inserir celular
    inserte_celular="INSERT INTO Celular (Numero, Informante, Modelo) VALUES ("
    inserte_celular+= str(Numero_cel)+","+str(CPF)+",'"+str(Modelo_Cel)+"')"

    try:
        cursor.execute(inserte_celular)
        connection.commit()

    except cx_Oracle.DatabaseError as e:
        #Controle de erros

        error, = e.args

        if error.message.find("CK_CELULAR_NUMERO") != -1:
            print("\nO numero precisa ter 11 digitos, perfil cadastrado porem telefone nao")
            return -1

        return -1
       
    except cx_Oracle.IntegrityError as e:
        error, = e.args

        print("\nPerfil cadastrado porem telefone nao foi possivel cadastrar")

        return -1

      






def Cadastra_informante(connection,cursor,CPF,Nome,DataNasc,CEP,Rua,Numero):


    #String para inserir na tabela de informante
    inserte_informante="INSERT INTO Informante (CPF, Nome, DataNasc, CEP, Rua, Numero) VALUES "
    inserte_informante+="('"+str(CPF)+"','"+str(Nome)+"', TO_DATE('"+str(DataNasc)+"','DD/MM/YYYY'),'"
    inserte_informante+=str(CEP)+"','"+str(Rua)+"',"+str(Numero)+")"

    
    try:
        cursor.execute(inserte_informante) #Comando
        connection.commit()

    except cx_Oracle.DatabaseError as e:

        #Caso de Errro na insercao na tabela informante, tambem
        # excluimos da tabela tipo pessoa    
        cursor.execute("DELETE FROM TIPO_PESSOA I WHERE I.CPF = "+str(CPF))
        connection.commit()

        error, = e.args

        if error.message.find("CK_INFORMANTE_CEP") != -1:
            print("\nCEP precisa conter 8 digitos")
            return -1

        if error.message.find("CK_INFORMANTE_NUMERO") != -1:
            print("\nNumero precisa ser > 0")
            return -1
       
    except cx_Oracle.IntegrityError as e:
        error, = e.args

        print(error.message)

        return -1



def Cadastra_tipo(connection,cursor,CPF):

    #Insere na tabela de tipo
    inserte_tipo = "INSERT INTO Tipo_Pessoa (CPF, Tipo) VALUES ("+str(CPF)+",'informante')"

    try:
        cursor.execute(inserte_tipo) #Comando
        connection.commit()

    except cx_Oracle.IntegrityError as e:
        error, = e.args

        #Controle de Erros
        if error.code == 1:
            print("\nCPF ja cadastrado como informante")
            return -1

        if error.code == 2290:
            print("\nCPF precisa conter 11 digitos")
            return -1
