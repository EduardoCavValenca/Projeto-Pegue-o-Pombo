'DROPTABLE',TABLE_NAME,'CASCADECONSTRAINTS;'

drop table REGIAO cascade constraints;
drop table BAIRRO cascade constraints;
drop table CENTRAL_POMBOS cascade constraints;
drop table COCO_POMBO cascade constraints;
drop table TIPO_PESSOA cascade constraints;
drop table INFORMANTE cascade constraints;
drop table CELULAR cascade constraints;
drop table INFORMA_COCO cascade constraints;
drop table ZELADOR cascade constraints;
drop table NOTIFICACAO_ZELADOR cascade constraints;
drop table MATADOR_POMBOS cascade constraints;
drop table NOTIFICACAO_MATADOR cascade constraints;
drop table PESQUISADOR cascade constraints;
drop table NOTIFICACAO_PESQUISADOR cascade constraints;
drop table LABORATORIO cascade constraints;
drop table AMOSTRA cascade constraints;
drop table RELATORIO cascade constraints;
drop table SENSOR_DENSIDADE_POMBO cascade constraints;
drop table DADOS_DENSIDADE cascade constraints;


DROP TYPE Historico_Zel_Pes_Linha FORCE;
DROP TYPE Historico_Zel_Pes_Table FORCE;
DROP TYPE Historico_Pesq_Full_Linha FORCE;
DROP TYPE Historico_Pesq_Full_Table FORCE;
DROP TYPE Historico_Matador_Linha FORCE;
DROP TYPE Historico_Matador_Table FORCE;


DROP FUNCTION Historico_Zelador;
DROP FUNCTION Historico_Pesquisador;
DROP FUNCTION Historico_Pesquisador_Full;
DROP FUNCTION Historico_Matador;