


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