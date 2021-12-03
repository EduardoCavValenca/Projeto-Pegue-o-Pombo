--Media do sensor das regioes de forma Descrescente
SELECT SPD.Regiao, AVG(DD.Densidade) AS Densidade_Media
    FROM Sensor_Densidade_Pombo SPD 
    join Dados_Densidade DD on SPD.NroSerie = DD.Sensor
    GROUP BY SPD.Regiao
    ORDER BY AVG(DD.Densidade) DESC;



--Regioes que possuem médoa maior do que 1
SELECT SPD.Regiao, AVG(DD.Densidade) AS Densidade_Media
    FROM Sensor_Densidade_Pombo SPD
    join Dados_Densidade DD on SPD.NroSerie = DD.Sensor
    GROUP BY SPD.Regiao HAVING AVG(DD.Densidade) > 1
    ORDER BY AVG(DD.Densidade) DESC;

--Versao funcao com media buscada variavel
SELECT * FROM TABLE(Densidade_Regiao(9));




--Quantidade de Coco Contaminado por Regiao
SELECT B.Regiao, SUM(R.RiscoIminente) AS Amostras_Contaminadas
    FROM Bairro B
    join Coco_Pombo CP on B.Nome = CP.Bairro
    left join Relatorio R on R.Amostra = CP.ID
    GROUP BY B.Regiao
    ORDER BY SUM(R.RiscoIminente) DESC;


--Situacao dos Cocos por regiao
SELECT B.Regiao, CP.ID, TO_CHAR(CP.DataHoraRetirado, 'HH24:MI:SS DD/MM/YYYY') AS Data_Retirado, R.RiscoIminente
    FROM Bairro 
    B join Coco_Pombo CP on B.Nome = CP.Bairro
    left join Relatorio R on R.Amostra = CP.ID  
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


--Para Cada Pesquisador:
--  Numero de Notificoes Recebidas
--  Numero de Notificacoes Atendidas = Numero Amostras Coletadas  
--  Numero Amostras Enviadas para Laboratorio
--  Numero de Relatorios Finalizados
SELECT  P.Nome AS Pesquisador, P.CPF, COUNT (N.Coco) as N_Notif_Recebidas, COUNT (C.DataHoraRetirado) as N_Notif_Atendidas,
        COUNT (A.Coco) as N_Amostras_Coletadas, COUNT (R.Amostra) AS N_Amostras_Enviadas, COUNT (R.DataHora) AS N_Relatorios_Finalizados
FROM PESQUISADOR P
    LEFT JOIN NOTIFICACAO_PESQUISADOR N ON N.Pesquisador = P.CPF
    LEFT JOIN Coco_Pombo C ON N.Coco = c.ID
    LEFT JOIN Amostra A ON A.Coco = C.ID
    LEFT JOIN Relatorio R ON R.Amostra = A.Coco
GROUP BY P.Nome, P.CPF
ORDER BY P.Nome;


--Notificacoes Recebidas e Atendidas pelos Pesquisadores
SELECT P.Nome as Pesquisador, C.ID as ID_COCO, C.DataHora as Data_Reportado, N.DataHora as Data_Notificacao,  C.DataHoraRetirado
FROM COCO_POMBO C
    RIGHT JOIN NOTIFICACAO_PESQUISADOR N on N.Coco = C.ID
    RIGHT JOIN PESQUISADOR P on N.Pesquisador = P.CPF 
ORDER BY P.Nome, C.ID;

--Das Notificacoes Antendidas, Mostra as que foram coletadas, enviadas e os relatorios
-- ID_COCO = NULL                                               --> Nao atendeu nenhuma notificacao
-- ID_COCO != NULL & ID_AMOSTRA = NULL                          --> Amostra foi coletada mas nao enviada para o Laboratorio
-- ID_COCO != NULL & ID_AMOSTRA != NULL & DATA_RELATORIO = NULL --> Amostra enviada mas Relatorio Nao Finalizado 
SELECT  P.Nome AS Pesquisador, N.Coco AS ID_COCO, N.DataHora AS Data_Notificacao, A.DataHoraColeta AS Data_Coleta, 
        R.Amostra AS ID_AMOSTRA, R.DataHora AS DATA_RELATORIO
FROM Pesquisador P
    LEFT JOIN Amostra A ON A.Pesquisador = P.CPF
    LEFT JOIN Notificacao_Pesquisador N ON N.Pesquisador = P.CPF AND N.COCO = A.COCO
    LEFT JOIN Relatorio R ON R.Amostra = A.Coco
ORDER BY P.Nome;

SELECT * From RELATORIO;
SELECT * FROM Amostra;
SELECT * FROM NOTIFICACAO_PESQUISADOR;


--Para cada Informante, Numero de Cocos Informados e Quantidade ja retirada
SELECT  I.Nome AS Informante, COUNT (IC.Coco) AS Cocos_Reportadors, COUNT (C.DataHoraRetirado) AS Cocos_Retirados
FROM INFORMA_COCO IC
    LEFT JOIN CELULAR Cel ON IC.Celular = Cel.Numero
    RIGHT JOIN Informante I ON I.CPF = Cel.Informante
    LEFT JOIN Coco_Pombo C ON C.ID = IC.Coco
GROUP BY I.Nome
ORDER By I.Nome;










