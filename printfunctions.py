import cx_Oracle

def print_historico_zelador(cursor):
    CPF_encontrado = False
    for result in cursor:
        CPF_encontrado = True
        print("\n\nNome Zelador:",result[0])
        print("ID Coco:",result[1],
        ", Data Notificacao:",result[2],", Data Retirado:",result[3])
        break
    for result in cursor:
        print("ID Coco:",result[1],
        ", Data Notificacao:",result[2],", Data Retirado:",result[3])

    print("\n")

    return CPF_encontrado


def print_historico_pesquisador(cursor):
    CPF_encontrado = False
    for result in cursor:
        CPF_encontrado = True
        print("\n\nNome Pesquisador:",result[0])
        print("ID Coco:",result[1],
        ", Data Notificacao:",result[2],", Data Retirado:",result[3])
        break
    for result in cursor:
        print("ID Coco:",result[1],
        ", Data Notificacao:",result[2],", Data Retirado:",result[3])
    
    print("\n")

    return CPF_encontrado


def print_historico_pesquisador_full(cursor):
    CPF_encontrado = False
    for result in cursor:
        CPF_encontrado = True
        print("\n\nNome Pesquisador:",result[0])
        print("ID Coco:",result[1], ", Risco iminente:",result[2],
        ", Peso:",result[3], ", Coloracao:",result[4],", Laboratorio:",result[5],
        ", Data Notificacao:",result[6],", Data Retirado:",result[7])
        break
    for result in cursor:
        print("ID Coco:",result[1], ", Risco iminente:",result[2],
        ", Peso:",result[3], ", Coloracao:",result[4],", Laboratorio:",result[5],
        ", Data Notificacao:",result[6],", Data Retirado:",result[7])

    print("\n")

    return CPF_encontrado


def print_historico_matador(cursor):
    CPF_encontrado = False
    for result in cursor:
        CPF_encontrado = True
        print("\n\nNome Matador:",result[0])
        print("Data Notificacao:",result[1])
        break
    for result in cursor:
        print("Data Notificacao:",result[1])
    
    print("\n")

    return CPF_encontrado


def print_pesquisador(cursor):

    print("\n\n")
    for result in cursor:
        print("CPF:",result[0],", Nome:",result[1],", Data Nascimento:",result[2],
        ", CEP:",result[3],", Rua:",result[4],", Numero:",result[5],", Formacao:",result[6])
    
    print("\n")

def print_informante(cursor):

    print("\n\n")
    for result in cursor:
        print("CPF:",result[0],", Nome:",result[1],", Data Nascimento:",result[2],
        ", CEP:",result[3],", Rua:",result[4],", Numero:",result[5])
    
    print("\n")

def print_zelador(cursor):

    print("\n\n")
    for result in cursor:
        print("CPF:",result[0],", Nome:",result[1],", Data Nascimento:",result[2],
        ", CEP:",result[3],", Rua:",result[4],", Numero:",result[5],", Carteira de Trabalho:",result[6])
    
    print("\n")


def print_matador(cursor):

    print("\n\n")
    for result in cursor:
        print("CPF:",result[0],", Central:",result[1],", Nome:",result[2],
        ", Data Nascimento:",result[3],", CEP:",result[4],", Rua:",result[5],
        ", Numero:",result[6],", Licenca:",result[7],", Modelo Arma:",result[8])
    
    print("\n")


def print_central(cursor):
    print("\n\n")
    for result in cursor:
        print("CNPJ:",result[0],", Regiao:",result[1],", CEP:",result[2],
        ", Rua:",result[3],", Numero:",result[4])
    
    print("\n")


def print_coco(cursor):
    print("\n\n")
    for result in cursor:
        print("ID:",result[0],", Latitude:",result[1],", Longitude:",result[2],
        ", Data Informado:",result[3],", Data Retirado:",result[4],", CEP:",result[5],
        ", Bairro:",result[6],", Rua:",result[7],", Numero:",result[8])
    
    print("\n")

 