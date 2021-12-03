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

















