import cx_Oracle

def RealizaConsulta(cursor):

    Possibilidades=["pesquisador","informante","zelador","matador_pombos"] 
    # Printa possiblidades e pega input
    x=1
    string_busca = "SELECT * FROM " + Possibilidades[x]
    cursor.execute(string_busca)
    for result in cursor:
        print(result)
    
