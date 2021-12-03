-- **************** Observacoes **********************
--  1.  Para os atributos númericos de tamanho fixo, como CPF,
--      CNPJ, CEP, e Numero de Celular, preferiu-se utilizar o tipo VARCHAR2 
--      em conjunto com um CHECK para garantir que os campos tivessem o tamanho designado.
-- 
--  2.  Para os Triggers de CPF, a logica utilizada foi usar um SELECT com COUNT para
--      verificar se o cpf que esta sendo inserido ja esta na tabela Tipo_Pessoa e se 
--      seu tipo eh compativel. 
--      Por exemplo, antes de inserir uma entrada na tabela Informante, o trigger verifica
--      se o CPF sendo cadastrado ja esta na tabela Tipo_Pessoa, se sim, ele verifica se o
--      tipo cadastrado eh 'INFORMANTE'. Se algo estiver errrado, ele lanca uma excessao e 
--      impede a insersão. 
-- 
--  3.  Para os Triggers de Data Notificacao, a logica utilizada foi apenas verificar se,
--      para um determinado Coco, a data da notificacao que está sendo inserida não eh menor
--      que a data na qual o coco foi inserido no sistema
-- 
--  4.  Para o Trigger de Data Amostra, eh verificado se a data de coleta nao eh menor que
--      a data na qual o coco foi informado no sistema
-- 
--  5.  Para o Trigger de Data Relatorio, eh verificado se a data do relatorio a ser inserida não
--      eh menor que a data em que o coco foi coletado (Amostra)
-- 
--  6.  Para os Triggers de Coco Ja Retirado, a ideia foi similiar aquela usada nos Triggers de 
--      Data Notificacao, durante a isnersao de uma Notificao para o Pesquisador, verifica-se se 
--      ja nao existe uma notificao Zelador para aquele mesmo coco, se sim, o trigger impede a insersão.
--      O mesmo ocorre quando inserindo um Notificao para o Pesquisador.
-- 


-- **************** Tabelas **********************
-- ~~~~ Regiao ~~~~
CREATE TABLE Regiao (
    Nome VARCHAR2(40) NOT NULL,

    CONSTRAINT PK_Regiao PRIMARY KEY (Nome)
);

-- ~~~~ Bairro ~~~~
CREATE TABLE Bairro (
    Nome VARCHAR2(40) NOT NULL,
    Regiao VARCHAR2(40) NOT NULL,   --FK: Nome da Regiao
    
    CONSTRAINT PK_Bairro PRIMARY KEY (Nome),
    CONSTRAINT FK_Bairro_Regiao FOREIGN KEY (Regiao) REFERENCES Regiao(Nome) ON DELETE CASCADE
);

-- ~~~~ Central de Pombo ~~~~
CREATE TABLE Central_Pombos (
    CNPJ VARCHAR2(14) NOT NULL,
    Regiao VARCHAR2(40) NOT NULL,   --FK: Nome da Regiao
    CEP VARCHAR2(8),
    Bairro VARCHAR2(40),
    Rua VARCHAR2(40),
    Numero NUMBER(5),
    
    CONSTRAINT PK_Central_Pombos PRIMARY KEY (CNPJ),
    CONSTRAINT UN_Central_Pombos UNIQUE (Regiao),
    CONSTRAINT FK_Central_Pombos_Regiao FOREIGN KEY (Regiao) REFERENCES Regiao(Nome) ON DELETE CASCADE,

    CONSTRAINT CK_Central_Pombos_CNPJ CHECK (LENGTH(CNPJ) = 14),
    CONSTRAINT CK_Central_Pombos_CEP CHECK (LENGTH(CEP) = 8),
    CONSTRAINT CK_Central_Pombos_Numero CHECK (Numero > 0)
);

-- ~~~~ Coco_Pombo ~~~~
CREATE TABLE Coco_Pombo (
    ID NUMBER NOT NULL,
    Latitude NUMBEr(8,6) NOT NULL,  --Latitude  possui no max 2 digitos antes do ponto e 6 digitos depois do ponto
    Longitude NUMBER(9,6) NOT NULL, --Longitude possui no max 3 digitos antes do ponto e 6 digitos depois do ponto
    DataHora DATE NOT NULL,
    DataHoraRetirado DATE,
    CEP CHAR(8),
    Bairro VARCHAR2(40),    --FK: Nome do Bairro
    Rua VARCHAR2(40),
    Numero NUMBER(5),
    
    CONSTRAINT PK_Coco_Pombo PRIMARY KEY (ID),
    CONSTRAINT UN_Coco_Pombo UNIQUE (Latitude, Longitude, DataHora),
    CONSTRAINT FK_Coco_Pombo_Bairro FOREIGN KEY (Bairro) REFERENCES Bairro (Nome) ON DELETE CASCADE,

    CONSTRAINT CK_Coco_Pombo_DataHoraRetirado CHECK (DataHoraRetirado >= DataHora OR DataHoraRetirado IS NULL),
    CONSTRAINT CK_Coco_Pombo_CEP CHECK (LENGTH(CEP) = 8),
    CONSTRAINT CK_Coco_Pombo_Numero CHECK (Numero > 0),
    CONSTRAINT CK_Coco_Pombo_Latitude CHECK (Latitude >= -90 AND Latitude <= 90), 
    CONSTRAINT CK_Coco_Pombo_Longitude CHECK (Longitude >= -180 AND Longitude <= 180)
);

-- ~~~~ Tipo_Pessoa ~~~~
CREATE TABLE Tipo_Pessoa (
    CPF VARCHAR2(11) NOT NULL,
    Tipo VARCHAR2(11) NOT NULL,

    CONSTRAINT PK_Tipo_Pessoa PRIMARY KEY (CPF,Tipo),

    CONSTRAINT CK_Tipo_Pessoa_CPF CHECK (LENGTH(CPF) = 11),
    CONSTRAINT CK_Tipo_Pessoa_Tipo CHECK (UPPER(Tipo) IN ('MATADOR', 'INFORMANTE', 'ZELADOR', 'PESQUISADOR'))
);

-- ~~~~ Informante ~~~~
CREATE TABLE Informante (
    CPF VARCHAR2(11) NOT NULL,
    Nome VARCHAR2(40) NOT NULL,
    DataNasc DATE,
    CEP VARCHAR2(8),
    Bairro VARCHAR2(40),
    Rua VARCHAR2(40),
    Numero NUMBER(5),
    
    CONSTRAINT PK_Informante PRIMARY KEY (CPF),
    
    CONSTRAINT CK_Informante_CPF CHECK (LENGTH(CPF) = 11),
    CONSTRAINT CK_Informante_CEP CHECK (LENGTH(CEP) = 8),
    CONSTRAINT CK_Informante_Numero CHECK (Numero > 0)
);

-- ~~~~ Celular ~~~~
CREATE TABLE Celular(
    Numero VARCHAR2(11) NOT NULL,
    Informante VARCHAR2(11) NOT NULL,   --FK: CPF do Informante
    Modelo VARCHAR2(20),
    
    CONSTRAINT PK_Celular PRIMARY KEY (Numero),
    CONSTRAINT FK_Celular_Informante FOREIGN KEY (Informante) REFERENCES Informante (CPF) ON DELETE CASCADE,

    CONSTRAINT CK_Celular_Numero CHECK (LENGTH(Numero) = 11)
);

-- ~~~~ Informa_Coco ~~~~
CREATE TABLE Informa_Coco(
    Celular VARCHAR2(11) NOT NULL,  --FK: Numero do Celular
    Coco NUMBER NOT NULL,           --FK: ID do Coco
    DataHora DATE NOT NULL,
    
    CONSTRAINT PK_Informa_Coco PRIMARY KEY (Celular, Coco),
    CONSTRAINT FK_Informa_Coco_Celular FOREIGN KEY (Celular) REFERENCES Celular (Numero) ON DELETE CASCADE,
    CONSTRAINT FK_Informa_Coco_Coco FOREIGN KEY (Coco) REFERENCES Coco_Pombo (ID) ON DELETE CASCADE
);



-- ~~~~ Zelador ~~~~
CREATE TABLE Zelador (
    CPF VARCHAR2(11) NOT NULL,
    Nome VARCHAR2(40) NOT NULL,
    DataNasc DATE,
    CEP VARCHAR2(8),
    Bairro VARCHAR2(40),
    Rua VARCHAR2(40),
    Numero NUMBER(5),
    CarteiraTrab VARCHAR2(8),   --Atributo Genérrico que identifica cada Zelador
    
    CONSTRAINT PK_Zelador PRIMARY KEY (CPF),
    CONSTRAINT UN_Zelador UNIQUE (CarteiraTrab),

    CONSTRAINT CK_Zelador_CarteiraTrab CHECK (LENGTH(CarteiraTrab) = 8),
    CONSTRAINT CK_Zelador_CEP CHECK (LENGTH(CEP) = 8),
    CONSTRAINT CK_Zelador_Numero CHECK (Numero > 0)
);

-- ~~~~ Notificacao_Zelador ~~~~
CREATE TABLE Notificacao_Zelador (
    Coco NUMBER NOT NULL,
    Zelador VARCHAR2(11) NOT NULL,  --FK: CPF do Zelador
    Central VARCHAR2(14) NOT NULL,  --FK: CNPJ da Central
    DataHora DATE,
    
    CONSTRAINT PK_Notificacao_Zelador PRIMARY KEY (Coco),
    CONSTRAINT FK_Notificacao_Zelador_Zelador FOREIGN KEY (Zelador) REFERENCES Zelador(CPF) ON DELETE CASCADE,
    CONSTRAINT FK_Notificacao_Zelador_Coco FOREIGN KEY (Coco) REFERENCES Coco_Pombo(ID) ON DELETE CASCADE
);

-- ~~~~ Matador de Pombos ~~~~
CREATE TABLE Matador_Pombos 
(
    CPF     VARCHAR2(11) NOT NULL,
    Central VARCHAR2(14) NOT NULL,  --FK: CNPJ da Central
    Nome    VARCHAR2(40) NOT NULL,
    DataNasc DATE,
    CEP     VARCHAR2(8),
    Bairro  VARCHAR2(40),
    Rua     VARCHAR2(40),
    Numero  NUMBER(5),
    NroLicenca VARCHAR2(10) NOT NULL,   --Atributo generico que identifica cada matador
    ModeloArma VARCHAR2(20),

    CONSTRAINT PK_Matador_Pombos PRIMARY KEY (CPF),
    CONSTRAINT FK_Central FOREIGN KEY (Central) REFERENCES Central_Pombos(CNPJ) ON DELETE CASCADE,

    CONSTRAINT UN_Matador_Pombos_Licenca UNIQUE (NroLicenca),
    
    -- CONSTRAINT CK_Matador_Pombos_CPF CHECK (LENGTH(CPF) = 11), --Ja verificado em Tipo Pessoa RETIRAR??????
    CONSTRAINT CK_Matador_Pombos_NroLicenca CHECK (LENGTH(NroLicenca) = 10),
    CONSTRAINT CK_Matador_Pombos_CEP CHECK (LENGTH(CEP) = 8),
    CONSTRAINT CK_Matador_Pombos_Numero CHECK (Numero > 0)

);

-- ~~~~ Notificacao Matador ~~~~
CREATE TABLE Notificacao_Matador (
    Matador VARCHAR2(11) NOT NULL,  --FK: CPF do Matador
    DataHora DATE NOT NULL,

    CONSTRAINT PK_Notificacao_Matador PRIMARY KEY (Matador, DataHora),
    CONSTRAINT FK_Notificacao_Matador_Matador FOREIGN KEY (Matador) REFERENCES Matador_Pombos(CPF) ON DELETE CASCADE

);

-- ~~~~ Pesquisador ~~~~
CREATE TABLE Pesquisador(
    CPF VARCHAR2(11),
    Nome VARCHAR2(40) NOT NULL,
    DataNasc DATE,
    CEP VARCHAR2(8),
    Bairro VARCHAR2(40),
    Rua VARCHAR2(40),
    Numero NUMBER(5),
    Formacao VARCHAR2(20) NOT NULL,

    CONSTRAINT PK_Pesquisador PRIMARY KEY (CPF),

    CONSTRAINT CK_Pesquisador_Formacao CHECK ((UPPER(Formacao)) IN ('BACHARELADO', 'MESTRADO', 'DOUTORADO', 'POS-DOUTORADO')),
    CONSTRAINT CK_Pesquisador_CPF CHECK (LENGTH(CPF) = 11),
    CONSTRAINT CK_Pesquisador_CEP CHECK (LENGTH(CEP) = 8),
    CONSTRAINT CK_Pesquisador_Numero CHECK (Numero > 0)
);

-- ~~~~ Notificacao_Pesquisador ~~~~
CREATE TABLE Notificacao_Pesquisador (
    Pesquisador VARCHAR2(11) NOT NULL,  --FK: CPF do Pesquiasdor
    Central VARCHAR2(14) NOT NULL,      --FK: CNPJ da Central
    Coco NUMBER NOT NULL,               --FK: ID do Coco
    DataHora DATE NOT NULL,

    CONSTRAINT PK_Notifi_Pesquisador PRIMARY KEY (Coco),
    CONSTRAINT FK_Notifi_Pesquisador_Pesquis FOREIGN KEY (Pesquisador) REFERENCES Pesquisador (CPF) ON DELETE CASCADE,
    CONSTRAINT FK_Notifi_Pesquisador_Central FOREIGN KEY (Central) REFERENCES Central_Pombos (CNPJ) ON DELETE CASCADE,
    CONSTRAINT FK_Notifi_Pesquisador_Coco FOREIGN KEY (Coco) REFERENCES Coco_Pombo (ID) ON DELETE CASCADE
);

-- ~~~~ Laboratorio ~~~~
CREATE TABLE Laboratorio (
    CNPJ    VARCHAR2(14) NOT NULL,
    CEP     VARCHAR2(8),
    Bairro  VARCHAR2(40),
    Rua     VARCHAR2(40),
    Numero  NUMBER(5),
    
    CONSTRAINT PK_Laboratorio PRIMARY KEY (CNPJ),

    CONSTRAINT CK_Laboratorio_CNPJ CHECK (LENGTH(CNPJ) = 14),
    CONSTRAINT CK_Laboratorio_CEP CHECK (LENGTH(CEP) = 8),
    CONSTRAINT CK_Laboratorio_Numero CHECK (Numero > 0)

);

-- ~~~~ Amostra ~~~~
CREATE TABLE Amostra (
    Coco NUMBER NOT NULL,               --FK: ID do Coco
    Pesquisador VARCHAR2(11) NOT NULL,  --FK: CPF do Pesquisador
    DataHoraColeta DATE NOT NULL,
    Peso NUMBER(6,3),
    Coloracao VARCHAR2(20),
    Laboratorio VARCHAR2(14) NOT NULL,  --FK: CNPJ do Laboratorio
    
    CONSTRAINT PK_Amostra PRIMARY KEY (Coco),

    CONSTRAINT FK_Amostra_Coco FOREIGN KEY (Coco) REFERENCES Coco_Pombo(ID) ON DELETE CASCADE,
    CONSTRAINT FK_Amostra_Pesquisador FOREIGN KEY (Pesquisador) REFERENCES Pesquisador(CPF) ON DELETE CASCADE,
    CONSTRAINT FK_Amostra_Laboratorio FOREIGN KEY (Laboratorio) REFERENCES Laboratorio(CNPJ) ON DELETE CASCADE,

    CONSTRAINT CK_PESO CHECK (Peso > 0 AND Peso < 1000) --Peso deve ser positivo e menor que 1kg

);

-- ~~~~ Relatorio ~~~~
CREATE TABLE Relatorio (
    Amostra NUMBER NOT NULL,    --FK: ID do Coco da Amostra
    DataHora DATE,
    RiscoIminente NUMBER(1) DEFAULT(0) NOT NULL,
    
    CONSTRAINT PK_Relatorio PRIMARY KEY (Amostra),
    CONSTRAINT FK_Relatorio_Amostra FOREIGN KEY (Amostra) REFERENCES Amostra(Coco) ON DELETE CASCADE, 
    
    CONSTRAINT CK_Relatorio_Risco CHECK (RiscoIminente = 1 OR RiscoIminente = 0)  --RiscoIminente eh um booleano
);

-- ~~~~ Sensor Densidade de Pombo ~~~~
CREATE TABLE Sensor_Densidade_Pombo (
    NroSerie VARCHAR2(10) NOT NULL,
    Regiao VARCHAR2(40) NOT NULL,   --FK: Nome da Regiao
    
    CONSTRAINT PK_Sensor_Densidade_Pombo PRIMARY KEY (NroSerie),
    CONSTRAINT FK_Sensor_Densidade_Pombo FOREIGN KEY (Regiao) REFERENCES Regiao(Nome) ON DELETE CASCADE,
    
    CONSTRAINT CK_SDP_NroSerie CHECK (LENGTH(NroSerie)=10)
);

-- ~~~~ Dados_Densidade ~~~~
CREATE TABLE Dados_Densidade (
    Sensor VARCHAR2(10) NOT NULL,   --FK: NroSerie do Sensor
    DataHora DATE NOT NULL,
    Densidade NUMBER(4,2) NOT NULL,
    
    CONSTRAINT PK_Dados_Densidade PRIMARY KEY (Sensor,DataHora),
    CONSTRAINT FK_Dados_Densidade FOREIGN KEY (Sensor) REFERENCES Sensor_Densidade_Pombo(NroSerie) ON DELETE CASCADE,

    CONSTRAINT CK_Dados_Densidade CHECK (Densidade >= 0 AND Densidade < 20) --Densidade por m2 deve estar entre 0 e 20 pombos
);


-- **************** Triggers **********************
-- ~~~~ CPF Matador de Pombos ~~~~
CREATE OR REPLACE TRIGGER TR_CPF_Matador
    BEFORE INSERT OR UPDATE ON Matador_Pombos FOR EACH ROW
DECLARE
    cpf_count NUMBER(1); 

BEGIN
    SELECT COUNT (*) INTO cpf_count FROM TIPO_PESSOA 
    WHERE (cpf = :NEW.cpf AND UPPER(tipo) = 'MATADOR') ;

    IF cpf_count = 0 
    THEN RAISE_APPLICATION_ERROR(-20250, 'CPF nao cadastrado em Tipo_pessoa ou Tipo Incompativel para CPF');
    END IF;
END;
/
-- ~~~~ CPF Informante ~~~~
CREATE OR REPLACE TRIGGER TR_CPF_Informante 
    BEFORE INSERT OR UPDATE ON Informante FOR EACH ROW
DECLARE
    cpf_count NUMBER(1);

BEGIN
    SELECT COUNT (*) INTO cpf_count FROM TIPO_PESSOA 
    WHERE (cpf = :NEW.cpf AND UPPER(tipo) = 'INFORMANTE') ;

    IF cpf_count = 0 
    THEN RAISE_APPLICATION_ERROR(-20250, 'CPF nao cadastrado em Tipo_pessoa ou Tipo Incompativel para CPF');
    END IF;
END;  
/
-- ~~~~ CPF Pesquisador ~~~~
CREATE OR REPLACE TRIGGER TR_CPF_Pesquisador
    BEFORE INSERT OR UPDATE ON Pesquisador FOR EACH ROW
DECLARE
    cpf_count NUMBER(1);

BEGIN
    SELECT COUNT (*) INTO cpf_count FROM TIPO_PESSOA 
    WHERE (cpf = :NEW.cpf AND UPPER(tipo) = 'PESQUISADOR') ;

    IF cpf_count = 0 
    THEN RAISE_APPLICATION_ERROR(-20250, 'CPF nao cadastrado em Tipo_pessoa ou Tipo Incompativel para CPF');
    END IF;
END;  
/
-- ~~~~ CPF Zelador ~~~~
CREATE OR REPLACE TRIGGER TR_CPF_Zelador
    BEFORE INSERT OR UPDATE ON Zelador FOR EACH ROW
DECLARE
    cpf_count NUMBER(1);

BEGIN
    SELECT COUNT (*) INTO cpf_count FROM TIPO_PESSOA 
    WHERE (cpf = :NEW.cpf AND UPPER(tipo) = 'ZELADOR') ;

    IF cpf_count = 0 
    THEN RAISE_APPLICATION_ERROR(-20250, 'CPF nao cadastrado em Tipo_pessoa ou Tipo Incompativel para CPF');
    END IF;
END;
/
-- ~~~~ Data Notificacao Pesquisador ~~~~
CREATE OR REPLACE TRIGGER TR_DATE_Notif_Pesquisador
    BEFORE INSERT OR UPDATE ON Notificacao_Pesquisador FOR EACH ROW
DECLARE
    date_coco DATE;

BEGIN
    SELECT DataHora INTO date_coco FROM Coco_Pombo 
        WHERE ID = :NEW.Coco;

    IF (:NEW.DataHora < date_coco) 
    THEN raise_application_error(-20101,'Data da notificao menor que a data de reportagem');
    END IF;
END;
/
-- ~~~~ Data Notificacao Zelador ~~~~
CREATE OR REPLACE TRIGGER TR_DATE_Notificacao_Zelador
    BEFORE INSERT OR UPDATE ON Notificacao_Zelador FOR EACH ROW
DECLARE
    date_coco DATE;

BEGIN
    SELECT DISTINCT DataHora INTO date_coco FROM Coco_Pombo 
        WHERE ID = :NEW.Coco;

    IF (:NEW.DataHora < date_coco) THEN
        raise_application_error(-20101,'Data da notificao menor que a data de reportagem');
    END IF;
END;
/
-- ~~~~ Data Amostra ~~~~
CREATE OR REPLACE TRIGGER TR_DATE_Amostra
    BEFORE INSERT OR UPDATE ON Amostra FOR EACH ROW
DECLARE
    date_coco DATE;

BEGIN
    SELECT DISTINCT DataHora INTO date_coco FROM Coco_Pombo 
        WHERE ID = :NEW.Coco;

    IF (:NEW.DataHoraColeta < date_coco) THEN
        raise_application_error(-20101,'Data da notificao menor que a data de reportagem');
    END IF;
END;
/
-- ~~~~ Data Relatorio ~~~~
CREATE OR REPLACE TRIGGER TR_DATE_Relatorio
    BEFORE INSERT OR UPDATE ON Relatorio FOR EACH ROW
DECLARE
    date_coleta DATE;

BEGIN
    SELECT DISTINCT DataHoraColeta INTO date_coleta FROM Amostra 
        WHERE Coco = :NEW.Amostra;

    IF (:NEW.DataHora < date_coleta) THEN
        raise_application_error(-20101,'Data da notificao menor que a data de reportagem');
    END IF;
END;
/
-- ~~~~ Notificacao Pesquisador ja  Retirada ~~~~
CREATE OR REPLACE TRIGGER TR_Coco_NotifPesquisador
    BEFORE INSERT OR UPDATE ON NOTIFICACAO_PESQUISADOR FOR EACH ROW
DECLARE
    coco_count NUMBER(1);

BEGIN
    SELECT COUNT (*) INTO coco_count FROM NOTIFICACAO_ZELADOR 
    WHERE (Coco = :NEW.coco) ;

    IF coco_count != 0 
    THEN RAISE_APPLICATION_ERROR(-20250, 'Coco ja retirado por um Zelador');
    END IF;
END;
/
-- ~~~~ Notificacao Zelador ja Coletada ~~~~
CREATE OR REPLACE TRIGGER TR_Coco_NotifZelador
    BEFORE INSERT OR UPDATE ON Notificacao_zelador FOR EACH ROW
DECLARE
    coco_count NUMBER(1);

BEGIN
    SELECT COUNT (*) INTO coco_count FROM notificacao_pesquisador
    WHERE (Coco = :NEW.coco) ;

    IF coco_count != 0 
    THEN RAISE_APPLICATION_ERROR(-20250, 'Coco ja coletado por um Pesquisador');
    END IF;
END;


-- **************** TYPE OBJECTS **********************
/
CREATE OR REPLACE TYPE Historico_Zel_Pes_Linha AS OBJECT(
    Nome VARCHAR2(40),
    Coco NUMBER,
    Data_Notificacao VARCHAR2(20),
    Data_Retirado VARCHAR2(20)
);
/
CREATE OR REPLACE TYPE Historico_Zel_Pes_Table AS TABLE OF Historico_Zel_Pes_Linha;


/
CREATE OR REPLACE TYPE Historico_Pesq_Full_Linha AS OBJECT(
    Nome VARCHAR2(40),
    Coco NUMBER,
    Risco_Iminente NUMBER(1),
    Peso NUMBER(6,3),
    Coloracao VARCHAR2(20),
    Laboratorio VARCHAR2(14),
    Data_Notificacao VARCHAR2(20),
    Data_Retirado VARCHAR2(20)
   
);
/
CREATE OR REPLACE TYPE Historico_Pesq_Full_Table AS TABLE OF Historico_Pesq_Full_Linha;

/
CREATE OR REPLACE TYPE Historico_Matador_Linha AS OBJECT(
    Nome VARCHAR2(40),
    Data_Notificacao VARCHAR2(20)
);

/
CREATE OR REPLACE TYPE Historico_Matador_Table AS TABLE OF Historico_Matador_Linha;


/
CREATE OR REPLACE TYPE Densidade_Regiao_Linha AS OBJECT(
    Regiao VARCHAR2(40),
    Densidade NUMBER
);

/
CREATE OR REPLACE TYPE Densidade_Regiao_Table AS TABLE OF Densidade_Regiao_Linha;


-- **************** FUNCTIONS **********************
/
CREATE OR REPLACE FUNCTION Historico_Zelador (CPF_Pesquisa IN VARCHAR2)
RETURN Historico_Zel_Pes_Table
IS
    Historico Historico_Zel_Pes_Table := Historico_Zel_Pes_Table();

BEGIN

    SELECT Historico_Zel_Pes_Linha(Z.Nome,NF.Coco,TO_CHAR(NF.DataHora, 'HH24:MI:SS DD/MM/YYYY'), TO_CHAR(CP.DataHoraRetirado, 'HH24:MI:SS DD/MM/YYYY'))
    BULK COLLECT INTO Historico
    FROM Zelador Z join Notificacao_Zelador NF
    on Z.CPF = NF.Zelador AND Z.CPF = CPF_Pesquisa
    join Coco_Pombo CP
    on NF.Coco = CP.ID
    ORDER BY NF.DataHora DESC;

RETURN Historico;
END;
/

CREATE OR REPLACE FUNCTION Historico_Pesquisador (CPF_Pesquisa IN VARCHAR2)
RETURN Historico_Zel_Pes_Table
IS
    Historico Historico_Zel_Pes_Table := Historico_Zel_Pes_Table();

BEGIN

    SELECT Historico_Zel_Pes_Linha(P.Nome,NP.Coco, TO_CHAR(NP.DataHora, 'HH24:MI:SS DD/MM/YYYY'), TO_CHAR(CP.DataHoraRetirado, 'HH24:MI:SS DD/MM/YYYY'))
    BULK COLLECT INTO Historico
    FROM Pesquisador P join Notificacao_Pesquisador NP
    on P.CPF = NP.Pesquisador AND P.CPF = CPF_Pesquisa
    join Coco_Pombo CP
    on NP.Coco = CP.ID
    ORDER BY NP.DataHora DESC;

RETURN Historico;
END;
/

CREATE OR REPLACE FUNCTION Historico_Pesquisador_Full (CPF_Pesquisa IN VARCHAR2)
RETURN Historico_Pesq_Full_Table
IS
    Historico Historico_Pesq_Full_Table := Historico_Pesq_Full_Table();

BEGIN

    SELECT Historico_Pesq_Full_Linha(P.Nome,NP.Coco, R.RiscoIminente,A.Peso,A.Coloracao,A.Laboratorio,
    TO_CHAR(NP.DataHora, 'HH24:MI:SS DD/MM/YYYY'),TO_CHAR(CP.DataHoraRetirado, 'HH24:MI:SS DD/MM/YYYY'))
    BULK COLLECT INTO Historico
    FROM Pesquisador P join Notificacao_Pesquisador NP
    on P.CPF = NP.Pesquisador AND P.CPF = CPF_Pesquisa
    left join Amostra A
    on A.Coco = NP.Coco
    left join Relatorio R
    on A.Coco = R.Amostra
    join Coco_Pombo CP
    on NP.Coco = CP.ID
    ORDER BY NP.DataHora DESC;

RETURN Historico;
END;
/

CREATE OR REPLACE FUNCTION Historico_Matador (CPF_Pesquisa IN VARCHAR2)
RETURN Historico_Matador_Table
IS
    Historico Historico_Matador_Table := Historico_Matador_Table();

BEGIN

    SELECT Historico_Matador_Linha(MP.Nome, TO_CHAR(NM.DataHora, 'HH24:MI:SS DD/MM/YYYY'))
    BULK COLLECT INTO Historico
    FROM Matador_Pombos MP join Notificacao_Matador NM
    on MP.CPF = NM.Matador AND MP.CPF = CPF_Pesquisa
    ORDER BY NM.DataHora DESC;

RETURN Historico;
END;


/
CREATE OR REPLACE FUNCTION Densidade_Regiao (Media IN NUMBER)
RETURN Densidade_Regiao_Table
IS
    Media_Table Densidade_Regiao_Table := Densidade_Regiao_Table();

BEGIN

    SELECT Densidade_Regiao_Linha(SPD.Regiao, AVG(DD.Densidade))
    BULK COLLECT INTO Media_Table
    FROM Sensor_Densidade_Pombo SPD
    join Dados_Densidade DD on SPD.NroSerie = DD.Sensor
    GROUP BY SPD.Regiao HAVING AVG(DD.Densidade) > Media
    ORDER BY AVG(DD.Densidade) DESC;


RETURN Media_Table;
END;