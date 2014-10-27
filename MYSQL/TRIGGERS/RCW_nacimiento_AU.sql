DROP TRIGGER IF EXISTS RCW_nacimiento_AU;
delimiter $$
CREATE TRIGGER RCW_nacimiento_AU
AFTER UPDATE ON nacimiento 
FOR EACH ROW
begin
	
	DECLARE NUMEROACTA	decimal(5,0);
	DECLARE ANIOREGISTRO	decimal(4,0);
	DECLARE TIPODOCUMENTO	decimal(1,0);
	DECLARE ENTIDADREGISTRO	decimal(2,0);
	DECLARE O_ENTIDADREGISTRO	decimal(2,0);
	DECLARE MUNICIPIOREGISTRO	decimal(3,0);
	DECLARE O_MUNICIPIOREGISTRO	decimal(3,0);	
	DECLARE OFICIALIA	decimal(4,0);
	DECLARE O_OFICIALIA	decimal(4,0);
	DECLARE ACTABIS	varchar(1);
	DECLARE CADENA	varchar(20);
	DECLARE O_CADENA	varchar(20);
	DECLARE CO_FECHA_REGISTRO	datetime;
	DECLARE CO_LLAVEREGISTROCIVIL	varchar(70);
	DECLARE CO_FOJA	decimal(5,0);
	DECLARE CO_TOMO	decimal(4,0);
	DECLARE CO_LIBRO	decimal(4,0);
	DECLARE OT_NOTASMARGINALES	text;
	DECLARE OT_CRIP	varchar(2000);
	DECLARE OT_VIVOOMUERTO	varchar(1);
	DECLARE PE_PRIMERAPELLIDO	varchar(50);
	DECLARE PE_SEGUNDOAPELLIDO	varchar(50);
	DECLARE PE_NOMBRES	varchar(50);
	DECLARE PE_EDAD	decimal(2,0);
	DECLARE PE_SEXO	varchar(1);
	DECLARE PE_FECHANACIMIENTO	date;
	DECLARE PE_ENTIDADNACIMIENTO	decimal(2,0);
	DECLARE PE_MUNICIPIONACIMIENTO	decimal(3,0);
	DECLARE PE_LOCALIDADNACIMIENTO	varchar(70);
	DECLARE PE_NACIONALIDAD	decimal(3,0);
	DECLARE PE_PAISNACIMIENTO	decimal(3,0);
	DECLARE PE_CURP	varchar(18);
	DECLARE PA_PRIMERAPELLIDO	varchar(50);
	DECLARE PA_SEGUNDOAPELLIDO	varchar(50);
	DECLARE PA_NOMBRES	varchar(50);
	DECLARE PA_EDAD	decimal(2,0);
	DECLARE PA_SEXO	varchar(1);
	DECLARE PA_FECHANACIMIENTO	datetime;
	DECLARE PA_ENTIDADNACIMIENTO	decimal(2,0);
	DECLARE PA_MUNICIPIONACIMIENTO	decimal(3,0);
	DECLARE PA_LOCALIDADNACIMIENTO	varchar(70);
	DECLARE PA_NACIONALIDAD	decimal(3,0);
	DECLARE PA_PAISNACIMIENTO	decimal(3,0);
	DECLARE PA_CURP	varchar(18);
	DECLARE PA_NUMEROACTA	decimal(5,0);
	DECLARE PA_ANIOREGISTRO	decimal(4,0);
	DECLARE PA_TIPODOCUMENTO	decimal(1,0);
	DECLARE PA_ENTIDADREGISTRO	decimal(2,0);
	DECLARE PA_MUNICIPIOREGISTRO	decimal(3,0);
	DECLARE PA_OFICIALIA	decimal(4,0);
	DECLARE PA_ACTABIS	varchar(1);
	DECLARE MA_NUMEROACTA	decimal(5,0);
	DECLARE MA_ANIOREGISTRO	decimal(4,0);
	DECLARE MA_TIPODOCUMENTO	decimal(1,0);
	DECLARE MA_ENTIDADREGISTRO	decimal(2,0);
	DECLARE MA_MUNICIPIOREGISTRO	decimal(3,0);
	DECLARE MA_OFICIALIA	decimal(4,0);
	DECLARE MA_ACTABIS	varchar(1);
	DECLARE MA_PRIMERAPELLIDO	varchar(50);
	DECLARE MA_SEGUNDOAPELLIDO	varchar(50);
	DECLARE MA_NOMBRES	varchar(50);
	DECLARE MA_EDAD	decimal(2,0);
	DECLARE MA_SEXO	varchar(1);
	DECLARE MA_FECHANACIMIENTO	datetime;
	DECLARE MA_ENTIDADNACIMIENTO	decimal(2,0);
	DECLARE MA_MUNICIPIONACIMIENTO	decimal(3,0);
	DECLARE MA_LOCALIDADNACIMIENTO	varchar(70);
	DECLARE MA_NACIONALIDAD	decimal(3,0);
	DECLARE MA_PAISNACIMIENTO	decimal(3,0);
	DECLARE MA_CURP	varchar(18);
	DECLARE OT_CERTIFICADO_NA	varchar(20);
	DECLARE bandera int(11);
	DECLARE CO_TIPO	varchar(1);
	DECLARE CO_FECHAORIGINAL	date;
	DECLARE CO_TRANSCRIPCION	longtext;
	DECLARE CO_SOPORTE	longblob;
	-- variables de nacimiento
	declare txt longtext;
	DECLARE INFORMACION longtext;
	
	DECLARE ID_REGISTRADO bigint(20);
	DECLARE ID_PADRE bigint(20);
	DECLARE ID_MADRE bigint(20);
	DECLARE contador int;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET bandera = 1;			 
	DECLARE CONTINUE HANDLER FOR 1062 SET bandera = 2; -- duplicated primary key	


-- insert into monitor(tipo,mensaje) Values('inicia', concat('empieza PROCESO2, '));

-- insert into monitor(tipo,mensaje) Values('inicia',concat('NOTAS MARGINALES','INICIA PROCESO nm 26'));

if ( coalesce(new.notas,'')!='') then 

  insert into monitor(tipo,mensaje) Values('inicia',concat('NOTAS MARGINALES', new.notas));

  -- se busca primero la nota marginal abierta
  select count(*) into contador from nm_nacimiento
  where id_nacimiento=new.guid
  and tipo=26 ;
  
  if (contador<=0) THEN
     select table_sequence_val+1 into contador from sequence_table where table_sequence_name='NM_NACIMIENTO';
     update sequence_table set table_sequence_val=contador+1 where table_sequence_name='NM_NACIMIENTO'; 
     -- insert into monitor(tipo,mensaje) Values('Inserta',concat('NOTAS MARGINALES',new.notas));
     insert into nm_nacimiento(id,fecha_creacion,fecha_actualizacion,imprimible,tipo,id_nacimiento,informacion)
     Values(contador,current_timestamp, current_timestamp, 1, 26, new.guid, new.notas);
  else
     insert into monitor(tipo,mensaje) Values('Actualiza',concat('NOTAS MARGINALES',new.notas));
     update nm_nacimiento set informacion=new.notas, fecha_actualizacion=current_timestamp
     where id_nacimiento=new.guid and tipo=26;
  end if;
  
  
end if;

-- insert into monitor(tipo,mensaje) Values('Notas marginales',concat('NOTAS MARGINALES','termina PROCESO nm 26'));

set txt = '';
if (new.acta_bis<>old.acta_bis)then
	set txt =txt +'  ACTA BIS actual:' + new.acta_bis +' antes'+ old.acta_bis;
end if;
IF (NEW.MODIFICA<>old.MODIFICA)then
	SET txt=txt + ' FECHA REGISTRO actual:' + cast(new.MODIFICA as char) +' antes' + cast(old.MODIFICA as char);
end if;
IF (NEW.FECHA_REGISTRO<>old.FECHA_REGISTRO)then
	SET txt=txt + ' FECHA REGISTRO actual:' + cast(new.FECHA_REGISTRO as char) +' antes' + cast(old.FECHA_REGISTRO as char);
end if;
if (new.FOJA<>old.FOJA)then
	set txt=txt + ' FOJA actual: ' + new.FOJA +' antes:' + old.FOJA;
end if;
if (new.LIBRO<>old.LIBRO)then
	set txt=txt + ' LIBRO actual: '+ new.LIBRO +' antes:' + old.LIBRO;
end if;
if (new.LLAVE_ORIGINAL<> old.LLAVE_ORIGINAL)then
	set	 txt=txt + ' LLAVE ORIGINAL actual: '+ new.LLAVE_ORIGINAL +' antes:' + old.LLAVE_ORIGINAL;
end if;
if (new.LOCALIDAD_REGISTRO<> old.LOCALIDAD_REGISTRO)then
	set txt=txt + ' LOCALIDAD REGISTRO actual: '+ new.LOCALIDAD_REGISTRO +' antes: '+  old.LOCALIDAD_REGISTRO;
end if;
if (new.NOMBRE_OFICIAL<>old.NOMBRE_OFICIAL)then
	set txt=txt + ' NOMBRE OFICIAL actual: ' + new.NOMBRE_OFICIAL +' antes: ' +  old.NOMBRE_OFICIAL;
end if;
if (new.NUMERO_ACTA<>old.NUMERO_ACTA)then
	set txt=txt + ' NUMERO ACTA actual: ' + new.NUMERO_ACTA +' antes: ' + old.NUMERO_ACTA;
end if;
if (new.TIPO_CAPTURA<>old.TIPO_CAPTURA)then
	set txt=txt + ' TIPO CAPTURA actual: ' + new.TIPO_CAPTURA +' antes: ' + old.TIPO_CAPTURA;
end if;
if (new.TOMO<>old.TOMO)then
	set txt=txt + ' TOMO actual: ' + new.TOMO +' antes: ' + old.TOMO;
end if;
if (new.VALIDADO<>old.VALIDADO)then
	set txt=txt + ' VALIDADO actual: ' + cast(new.VALIDADO as char) + ' antes: ' + cast(old.VALIDADO as char);
end if;
if (new.VERSION<>old.VERSION)then
	set txt=txt + 'VERSION actual; ' + cast(new.VERSION as char) + ' antes: ' + cast(old.VERSION as char);
end if;
if (new.ADOPCION<>old.ADOPCION)then
	set txt=txt + 'ADOPCION actual: ' +  cast(new.ADOPCION as char) + 'antes: ' + cast(old.ADOPCION as char);
end if;
if (new.CLAVE_ESTADISTICA<>old.CLAVE_ESTADISTICA)then
	set txt=txt + 'CLAVE ESTADISTICA actual: ' + cast(new.CLAVE_ESTADISTICA as char) + 'antes: ' + cast(old.CLAVE_ESTADISTICA as char);
end if;
if (new.CON_PROGENITOR_DOS<>old.CON_PROGENITOR_DOS)then
	set txt=txt + 'CON PROGENITOR DOS actual: '+ cast(new.CON_PROGENITOR_DOS as char) + 'antes: '+ cast(old.CON_PROGENITOR_DOS as char);
end if;
if (new.con_progenitor_uno<>old.con_progenitor_uno)then
	set txt=txt + 'CON PROGENITOR UNO actual: ' + cast(new.con_progenitor_uno as char) + 'antes: '+ cast(old.con_progenitor_uno as char);
end if;
if (new.extemporaneo<>old.extemporaneo)then
	set txt=txt + 'EXTEMPORANEO actual: '+ cast(new.extemporaneo as char) + 'antes: ' + cast(old.extemporaneo as char);
end if;
if (new.hora_nac_registrado<>old.hora_nac_registrado)then
	set txt=txt + 'HORA NAC REGISTRADO actual: '+ cast(new.hora_nac_registrado as char) + 'antes: '+ cast(old.hora_nac_registrado as char);
end if;
if (new.llave_historico<>old.llave_historico)then
	set txt=txt + 'LLAVE HISTORICO actual: '+ new.llave_historico + ' antes: '+ old.llave_historico;
end if;
if (new.madre_soltera<>old.madre_soltera)then
	set txt=txt + ' MADRE SOLTERA actual: ' + cast(new.madre_soltera as char) + ' antes: '+ cast(old.madre_soltera as char);
end if;
if (new.nacieron_vivos<>old.nacieron_vivos)then
	set txt=txt + 'NACIERON VIVOS actual: ' + cast(new.nacieron_vivos as char) + ' antes: ' + cast(old.nacieron_vivos as char);
end if;
if (new.nc_estadistica4<>old.nc_estadistica4)then
	set txt=txt + 'NC ESTADISTICA4 actual: '+ new.nc_estadistica4 + ' antes: ' + old.nc_estadistica4;
end if;
if (new.nc_estadistica2<>old.nc_estadistica2)then
	set txt=txt + 'NC ESTADISTICA2 actual: ' + new.nc_estadistica2 + ' antes: ' + old.nc_estadistica2;
end if;
if (new.nc_estadistica3<>old.nc_estadistica3)then
	set txt=txt + 'NC ESTADISTICA3 actual: ' + new.nc_estadistica3 + ' antes: ' + old.nc_estadistica3;
end if;
if (new.nc_estadistica1<>old.nc_estadistica1)then
	set txt=txt + 'NC ESTADISTICA1 actual: '+ new.nc_estadistica1 + ' antes: '+ old.nc_estadistica1;
end if;
if (new.num_parto<>old.num_parto)then
	set txt=txt + 'NUM PARTO actual: ' + cast(new.num_parto as char) + ' antes: ' + cast(old.num_parto as char);
end if;
if (new.restringido<>old.restringido)then
	set txt=txt + 'RESTRINGIDO actual: ' + cast(new.restringido as char) + ' antes: ' + cast(old.restringido as char);
end if;
if (new.sello<>old.sello)then
	set txt=txt + 'SELLO actual: ' + new.sello + ' antes:' + old.sello;
end if;
if (new.tipo_operacion<>old.tipo_operacion)then
	set txt=txt + 'TIPO OPERACION actual: ' +  cast(new.tipo_operacion as char) + ' antes: '+ cast(old.tipo_operacion as char);
end if;
if (new.transcripcion<>old.transcripcion)then
	set txt=txt + 'TRANSCRIPCION actual: ' + new.transcripcion + ' antes: '+ old.transcripcion;
end if;
if (new.vacunado<>old.vacunado)then	
	set txt=txt + ' VACUNADO actual: ' + cast(new.vacunado as char) + ' antes: ' + cast(old.vacunado as char);
end if;
if (new.variable_control_estadistica<>old.variable_control_estadistica)then
	set txt=txt + 'VARIABLE CONTROL ESTADISTICA actual: '+ cast(new.variable_control_estadistica as char) + ' antes: '+ cast(old.variable_control_estadistica as char );
end if;
if (new.viven<>old.viven)then
	set txt=txt + 'VIVEN actual: ' + cast(new.viven as char) + ' antes: '+ cast(old.viven as char);
end if;
if (new.viven_mismo_hogar<>old.viven_mismo_hogar)then
	set txt=txt + 'VIVEN MISMO HOGAR actual:' + cast(new.viven_mismo_hogar as char) + ' antes: ' + cast(old.viven_mismo_hogar as char);
end if;
if (new.registra_vivo_muerto<>old.registra_vivo_muerto)then
	set txt=txt + 'REGISTRA VIVO MUERTO actual: '+ new.registra_vivo_muerto + ' antes: ' + old.registra_vivo_muerto;
end if;
if (new.entidad_registro<>old.entidad_registro)then
	set txt=txt + 'ENTIDAD REGISTRO actual: ' + cast(new.entidad_registro as char) + ' antes: '+ cast(old.entidad_registro as  char);
end if;
if (new.municipio_registro<>old.entidad_registro)then
	set txt=txt + 'MUNICIPIO REGISTRO actual: ' + cast(new.municipio_registro as char) + ' antes: '+ cast(old.municipio_registro as char);
end if;
if (new.oficialia<>old.oficialia)then
	set txt=txt  + 'OFICIALIA actual : '+ cast(new.oficialia as char) + ' antes: ' + cast(old.oficialia as char);
end if;
if (new.tipo_documento<>old.tipo_documento)then	
	set txt=txt + 'TIPO DOCUMENTO actual: ' + cast(new.tipo_documento as char) + ' antes: ' + cast(old.tipo_documento as char);
end if;
if (new.abuela_materna<>old.abuela_materna)then	
	set txt=txt + ' ABUELA MATERNA actual: ' + cast(new.abuela_materna as char) + ' antes: ' + cast(old.abuela_materna as char);
end if;
if (new.abuela_paterna<>old.abuela_paterna)then
	set txt=txt + 'ABUELA PATERNA actual: ' + cast(new.abuela_paterna as char) + ' antes: ' + cast(old.abuela_paterna as char);
end if;
if (new.abuelo_materno<>old.abuelo_materno)then 
	set txt=txt + 'ABUELO MATERNO actual: ' + cast(new.abuelo_materno as char) + ' antes: ' + cast(old.abuelo_materno as char);
end if;
if (new.abuelo_paterno<>old.abuelo_paterno)then
	set txt=txt + 'ABUELO PATERNO actual: ' + cast(new.abuelo_paterno as char) + ' antes: ' + cast(old.abuelo_paterno as char);
end if;
if (new.atendio_parto<>old.atendio_parto)then
	set txt= txt + 'ATENDIO PARTO actual: ' + cast(new.atendio_parto as char) + ' antes: ' + cast(old.atendio_parto as char);
end if;
if (new.comparece<>old.comparece)then
	set txt=txt + 'COMPARECE actual: ' + cast(new.comparece as char) + ' antes: '+  cast(old.comparece as char);
end if;
if (new.con_pro2_menor<>old.con_pro2_menor)then
	set txt=txt + 'CON PRO2 MENOR actual: ' + cast(new.con_pro2_menor as char) + ' antes: ' + cast(old.con_pro2_menor as char);
end if;
if (new.con_pro1_menor<>old.con_pro1_menor)then
	set txt=txt + 'CON PRO1 MENOR actual: ' + cast(new.con_pro1_menor as char) + ' antes: ' + cast(old.con_pro1_menor as char);
end if;
if (new.escolaridad_madre<>old.escolaridad_madre)then
	set txt=txt + 'ESCOLARIDAD MADRE actual: ' + cast(new.escolaridad_madre as char) + ' antes: ' + cast(old.escolaridad_madre as char);
end if;
if (new.escolaridad_padre<>old.escolaridad_padre)then 
	set txt=txt + 'ESCOLARIDAD PADRE actual: ' + cast(new.escolaridad_padre as char) + ' antes: ' + cast(old.escolaridad_padre as char);
end if;
if (new.lugar_atencion_parto<>old.lugar_atencion_parto)then 
	set txt=txt + 'LUGAR ATENCION PARTO actual: ' + cast(new.lugar_atencion_parto as char) + ' antes: ' + cast(old.lugar_atencion_parto as char);
end if;
if (new.madre<>old.madre)then
	set txt=txt + 'MADRE actual: ' + cast(new.madre as char) + ' antes: ' + cast(old.madre as char);
end if;
if (new.padre<>old.padre)then
	set txt=txt + 'PADRE actual: ' + cast(new.padre as char) + ' antes: ' + cast(old.padre as char);
end if;
if (new.pa_per_distinta_presenta<>old.pa_per_distinta_presenta)then
	set txt=txt + 'PA PER DISTINTA PRESENTA actual: ' + cast(new.pa_per_distinta_presenta as char) + ' antes: ' + cast(old.pa_per_distinta_presenta as char);
end if;
if (new.pa_con_progenitor2<>old.pa_con_progenitor2)then
	set txt=txt + 'PA CON PROGENITOR2 actual: ' + cast(new.pa_con_progenitor2 as char) + ' antes: ' + cast(old.pa_con_progenitor2 as char);
end if;
if (new.pa_con_progenitor1<>old.pa_con_progenitor1)then
	set txt=txt + 'PA CON PROGENITOR1 actual: ' + cast(new.pa_con_progenitor1 as char) + ' antes: ' + cast(old.pa_con_progenitor1 as char);
end if;
if (new.persona_distinta_comparece<>old.persona_distinta_comparece)then
	set txt=txt + 'PERSONA DISTINTA COMPARECE actual: ' + cast(new.persona_distinta_comparece as char) + ' antes: ' + cast(old.persona_distinta_comparece as char);
end if;
if (new.posicion_trabajo_madre<>old.posicion_trabajo_madre)then
	set txt=txt + 'POSICION TRABAJO MADRE actual: ' + cast(new.posicion_trabajo_madre as char) + ' antes: ' + cast(old.posicion_trabajo_madre as char);
end if;
if (new.posicion_trabajo_padre<>old.posicion_trabajo_padre)then
	set txt=txt + 'POSICION TRABAJO PADRE actual: ' + cast(new.posicion_trabajo_padre as char) + ' antes: ' + cast(old.posicion_trabajo_padre as char);
end if;
if (new.registrado<>old.registrado)then
	set txt=txt + 'REGISTRADO actual: ' + cast(new.registrado as char) + ' antes: ' + cast(old.registrado as char);
end if;
if (new.sit_lab_madre<>old.sit_lab_madre)then
	set txt=txt + 'SIT LAB MADRE actual: ' + cast(new.sit_lab_madre as char) + ' antes: ' + cast(old.sit_lab_madre as char);
end if;
if (new.sit_lab_padre<>old.sit_lab_padre)then
	set txt=txt + 'SIT LAB PADRE actual: ' + cast(new.sit_lab_padre as char) + ' antes: ' + cast(old.sit_lab_padre as char);
end if;
if (new.testigo_dos<>old.testigo_dos)then
	set txt=txt + 'TESTIGO DOS actual: ' + cast(new.testigo_dos as char) + ' antes: ' + cast(old.testigo_dos as char);
end if;
if (new.testigo_uno<>old.testigo_uno)then	
	set txt=txt + 'TESTIGO UNO actual: ' + cast(new.testigo_uno as char) + ' antes: ' + cast(old.testigo_uno as char);
end if;
if (new.tipo_parto<>old.tipo_parto)then
	set txt=txt + 'TIPO PARTO actual: ' + cast(new.tipo_parto as char) + ' antes: ' +  cast(old.tipo_parto as char);
end if;
if (new.union_madre<>old.union_madre)then
	set txt=txt + 'UNION MADRE actual: ' + cast(new.union_madre as char) + ' antes: ' + cast(old.union_madre as char);
end if;
if (new.descricion_error_validacion<>old.descricion_error_validacion)then
	set txt=txt + 'DESCRIPCION ERROR VALIDACION actual: ' + new.descricion_error_validacion + ' antes: ' + old.descricion_error_validacion;
end if;
if (new.visible<>old.visible)then
	set txt=txt + 'VISIBLE actual: ' + cast(new.visible as char) + ' antes: ' + cast(old.visible as char);
end if;
if (new.causa_baja<>o0ld.causa_baja)then
	set txt=txt + 'CAUSA BAJA actual: ' + cast(new.causa_baja as char) + ' antes: ' + cast(old.causa_baja as char);
end if;
/*
if (new.CAMPAÑA_DIF<>old.CAMPAÑA_DIF)then
	set txt=txt + 'CAMPAÑA DIF actual: ' + cast(new.CAMPAÑA_DIF as char) + ' antes: ' + cast(old.CAMPAÑA_DIF as char);
end if;
*/
if (new.modifica<>old.modifica)then
	set txt=txt + 'MODIFICA actual: ' + cast(new.modifica as char) + ' antes: ' + cast(old.modifica as char);
end if;
/*
if (new.resolucion<>old.resolucion)then
	set txt=txt + ' SE MODIFICA LA RESOLUCION  ';
end if;
if (new.fecha_resolucion<>old.fecha_resolucion)then	
	set txt=txt + 'FECHA RESOLUCION actual: ' + cast(new.fecha_resolucion as char) + ' antes: ' + cast(old.fecha_resolucion as char);
end if;
if (new.autoridad<>old.autoridad)then
	set txt=txt + 'AUTORIDAD actual: ' + new.autoridad + ' antes: ' + old.autoridad;
end if;
*/

insert into bitacora_cambio set
bitacora_cambio.USUARIO= NEW.MODIFICA,
bitacora_cambio.FECHA= now(),
bitacora_cambio.TIPO = 'A',
bitacora_cambio.Tabla = 'NACIMIENTO ',
bitacora_cambio.MOdificacion = txt;


-- insert into monitor(tipo,mensaje) Values(concat('bitacora cambio','termina', cast(new.fecha_borrado as char)));
SET CADENA	= CONCAT(TIPODOCUMENTO,	LPAD(ENTIDADREGISTRO,2,'0'),	LPAD(MUNICIPIOREGISTRO,3,'0'),	LPAD(OFICIALIA,4,'0'),	LPAD(ANIOREGISTRO,4,'0'),	LPAD(NUMEROACTA,5,'0'),ACTABIS);
SET O_CADENA	= CONCAT(TIPODOCUMENTO,	LPAD(O_ENTIDADREGISTRO,2,'0'),	LPAD(O_MUNICIPIOREGISTRO,3,'0'),	LPAD(O_OFICIALIA,4,'0'),	LPAD(ANIOREGISTRO,4,'0'),	LPAD(OLD.numero_Acta,5,'0'),ACTABIS);

-- asignacion de VARIABLES
IF (NEW.FECHA_BORRADO IS NULL)THEN	
	IF( (NEW.VALIDADO = 1) or (new.numero_acta!=old.numero_acta and new.validado>0))THEN
				insert into monitor(tipo,mensaje) Values('Validaciones',concat('Validaciones','inicia'));
				SET NUMEROACTA	= NEW.NUMERO_ACTA;
				SET ANIOREGISTRO	= YEAR(NEW.FECHA_REGISTRO);
				SET TIPODOCUMENTO	= 1;
				SET ENTIDADREGISTRO	= (SELECT cat_e.ID_RENAPO FROM cat_estado cat_e where cat_e.id = NEW.ENTIDAD_REGISTRO);
				SET O_ENTIDADREGISTRO	= (SELECT cat_e.ID_RENAPO FROM cat_estado cat_e where cat_e.id = OLD.ENTIDAD_REGISTRO);
				SET MUNICIPIOREGISTRO	= (SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = NEW.MUNICIPIO_REGISTRO);
				SET O_MUNICIPIOREGISTRO	= (SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = OLD.MUNICIPIO_REGISTRO);

				SET OFICIALIA	= (SELECT cat_of.ID_RENAPO FROM cat_oficialia cat_of WHERE cat_of.id = NEW.OFICIALIA);
				SET O_OFICIALIA	= (SELECT cat_of.ID_RENAPO FROM cat_oficialia cat_of WHERE cat_of.id = OLD.OFICIALIA);
				SET ACTABIS	= COALESCE(NEW.ACTA_BIS,'0');
				SET CADENA	= CONCAT(TIPODOCUMENTO,	LPAD(ENTIDADREGISTRO,2,'0'),	LPAD(MUNICIPIOREGISTRO,3,'0'),	LPAD(OFICIALIA,4,'0'),	LPAD(ANIOREGISTRO,4,'0'),	LPAD(NUMEROACTA,5,'0'),ACTABIS);
				SET O_CADENA	= CONCAT(TIPODOCUMENTO,	LPAD(O_ENTIDADREGISTRO,2,'0'),	LPAD(O_MUNICIPIOREGISTRO,3,'0'),	LPAD(O_OFICIALIA,4,'0'),	LPAD(ANIOREGISTRO,4,'0'),	LPAD(OLD.numero_Acta,5,'0'),ACTABIS);
				SET CO_FECHA_REGISTRO	= NEW.FECHA_REGISTRO;
				SET CO_LLAVEREGISTROCIVIL	= NEW.GUID;
				SET CO_FOJA	= IF(LENGTH(TRIM(NEW.FOJA)) = 0, null,NEW.FOJA);
				SET CO_TOMO	= IF(LENGTH(TRIM(NEW.TOMO)) = 0, null,NEW.TOMO);
				SET CO_LIBRO = IF(LENGTH(TRIM(NEW.LIBRO)) = 0, null,NEW.LIBRO);
				SET OT_VIVOOMUERTO = NEW.REGISTRA_VIVO_MUERTO;
				SET ID_REGISTRADO = NEW.REGISTRADO;
				SET ID_PADRE = NEW.PADRE;
				SET ID_MADRE =NEW.MADRE;
				SET PE_EDAD = null;
				SET PA_TIPODOCUMENTO = 1;
				SET MA_TIPODOCUMENTO = 1;
				SET CO_TIPO	= NEW.TIPO_OPERACION;
				SET CO_FECHAORIGINAL	= NEW.FECHA_REGISTRO;
				SET CO_TRANSCRIPCION	= NEW.TRANSCRIPCION;
				SET CO_SOPORTE	= NEW.IM_ARCHIVO;
				set contador = 0;
				SET OT_NOTASMARGINALES = f_char_notas_nacimiento(NEW.GUID);		
				CASE CO_TIPO 
						WHEN '1' THEN SET CO_TIPO = 'N';
						WHEN '2' THEN SET CO_TIPO = 'I';
						ELSE SET CO_TIPO = 'N';
				END CASE;
				
				
				SELECT per.CRIP, f_char_limpiar(per.PRIMER_APELLIDO), f_char_limpiar(per.SEGUNDO_APELLIDO), f_char_limpiar(per.NOMBRE),per.SEXO,per.FECHA_NACIMIENTO,
							(SELECT cat_ent.ID_RENAPO FROM cat_estado cat_ent WHERE cat_ent.id = per.ENTIDAD) AS entidad,
							(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = per.MUNICIPIO), f_char_limpiar_CE(per.LOCALIDAD),
							(SELECT cat_p.ID FROM cat_pais cat_p WHERE cat_p.id = per.PAIS),	
							per.CURP,per.CERTIFICADO_NACIMIENTO		
						INTO OT_CRIP,PE_PRIMERAPELLIDO,PE_SEGUNDOAPELLIDO,PE_NOMBRES,PE_SEXO,PE_FECHANACIMIENTO,PE_ENTIDADNACIMIENTO,PE_MUNICIPIONACIMIENTO,PE_LOCALIDADNACIMIENTO,PE_NACIONALIDAD,PE_CURP,OT_CERTIFICADO_NA
				FROM persona per 
				WHERE  per.id = ID_REGISTRADO;

				SET PE_PAISNACIMIENTO = PE_NACIONALIDAD;
				-- select datos del ancimiento del padre 
				SELECT per.EDAD, f_char_limpiar(per.PRIMER_APELLIDO), f_char_limpiar(per.SEGUNDO_APELLIDO), f_char_limpiar(per.NOMBRE),per.SEXO,per.FECHA_NACIMIENTO,
							(SELECT cat_ent.ID_RENAPO FROM cat_estado cat_ent WHERE cat_ent.id = per.ENTIDAD) AS entidad,
							(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = per.MUNICIPIO), f_char_limpiar_CE(per.LOCALIDAD),
							(SELECT cat_p.ID FROM cat_pais cat_p WHERE cat_p.id = per.PAIS),	
							per.CURP		
						INTO PA_EDAD,PA_PRIMERAPELLIDO,PA_SEGUNDOAPELLIDO,PA_NOMBRES,PA_SEXO,PA_FECHANACIMIENTO,PA_ENTIDADNACIMIENTO,PA_MUNICIPIONACIMIENTO,PA_LOCALIDADNACIMIENTO,PA_NACIONALIDAD,PA_CURP
				FROM persona per 
				WHERE  per.id = ID_PADRE limit 1;
				SET PA_PAISNACIMIENTO = PA_NACIONALIDAD ;
				
				-- select datos del ancimiento de la madre 
				SELECT per.EDAD, f_char_limpiar(per.PRIMER_APELLIDO), f_char_limpiar(per.SEGUNDO_APELLIDO), f_char_limpiar(per.NOMBRE),per.SEXO,per.FECHA_NACIMIENTO,
							(SELECT cat_ent.ID_RENAPO FROM cat_estado cat_ent WHERE cat_ent.id = per.ENTIDAD) AS entidad,
							(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = per.MUNICIPIO), f_char_limpiar_CE(per.LOCALIDAD),
							(SELECT cat_p.ID FROM cat_pais cat_p WHERE cat_p.id = per.PAIS),	
							per.CURP		
						INTO MA_EDAD,MA_PRIMERAPELLIDO,MA_SEGUNDOAPELLIDO,MA_NOMBRES,MA_SEXO,MA_FECHANACIMIENTO,MA_ENTIDADNACIMIENTO,MA_MUNICIPIONACIMIENTO,MA_LOCALIDADNACIMIENTO,MA_NACIONALIDAD,MA_CURP
				FROM persona per 
				WHERE  per.id = ID_MADRE limit 1;
				SET MA_PAISNACIMIENTO = MA_NACIONALIDAD;
				-- datos de registro de los padres
				-- datos de registrado padre
				
				SELECT nac.NUMERO_ACTA,YEAR(nac.FECHA_REGISTRO),
							(SELECT cat_ent.ID_RENAPO FROM cat_estado cat_ent WHERE cat_ent.id = nac.ENTIDAD_REGISTRO),
							(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = nac.MUNICIPIO_REGISTRO),
							(SELECT cat_of.ID_RENAPO FROM cat_oficialia cat_of WHERE cat_of.id = nac.OFICIALIA),
							nac.ACTA_BIS
						INTO PA_NUMEROACTA,PA_ANIOREGISTRO,PA_ENTIDADREGISTRO,PA_MUNICIPIOREGISTRO,PA_OFICIALIA,PA_ACTABIS
				FROM nacimiento nac
				WHERE nac.REGISTRADO = ID_PADRE limit 1;
				-- datos de la registrada madre
				
				SELECT nac.NUMERO_ACTA,YEAR(nac.FECHA_REGISTRO),
							(SELECT cat_ent.ID_RENAPO FROM cat_estado cat_ent WHERE cat_ent.id = nac.ENTIDAD_REGISTRO),
							(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = nac.MUNICIPIO_REGISTRO),
							(SELECT cat_of.ID_RENAPO FROM cat_oficialia cat_of WHERE cat_of.id = nac.OFICIALIA),
							nac.ACTA_BIS
						INTO MA_NUMEROACTA,MA_ANIOREGISTRO,MA_ENTIDADREGISTRO,MA_MUNICIPIOREGISTRO,MA_OFICIALIA,MA_ACTABIS
				FROM nacimiento nac
				WHERE nac.REGISTRADO = ID_MADRE limit 1;
				
				-- se manda la baja cuando hay un cambio en los datos de la cadena
				if (cadena!=o_cadena) THEN	
					insert into monitor(tipo,mensaje) Values('dato1', concat('baja de nacimiento, ',CADENA,',',O_CADENA,','));

					-- se da de baja la cadena anterior
					INSERT INTO CIRR_TA01_NAPETICION(TA01_E_PRIORIDAD,TA01_E_OPERACIONACTO,TA01_C_CADENA,TA01_E_ESTATUS,TA01_E_CUANTOS) 
																								VALUES(1,2,O_CADENA,0,0);							
				end if;

				-- select datos del registrado

				IF(OT_VIVOOMUERTO  <> 'M')THEN
					SET OT_VIVOOMUERTO = 'V';
				END If;
				IF (LENGTH(OT_NOTASMARGINALES) > 4000 OR LENGTH(TRIM(OT_NOTASMARGINALES)) = 0) THEN
								SET OT_NOTASMARGINALES = null;
					END IF;
				IF(LENGTH(CADENA) <> 20 OR CADENA IS NULL )THEN
					INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'LA CADENA ES INVALIDA',3,1,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
					UPDATE nacimiento n
						SET n.VALIDADO = 3,
								n.DESCRICION_ERROR_VALIDACION = 'LA CADENA ES INVALIDA'
					WHERE n.GUID = CO_LLAVEREGISTROCIVIL;
				ELSEIF (NUMEROACTA IS NULL OR NUMEROACTA < 1) THEN
					INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'NUMERO DE ACTA INVALIDO',3,1,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);	
					UPDATE nacimiento n
						SET n.VALIDADO = 3,
								n.DESCRICION_ERROR_VALIDACION = 'NUMERO DE ACTA INVALIDO'
					WHERE n.GUID = CO_LLAVEREGISTROCIVIL;
				ELSEIF (CO_FECHA_REGISTRO IS NULL OR CO_FECHA_REGISTRO > NOW() OR CO_FECHA_REGISTRO < PE_FECHANACIMIENTO) THEN
					
					-- select datos del registrado

					INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'FECHA DE REGISTRO INVALIDA',3,1,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);		
					UPDATE nacimiento n
						SET n.VALIDADO = 3,
								n.DESCRICION_ERROR_VALIDACION ='FECHA DE REGISTRO INVALIDA'
					WHERE n.GUID = CO_LLAVEREGISTROCIVIL;
				ELSEIF (PE_FECHANACIMIENTO IS NULL OR PE_FECHANACIMIENTO > NOW()) THEN
					INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'FECHA DE NACIMIENTO INVALIDA',3,1,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);	
					UPDATE nacimiento n
						SET n.VALIDADO = 3,
								n.DESCRICION_ERROR_VALIDACION ='FECHA DE NACIMIENTO INVALIDA'
					WHERE n.GUID = CO_LLAVEREGISTROCIVIL;
				ELSEIF (PE_ENTIDADNACIMIENTO IS NULL OR PE_ENTIDADNACIMIENTO < 1) THEN
					INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'ENTIDAD DE NACIMIENTO INVALIDA',3,1,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
					UPDATE nacimiento n
						SET n.VALIDADO = 3,
								n.DESCRICION_ERROR_VALIDACION ='ENTIDAD DE NACIMIENTO INVALIDA'
					WHERE n.GUID = CO_LLAVEREGISTROCIVIL;
				ELSEIF (PE_SEXO IS NULL OR (PE_SEXO != 'M' AND PE_SEXO != 'F')) THEN
					INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'DATO DEL SEXO DEL REGISTRADO INVALIDO',1,1,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
					UPDATE nacimiento n
						SET n.VALIDADO = 3,
								n.DESCRICION_ERROR_VALIDACION ='DATO DEL SEXO DEL REGISTRADO INVALIDO'
					WHERE n.GUID = CO_LLAVEREGISTROCIVIL;
				ELSEIF (OT_VIVOOMUERTO IS NULL ) THEN
					INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'DATO VIVO O MUERTO INVALIDO',3,1,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
					UPDATE nacimiento n
						SET n.VALIDADO = 3,
								n.DESCRICION_ERROR_VALIDACION ='DATO VIVO O MUERTO INVALIDO'
					WHERE n.GUID = CO_LLAVEREGISTROCIVIL;
				ELSE
					set bandera =0;
					set  contador=0;
					insert into monitor(tipo,mensaje) Values('Validaciones termina',concat('llave',new.guid,'. Contador: ', cast(contador as char)));
					select count(*) into contador from nrc_nacimientos where nrc_nacimientos.CO_LLAVEREGISTROCIVIL=new.GUID;
					-- insert into monitor(tipo,mensaje) Values('Validaciones termina',concat('llave',new.guid,'. Contador: ', cast(contador as char)));
					-- insert into monitor(tipo,mensaje) Values('error -1', concat('insertar nacimiento2, ',CADENA, ',',cast(contador as char)));
					IF (  contador<=0 )THEN
					
                     insert into monitor(tipo,mensaje) Values('dato1', concat('inserta cadena, ',CADENA,',',O_CADENA,',  old ',cast(old.validado as char),',  new ',cast(new.validado as char)));
					INSERT INTO nrc_nacimientos(NUMEROACTA,ANIOREGISTRO,TIPODOCUMENTO,ENTIDADREGISTRO,MUNICIPIOREGISTRO,OFICIALIA,ACTABIS,CADENA,CO_FECHA_REGISTRO,CO_LLAVEREGISTROCIVIL,CO_FOJA,CO_TOMO,CO_LIBRO,OT_NOTASMARGINALES,OT_CRIP,OT_VIVOOMUERTO,PE_PRIMERAPELLIDO,PE_SEGUNDOAPELLIDO,PE_NOMBRES,PE_EDAD,PE_SEXO,PE_FECHANACIMIENTO,PE_ENTIDADNACIMIENTO,PE_MUNICIPIONACIMIENTO,PE_LOCALIDADNACIMIENTO,PE_NACIONALIDAD,PE_PAISNACIMIENTO,PE_CURP,PA_PRIMERAPELLIDO,PA_SEGUNDOAPELLIDO,PA_NOMBRES,PA_EDAD,PA_SEXO,PA_FECHANACIMIENTO,PA_ENTIDADNACIMIENTO,PA_MUNICIPIONACIMIENTO,PA_LOCALIDADNACIMIENTO,PA_NACIONALIDAD,PA_PAISNACIMIENTO,PA_CURP,PA_NUMEROACTA,PA_ANIOREGISTRO,PA_TIPODOCUMENTO,PA_ENTIDADREGISTRO,PA_MUNICIPIOREGISTRO,PA_OFICIALIA,PA_ACTABIS,MA_NUMEROACTA,MA_ANIOREGISTRO,MA_TIPODOCUMENTO,MA_ENTIDADREGISTRO,MA_MUNICIPIOREGISTRO,MA_OFICIALIA,MA_ACTABIS,MA_PRIMERAPELLIDO,MA_SEGUNDOAPELLIDO,MA_NOMBRES,MA_EDAD,MA_SEXO,MA_FECHANACIMIENTO,MA_ENTIDADNACIMIENTO,MA_MUNICIPIONACIMIENTO,MA_LOCALIDADNACIMIENTO,MA_NACIONALIDAD,MA_PAISNACIMIENTO,MA_CURP,OT_CERTIFICADO_NA,CO_TIPO,CO_FECHAORIGINAL,CO_TRANSCRIPCION,CO_SOPORTE) 
															 VALUES(NUMEROACTA,ANIOREGISTRO,TIPODOCUMENTO,ENTIDADREGISTRO,MUNICIPIOREGISTRO,OFICIALIA,ACTABIS,CADENA,CO_FECHA_REGISTRO,CO_LLAVEREGISTROCIVIL,CO_FOJA,CO_TOMO,CO_LIBRO,OT_NOTASMARGINALES,OT_CRIP,OT_VIVOOMUERTO,PE_PRIMERAPELLIDO,PE_SEGUNDOAPELLIDO,PE_NOMBRES,PE_EDAD,PE_SEXO,PE_FECHANACIMIENTO,PE_ENTIDADNACIMIENTO,PE_MUNICIPIONACIMIENTO,PE_LOCALIDADNACIMIENTO,PE_NACIONALIDAD,PE_PAISNACIMIENTO,PE_CURP,PA_PRIMERAPELLIDO,PA_SEGUNDOAPELLIDO,PA_NOMBRES,PA_EDAD,PA_SEXO,PA_FECHANACIMIENTO,PA_ENTIDADNACIMIENTO,PA_MUNICIPIONACIMIENTO,PA_LOCALIDADNACIMIENTO,PA_NACIONALIDAD,PA_PAISNACIMIENTO,PA_CURP,PA_NUMEROACTA,PA_ANIOREGISTRO,PA_TIPODOCUMENTO,PA_ENTIDADREGISTRO,PA_MUNICIPIOREGISTRO,PA_OFICIALIA,PA_ACTABIS,MA_NUMEROACTA,MA_ANIOREGISTRO,MA_TIPODOCUMENTO,MA_ENTIDADREGISTRO,MA_MUNICIPIOREGISTRO,MA_OFICIALIA,MA_ACTABIS,MA_PRIMERAPELLIDO,MA_SEGUNDOAPELLIDO,MA_NOMBRES,MA_EDAD,MA_SEXO,MA_FECHANACIMIENTO,MA_ENTIDADNACIMIENTO,MA_MUNICIPIONACIMIENTO,MA_LOCALIDADNACIMIENTO,MA_NACIONALIDAD,MA_PAISNACIMIENTO,MA_CURP,OT_CERTIFICADO_NA,CO_TIPO,CO_FECHAORIGINAL,CO_TRANSCRIPCION,CO_SOPORTE);
							IF (bandera = 1 ) THEN									
									INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																					VALUES(CADENA,NOW(),'ERROR DESCONOCIDO',3,1,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);	
								UPDATE nacimiento n
									SET n.VALIDADO = 3,
											n.DESCRICION_ERROR_VALIDACION ='ERROR DESCONOCIDO'
								WHERE n.GUID = CO_LLAVEREGISTROCIVIL;
								SET bandera = 0;
							ELSEIF (bandera = 2 ) THEN
						
									INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'CADENA DUPLICADA',3,1,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);	
									UPDATE nacimiento n
										SET n.VALIDADO = 3,
												n.DESCRICION_ERROR_VALIDACION ='CADENA DUPLICADA'
									WHERE n.GUID = CO_LLAVEREGISTROCIVIL;
									SET bandera = 0;
							ELSE		
									-- insert into monitor(tipo,mensaje) Values('error', 'insertar nacimiento');
									INSERT INTO CIRR_TA01_NAPETICION(TA01_E_PRIORIDAD,TA01_E_OPERACIONACTO,TA01_C_CADENA,TA01_E_ESTATUS,TA01_E_CUANTOS) 
																								VALUES(1,1,CADENA,0,0);
									
									-- insert into monitor(tipo,mensaje) Values('error2', 'insertar nacimiento');
									SET bandera = 0;
							END IF; -- if banderas
					ELSE
					set bandera=0;
					insert into monitor(tipo,mensaje) Values('dato1', concat('actualiza cadena, ',CADENA,',',O_CADENA,',  old ',cast(old.validado as char),',  new ',cast(new.validado as char)));
					UPDATE nrc_nacimientos	SET NUMEROACTA = NUMEROACTA,ANIOREGISTRO = ANIOREGISTRO,TIPODOCUMENTO = TIPODOCUMENTO,ENTIDADREGISTRO = ENTIDADREGISTRO,MUNICIPIOREGISTRO = MUNICIPIOREGISTRO,OFICIALIA = OFICIALIA,ACTABIS = ACTABIS,CO_FECHA_REGISTRO = CO_FECHA_REGISTRO,/*CO_LLAVEREGISTROCIVIL = CO_LLAVEREGISTROCIVIL,*/ CO_FOJA = CO_FOJA,CO_TOMO = CO_TOMO,CO_LIBRO = CO_LIBRO,OT_NOTASMARGINALES = OT_NOTASMARGINALES,OT_CRIP = OT_CRIP,OT_VIVOOMUERTO = OT_VIVOOMUERTO,PE_PRIMERAPELLIDO = PE_PRIMERAPELLIDO,PE_SEGUNDOAPELLIDO = PE_SEGUNDOAPELLIDO,PE_NOMBRES = PE_NOMBRES,PE_EDAD = PE_EDAD,PE_SEXO = PE_SEXO,PE_FECHANACIMIENTO = PE_FECHANACIMIENTO,PE_ENTIDADNACIMIENTO = PE_ENTIDADNACIMIENTO,PE_MUNICIPIONACIMIENTO = PE_MUNICIPIONACIMIENTO,PE_LOCALIDADNACIMIENTO = PE_LOCALIDADNACIMIENTO,PE_NACIONALIDAD = PE_NACIONALIDAD,PE_PAISNACIMIENTO = PE_PAISNACIMIENTO,PE_CURP = PE_CURP,PA_PRIMERAPELLIDO = PA_PRIMERAPELLIDO,PA_SEGUNDOAPELLIDO = PA_SEGUNDOAPELLIDO,PA_NOMBRES = PA_NOMBRES,PA_EDAD = PA_EDAD,PA_SEXO = PA_SEXO,PA_FECHANACIMIENTO = PA_FECHANACIMIENTO,PA_ENTIDADNACIMIENTO = PA_ENTIDADNACIMIENTO,PA_MUNICIPIONACIMIENTO = PA_MUNICIPIONACIMIENTO,PA_LOCALIDADNACIMIENTO = PA_LOCALIDADNACIMIENTO,PA_NACIONALIDAD = PA_NACIONALIDAD,PA_PAISNACIMIENTO = PA_PAISNACIMIENTO,PA_CURP = PA_CURP,PA_NUMEROACTA = PA_NUMEROACTA,PA_ANIOREGISTRO = PA_ANIOREGISTRO,PA_TIPODOCUMENTO = PA_TIPODOCUMENTO,PA_ENTIDADREGISTRO = PA_ENTIDADREGISTRO,PA_MUNICIPIOREGISTRO = PA_MUNICIPIOREGISTRO,PA_OFICIALIA = PA_OFICIALIA,PA_ACTABIS = PA_ACTABIS,MA_NUMEROACTA = MA_NUMEROACTA,MA_ANIOREGISTRO = MA_ANIOREGISTRO,MA_TIPODOCUMENTO = MA_TIPODOCUMENTO,MA_ENTIDADREGISTRO = MA_ENTIDADREGISTRO,MA_MUNICIPIOREGISTRO = MA_MUNICIPIOREGISTRO,MA_OFICIALIA = MA_OFICIALIA,MA_ACTABIS = MA_ACTABIS,MA_PRIMERAPELLIDO = MA_PRIMERAPELLIDO,MA_SEGUNDOAPELLIDO = MA_SEGUNDOAPELLIDO,MA_NOMBRES = MA_NOMBRES,MA_EDAD = MA_EDAD,MA_SEXO = MA_SEXO,MA_FECHANACIMIENTO = MA_FECHANACIMIENTO,MA_ENTIDADNACIMIENTO = MA_ENTIDADNACIMIENTO,MA_MUNICIPIONACIMIENTO = MA_MUNICIPIONACIMIENTO,MA_LOCALIDADNACIMIENTO = MA_LOCALIDADNACIMIENTO,MA_NACIONALIDAD = MA_NACIONALIDAD,MA_PAISNACIMIENTO = MA_PAISNACIMIENTO,MA_CURP = MA_CURP,OT_CERTIFICADO_NA = OT_CERTIFICADO_NA,CO_TIPO = CO_TIPO,CO_FECHAORIGINAL = CO_FECHAORIGINAL,CO_TRANSCRIPCION = CO_TRANSCRIPCION,CO_SOPORTE = CO_SOPORTE, CADENA=CADENA WHERE nrc_nacimientos.CO_LLAVEREGISTROCIVIL = CO_LLAVEREGISTROCIVIL;
						
							IF (bandera = 1 ) THEN
									insert into monitor(tipo,mensaje) Values('error 13', concat('actualizar nacimiento, ',',',cast(contador as char),',',cast(bandera as char)));
					
									INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																					VALUES(CADENA,NOW(),'ERROR DESCONOCIDO',3,1,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
									UPDATE nacimiento n
										SET n.VALIDADO = 3,
												n.DESCRICION_ERROR_VALIDACION ='ERROR DESCONOCIDO'
									WHERE n.GUID = CO_LLAVEREGISTROCIVIL;
									SET bandera = 0;
							ELSEIF (bandera = 2 ) THEN
									insert into monitor(tipo,mensaje) Values('error 14', concat('actualizar nacimiento, ',',',cast(contador as char),',',cast(bandera as char)));
					
									INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																					VALUES(CADENA,NOW(),'CADENA DUPLICADA',3,1,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
									UPDATE nacimiento n
										SET n.VALIDADO = 3,
												n.DESCRICION_ERROR_VALIDACION ='CADENA DUPLICADA'
									WHERE n.GUID = CO_LLAVEREGISTROCIVIL;
									SET bandera = 0;
							ELSE	
									
									-- insert into monitor(tipo,mensaje) Values('error15', 'actualizar nacimiento');
									if (cadena=o_cadena) then
											INSERT INTO CIRR_TA01_NAPETICION(TA01_E_PRIORIDAD,TA01_E_OPERACIONACTO,TA01_C_CADENA,TA01_E_ESTATUS,TA01_E_CUANTOS) 
																					VALUES(1,3,CADENA,0,0);									
									ELSE
											INSERT INTO CIRR_TA01_NAPETICION(TA01_E_PRIORIDAD,TA01_E_OPERACIONACTO,TA01_C_CADENA,TA01_E_ESTATUS,TA01_E_CUANTOS) 
																					VALUES(1,1,CADENA,0,0);									
									end if;
									
									-- insert into monitor(tipo,mensaje) Values('error16', 'actualizar nacimiento');
									SET bandera = 0;
							END IF; -- if banderas

					END IF;
					
				END IF;
		END IF;	
	ELSE
		SET BANDERA=0;
				INSERT INTO CIRR_TA01_NAPETICION(TA01_E_PRIORIDAD,TA01_E_OPERACIONACTO,TA01_C_CADENA,TA01_E_ESTATUS,TA01_E_CUANTOS) 
				VALUES(1,2,NEW.CADENA,0,0);
		if(bandera=0) then

				insert into bitacora_cambio set
				bitacora_cambio.USUARIO= NEW.MODIFICA,
				bitacora_cambio.FECHA= now(),
				bitacora_cambio.TIPO = 'B',
				bitacora_cambio.Tabla = 'NACIMIENTO',
				bitacora_cambio.MOdificacion = txt;
			end if;
	END IF;
END