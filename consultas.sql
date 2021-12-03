--Teste branch


--Dados de Sensores por regiao
SELECT SPD.Regiao, DD.Densidade, TO_CHAR(DD.DataHora, 'HH24:MI:SS DD/MM/YYYY') AS Data, DD.Sensor
    FROM Sensor_Densidade_Pombo SPD 
    join Dados_Densidade DD on SPD.NroSerie = DD.Sensor
    ORDER BY SPD.Regiao,DD.DataHora;

--Situacao dos Cocos por regiao
SELECT B.Regiao, CP.ID, TO_CHAR(CP.DataHoraRetirado, 'HH24:MI:SS DD/MM/YYYY') AS Data_Retirado, R.RiscoIminente
    FROM Bairro 
    B join Coco_Pombo CP on B.Nome = CP.Bairro
    left join Relatorio R on R.Amostra = CP.ID  
    ORDER BY B.Regiao;

--Media do sensor da regiao > X

--Quantidade de Coco Contaminado por Regiao
SELECT B.Regiao, SUM(R.RiscoIminente) AS Amostras_Contaminadas
    FROM Bairro B
    join Coco_Pombo CP on B.Nome = CP.Bairro
    left join Relatorio R on R.Amostra = CP.ID
    GROUP BY B.Regiao
    ORDER BY B.Regiao;


--Historico de Todos Zeladores
SELECT Z.Nome,NF.Coco,TO_CHAR(NF.DataHora, 'HH24:MI:SS DD/MM/YYYY') AS Data_Notificacao,
       TO_CHAR(CP.DataHoraRetirado, 'HH24:MI:SS DD/MM/YYYY') AS Data_Retirado
    FROM Zelador Z 
    join Notificacao_Zelador NF on Z.CPF = NF.Zelador
    join Coco_Pombo CP  on NF.Coco = CP.ID
    ORDER BY Z.Nome,NF.DataHora;



SELECT * FROM TABLE(Historico_Zelador('12345678901'));
SELECT * FROM TABLE(Historico_Pesquisador('81282720040'));
SELECT * FROM TABLE(Historico_Pesquisador_Full('81282720040'));
SELECT * FROM TABLE(Historico_Matador('66666666666'));


-- Consulta Nome, CPF, CNPJ e ID do coco nao limpo por zelador
SELECT  Z.Nome, NZ.Zelador AS CPF, CP.CNPJ AS CNPJ_Central, C.ID AS ID_Coco_nao_limpo FROM Zelador Z JOIN Notificacao_Zelador NZ ON Z.CPF = NZ.Zelador JOIN Coco_Pombo C ON NZ.Coco = C.ID 
    JOIN Central_Pombos CP ON NZ.Central = CP.CNPJ WHERE C.DataHoraRetirado IS NULL;

-- Consulta Nome, CPF, CNPJ e ID do coco nao limpo por pesquisador
SELECT  P.Nome, NP.Pesquisador AS CPF, CP.CNPJ AS CNPJ_Central, C.ID AS ID_Coco_nao_limpo FROM Pesquisador P JOIN Notificacao_Pesquisador NP ON P.CPF = NP.Pesquisador JOIN Coco_Pombo C ON NP.Coco = C.ID 
    JOIN Central_Pombos CP ON NP.Central = CP.CNPJ WHERE C.DataHoraRetirado IS NULL;

-- Consulta Nome, CPF e ID do coco limpo por zelador
SELECT  Z.Nome, NZ.Zelador AS CPF, C.ID AS ID_coco_limpo FROM Zelador Z JOIN Notificacao_Zelador NZ ON Z.CPF = NZ.Zelador JOIN Coco_Pombo C ON NZ.Coco = C.ID 
    WHERE C.DataHoraRetirado IS NOT NULL
    GROUP BY Z.Nome, NZ.Zelador, C.ID
    ORDER BY Z.Nome;

-- Consulta Nome, CPF e ID do coco coletado por pesquisador
SELECT  P.Nome, NP.Pesquisador AS CPF, C.ID AS ID_coco_limpo FROM Pesquisador P JOIN Notificacao_Pesquisador NP ON P.CPF = NP.Pesquisador JOIN Coco_Pombo C ON NP.Coco = C.ID 
    WHERE C.DataHoraRetirado IS NOT NULL
    GROUP BY P.Nome, NP.Pesquisador, C.ID
    ORDER BY P.Nome; 
    
-- Consulta Nome, CPF e quantidade de coco limpo por zelador
SELECT  Z.Nome AS Nome_Zelador, NZ.Zelador AS CPF, COUNT(*) AS Quantidade_coco_limpo FROM Zelador Z JOIN Notificacao_Zelador NZ ON Z.CPF = NZ.Zelador JOIN Coco_Pombo C ON NZ.Coco = C.ID 
    WHERE C.DataHoraRetirado IS NOT NULL
    GROUP BY Z.Nome, NZ.Zelador
    ORDER BY Z.Nome;

-- Consulta Nome, CPF e quantidade de coco limpo por pesquisador
SELECT  P.Nome AS Nome_Pesquisador, NP.Pesquisador AS CPF, COUNT(*) AS Quantidade_coco_limpo FROM Pesquisador P JOIN Notificacao_Pesquisador NP ON P.CPF = NP.Pesquisador JOIN Coco_Pombo C ON NP.Coco = C.ID 
    WHERE C.DataHoraRetirado IS NOT NULL
    GROUP BY P.Nome, NP.Pesquisador
    ORDER BY P.Nome; 





-- ******************** MuSSATTINHO ******************************
-- **************** Descricao das Consultas **********************
-- 
--  1.  Consulta que informa o ID do Coco reportado por cada um dos Informantes, a Data em que
--      ele foi reportado e a data em que ele foi retirado, juntamente com o Nome do Informante e
--      o Numero do Celular utilizado. Caso a DataHoraRetirado esteja com valor nulo, interpreta-se 
--      o coco ainda não foi retirado do local.
-- 
--  2.  Consulta que informa os Cocos retirados por Pesquisadores, o Laboratorio para qual a Amostra
--      foi enviada e se existe um relatorio finalizado para aquele coco.
-- 
-- 


-- Consulta 1
SELECT  I.Nome, Cel.Numero, C.ID, C.DataHora as Data_Reportado, C.DataHoraRetirado
FROM COCO_POMBO C 
    JOIN Informa_Coco INF ON C.ID = INF.Coco
    JOIN Celular CEL ON INF.Celular = Cel.Numero
    JOIN Informante I on I.CPF = Cel.Informante
    ORDER BY I.Nome, C.ID, Cel.Numero, C.DataHora, C.DataHoraRetirado;


-- Consulta 2
SELECT C.ID as ID_COCO, C.DataHoraRetirado, P.Nome as PESQUISADOR, L.CNPJ as LABORATORIO, R.DataHora as DATA_RELATORIO, R.RiscoIminente
FROM COCO_POMBO C
    JOIN AMOSTRA A on C.Id = A.Coco
    JOIN LABORATORIO L ON A.Laboratorio = L.CNPJ
    JOIN RELATORIO R on A.Coco = R.Amostra
    JOIN PESQUISADOR P on A.Pesquisador = P.CPF 
    ORDER BY P.CPF, C.ID;

--Verifica Pesquisadores, Suas Notificacoes, Quando o Coco foi Reportado e se foi Retirado
SELECT P.Nome as Pesquisador, C.ID as ID_COCO, C.DataHora as Data_Reportado, N.DataHora as Data_Notificacao,  C.DataHoraRetirado, A.DataHoraColeta
FROM COCO_POMBO C
    JOIN AMOSTRA A on C.Id = A.Coco
    JOIN PESQUISADOR P on A.Pesquisador = P.CPF 
    JOIN NOTIFICACAO_PESQUISADOR N on N.Coco = C.ID
    ORDER BY P.CPF, C.ID;

--
SELECT * FROM INFORMA_COCO;

--
SELECT * FROM CELULAR JOIN INFORMANTE on CELULAR.INFORMANTE = Informante.CPF;

--Verifica Zeladores, Suas Notificacoes, Quando o Coco foi Reportado e se foi Retirado
SELECT Z.Nome as ZELADOR, C.ID as ID_COCO, C.DataHora as Data_Reportado, N.DataHora as Data_Notificacao, C.DataHoraRetirado
FROM Coco_Pombo C
    RIGHT JOIN Notificacao_Zelador N  ON N.Coco = C.ID
    RiGHT JOIN Zelador Z ON N.Zelador = Z.CPF;

-- Verifica Todos os Cocos, se foram notificados, quem recebeu a notificacao e se ja foi retirado
SELECT  C.ID as ID_COCO, C.DataHora as Data_Reportado, P.Nome as Pesquisador, NP.DataHora as Data_Notifi_Pesquisador,
        Z.Nome as ZELADOR, NZ.DataHora as Data_Notifi_Zelador, C.DataHoraRetirado
FROM COCO_POMBO C
    LEFT JOIN NOTIFICACAO_PESQUISADOR NP on NP.Coco = C.ID
    LEFT JOIN Notificacao_Zelador NZ  ON NZ.Coco = C.ID
    LEFT JOIN Zelador Z ON NZ.Zelador = Z.CPF
    LEFT JOIN PESQUISADOR P on NP.Pesquisador = P.CPF;


--
SELECT * FROM AMOSTRA JOIN Pesquisador ON Amostra.Pesquisador = Pesquisador.CPF;


DELETE  from COCO_POMBO Where COCO_POMBO.ID = 123;














