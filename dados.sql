-- **************** Dados **********************
-- ~~~~ Inserção na tabela Regiao ~~~~
INSERT INTO Regiao (Nome)
    VALUES ('Zona Norte');

INSERT INTO Regiao (Nome)
    VALUES ('Zona Sul');

INSERT INTO Regiao (Nome)
    VALUES ('Zona Leste');

INSERT INTO Regiao (Nome)
    VALUES ('Zona Oeste');

INSERT INTO Regiao (Nome)
    VALUES ('Centro');


-- ~~~~ Inserção na tabela Bairro ~~~~
INSERT INTO Bairro (Nome, Regiao)
    VALUES ('Flores Altas','Zona Norte');

INSERT INTO Bairro (Nome, Regiao)
    VALUES ('Nova Alianca','Zona Sul');

INSERT INTO Bairro (Nome, Regiao)
    VALUES ('Soledade','Zona Leste');

INSERT INTO Bairro (Nome, Regiao)
    VALUES ('Bangu','Zona Oeste');

INSERT INTO Bairro (Nome, Regiao)
    VALUES ('Santa Maria','Centro');

INSERT INTO Bairro (Nome, Regiao)
    VALUES ('Padaria Centrolifica','Zona Oeste');

INSERT INTO Bairro (Nome, Regiao)
    VALUES ('Jardim Celeste','Centro');

INSERT INTO Bairro (Nome, Regiao)
    VALUES ('Bela Aliança','Zona Oeste');
    
INSERT INTO Bairro (Nome, Regiao)
    VALUES ('Central','Centro');    

INSERT INTO Bairro (Nome, Regiao)
    VALUES ('Parque Verde','Zona Oeste');

INSERT INTO Bairro (Nome, Regiao)
    VALUES ('Alto Santa Maria','Zona Norte');

INSERT INTO Bairro (Nome, Regiao)
    VALUES ('Alameda das Angélicas','Zona Oeste');

INSERT INTO Bairro (Nome, Regiao)
    VALUES ('Porenquanto','Centro');

INSERT INTO Bairro (Nome, Regiao)
    VALUES ('Cosmos','Zona Leste');

INSERT INTO Bairro (Nome, Regiao)
    VALUES ('Tabuleiro do Martins','Zona Sul');

INSERT INTO Bairro (Nome, Regiao)
    VALUES ('Diamante','Zona Norte');

INSERT INTO Bairro (Nome, Regiao)
    VALUES ('Vila Olimpia','Zona Oeste');

INSERT INTO Bairro (Nome, Regiao)
    VALUES ('São João do Cabrito','Zona Sul');

INSERT INTO Bairro (Nome, Regiao)
    VALUES ('Oriente','Zona Norte');

INSERT INTO Bairro (Nome, Regiao)
    VALUES ('Armação do Pântano do Sul','Zona Oeste');

INSERT INTO Bairro (Nome, Regiao)
    VALUES ('São Jorge de Agostina','Centro');

INSERT INTO Bairro (Nome, Regiao)
    VALUES ('Lemoyne','Zona Leste');

INSERT INTO Bairro (Nome, Regiao)
    VALUES ('Pajuçara','Zona Oeste');

INSERT INTO Bairro (Nome, Regiao)
    VALUES ('Santa Helena','Zona Oeste');

INSERT INTO Bairro (Nome, Regiao)
    VALUES ('Novo Eldorado','Zona Oeste');

INSERT INTO Bairro (Nome, Regiao)
    VALUES ('Laranjeiras','Zona Norte');

INSERT INTO Bairro (Nome, Regiao)
    VALUES ('Palhano','Zona Oeste');

INSERT INTO Bairro (Nome, Regiao)
    VALUES ('Nova Pombopolis','Zona Sul');





-- ~~~~ Inserção na tabela Central Pombos ~~~~
INSERT INTO Central_Pombos (CNPJ, Regiao, CEP, Bairro, Rua, Numero)
    VALUES ('01234567891011', 'Zona Norte', '86058142', 'Esperanca' , 'Rua Davis Cup' , 75);        --Central da Regiao: Zona Norte
    
INSERT INTO Central_Pombos (CNPJ, Regiao, CEP, Bairro, Rua, Numero)
    VALUES ('11019876543210', 'Zona Sul', '01234567', 'Nova Alianca' , 'Rua Trevis Scott', 103);    --Central da Regiao: Zonal Sul
    
INSERT INTO Central_Pombos (CNPJ, Regiao, CEP, Bairro, Rua, Numero)
    VALUES ('09182736450123', 'Zona Leste', '76543210', 'Espartano' , 'Rua dos Gamers', 25);        --Central da Regiao: Zona Leste

INSERT INTO Central_Pombos (CNPJ, Regiao, CEP, Bairro, Rua, Numero)
    VALUES ('90817263540123', 'Zona Oeste', '93494265', 'Flores Altas', 'Rua Palestra Italia', 518);--Central da Regiao: Zona Oeste

INSERT INTO Central_Pombos (CNPJ, Regiao, CEP, Bairro, Rua, Numero)
    VALUES ('67890123459999', 'Centro', '53069463', 'Bangu', 'Rua Brasilia', 644);                  ----Central da Regiao: Centro


-- ~~~~ Inserção na tabela Coco_Pombo ~~~~
INSERT INTO Coco_Pombo (ID, Latitude, Longitude, DataHora, DataHoraRetirado, CEP, Bairro, Rua, Numero)  --Zelador: Ze faiz tudo
    VALUES (1, 76.8171, 156.419902, TO_DATE('2021/10/10 10:45:38', 'YYYY/MM/DD HH24:MI:SS'),                --Retirado
            TO_DATE('2021/10/11 12:50:12', 'YYYY/MM/DD HH24:MI:SS'), '26215415', 'Central', 'Silvestre Coelho', 456);

INSERT INTO Coco_Pombo (ID, Latitude, Longitude, DataHora, DataHoraRetirado, CEP, Bairro, Rua, Numero)  --Zelador: Robertinho do Vassourao
    VALUES (2, 81.2041, 155.273612, TO_DATE('2019/12/01 22:52:24', 'YYYY/MM/DD HH24:MI:SS'),                --Retirado
            TO_DATE('2021/12/01 23:50:12', 'YYYY/MM/DD HH24:MI:SS'), '78556634', 'Jardim Celeste', 'Rua das Goiabeiras', 100); 

INSERT INTO Coco_Pombo (ID, Latitude, Longitude, DataHora, DataHoraRetirado, CEP, Bairro, Rua, Numero)  --Zelador: Dona Creuza
    VALUES (3, 70.4212, 154.109436, TO_DATE('2019/01/01 00:00:01', 'YYYY/MM/DD HH24:MI:SS'),                --Nao Retirado
            NULL, '69077450', 'Bela Aliança', 'Quadra B', 24);
    
INSERT INTO Coco_Pombo (ID, Latitude, Longitude, DataHora, DataHoraRetirado, CEP, Bairro, Rua, Numero)  --Zelador: Zelador do Clipe do Nirvana
    VALUES (4, 75.9296, 156.370572, TO_DATE('2020/02/02 22:22:22', 'YYYY/MM/DD HH24:MI:SS'),                --Nao Retirado
            NULL, '45601140', 'Parque Verde', 'Alameda das Angélicas', 225);
  
INSERT INTO Coco_Pombo (ID, Latitude, Longitude, DataHora, DataHoraRetirado, CEP, Bairro, Rua, Numero)  --Nao Notificado Para Nenhum Zelador
    VALUES (5, 74.9296, 156.370546, TO_DATE('2021/09/30 14:47:52', 'YYYY/MM/DD HH24:MI:SS'), 
            NULL, '64212385', 'Alto Santa Maria', 'Vinte Dois de Março', 89);  

INSERT INTO Coco_Pombo (ID, Latitude, Longitude, DataHora, DataHoraRetirado, CEP, Bairro, Rua, Numero)  --Zelador: Ze faiz tudo
    VALUES (13, 45.9296, 87.370546, TO_DATE('2021/09/15 14:47:52', 'YYYY/MM/DD HH24:MI:SS'),                --Retirado
            TO_DATE('2021/10/11 12:50:12', 'YYYY/MM/DD HH24:MI:SS'), '38560437', 'Central', 'Rua 25 de Marco', 55);  

INSERT INTO Coco_Pombo (ID, Latitude, Longitude, DataHora, DataHoraRetirado, CEP, Bairro, Rua, Numero)  --Zelador: Ze faiz tudo
    VALUES (25, 67.2346, 76.32346, TO_DATE('2021/11/20 14:47:52', 'YYYY/MM/DD HH24:MI:SS'),                --Notificado
            NULL, '50285634', 'Jardim Celeste', 'Rua dos Almirantes', 11);  

INSERT INTO Coco_Pombo (ID, Latitude, Longitude, DataHora, DataHoraRetirado, CEP, Bairro, Rua, Numero)  --Pesquisador: Anakin
    VALUES (123, 75.617085, 157.206858, TO_DATE('2021/11/10 13:20:51', 'YYYY/MM/DD HH24:MI:SS'),            --Relatorio Nao Finalizado
            TO_DATE('2021/11/20 10:45:38', 'YYYY/MM/DD HH24:MI:SS'), '58100456', 'Tabuleiro do Martins', 'Jornalista Renan Santiago', 01);  

INSERT INTO Coco_Pombo (ID, Latitude, Longitude, DataHora, DataHoraRetirado, CEP, Bairro, Rua, Numero)  --Pesquisador: Joao Coluna
    VALUES (666, 75.169157, 155.125823, TO_DATE('2021/11/20 10:50:14', 'YYYY/MM/DD HH24:MI:SS'),            --Relatorio Pronto
            TO_DATE('2021/11/21 17:30:04', 'YYYY/MM/DD HH24:MI:SS'), '23061495', 'Cosmos', 'Rua Costinha', 66);  

INSERT INTO Coco_Pombo (ID, Latitude, Longitude, DataHora, DataHoraRetirado, CEP, Bairro, Rua, Numero)  --Pesquisador: Alessandro Barbaro
    VALUES (500, 73.859468, 153.284157, TO_DATE('2018/12/25 11:00:00', 'YYYY/MM/DD HH24:MI:SS'),            --Amostra Sem Relatorio
            TO_DATE('2019/02/16 12:00:00', 'YYYY/MM/DD HH24:MI:SS'), '64003087', 'Porenquanto', 'Avenida Marechal Castelo Branco', 339);

INSERT INTO Coco_Pombo (ID, Latitude, Longitude, DataHora, DataHoraRetirado, CEP, Bairro, Rua, Numero)  --Pesquisador: Pedro Serrote
    VALUES (10, 89.9999, -170.763, TO_DATE('2020/12/25 11:00:00', 'YYYY/MM/DD HH24:MI:SS'),                 --Nao Retirado
            NULL, '64006787', 'Parque Verde', 'Avenida Joao Fiusa', 689);

INSERT INTO Coco_Pombo (ID, Latitude, Longitude, DataHora, DataHoraRetirado, CEP, Bairro, Rua, Numero)  --Nao Notificado para Nenhum Pesquisador
    VALUES (22, -30.45, 25.763, TO_DATE('2020/06/16 14:43:20', 'YYYY/MM/DD HH24:MI:SS'),                    
            NULL, '23905738', 'Jardim Celeste', 'Avenida Roedores', 784);

INSERT INTO Coco_Pombo (ID, Latitude, Longitude, DataHora, DataHoraRetirado, CEP, Bairro, Rua, Numero)  --Pesquisador: Ze faiz tudo
    VALUES (490, 37.800, 14.763, TO_DATE('2020/11/10 14:43:20', 'YYYY/MM/DD HH24:MI:SS'),                   --Relatorio Pronto
            TO_DATE('2020/11/19 10:22:20', 'YYYY/MM/DD HH24:MI:SS'), '23450965', 'Novo Eldorado', 'Avenida Roedores', 65);


-- ~~~~ Inserção na tabela Tipo Pessoa ~~~~

INSERT INTO Tipo_Pessoa (CPF, Tipo)
    VALUES ('12345678901','zelador');       -- Ze faiz tudo

INSERT INTO Tipo_Pessoa (CPF, Tipo)
    VALUES ('12345678901','matador');       -- Ze faiz tudo

INSERT INTO Tipo_Pessoa (CPF, Tipo)
    VALUES ('12345678901','informante');    -- Ze faiz tudo

INSERT INTO Tipo_Pessoa (CPF, Tipo)
    VALUES ('12345678901','pesquisador');   -- Ze faiz tudo

INSERT INTO Tipo_Pessoa (CPF, Tipo)
    VALUES ('81282720040','pesquisador');   -- Anakin

INSERT INTO Tipo_Pessoa (CPF, Tipo)
    VALUES ('15454291030','pesquisador');   -- Joao

INSERT INTO Tipo_Pessoa (CPF, Tipo)
    VALUES ('41716935008','pesquisador');   -- Alessandro Barbaro 

INSERT INTO Tipo_Pessoa (CPF, Tipo)
    VALUES ('10970670095','pesquisador');   -- Pedro Serrote

INSERT INTO Tipo_Pessoa (CPF, Tipo)
    VALUES ('04486497058','pesquisador');   -- Yudi
    
INSERT INTO Tipo_Pessoa (CPF, Tipo)
    VALUES ('03102496008','informante');    -- Minionzera

INSERT INTO Tipo_Pessoa (CPF, Tipo)
    VALUES ('19688269042','informante');    -- Mussattex
    
INSERT INTO Tipo_Pessoa (CPF, Tipo)
    VALUES ('29358867043','informante');    -- Chezon

INSERT INTO Tipo_Pessoa (CPF, Tipo)
    VALUES ('81771167033','informante');    -- Marcus Segundo

INSERT INTO Tipo_Pessoa (CPF, Tipo)
    VALUES ('30368706010','informante');    -- Bruno Mola  

INSERT INTO Tipo_Pessoa (CPF, Tipo)
    VALUES ('84732064927','matador');       -- Androgod

INSERT INTO Tipo_Pessoa (CPF, Tipo)
    VALUES ('66666666666','matador');       -- Joao de Santo Cristo

INSERT INTO Tipo_Pessoa (CPF, Tipo)
    VALUES ('45609874381','matador');       -- Evair o Matador

INSERT INTO Tipo_Pessoa (CPF, Tipo)
    VALUES ('92309874381','matador');       -- Arthur Morgan

INSERT INTO Tipo_Pessoa (CPF, Tipo)
    VALUES ('10365074901','zelador');       -- Robertinho do Vassourao

INSERT INTO Tipo_Pessoa (CPF, Tipo)
    VALUES ('93760124061','zelador');       -- Dona Creuza

INSERT INTO Tipo_Pessoa (CPF, Tipo)
    VALUES ('94520593443','zelador');       -- Zelador Do clip do Nirvana
    
INSERT INTO Tipo_Pessoa (CPF, Tipo)
    VALUES ('05395729513','zelador');       -- Jerry



-- ~~~~ Inserção na tabela Informante ~~~~
INSERT INTO Informante (CPF, Nome, DataNasc, CEP, Bairro, Rua, Numero)
    VALUES ('03102496008','Minionzera', TO_DATE('2001/06/25', 'YYYY/MM/DD'), 
            '58025480', 'Flores Altas', 'Marques de Sardinha', 69);
    
INSERT INTO Informante (CPF, Nome, DataNasc, CEP, Bairro, Rua, Numero)
    VALUES ('19688269042','Mussattex', TO_DATE('2000/04/24', 'YYYY/MM/DD'), 
            '08330095', 'Nova Alianca', 'Prado de Morais', 77);
    
INSERT INTO Informante (CPF, Nome, DataNasc, CEP, Bairro, Rua, Numero)
    VALUES ('29358867043','Chezon', TO_DATE('1998/03/14', 'YYYY/MM/DD'), 
            '54792035', 'Central', 'General Osorio', 35);
    
INSERT INTO Informante (CPF, Nome, DataNasc, CEP, Bairro, Rua, Numero)
    VALUES ('81771167033','Marcus Segundo', TO_DATE('1987/02/16', 'YYYY/MM/DD'), 
            '49089291', 'Soledade', 'Francisco Marcelino Dias', 08);
    
INSERT INTO Informante (CPF, Nome, DataNasc, CEP, Bairro, Rua, Numero)
    VALUES ('30368706010','Bruno Mola', TO_DATE('2001/02/20', 'YYYY/MM/DD'), 
            '91140210', 'Diamante', 'Sarandi', 333);

INSERT INTO Informante (CPF, Nome, DataNasc, CEP, Bairro, Rua, Numero)
    VALUES ('12345678901', 'Ze faiz tudo', TO_DATE('1982/11/04', 'YYYY/MM/DD'),
            '13946729', 'Vila Olimpia', 'Alameda dos Campeoes', 500);



--  ~~~~ Inserção na tabela Celular ~~~~
INSERT INTO Celular (Numero, Informante, Modelo)
    VALUES (43996305642, '03102496008', 'Galaxy Ultra');        --Miniozera
    
INSERT INTO Celular (Numero, Informante, Modelo)
    VALUES (43991302611, '03102496008', 'Galaxy S11');          --Miniozera
    
INSERT INTO Celular (Numero, Informante, Modelo)
    VALUES (19994812963, '19688269042', 'Iphone 13');           --Mussattex
    
INSERT INTO Celular (Numero, Informante, Modelo)
    VALUES (19992745981, '19688269042', 'Iphone 13 PRO');       --Mussattex

INSERT INTO Celular (Numero, Informante, Modelo)
    VALUES (16998417501, '29358867043', 'Positivo Standard');   --Chezon
    
INSERT INTO Celular (Numero, Informante, Modelo)
    VALUES (14993331449, '81771167033', 'Xiomi');               --Marcus Segundo
    
INSERT INTO Celular (Numero, Informante, Modelo)
    VALUES (15990009989, '30368706010', 'Motorola V8');         --Bruno Mola
    
INSERT INTO Celular (Numero, Informante, Modelo)                
    VALUES (18991287916, '12345678901', 'LG');                  --Ze faiz tudo



-- ~~~~ Inserção na tabela Informa_Coco ~~~~
-- Mesmo celular informa Coco 1 e 2 em DataHora diferente    
INSERT INTO Informa_Coco (Celular, Coco, DataHora)
    VALUES (43991302611, 1, TO_DATE('2021/10/10 10:45:38', 'YYYY/MM/DD HH24:MI:SS'));   --Miniozera

INSERT INTO Informa_Coco (Celular, Coco, DataHora)
    VALUES (43996305642, 2, TO_DATE('2021/12/10 12:59:02', 'YYYY/MM/DD HH24:MI:SS'));   --Miniozera
    
INSERT INTO Informa_Coco (Celular, Coco, DataHora)
    VALUES (19994812963, 2, TO_DATE('2021/12/01 22:52:24', 'YYYY/MM/DD HH24:MI:SS'));   --Mussattex

INSERT INTO Informa_Coco (Celular, Coco, DataHora)
    VALUES (16998417501, 3, TO_DATE('2019/01/01 00:00:01', 'YYYY/MM/DD HH24:MI:SS'));   --Chezon
    
INSERT INTO Informa_Coco (Celular, Coco, DataHora)
    VALUES (14993331449, 4, TO_DATE('2020/02/02 22:22:22', 'YYYY/MM/DD HH24:MI:SS'));   --Marcus Segundo
    
INSERT INTO Informa_Coco (Celular, Coco, DataHora)
    VALUES (15990009989, 5, TO_DATE('2020/05/17 03:39:59', 'YYYY/MM/DD HH24:MI:SS'));   --Bruno Mola
    
INSERT INTO Informa_Coco (Celular, Coco, DataHora)
    VALUES (18991287916, 666, TO_DATE('2021/11/20 10:50:14', 'YYYY/MM/DD HH24:MI:SS')); --Ze faiz tudo



-- ~~~~ Inserção na tabela Zelador ~~~~
INSERT INTO Zelador (CPF, Nome, DataNasc, CEP, Bairro, Rua, Numero, CarteiraTrab)
    VALUES ('12345678901', 'Ze faiz tudo', TO_DATE('1980/06/06', 'YYYY/MM/DD'), 
            '13946729', 'Vila Olimpia', 'Alameda dos Campeoes', 500, '10591478');
            
INSERT INTO Zelador (CPF, Nome, DataNasc, CEP, Bairro, Rua, Numero, CarteiraTrab)
    VALUES ('10365074901', 'Robertinho do Vassourao', TO_DATE('1955/02/20', 'YYYY/MM/DD'), 
            '40490204', 'São João do Cabrito', 'Rua da Paz de São João', 111, '83472643');

INSERT INTO Zelador (CPF, Nome, DataNasc, CEP, Bairro, Rua, Numero, CarteiraTrab)
    VALUES ('93760124061', 'Dona Creuza', TO_DATE('1968/09/17', 'YYYY/MM/DD'), 
            '29150518', 'Oriente', 'Rua Jerusalem', 898, '16734985');

INSERT INTO Zelador (CPF, Nome, DataNasc, CEP, Bairro, Rua, Numero, CarteiraTrab)
    VALUES ('94520593443', 'Zelador do Clip do Nirvana', TO_DATE('1978/03/10', 'YYYY/MM/DD'), 
            '88066577', 'Armação do Pântano do Sul', 'Servidão Quati', 45, '26841379');

INSERT INTO Zelador (CPF, Nome, DataNasc, CEP, Bairro, Rua, Numero, CarteiraTrab)   --Nao possui Notificacao
    VALUES ('05395729513', 'Jerry', TO_DATE('1999/05/13', 'YYYY/MM/DD'), 
            '56473829', 'São Jorge de Agostina', 'Avenida Higeanípolis', 313, '04171738');


    
-- ~~~~ Inserção na tabela Notificacao Zelador ~~~~

INSERT INTO Notificacao_Zelador (Coco , Zelador , Central, DataHora)                                        --Ze faiz tudo
    VALUES (1, '12345678901', '01234567891011', TO_DATE('2021/12/10 10:06:06', 'YYYY/MM/DD HH24:MI:SS'));       --Retirado

INSERT INTO Notificacao_Zelador (Coco , Zelador , Central, DataHora)                                        --Robertinho do Vassourao
    VALUES (2, '10365074901', '11019876543210', TO_DATE('2020/04/12 00:00:00', 'YYYY/MM/DD HH24:MI:SS'));       --Retirado

INSERT INTO Notificacao_Zelador (Coco , Zelador , Central, DataHora)                                        --Dona Creuza
    VALUES (3, '93760124061', '09182736450123', TO_DATE('2019/03/14 22:16:07', 'YYYY/MM/DD HH24:MI:SS'));       --Nao Retirado

INSERT INTO Notificacao_Zelador (Coco , Zelador , Central, DataHora)                                        --Zelador do Clip do Nirvana
    VALUES (4, '94520593443', '09182736450123', TO_DATE('2020/12/21 12:36:21', 'YYYY/MM/DD HH24:MI:SS'));       --Nao Retirado

INSERT INTO Notificacao_Zelador (Coco , Zelador , Central, DataHora)                                        --Ze faiz tudo
    VALUES (13, '12345678901', '01234567891011', TO_DATE('2021/09/25 15:27:22', 'YYYY/MM/DD HH24:MI:SS'));      --Retirado

INSERT INTO Notificacao_Zelador (Coco , Zelador , Central, DataHora)                                        --Ze faiz tudo
    VALUES (25, '12345678901', '01234567891011', TO_DATE('2021/11/22 10:23:55', 'YYYY/MM/DD HH24:MI:SS'));      --Nao Retirado



-- ~~~~ Inserção na tabela Matador de Pombo ~~~~
INSERT INTO Matador_Pombos (CPF, Central, Nome, DataNasc, CEP, Bairro, Rua, Numero, NroLicenca, ModeloArma) --Nao tem Notificacao
    VALUES ('84732064927', '01234567891011', 'Androgod', TO_DATE('2000/04/27', 'YYYY/MM/DD'),
            '93494265', 'Espartano', 'Rua dos Gamers', 25, 'a1b2c3d4e5', 'Desert Eagle');

INSERT INTO Matador_Pombos (CPF, Central, Nome, DataNasc, CEP, Bairro, Rua, Numero, NroLicenca, ModeloArma)
    VALUES ('66666666666', '11019876543210', 'Joao de Santo Cristo', TO_DATE('1987/08/15', 'YYYY/MM/DD'),
            '53069463', 'Planalto Central', 'Rua Brasilia', 2514, 'WN22666666', 'Winchester 22');
    
INSERT INTO Matador_Pombos (CPF, Central, Nome, DataNasc, CEP, Bairro, Rua, Numero, NroLicenca, ModeloArma)
    VALUES ('45609874381', '11019876543210', 'Evair o Matador', TO_DATE('1965/01/21', 'YYYY/MM/DD'),
            '40729528', 'Palmeiras', 'Rua Palestra Italia', 9, 'Palm3Ir4S9', 'Chute Potente');

INSERT INTO Matador_Pombos (CPF, Central, Nome, DataNasc, CEP, Bairro, Rua, Numero, NroLicenca, ModeloArma) --nao tem notificacao
    VALUES ('92309874381', '90817263540123', 'Arthur Morgan', TO_DATE('1863/06/10', 'YYYY/MM/DD'),
            '02594386', 'Lemoyne', 'Rua Saint Denis', 123, 'AmDutchV4N', 'Pistola Scotchfield');

INSERT INTO Matador_Pombos (CPF, Central, Nome, DataNasc, CEP, Bairro, Rua, Numero, NroLicenca, ModeloArma)
    VALUES ('12345678901', '67890123459999', 'Ze faiz tudo', TO_DATE('1982/11/04', 'YYYY/MM/DD'),
            '13946729', 'Vila Olimpia', 'Alameda dos Campeoes', 500, 'Ze123FT321', 'Arco e Flecha');



-- ~~~~ Inserção na tabela Notificacao Matador~~~~
INSERT INTO Notificacao_Matador (Matador, DataHora)
    VALUES ('45609874381', TO_DATE('1994/11/11 20:43:11', 'YYYY/MM/DD HH24:MI:SS'));    --Evair o Matador

INSERT INTO Notificacao_Matador (Matador, DataHora)
    VALUES ('45609874381', TO_DATE('1999/10/15 15:30:00', 'YYYY/MM/DD HH24:MI:SS'));    --Evair o Matador

INSERT INTO Notificacao_Matador (Matador, DataHora)
    VALUES ('66666666666', TO_DATE('2020/03/03 16:06:06', 'YYYY/MM/DD HH24:MI:SS'));    --Joao de Santo Cristo

INSERT INTO Notificacao_Matador (Matador, DataHora)
    VALUES ('12345678901', TO_DATE('2021/12/03 09:22:56', 'YYYY/MM/DD HH24:MI:SS'));    --Ze faiz tudo




-- ~~~~ Inserção na tabela Pesquisador ~~~~
INSERT INTO Pesquisador (CPF, Nome, DataNasc, CEP, Bairro, Rua, Numero, Formacao)
    VALUES ('81282720040', 'Anakin', TO_DATE('2000/04/27', 'YYYY/MM/DD'), 
            '59133265', 'Pajuçara', 'Rua Francisco Morato', 51, 'Mestrado');
    
INSERT INTO Pesquisador (CPF, Nome, DataNasc, CEP, Bairro, Rua, Numero, Formacao)
    VALUES ('15454291030', 'Joao Coluna', TO_DATE('1999/05/31', 'YYYY/MM/DD'), 
            '21850070', 'Bangu', 'Rua da Paz', 22, 'Doutorado'); 
    
INSERT INTO Pesquisador (CPF, Nome, DataNasc, CEP, Bairro, Rua, Numero, Formacao)
    VALUES ('41716935008', 'Alessandro Barbaro', TO_DATE('2001/05/14', 'YYYY/MM/DD'), 
            '49043687', 'Santa Maria', 'Rua Portugal', 10, 'Pos-Doutorado'); 
    
INSERT INTO Pesquisador (CPF, Nome, DataNasc, CEP, Bairro, Rua, Numero, Formacao)
    VALUES ('10970670095', 'Pedro Serrote', TO_DATE('2000/06/05', 'YYYY/MM/DD'), 
            '78045020', 'Santa Helena', 'Alameda Polivalente', 539, 'Bacharelado');
    
INSERT INTO Pesquisador (CPF, Nome, DataNasc, CEP, Bairro, Rua, Numero, Formacao)   --Sem Notificacao !!!!!!!
    VALUES ('04486497058', 'Yudi', TO_DATE('2000/06/23', 'YYYY/MM/DD'), 
            '32341450', 'Novo Eldorado', 'Rua Jacuma', 777, 'Bacharelado');

INSERT INTO Pesquisador (CPF, Nome, DataNasc, CEP, Bairro, Rua, Numero, Formacao)
    VALUES ('12345678901', 'Ze faiz tudo',TO_DATE('1982/11/04', 'YYYY/MM/DD'),
            '13946729','Vila Olimpia','Alameda dos Campeoes', 500, 'Bacharelado');



-- ~~~~ Inserção na tabela Notificacao_Pesquisador ~~~~
INSERT INTO Notificacao_Pesquisador (Pesquisador, Central, Coco, DataHora)                                  --Anakin
    VALUES ('81282720040', '90817263540123', 123, TO_DATE('2021/11/10 14:47:38', 'YYYY/MM/DD HH24:MI:SS'));     --Relatorio Nao Finalizado
 
INSERT INTO Notificacao_Pesquisador (Pesquisador, Central, Coco, DataHora)                                  --Joao
    VALUES ('15454291030', '01234567891011', 666, TO_DATE('2021/12/01 23:00:24', 'YYYY/MM/DD HH24:MI:SS'));     --Relatorio Finalizado

INSERT INTO Notificacao_Pesquisador (Pesquisador, Central, Coco, DataHora)                                  --Alessandro Barbaro
    VALUES ('41716935008', '90817263540123', 500, TO_DATE('2019/01/01 00:01:01', 'YYYY/MM/DD HH24:MI:SS'));     --Sem Relatorio

INSERT INTO Notificacao_Pesquisador (Pesquisador, Central, Coco, DataHora)                                  --Pedro Serrote
    VALUES ('10970670095', '01234567891011', 10, TO_DATE('2021/03/02 22:32:22', 'YYYY/MM/DD HH24:MI:SS'));      --Nao Retirado
    
INSERT INTO Notificacao_Pesquisador (Pesquisador, Central, Coco, DataHora)                                  --Ze faiz Tudo
    VALUES ('12345678901', '90817263540123', 490, TO_DATE('2020/11/18 15:30:20', 'YYYY/MM/DD HH24:MI:SS'));     --Relatorio Finalizado

-- ~~~~ Inserção na tabela Laboratorio ~~~~
INSERT INTO Laboratorio (CNPJ, CEP, Bairro, Rua, Numero)
    VALUES ('12345678901234', '12345678', 'Laranjeiras', 'Alameda Arantes',115);

INSERT INTO Laboratorio (CNPJ, CEP, Bairro, Rua, Numero)
    VALUES ('43210987654321', '87654321', 'Palhano', 'Rua Almirante Tamandare', 555);

INSERT INTO Laboratorio (CNPJ, CEP, Bairro, Rua, Numero)
    VALUES ('12345671234567', '12341234', 'Nova Pombopolis', 'Rua do Pombo', 478);


-- ~~~~ Inserção na tabela Amostra ~~~~
INSERT INTO Amostra (Coco, Pesquisador, DataHoraColeta, Peso, Coloracao, Laboratorio)
    VALUES (123, '81282720040', TO_DATE('2021/11/20 10:45:38', 'YYYY/MM/DD HH24:MI:SS'),    --Anakin; Lab: Laranjeiras
             122.100, 'Marrom','12345678901234');       

INSERT INTO Amostra (Coco, Pesquisador, DataHoraColeta, Peso, Coloracao, Laboratorio)
    VALUES (666, '15454291030', TO_DATE('2021/12/15 14:22:22', 'YYYY/MM/DD HH24:MI:SS'),    --Joao; Lab: Palhano
            666.666, 'Esbranquicado', '43210987654321');

INSERT INTO Amostra (Coco, Pesquisador, DataHoraColeta, Peso, Coloracao, Laboratorio)
    VALUES (500, '41716935008', TO_DATE('2019/02/16 12:00:00', 'YYYY/MM/DD HH24:MI:SS'),    --Alessandro Barbaro; Lab: Palhano
            15.987, 'Esverdeado', '43210987654321');                                            --Sem Relatorio

INSERT INTO Amostra (Coco, Pesquisador, DataHoraColeta, Peso, Coloracao, Laboratorio)
    VALUES (490, '12345678901', TO_DATE('2020/11/19 10:22:20', 'YYYY/MM/DD HH24:MI:SS'),    --Ze faiz Tudo; Lab: Nova Pombopolis
            15.987, 'Esverdeado', '12345671234567');


-- ~~~~ Inserção na tabela Relatorio ~~~~
INSERT INTO Relatorio (Amostra, DataHora, RiscoIminente)
    VALUES  (123, NULL, 0);

INSERT INTO Relatorio (Amostra, DataHora, RiscoIminente)
    VALUES  (666, TO_DATE('2021/12/31 23:59:59', 'YYYY/MM/DD HH24:MI:SS'), 1);

INSERT INTO Relatorio (Amostra, DataHora, RiscoIminente)
    VALUES  (490, TO_DATE('2021/02/15 23:59:59', 'YYYY/MM/DD HH24:MI:SS'), 0);



-- ~~~~ Inserção na tabela Sensor Densidade de Pombo ~~~~
INSERT INTO Sensor_Densidade_Pombo (NroSerie, Regiao)
    VALUES ('0123456789','Zona Norte');
    
INSERT INTO Sensor_Densidade_Pombo (NroSerie, Regiao)
    VALUES ('1011121314','Zona Sul');

INSERT INTO Sensor_Densidade_Pombo (NroSerie, Regiao)
    VALUES ('1516171819','Zona Leste');

INSERT INTO Sensor_Densidade_Pombo (NroSerie, Regiao)
    VALUES ('9876543210','Zona Oeste');

INSERT INTO Sensor_Densidade_Pombo (NroSerie, Regiao)
    VALUES ('8546543210','Zona Oeste');    

INSERT INTO Sensor_Densidade_Pombo (NroSerie, Regiao)
    VALUES ('0918273645','Centro');


-- ~~~~ Inserção na tabela Dados Densidade ~~~~
INSERT INTO Dados_Densidade (Sensor, DataHora, Densidade)
    VALUES ('0123456789', TO_DATE('2021/10/10 10:37:38', 'YYYY/MM/DD HH24:MI:SS'), 10);     --Zona Norte

INSERT INTO Dados_Densidade (Sensor, DataHora, Densidade)
    VALUES ('1011121314', TO_DATE('2021/08/01 04:47:23', 'YYYY/MM/DD HH24:MI:SS'), 0.25);   --Zona Sul

INSERT INTO Dados_Densidade (Sensor, DataHora, Densidade)
    VALUES ('1516171819', TO_DATE('2020/05/31 01:13:28', 'YYYY/MM/DD HH24:MI:SS'), 2);      --Zona Leste

INSERT INTO Dados_Densidade (Sensor, DataHora, Densidade)
    VALUES ('9876543210', TO_DATE('2000/04/24 08:00:00', 'YYYY/MM/DD HH24:MI:SS'), 0.44);   --Zona Oeste

INSERT INTO Dados_Densidade (Sensor, DataHora, Densidade)
    VALUES ('0918273645', TO_DATE('2021/12/03 11:43:11', 'YYYY/MM/DD HH24:MI:SS'), 0.99);   --Centro

INSERT INTO Dados_Densidade (Sensor, DataHora, Densidade)
    VALUES ('0918273645', TO_DATE('2021/12/03 11:43:12', 'YYYY/MM/DD HH24:MI:SS'), 0.33);   --Centro
    
