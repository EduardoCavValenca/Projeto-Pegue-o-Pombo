
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