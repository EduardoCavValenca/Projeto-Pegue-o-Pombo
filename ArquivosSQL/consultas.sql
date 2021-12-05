-- **************** Consultas **********************

-- 1. Media do sensor das regioes de forma Descrescente

SELECT SPD.Regiao, AVG(DD.Densidade) AS Densidade_Media
FROM Sensor_Densidade_Pombo SPD 
    JOIN Dados_Densidade DD on SPD.NroSerie = DD.Sensor
GROUP BY SPD.Regiao
ORDER BY AVG(DD.Densidade) DESC;


-- 2. Regioes que possuem médoa maior do que 1

SELECT SPD.Regiao, AVG(DD.Densidade) AS Densidade_Media
FROM Sensor_Densidade_Pombo SPD
    JOIN Dados_Densidade DD on SPD.NroSerie = DD.Sensor
GROUP BY SPD.Regiao HAVING AVG(DD.Densidade) > 1
ORDER BY AVG(DD.Densidade) DESC;


-- 3. Quantidade de Coco Contaminado por Regiao
--    NULL indica nulo

SELECT B.Regiao, SUM(R.RiscoIminente) AS Amostras_Contaminadas
FROM Bairro B
    JOIN Coco_Pombo CP on B.Nome = CP.Bairro
    LEFT JOIN Relatorio R on R.Amostra = CP.ID
GROUP BY B.Regiao
ORDER BY SUM(R.RiscoIminente) DESC;


-- 4. Consulta Nome do zelador, CPF, ID do coco limpo e DataHora do Coco limpo mais recente

SELECT  Z.Nome, NZ.Zelador AS CPF, C.ID AS ID_coco_limpo, TO_CHAR(C.DataHoraRetirado, 'DD/MM/YYYY HH24:MI:SS') AS DataHora_retirado
FROM Zelador Z 
    JOIN Notificacao_Zelador NZ ON Z.CPF = NZ.Zelador 
    JOIN Coco_Pombo C ON NZ.Coco = C.ID 
WHERE C.DataHoraRetirado IS NOT NULL AND C.DataHoraRetirado IN (SELECT MAX(DataHoraRetirado) FROM Coco_Pombo JOIN Notificacao_Zelador ON ID = Coco)
ORDER BY Z.Nome;


-- 5. Consulta Nome do pesquisador, CPF, ID do coco limpo e DataHora do Coco coletado mais recente

SELECT  P.Nome, NP.Pesquisador AS CPF, C.ID AS ID_coco_limpo, TO_CHAR(C.DataHoraRetirado, 'DD/MM/YYYY HH24:MI:SS') AS DataHora_retirado
FROM Pesquisador P 
    JOIN Notificacao_Pesquisador NP ON P.CPF = NP.Pesquisador 
    JOIN Coco_Pombo C ON NP.Coco = C.ID 
WHERE C.DataHoraRetirado IS NOT NULL AND C.DataHoraRetirado IN (SELECT MAX(DataHoraRetirado) FROM Coco_Pombo JOIN Notificacao_Pesquisador ON ID = Coco)
ORDER BY P.Nome;


-- 6. Situacao dos Cocos por regiao

SELECT B.Regiao, CP.ID, TO_CHAR(CP.DataHoraRetirado, 'DD/MM/YYYY HH24:MI:SS') AS Data_Retirado, R.RiscoIminente
FROM Bairro B 
    JOIN Coco_Pombo CP on B.Nome = CP.Bairro
    LEFT JOIN Relatorio R on R.Amostra = CP.ID  
ORDER BY B.Regiao;


-- 7. Historico de Todos Zeladores

SELECT Z.Nome,NF.Coco,NF.Central,TO_CHAR(NF.DataHora, 'DD/MM/YYYY HH24:MI:SS') AS Data_Notificacao,
       TO_CHAR(CP.DataHoraRetirado, 'DD/MM/YYYY HH24:MI:SS') AS Data_Retirado
FROM Zelador Z 
    JOIN Notificacao_Zelador NF on Z.CPF = NF.Zelador
    JOIN Coco_Pombo CP  on NF.Coco = CP.ID
ORDER BY Z.Nome,NF.DataHora;




-- ~~~~~~~~ Geral Pesquisadores ~~~~~~~~

-- 8.   Para Cada Pesquisador:
--          Numero de Notificoes Recebidas
--          Numero de Notificacoes Atendidas = Numero Amostras Coletadas  
--          Numero Amostras Enviadas para Laboratorio
--          Numero de Relatorios Finalizados

SELECT  P.Nome AS Pesquisador, P.CPF, 
        COUNT (N.Coco) AS N_Notif_Recebidas, 
        COUNT (C.DataHoraRetirado) AS N_Notif_Atendidas,
        COUNT (A.Coco) AS N_Amostras_Coletadas, 
        COUNT (R.Amostra) AS N_Amostras_Enviadas, 
        COUNT (R.DataHora) AS N_Relatorios_Finalizados
FROM PESQUISADOR P
    LEFT JOIN NOTIFICACAO_PESQUISADOR N ON N.Pesquisador = P.CPF
    LEFT JOIN Coco_Pombo C ON N.Coco = c.ID
    LEFT JOIN Amostra A ON A.Coco = C.ID
    LEFT JOIN Relatorio R ON R.Amostra = A.Coco
GROUP BY P.CPF, P.Nome
ORDER BY P.Nome;


-- 9. Notificacoes Recebidas e Atendidas pelos Pesquisadores

SELECT  P.Nome AS Pesquisador, C.ID AS ID_COCO, 
        TO_CHAR(C.DataHora, 'DD/MM/YYYY HH24:MI:SS') AS Data_Reportado, 
        TO_CHAR(N.DataHora, 'DD/MM/YYYY HH24:MI:SS') AS Data_Notificacao,  
        TO_CHAR(C.DataHoraRetirado, 'DD/MM/YYYY HH24:MI:SS') AS Data_Retirado
FROM COCO_POMBO C
    JOIN NOTIFICACAO_PESQUISADOR N on N.Coco = C.ID
    RIGHT JOIN PESQUISADOR P on N.Pesquisador = P.CPF 
ORDER BY P.Nome, C.ID;


-- 10. Das Notificacoes Antendidas, Mostra AS que foram coletadas, enviadas e os relatorios
--      ID_COCO = NULL                                               --> Nao atendeu nenhuma notificacao
--      ID_COCO != NULL & ID_AMOSTRA = NULL                          --> Amostra foi coletada mas nao enviada para o Laboratorio
--      ID_COCO != NULL & ID_AMOSTRA != NULL & DATA_RELATORIO = NULL --> Amostra enviada mas Relatorio Nao Finalizado 

SELECT  P.Nome AS Pesquisador, N.Coco AS ID_COCO, 
        TO_CHAR(N.DataHora, 'DD/MM/YYYY HH24:MI:SS') AS Data_Notificacao, 
        TO_CHAR(A.DataHoraColeta, 'DD/MM/YYYY HH24:MI:SS') AS Data_Coleta, 
        R.Amostra AS ID_Relatorio,  
        TO_CHAR(R.DataHora, 'DD/MM/YYYY HH24:MI:SS') AS DATA_RELATORIO
FROM Pesquisador P
    LEFT JOIN Notificacao_Pesquisador N ON N.Pesquisador = P.CPF 
    LEFT JOIN Amostra A ON A.Pesquisador = P.CPF AND N.COCO = A.COCO
    LEFT JOIN Relatorio R ON R.Amostra = A.Coco
ORDER BY P.Nome;




-- ~~~~~~~~ Geral Informantes ~~~~~~~~

-- 11. Para cada Informante, Numero de Cocos Informados e Quantidade ja Retirada
SELECT  I.Nome AS Informante,I.CPF, 
        COUNT (IC.Coco) AS Cocos_Reportadors, 
        COUNT (C.DataHoraRetirado) AS Cocos_Retirados
FROM INFORMA_COCO IC
    JOIN CELULAR Cel ON IC.Celular = Cel.Numero
    RIGHT JOIN Informante I ON I.CPF = Cel.Informante
    LEFT JOIN Coco_Pombo C ON C.ID = IC.Coco
GROUP BY I.CPF, I.Nome
ORDER By I.Nome;


-- 12. Mostra todos os informantes, seus numeros de celular, sua notificaoes criadas e quais foram atendidas
--      Numero = NULL                                   --> Pessoa não possui nenhum celular cadastrado
--      Numero != NULL & ID_COCO = NULL                 --> Nenhuma notificacao criada com aquele celular
--      Data_Notificacao != NULL & Data_Retirada = NULL --> Coco foi notificado mas ainda nao foi retirado

SELECT  I.Nome AS Informante, Cel.Numero , IC.Coco AS ID_COCO, 
        TO_CHAR(IC.DataHora, 'DD/MM/YYYY HH24:MI:SS') AS Data_Notificacao,
        TO_CHAR(C.DataHoraRetirado, 'DD/MM/YYYY HH24:MI:SS') AS Data_Retirado
FROM Informante I
    LEFT JOIN CELULAR Cel ON I.CPF = Cel.Informante
    LEFT JOIN Informa_Coco IC ON Cel.Numero = IC.Celular
    LEFT JOIN Coco_Pombo C ON C.ID = IC.Coco
ORDER BY I.Nome;





-- ~~~~~~~~~~~~~~ Consultas com Divisao ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- 13. Consulta todas as pessoas que são informante, zelador, matador e pesquisador
--     Utilizamos Tabela Pesquisador por provavelmente haver menos tuplas

SELECT P.Nome, CPF FROM Pesquisador P WHERE
    NOT EXISTS ( (SELECT DISTINCT UPPER(Tipo) FROM Tipo_Pessoa)
                  MINUS
                 (SELECT UPPER(Tipo) FROM Tipo_Pessoa 
                                     WHERE P.CPF = CPF)
                );


-- 14. Consulta o zelador que trabalhou para todas as centrais

SELECT Z.Nome, CPF FROM Zelador Z WHERE
    NOT EXISTS ((SELECT CNPJ FROM Central_Pombos)
                MINUS
                (SELECT Central FROM Notificacao_Zelador 
                                WHERE Zelador = Z.CPF)
                );




-- ~~~~~~~~~~~~~~ Consultas por Funcao ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
--  As funções são criadas juntamente com as tabelas no arquivo 'esquema.sql'.
--  
--  Abaixo estao representadas, em forma de comentario, o nucleo central da funcao,
--  responsavel por fazer a busca nas tabelas

--Versao funcao com media buscada variavel
SELECT * FROM TABLE(Densidade_Regiao(9));

    -- SELECT Densidade_Regiao_Linha(SPD.Regiao, AVG(DD.Densidade))
    -- BULK COLLECT INTO Media_Table -- Linha para inserir in nova tabela
    -- FROM Sensor_Densidade_Pombo SPD
    -- join Dados_Densidade DD on SPD.NroSerie = DD.Sensor
    -- GROUP BY SPD.Regiao HAVING AVG(DD.Densidade) > Media --Media valor de input
    -- ORDER BY AVG(DD.Densidade) DESC;


SELECT * FROM TABLE(Historico_Zelador('12345678901'));

    -- SELECT Historico_Zel_Pes_Linha(Z.Nome,NF.Coco,TO_CHAR(NF.DataHora, 'DD/MM/YYYY HH24:MI:SS'), TO_CHAR(CP.DataHoraRetirado, 'DD/MM/YYYY HH24:MI:SS'))
    -- BULK COLLECT INTO Historico
    -- FROM Zelador Z join Notificacao_Zelador NF
    -- on Z.CPF = NF.Zelador AND Z.CPF = CPF_Pesquisa
    -- join Coco_Pombo CP
    -- on NF.Coco = CP.ID
    -- ORDER BY NF.DataHora DESC;

SELECT * FROM TABLE(Historico_Pesquisador('81282720040'));

    -- SELECT Historico_Zel_Pes_Linha(P.Nome,NP.Coco, TO_CHAR(NP.DataHora, 'DD/MM/YYYY HH24:MI:SS'), TO_CHAR(CP.DataHoraRetirado, 'DD/MM/YYYY HH24:MI:SS'))
    -- BULK COLLECT INTO Historico
    -- FROM Pesquisador P join Notificacao_Pesquisador NP
    -- on P.CPF = NP.Pesquisador AND P.CPF = CPF_Pesquisa
    -- join Coco_Pombo CP
    -- on NP.Coco = CP.ID
    -- ORDER BY NP.DataHora DESC;


--Versao full possui mais joins e é mais custoso, optamos por separar
SELECT * FROM TABLE(Historico_Pesquisador_Full('81282720040'));

    -- SELECT Historico_Pesq_Full_Linha(P.Nome,NP.Coco, R.RiscoIminente,A.Peso,A.Coloracao,A.Laboratorio,
    -- TO_CHAR(NP.DataHora, 'DD/MM/YYYY HH24:MI:SS'),TO_CHAR(CP.DataHoraRetirado, 'DD/MM/YYYY HH24:MI:SS'))
    -- BULK COLLECT INTO Historico
    -- FROM Pesquisador P join Notificacao_Pesquisador NP
    -- on P.CPF = NP.Pesquisador AND P.CPF = CPF_Pesquisa
    -- left join Amostra A
    -- on A.Coco = NP.Coco
    -- left join Relatorio R
    -- on A.Coco = R.Amostra
    -- join Coco_Pombo CP
    -- on NP.Coco = CP.ID
    -- ORDER BY NP.DataHora DESC;

SELECT * FROM TABLE(Historico_Matador('66666666666'));

    -- SELECT Historico_Matador_Linha(MP.Nome, TO_CHAR(NM.DataHora, 'DD/MM/YYYY HH24:MI:SS'))
    -- BULK COLLECT INTO Historico
    -- FROM Matador_Pombos MP join Notificacao_Matador NM
    -- on MP.CPF = NM.Matador AND MP.CPF = CPF_Pesquisa
    -- ORDER BY NM.DataHora DESC;


