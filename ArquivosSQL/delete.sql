-- SELECT 'DROP TABLE ', TABLE_NAME, 'CASCADE CONSTRAINTS;' from USER_TABLES;
-- SELECT 'DROP FUNCTION' ,OBJECT_NAME,';' FROM USER_PROCEDURES WHERE OBJECT_TYPE= 'FUNCTION';
-- SELECT 'DROP TRIGGER' ,OBJECT_NAME,';' FROM USER_PROCEDURES WHERE OBJECT_TYPE= 'TRIGGER';

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
DROP TYPE Densidade_Regiao_Linha FORCE;
DROP TYPE Densidade_Regiao_Table FORCE;



DROP FUNCTION DENSIDADE_REGIAO;
	
DROP FUNCTION HISTORICO_MATADOR;
	
DROP FUNCTION HISTORICO_PESQUISADOR;
	
DROP FUNCTION HISTORICO_PESQUISADOR_FULL;
	
DROP FUNCTION HISTORICO_ZELADOR;


