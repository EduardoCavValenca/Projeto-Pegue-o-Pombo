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
    escolha = input("""\n\nDigite seu CPF (apenas os 11 digitos)
                    \nEntrada:""")

    busca_tipo = "SELECT TP.Tipo FROM Tipo_Pessoa TP WHERE TP.CPF = "+escolha

    try:
        cursor.execute(busca_tipo)
    except cx_Oracle.DatabaseError as error:

        print("Erro ao consultar cadastro de pessoas: ", error)
        return

    CPF_encontrado = False
    for result in cursor:
        CPF_encontrado = True
        print("\nSeu cadastro foi encontrado como: \n",result[0])
        break
    for result in cursor:
        print(result[0])

    if not CPF_encontrado:
        print("\nCPF nao foi encontrado no banco de dados")
        return





def Cadastro(connection,cursor):

    CPF = input("\nInforme seu CPF: ")
    Nome = input("Nome: ")
    DataNasc = input("Data de nascimento (DD/MM/YYYY): ")
    CEP = input("CEP: ")
    Rua = input("Rua: ")
    Numero = input("Numero: ")
    Numero_cel = input("Numero de celular: ")
    Modelo_Cel = input("Modelo do celular: ")


    if Cadastra_tipo(connection,cursor,CPF) == -1: return

    if Cadastra_informante(connection,cursor,CPF,Nome,DataNasc,CEP,Rua,Numero) == -1: return

    if Cadastra_celular(connection,cursor,CPF,Numero_cel,Modelo_Cel) == -1: return

    print("\nCadastro Realizado com sucesso!!!")



def Cadastra_celular(connection,cursor,CPF,Numero_cel,Modelo_Cel):

    inserte_celular="INSERT INTO Celular (Numero, Informante, Modelo) VALUES ("
    inserte_celular+= str(Numero_cel)+","+str(CPF)+","+str(Modelo_Cel)+")"

    try:
        cursor.execute(inserte_celular)
        connection.commit()

    except cx_Oracle.DatabaseError as e:

        error, = e.args

        if error.message.find("CK_Celular_Numero") != -1:
            print("\nO numero precisa ter 11 digitos, perfil cadastrado porem telefone nao")
            return -1
       
    except cx_Oracle.IntegrityError as e:
        error, = e.args
        print("\nPerfil cadastrado porem telefone nao")

        return -1






def Cadastra_informante(connection,cursor,CPF,Nome,DataNasc,CEP,Rua,Numero):

    inserte_informante="INSERT INTO Informante (CPF, Nome, DataNasc, CEP, Rua, Numero) VALUES "
    inserte_informante+="('"+str(CPF)+"','"+str(Nome)+"', TO_DATE('"+str(DataNasc)+"','DD/MM/YYYY'),'"
    inserte_informante+=str(CEP)+"','"+str(Rua)+"',"+str(Numero)+")"

    
    try:
        cursor.execute(inserte_informante)
        connection.commit()

    except cx_Oracle.DatabaseError as e:

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

        print(error.code)
        print(error.message)
        print(error.context)

        return -1



def Cadastra_tipo(connection,cursor,CPF):
    inserte_tipo = "INSERT INTO Tipo_Pessoa (CPF, Tipo) VALUES ("+str(CPF)+",'informante')"

    try:
        cursor.execute(inserte_tipo)
        connection.commit()

    except cx_Oracle.IntegrityError as e:
        error, = e.args

        if error.code == 1:
            print("\nCPF ja cadastrado como informante")
            return -1

        if error.code == 2290:
            print("\nCPF precisa conter 11 digitos")
            return -1
