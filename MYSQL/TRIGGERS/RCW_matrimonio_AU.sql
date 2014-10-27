DROP TRIGGER IF EXISTS RCW_matrimonio_AU;
delimiter $$
CREATE  TRIGGER RCW_matrimonio_AU 
AFTER UPDATE ON matrimonio
FOR EACH ROW
BEGIN 
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
		DECLARE CO_FECHA_REGISTRO	date;
		DECLARE CO_LLAVEREGISTROCIVIL	varchar(70);
		DECLARE CO_FOJA	decimal(5,0);
		DECLARE CO_TOMO	decimal(3,0);
		DECLARE CO_LIBRO	decimal(4,0);
		DECLARE OT_CRIP_P1	varchar(15);
		DECLARE OT_CRIP_P2	varchar(15);
		DECLARE IM_NOMBREORIGINALIMAGEN	varchar(250);
		DECLARE IM_ARCHIVO	longblob;
		DECLARE OT_NOTASMARGINALES	text;
		DECLARE OT_REGISTROPATRIMONIAL	decimal(1,0);
		DECLARE P1_NOMBRES	varchar(60);
		DECLARE P1_PRIMERAPELLIDO	varchar(60);
		DECLARE P1_SEGUNDOAPELLIDO	varchar(60);
		DECLARE P1_FECHANACIMIENTO	date;
		DECLARE P1_SEXO	varchar(1);
		DECLARE P1_EDAD	decimal(2,0);
		DECLARE P1_NACIONALIDAD	decimal(3,0);
		DECLARE P1_PAISNACIMIENTO	decimal(3,0);
		DECLARE P1_ENTIDADNACIMIENTO	decimal(2,0);
		DECLARE P1_MUNICIPIONACIMIENTO	decimal(3,0);
		DECLARE P1_LOCALIDADNACIMIENTO	varchar(120);
		DECLARE P1_NUMEROACTA	decimal(5,0);
		DECLARE P1_ANIOREGISTRO	decimal(4,0);
		DECLARE P1_TIPODOCUMENTO	decimal(1,0);
		DECLARE P1_ENTIDADREGISTRO	decimal(2,0);
		DECLARE P1_MUNICIPIOREGISTRO	decimal(3,0);
		DECLARE P1_OFICIALIA	decimal(4,0);
		DECLARE P1_ACTABIS	varchar(1);
		DECLARE P1_CURP	varchar(18);
		DECLARE P1_CADENA	varchar(20);
		DECLARE P2_NOMBRES	varchar(60);
		DECLARE P2_PRIMERAPELLIDO	varchar(60);
		DECLARE P2_SEGUNDOAPELLIDO	varchar(60);
		DECLARE P2_FECHANACIMIENTO	date;
		DECLARE P2_SEXO	varchar(1);
		DECLARE P2_EDAD	decimal(2,0);
		DECLARE P2_NACIONALIDAD	decimal(3,0);
		DECLARE P2_PAISNACIMIENTO	decimal(3,0);
		DECLARE P2_ENTIDADNACIMIENTO	decimal(2,0);
		DECLARE P2_MUNICIPIONACIMIENTO	decimal(3,0);
		DECLARE P2_LOCALIDADNACIMIENTO	varchar(120);
		DECLARE P2_NUMEROACTA	decimal(5,0);
		DECLARE P2_ANIOREGISTRO	decimal(4,0);
		DECLARE P2_TIPODOCUMENTO	decimal(1,0);
		DECLARE P2_ENTIDADREGISTRO	decimal(2,0);
		DECLARE P2_MUNICIPIOREGISTRO	decimal(3,0);
		DECLARE P2_OFICIALIA	decimal(4,0);
		DECLARE P2_ACTABIS	varchar(1);
		DECLARE P2_CURP	varchar(18);
		DECLARE P2_CADENA	varchar(20);
		DECLARE P1_PA_NOMBRES	varchar(50);
		DECLARE P1_PA_PRIMERAPELLIDO	varchar(50);
		DECLARE P1_PA_SEGUNDOAPELLIDO	varchar(50);
		DECLARE P1_PA_NUMEROACTA	decimal(5,0);
		DECLARE P1_PA_ANIOREGISTRO	decimal(4,0);
		DECLARE P1_PA_TIPODOCUMENTO	decimal(1,0);
		DECLARE P1_PA_ENTIDADREGISTRO	decimal(2,0);
		DECLARE P1_PA_MUNICIPIOREGISTRO	decimal(3,0);
		DECLARE P1_PA_OFICIALIA	decimal(4,0);
		DECLARE P1_PA_ACTABIS	varchar(1);
		DECLARE P1_PA_CURP	varchar(18);
		DECLARE P1_PA_NACIONALIDAD	decimal(3,0);
		DECLARE P1_PA_CADENA	varchar(20);
		DECLARE P1_MA_NOMBRES	varchar(50);
		DECLARE P1_MA_PRIMERAPELLIDO	varchar(50);
		DECLARE P1_MA_SEGUNDOAPELLIDO	varchar(50);
		DECLARE P1_MA_NUMEROACTA	decimal(5,0);
		DECLARE P1_MA_ANIOREGISTRO	decimal(4,0);
		DECLARE P1_MA_TIPODOCUMENTO	decimal(1,0);
		DECLARE P1_MA_ENTIDADREGISTRO	decimal(2,0);
		DECLARE P1_MA_MUNICIPIOREGISTRO	decimal(3,0);
		DECLARE P1_MA_OFICIALIA	decimal(4,0);
		DECLARE P1_MA_ACTABIS	varchar(1);
		DECLARE P1_MA_CURP	varchar(18);
		DECLARE P1_MA_NACIONALIDAD	decimal(3,0);
		DECLARE P1_MA_CADENA	varchar(20);
		DECLARE P2_PA_NOMBRES	varchar(50);
		DECLARE P2_PA_PRIMERAPELLIDO	varchar(50);
		DECLARE P2_PA_SEGUNDOAPELLIDO	varchar(50);
		DECLARE P2_PA_NUMEROACTA	decimal(5,0);
		DECLARE P2_PA_ANIOREGISTRO	decimal(4,0);
		DECLARE P2_PA_TIPODOCUMENTO	decimal(1,0);
		DECLARE P2_PA_ENTIDADREGISTRO	decimal(2,0);
		DECLARE P2_PA_MUNICIPIOREGISTRO	decimal(3,0);
		DECLARE P2_PA_OFICIALIA	decimal(4,0);
		DECLARE P2_PA_ACTABIS	varchar(1);
		DECLARE P2_PA_CURP	varchar(18);
		DECLARE P2_PA_NACIONALIDAD	decimal(3,0);
		DECLARE P2_PA_CADENA	varchar(20);
		DECLARE P2_MA_NOMBRES	varchar(50);
		DECLARE P2_MA_PRIMERAPELLIDO	varchar(50);
		DECLARE P2_MA_SEGUNDOAPELLIDO	varchar(50);
		DECLARE P2_MA_NUMEROACTA	decimal(5,0);
		DECLARE P2_MA_ANIOREGISTRO	decimal(4,0);
		DECLARE P2_MA_TIPODOCUMENTO	decimal(1,0);
		DECLARE P2_MA_ENTIDADREGISTRO	decimal(2,0);
		DECLARE P2_MA_MUNICIPIOREGISTRO	decimal(3,0);
		DECLARE P2_MA_OFICIALIA	decimal(4,0);
		DECLARE P2_MA_ACTABIS	varchar(1);
		DECLARE P2_MA_CURP	varchar(18);
		DECLARE P2_MA_NACIONALIDAD	decimal(3,0);
		DECLARE P2_MA_CADENA	varchar(20);
		DECLARE P1_PA_SEXO	varchar(1);
		DECLARE P1_MA_SEXO	varchar(1);
		DECLARE P2_PA_SEXO	varchar(1);
		DECLARE P2_MA_SEXO	varchar(1);
		DECLARE CO_TIPO	varchar(1);
		DECLARE CO_FECHAORIGINAL	date;
		DECLARE CO_TRANSCRIPCION	longtext;
		DECLARE CO_SOPORTE	longblob;
		DECLARE bandera int(11);
		declare contador int;
		DECLARE ID_EL bigint(20);
		DECLARE ID_ELLA bigint(20);
		DECLARE ID_PADRE_EL bigint(20);
		DECLARE ID_PADRE_ELLA bigint(20);
		DECLARE ID_MADRE_EL bigint(20);
		DECLARE ID_MADRE_ELLA bigint(20);
		declare txt longtext;
		DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET bandera = 1;			 
		DECLARE CONTINUE HANDLER FOR 1062 SET bandera = 2; -- duplicated primary key
		
-- insert into monitor(tipo,mensaje) Values('Inicia', concat('proceso de matrimonio, ', new.NOTAS));
if ( trim(coalesce(new.notas,''))<>'') then
  
  -- se busca primero la nota marginal abierta
  select count(*) into contador from nm_matrimonio
  where ID_MATRIMONIO=new.guid and tipo =26;
  
  -- insert into monitor(tipo,mensaje) Values('Inicia', concat('inserta matrimonio nota marginal, '));
  if (contador<=0) THEN
	 select table_sequence_val +1 into contador from sequence_table where table_sequence_name='NM_MATRIMONIO';
     update sequence_table set table_sequence_val=contador+1 where table_sequence_name='NM_MATRIMONIO'; 
     insert into nm_matrimonio(id,fecha_creacion,fecha_actualizacion,imprimible,tipo,id_matrimonio,informacion)
     Values(contador,current_timestamp, current_timestamp, 1, 26, new.guid, new.notas);
  else
     update nm_matrimonio set informacion=new.notas, fecha_actualizacion=current_timestamp
     where ID_MATRIMONIO=new.guid and tipo=26;
  end if;  
  
end if;

	set bandera=0;
		set txt = '';
		if (new.acta_bis<>old.acta_bis)then
			set txt =concat(txt ,'  ACTA BIS actual:' , new.acta_bis ,' antes', old.acta_bis);
		end if;
		IF (NEW.FECHA_REGISTRO<>old.FECHA_REGISTRO)then
			set txt =concat(txt , ' FECHA REGISTRO actual:' , cast(new.FECHA_REGISTRO as char) ,' antes' , cast(old.FECHA_REGISTRO as char));
		end if;
		if (new.FOJA<>old.FOJA)then
			set txt =concat(txt , ' FOJA actual: ' , new.FOJA ,' antes:' , old.FOJA);
		end if;
		if (new.LIBRO<>old.LIBRO)then
			set txt =concat(txt , ' LIBRO actual: ', new.LIBRO ,' antes:' , old.LIBRO);
		end if;
		if (new.LLAVE_ORIGINAL<> old.LLAVE_ORIGINAL)then
			set txt =concat(txtt , ' LLAVE ORIGINAL actual: ', new.LLAVE_ORIGINAL ,' antes:' , old.LLAVE_ORIGINAL);
		end if;
		if (new.LOCALIDAD_REGISTRO<> old.LOCALIDAD_REGISTRO)then
			set txt =concat(txt , ' LOCALIDAD REGISTRO actual: ', new.LOCALIDAD_REGISTRO ,' antes: ',  old.LOCALIDAD_REGISTRO);
		end if;
		if (new.NOMBRE_OFICIAL<>old.NOMBRE_OFICIAL)then
			set txt =concat(txt , ' NOMBRE OFICIAL actual: ' , new.NOMBRE_OFICIAL ,' antes: ' ,  old.NOMBRE_OFICIAL);
		end if;
		if (new.NUMERO_ACTA<>old.NUMERO_ACTA)then
			set txt =concat(txt , ' NUMERO ACTA actual: ' , new.NUMERO_ACTA ,' antes: ' , old.NUMERO_ACTA);
		end if;
		if (new.TIPO_CAPTURA<>old.TIPO_CAPTURA)then
			set txt =concat(txt , ' TIPO CAPTURA actual: ' , new.TIPO_CAPTURA ,' antes: ' , old.TIPO_CAPTURA);
		end if;
		if (new.TOMO<>old.TOMO)then
			set txt =concat(txt , ' TOMO actual: ' , new.TOMO ,' antes: ' , old.TOMO);
		end if;
		if (new.VALIDADO<>old.VALIDADO)then
			set txt =concat(txt , ' VALIDADO actual: ' , cast(new.VALIDADO as char) , ' antes: ' , cast(old.VALIDADO as char));
		end if;
		if (new.VERSION<>old.VERSION)then
			set txt =concat(txt , 'VERSION actual); ' , cast(new.VERSION as char) , ' antes: ' , cast(old.VERSION as char));
		end if;
		if (new.autorizacion_dgrc<>old.autorizacion_dgrc)then
			set txt =concat(txt ,  'AUTORIZACION DGRC actual: ' , new.autorizacion_dgrc , ' antes: ' , old.autorizacion_dgrc);
		end if;
		if (new.con_contrayente_dos<>old.con_contrayente_dos)then
			set txt =concat(txt , 'CON CONTRAYENTE DOS actual: ' , cast(new.con_contrayente_dos as char) , ' antes: ' , cast(old.con_contrayente_dos as char));
		end if;
		if (new.con_contrayente_uno<>old.con_contrayente_uno)then
			set txt =concat(txt , 'CON CONTRAYENTE UNO actual: ' , cast(new.con_contrayente_uno as char) , ' antes: ' , cast(old.con_contrayente_uno as char));
		end if;
		if (new.im_archivo<>old.im_archivo)then
			set txt =concat(txt , 'IM ARCHIVO actual: ' , new.im_archivo , ' antes: ' , old.im_archivo);
		end if;
		if (new.im_nombre<>old.im_nombre)then
			set txt =concat(txt , 'IM NOMBRE actual: ' , new.im_nombre , ' antes: ' , old.new.im_nombre);
		end if;
		if (new.ocupacion_contrayente_dos<>old.ocupacion_contrayente_dos)then
			set txt =concat(txt , 'OCUPACION CONTRAYENTE DOS actual: ' , new.ocupacion_contrayente_dos , ' antes: ' , old.ocupacion_contrayente_dos);
		end if;
		if (new.ocupacion_contrayente_uno<>old.ocupacion_contrayente_uno)then
			set txt =concat(txt , 'OCUPACION CONTRAYENTE UNO actual: ' , new.ocupacion_contrayente_uno , ' antes: ' , old.ocupacion_contrayente_uno);
		end if;
		if (new.ocupacion_madre_dos<>old.ocupacion_madre_dos)then
			set txt =concat(txt , 'OCUPACION MADRE DOS actual: ' , new.ocupacion_madre_dos , ' antes: ' , old.ocupacion_madre_dos);
		end if;
		if (new.ocupacion_madre_uno<>old.ocupacion_madre_uno)then
			set txt =concat(txt , 'OCUPACION MADRE UNO actual: ' , new.ocupacion_madre_uno , ' antes: ' , old.ocupacion_madre_uno);
		end if;
		if (new.ocupacion_padre_dos<>old.ocupacion_padre_dos)then
			set txt =concat(txt , 'OCUPACION PADRE DOS actual: ' , new.ocupacion_padre_dos , ' antes: ' , old.ocupacion_padre_dos);
		end if;
		if (new.ocupacion_padre_uno<>old.ocupacion_padre_uno)then
			set txt =concat(txt , 'OCUPACION PADRE UNO actual: ' , new.ocupacion_padre_uno , ' antes: ' , old.ocupacion_padre_uno);
		end if;
		if (new.ocupacion_test_cuatro<>old.ocupacion_test_cuatro)then
			set txt =concat(txt , 'OCUPACION TEST CUATRO actual: ' , new.ocupacion_test_cuatro , ' antes: ' , old.ocupacion_test_cuatro);
		end if;
		if (new.ocupacion_test_dos<>old.ocupacion_test_dos)then
			set txt =concat(txt , 'OCUPACION TEST DOS actual: ' , new.ocupacion_test_dos , ' antes: ' , old.ocupacion_test_dos);
		end if;
		if (new.ocupacion_test_tres<>old.ocupacion_test_tres)then
			set txt =concat(txt , 'OCUPACION TEST TRES actual: ' , new.ocupacion_test_tres , ' antes: ' , old.ocupacion_test_tres);
		end if;
		if (new.ocupacion_test_uno<>old.ocupacion_test_uno)then
			set txt =concat(txt , 'OCUPACION TEST UNO actual: ' , new.ocupacion_test_uno , ' antes: ' , old.ocupacion_test_uno);
		end if;
		if (new.sello<>old.sello)then
			set txt =concat(txt , 'SELLO actual: ' , new.sello , ' antes:' , old.sello);
		end if;
		if (new.sello_img<>old.sello_img)then
			set txt =concat(txt , 'SELLO IMG actual: ' , new.sello_img , ' antes: ', old.sello_img);
		end if;
		if (new.tipo_operacion<>old.tipo_operacion)then
			set txt =concat(txt , 'TIPO OPERACION actual: ' ,  cast(new.tipo_operacion as char) , ' antes: ', cast(old.tipo_operacion as char));
		end if;
		if (new.transcripcion<>old.transcripcion)then
			set txt =concat(txt , 'TRANSCRIPCION actual: ' , new.transcripcion , ' antes: ', old.transcripcion);
		end if;
		if (new.entidad_registro<>old.entidad_registro)then
			set txt =concat(txt , 'ENTIDAD REGISTRO actual: ' , cast(new.entidad_registro as char) , ' antes: ', cast(old.entidad_registro as  char));
		end if;
		if (new.municipio_registro<>old.entidad_registro)then
			set txt =concat(txt , 'MUNICIPIO REGISTRO actual: ' , cast(new.municipio_registro as char) , ' antes: ', cast(old.municipio_registro as char));
		end if;
		if (new.oficialia<>old.oficialia)then
			set txt =concat(txt  , 'OFICIALIA actual : ', cast(new.oficialia as char) , ' antes: ' , cast(old.oficialia as char));
		end if;
		if (new.tipo_documento<>old.tipo_documento)then	
			set txt =concat(txt , 'TIPO DOCUMENTO actual: ' , cast(new.tipo_documento as char) , ' antes: ' , cast(old.tipo_documento as char));
		end if;
		if (new.consen_menor_contrayente_dos<>old.consen_menor_contrayente_dos)then
			set txt =concat(txt , 'CONSEN MENOR CONTRAYENTE DOS actual: ' , cast(new.consen_menor_contrayente_dos as char) , ' antes: ' , cast(old.consen_menor_contrayente_dos as char));
		end if;
		if (new.consen_menor_contrayente_uno<>old.consen_menor_contrayente_uno)then
			set txt =concat(txt , 'CONSEN MENOR CONTRAYENTE UNO actual: ' , cast(new.consen_menor_contrayente_uno as char) , ' antes: ' , cast(old.consen_menor_contrayente_uno as char));
		end if;
		if (new.contrayente_dos<>old.contrayente_dos)then
			set txt =concat(txt , 'CONTRAYENTE DOS actual: ' , cast(new.contrayente_dos as char) , ' antes: ' , cast(old.contrayente_dos as char));
		end if;
		if (new.contrayente_uno<>old.contrayente_uno)then
			set txt =concat(txt , 'CONTRAYENTE UNO actual: ' , cast(new.contrayente_uno as char) , ' antes: ' , cast(old.contrayente_uno as char));
		end if;
		if (new.escolaridad_dos<>old.escolaridad_dos)then
			set txt =concat(txt , 'ESCOLARIDAD DOS actual: ' , cast(new.escolaridad_dos as char) , ' antes: ' , cast(old.escolaridad_dos as char));
		end if;
		if (new.escolaridad_uno<>old.escolaridad_uno)then
			set txt =concat(txt , 'ESCOLARIDAD UNO actual: ' , cast(new.escolaridad_uno as char) , ' antes: ' , cast(old.escolaridad_uno as char));
		end if;
		if (new.madre_dos<>old.madre_dos)then
			set txt =concat(txt , 'MADRE DOS actual: ' , cast(new.madre_dos as char) , ' antes: ' , cast(old.madre_dos as char));
		end if;
		if (new.madre_uno<>old.madre_uno)then 
			set txt =concat(txt , 'MADRE UNO actual: ' , cast(new.madre_uno as char) , ' antes: ' , cast(old.madre_uno as char));
		end if;
		if (new.padre_dos<>old.padre_dos)then
			set txt =concat(txt , 'PADRE DOS actual: ' , cast(new.padre_dos as char) , ' antes: ' , cast(old.padre_dos as char));
		end if;
		if (new.padre_uno<>old.padre_uno)then
			set txt =concat(txt , 'PADRE UNO actual: ' , cast(new.padre_uno as char) , ' antes: ' , cast(old.padre_dos as char));
		end if;
		if (new.pa_testigo_cuatro<>old.pa_testigo_cuatro)then
			set txt =concat(txt , 'PA TEST CUATRO actual: ' , cast(new.pa_testigo_cuatro as char) , ' antes: ' , cast(old.pa_testigo_cuatro as char));
		end if;
		if (new.pa_testigo_dos<>old.pa_testigo_dos)then
			set txt =concat(txt , 'PA TEST DOS actual: ' , cast(new.pa_testigo_dos as char) , ' antes: ' , cast(old.pa_testigo_dos as char));
		end if;
		if (new.pa_testigo_tres<>old.pa_testigo_tres)then
			set txt =concat(txt , 'PA TEST TRES actual: ' , cast(new.pa_testigo_tres as char) , ' antes: ' , cast(old.pa_testigo_tres as char));
		end if;
		if (new.pa_testigo_uno<>old.pa_testigo_uno)then
			set txt =concat(txt , 'PA TEST UNO actual: ' , cast(new.pa_testigo_uno as char) , ' antes: ' , cast(old.pa_testigo_uno as char));
		end if;
		if (new.pos_trab_uno<>old.pos_trab_uno)then
			set txt =concat(txt , 'POS TRAB UNO actual: ' , cast(new.pos_trab_uno as char) , ' antes: ' , cast(old.pos_trab_uno as char));
		end if;
		if (new.pos_trab_dos<>old.pos_trab_dos)then
			set txt =concat(txt , 'POS TRAB DOS actual: ' , cast(new.pos_trab_dos as char) , ' antes: ' , cast(old.pos_trab_dos as char));
		end if;
		if (new.regimen<>old.regimen)then
			set txt =concat(txt , 'REGIMEN acutual: ' , cast(new.regimen as char) , ' antes: '  , cast(old.regimen as char));
		end if;
		if (new.sit_lab_dos<>old.sit_lab_dos)then
			set txt =concat(txt , 'SIT LAB DOS actual: ' , cast(new.sit_lab_dos as char) , ' antes: ' , cast(old.sit_lab_dos as char));
		end if;
		if (new.sit_lab_uno<>old.sit_lab_uno)then
			set txt =concat(txt , 'SIT LAB UNO actual: ' , cast(new.sit_lab_uno as char) , ' antes: ' , cast(old.sit_lab_uno as char));
		end if;
		if (new.testigo_cuatro<>old.testigo_cuatro)then
			set txt =concat(txt , 'TESTIGO CUATRO actual: ' , cast(new.testigo_cuatro as char) , ' antes: ' , cast(old.testigo_cuatro as char));
		end if;
		if (new.testigo_tres<>old.testigo_tres)then
			set txt =concat(txt , 'TESTIGO TRES actual: ' , cast(new.testigo_tres as char) , ' antes: ' , cast(old.testigo_tres as char));
		end if;
		if (new.testigo_dos<>old.testigo_dos)then
			set txt =concat(txt , 'TESTIGO DOS actual: ' , cast(new.testigo_dos as char) , ' antes: ' , cast(old.testigo_dos as char));
		end if;
		if (new.testigo_uno<>old.testigo_uno)then
			set txt =concat(txt , 'TESTIGO UNO actual: ' , cast(new.testigo_uno as char) , ' antes: ' , cast(old.testigo_uno as char));
		end if;
		if (new.descricion_error_validacion<>old.descricion_error_validacion)then
			set txt =concat(txt , 'DESCRICION ERROR VALIDACION actual: ' , new.descricion_error_validacion , ' antes: ' , old.descricion_error_validacion);
		end if;
		if (new.visible<>old.visible)then
			set txt =concat(txt , 'VISIBLE actual: ' , cast(new.visible as char) , ' antes: ' , cast(old.visible as char));
		end if;
		if (new.restringido<>old.restringido)then
			set txt =concat(txt , 'RESTRINGIDO actual: ' , cast(new.restringido as char) , ' antes: ' , cast(old.restringido as char));
		end if;
		if (new.causa_baja<>old.causa_baja)then
			set txt =concat(txt , 'CAUSA BAJA actual: ' , cast(new.causa_baja as char) , ' antes: ' , cast(old.causa_baja as char));
		end if;
		/*
		if (new.campaña_dif<>old.campaña_dif)then
			set txt =concat(txt , 'CAMPAÑA DIF actual: ' , cast(new.campaña_dif as char) , ' antes: ' , cast(old.campaña_dif as char));
		end if;
		*/
		if (new.modifica<>old.modifica)then
			set txt =concat(txt , 'MODIFICA actual: ' , cast(new.modifica as char) , ' antes: ' , cast(old.modifica as char));
		end if;

		insert into bitacora_cambio set
		bitacora_cambio.USUARIO= NEW.MODIFICA,
		bitacora_cambio.FECHA= now(),
		bitacora_cambio.TIPO = 'M',
		bitacora_cambio.Tabla = 'MATRIMONIO',
		bitacora_cambio.MOdificacion = txt;

		IF (NEW.FECHA_BORRADO IS NULL)THEN	
				IF( (NEW.VALIDADO = 1) or (cadena!=o_cadena and new.validado>0))THEN
					SET ID_EL = NEW.CONTRAYENTE_UNO;
					SET ID_ELLA = NEW.CONTRAYENTE_DOS;
					SET ID_PADRE_EL = NEW.PADRE_UNO;
					SET ID_PADRE_ELLA = NEW.PADRE_DOS;
					SET ID_MADRE_EL = NEW.MADRE_UNO;
					SET ID_MADRE_ELLA = NEW.MADRE_DOS;

					SET NUMEROACTA	= NEW.NUMERO_ACTA;
					SET ANIOREGISTRO	= YEAR(NEW.FECHA_REGISTRO);
					SET TIPODOCUMENTO	= 3;
					SET P1_TIPODOCUMENTO = 1; 
					SET P2_TIPODOCUMENTO = 1; 
					SET P1_PA_TIPODOCUMENTO = 1; 
					SET P1_MA_TIPODOCUMENTO = 1; 
					SET P2_PA_TIPODOCUMENTO = 1; 
					SET P2_MA_TIPODOCUMENTO = 1; 
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
					set contador = 0;
					SET CO_TIPO = NEW.TIPO_OPERACION;
					SET CO_FECHAORIGINAL = NEW.FECHA_REGISTRO;
					SET CO_TRANSCRIPCION =  NEW.TRANSCRIPCION;
					SET CO_SOPORTE =  NEW.IM_ARCHIVO;
					SET OT_REGISTROPATRIMONIAL = NEW.REGIMEN;
					CASE CO_TIPO 
						WHEN '1' THEN SET CO_TIPO = 'N';
						WHEN '2' THEN SET CO_TIPO = 'I';
						ELSE SET CO_TIPO = 'N';
					END CASE;
					SET OT_NOTASMARGINALES = f_char_notas_matrimonio(NEW.GUID);
					
					-- Datos de nacimiento de el
					SELECT per.CRIP, f_char_limpiar(per.NOMBRE), f_char_limpiar(per.PRIMER_APELLIDO), f_char_limpiar(per.SEGUNDO_APELLIDO),per.FECHA_NACIMIENTO,per.SEXO,per.EDAD,
							(SELECT cat_p.ID FROM cat_pais cat_p WHERE cat_p.id = per.PAIS),
							(SELECT cat_e.ID_RENAPO FROM cat_estado cat_e where cat_e.id = per.ENTIDAD),
							(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = per.MUNICIPIO),
							 f_char_limpiar_CE(per.LOCALIDAD),per.CURP
						INTO OT_CRIP_P1,P1_NOMBRES,P1_PRIMERAPELLIDO,P1_SEGUNDOAPELLIDO,P1_FECHANACIMIENTO,P1_SEXO,P1_EDAD,P1_NACIONALIDAD,P1_ENTIDADNACIMIENTO,P1_MUNICIPIONACIMIENTO,P1_LOCALIDADNACIMIENTO,P1_CURP
					FROM persona per
					WHERE per.id = ID_EL limit 1;
					SET P1_PAISNACIMIENTO = P1_NACIONALIDAD;
					-- Datos de registro de nacimiento 
					SELECT nac.NUMERO_ACTA,YEAR(nac.FECHA_REGISTRO),
						(SELECT cat_ent.ID_RENAPO FROM cat_estado cat_ent WHERE cat_ent.id = nac.ENTIDAD_REGISTRO),
						(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = nac.MUNICIPIO_REGISTRO),
						(SELECT cat_of.ID_RENAPO FROM cat_oficialia cat_of WHERE cat_of.id = nac.OFICIALIA),
						nac.ACTA_BIS,nac.CADENA
						INTO P1_NUMEROACTA,P1_ANIOREGISTRO,P1_ENTIDADREGISTRO,P1_MUNICIPIOREGISTRO,P1_OFICIALIA,P1_ACTABIS,P1_CADENA
					FROM nacimiento nac
					WHERE nac.REGISTRADO = ID_EL limit 1;
					-- Datos de nacimiento de ella
					SELECT per.CRIP, f_char_limpiar(per.NOMBRE), f_char_limpiar(per.PRIMER_APELLIDO), f_char_limpiar(per.SEGUNDO_APELLIDO),per.FECHA_NACIMIENTO,per.SEXO,per.EDAD,
							(SELECT cat_p.ID FROM cat_pais cat_p WHERE cat_p.id = per.PAIS),
							(SELECT cat_e.ID_RENAPO FROM cat_estado cat_e where cat_e.id = per.ENTIDAD),
							(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = per.MUNICIPIO),
							 f_char_limpiar_CE(per.LOCALIDAD),per.CURP
						INTO OT_CRIP_P2,P2_NOMBRES,P2_PRIMERAPELLIDO,P2_SEGUNDOAPELLIDO,P2_FECHANACIMIENTO,P2_SEXO,P2_EDAD,P2_NACIONALIDAD,P2_ENTIDADNACIMIENTO,P2_MUNICIPIONACIMIENTO,P2_LOCALIDADNACIMIENTO,P2_CURP
					FROM persona per
					WHERE per.id = ID_ELLA limit 1;
					SET P2_PAISNACIMIENTO = P2_NACIONALIDAD;
					-- Datos de registro de nacimiento de ella
					SELECT nac.NUMERO_ACTA,YEAR(nac.FECHA_REGISTRO),
						(SELECT cat_ent.ID_RENAPO FROM cat_estado cat_ent WHERE cat_ent.id = nac.ENTIDAD_REGISTRO),
						(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = nac.MUNICIPIO_REGISTRO),
						(SELECT cat_of.ID_RENAPO FROM cat_oficialia cat_of WHERE cat_of.id = nac.OFICIALIA),
						nac.ACTA_BIS,nac.CADENA
						INTO P2_NUMEROACTA,P2_ANIOREGISTRO,P2_ENTIDADREGISTRO,P2_MUNICIPIOREGISTRO,P2_OFICIALIA,P2_ACTABIS,P2_CADENA
					FROM nacimiento nac
					WHERE nac.REGISTRADO = ID_ELLA limit 1;
					
					-- Datos de nacimiento del padre de él
					SELECT  f_char_limpiar(per.NOMBRE), f_char_limpiar(per.PRIMER_APELLIDO), f_char_limpiar(per.SEGUNDO_APELLIDO),per.SEXO,
							(SELECT cat_p.ID FROM cat_pais cat_p WHERE cat_p.id = per.PAIS),per.CURP
						INTO P1_PA_NOMBRES,P1_PA_PRIMERAPELLIDO,P1_PA_SEGUNDOAPELLIDO,P1_PA_SEXO,P1_PA_NACIONALIDAD,P1_PA_CURP
					FROM persona per
					WHERE per.id = ID_PADRE_EL limit 1;
					-- Datos de registro de padre de el
					SELECT nac.NUMERO_ACTA,YEAR(nac.FECHA_REGISTRO),
						(SELECT cat_ent.ID_RENAPO FROM cat_estado cat_ent WHERE cat_ent.id = nac.ENTIDAD_REGISTRO),
						(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = nac.MUNICIPIO_REGISTRO),
						(SELECT cat_of.ID_RENAPO FROM cat_oficialia cat_of WHERE cat_of.id = nac.OFICIALIA),
						nac.ACTA_BIS,nac.CADENA
						INTO P1_PA_NUMEROACTA,P1_PA_ANIOREGISTRO,P1_PA_ENTIDADREGISTRO,P1_PA_MUNICIPIOREGISTRO,P1_PA_OFICIALIA,P1_PA_ACTABIS,P1_PA_CADENA
					FROM nacimiento nac
					WHERE nac.REGISTRADO = ID_PADRE_EL limit 1;
					
					-- Datos de nacimiento del padre de ella
					SELECT  f_char_limpiar(per.NOMBRE), f_char_limpiar(per.PRIMER_APELLIDO), f_char_limpiar(per.SEGUNDO_APELLIDO),per.SEXO,
							(SELECT cat_p.ID FROM cat_pais cat_p WHERE cat_p.id = per.PAIS),per.CURP
						INTO P2_PA_NOMBRES,P2_PA_PRIMERAPELLIDO,P2_PA_SEGUNDOAPELLIDO,P2_PA_SEXO,P2_PA_NACIONALIDAD,P2_PA_CURP
					FROM persona per
					WHERE per.id = ID_PADRE_ELLA limit 1;
					-- Datos de registro de padre de ella
					SELECT nac.NUMERO_ACTA,YEAR(nac.FECHA_REGISTRO),
						(SELECT cat_ent.ID_RENAPO FROM cat_estado cat_ent WHERE cat_ent.id = nac.ENTIDAD_REGISTRO),
						(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = nac.MUNICIPIO_REGISTRO),
						(SELECT cat_of.ID_RENAPO FROM cat_oficialia cat_of WHERE cat_of.id = nac.OFICIALIA),
						nac.ACTA_BIS,nac.CADENA
						INTO P2_PA_NUMEROACTA,P2_PA_ANIOREGISTRO,P2_PA_ENTIDADREGISTRO,P2_PA_MUNICIPIOREGISTRO,P2_PA_OFICIALIA,P2_PA_ACTABIS,P2_PA_CADENA
					FROM nacimiento nac
					WHERE nac.REGISTRADO = ID_PADRE_ELLA limit 1;
					
					-- Datos de nacimiento de la madre de el
					SELECT  f_char_limpiar(per.NOMBRE), f_char_limpiar(per.PRIMER_APELLIDO), f_char_limpiar(per.SEGUNDO_APELLIDO),per.SEXO,
							(SELECT cat_p.ID FROM cat_pais cat_p WHERE cat_p.id = per.PAIS),per.CURP
						INTO P1_MA_NOMBRES,P1_MA_PRIMERAPELLIDO,P1_MA_SEGUNDOAPELLIDO,P1_MA_SEXO,P1_MA_NACIONALIDAD,P1_MA_CURP
					FROM persona per
					WHERE per.id = ID_MADRE_EL limit 1;
					-- Datos de registro de la madre de el
					SELECT nac.NUMERO_ACTA,YEAR(nac.FECHA_REGISTRO),
						(SELECT cat_ent.ID_RENAPO FROM cat_estado cat_ent WHERE cat_ent.id = nac.ENTIDAD_REGISTRO),
						(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = nac.MUNICIPIO_REGISTRO),
						(SELECT cat_of.ID_RENAPO FROM cat_oficialia cat_of WHERE cat_of.id = nac.OFICIALIA),
						nac.ACTA_BIS,nac.CADENA
						INTO P1_MA_NUMEROACTA,P1_MA_ANIOREGISTRO,P1_MA_ENTIDADREGISTRO,P1_MA_MUNICIPIOREGISTRO,P1_MA_OFICIALIA,P1_MA_ACTABIS,P1_MA_CADENA
					FROM nacimiento nac
					WHERE nac.REGISTRADO = ID_MADRE_EL limit 1;

					-- Datos de nacimiento de la madre de ella
					SELECT  f_char_limpiar(per.NOMBRE), f_char_limpiar(per.PRIMER_APELLIDO), f_char_limpiar(per.SEGUNDO_APELLIDO),per.SEXO,
							(SELECT cat_p.ID FROM cat_pais cat_p WHERE cat_p.id = per.PAIS),per.CURP
						INTO P2_MA_NOMBRES,P2_MA_PRIMERAPELLIDO,P2_MA_SEGUNDOAPELLIDO,P2_MA_SEXO,P2_MA_NACIONALIDAD,P2_MA_CURP
					FROM persona per
					WHERE per.id = ID_MADRE_ELLA limit 1;
					-- Datos de registro de la madre de ella
					SELECT nac.NUMERO_ACTA,YEAR(nac.FECHA_REGISTRO),
						(SELECT cat_ent.ID_RENAPO FROM cat_estado cat_ent WHERE cat_ent.id = nac.ENTIDAD_REGISTRO),
						(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = nac.MUNICIPIO_REGISTRO),
						(SELECT cat_of.ID_RENAPO FROM cat_oficialia cat_of WHERE cat_of.id = nac.OFICIALIA),
						nac.ACTA_BIS,nac.CADENA
						INTO P2_MA_NUMEROACTA,P2_MA_ANIOREGISTRO,P2_MA_ENTIDADREGISTRO,P2_MA_MUNICIPIOREGISTRO,P2_MA_OFICIALIA,P2_MA_ACTABIS,P2_MA_CADENA
					FROM nacimiento nac
					WHERE nac.REGISTRADO = ID_MADRE_ELLA limit 1;
					IF (LENGTH(OT_NOTASMARGINALES) > 4000 OR LENGTH(TRIM(OT_NOTASMARGINALES)) = 0) THEN
								SET OT_NOTASMARGINALES = null;
					END IF;
					if (cadena!=o_cadena) THEN	
						insert into monitor(tipo,mensaje) Values('dato1', concat('baja de matrimonio, ',CADENA,',',O_CADENA,','));

						-- se da de baja la cadena anterior
						INSERT INTO CIRR_TA09_MAPETICION(TA09_E_PRIORIDAD,TA09_E_OPERACIONACTO,TA09_C_CADENA,TA09_E_ESTATUS,TA09_E_CUANTOS) 
																								VALUES(1,2,O_CADENA,0,0);							
						end if;
								-- validaciones para insertar
					IF (NUMEROACTA IS NULL OR NUMEROACTA < 1) THEN
					 INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																							VALUES(CADENA,NOW(),'NUMERO DE ACTA INVALIDA',1,3,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE matrimonio m
									SET m.VALIDADO = 3,
										  m.DESCRICION_ERROR_VALIDACION ='NUMERO DE ACTA INVALIDA'
							WHERE m.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF(MUNICIPIOREGISTRO IS NULL OR MUNICIPIOREGISTRO = 0) THEN
					INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																							VALUES(CADENA,NOW(),'MUNICIPIO DE REGISTRO INVALIDO',1,3,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE matrimonio m
									SET m.VALIDADO = 3,
										  m.DESCRICION_ERROR_VALIDACION ='MUNICIPIO DE REGISTRO INVALIDO'
							WHERE m.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF(OFICIALIA IS NULL OR OFICIALIA < 1) THEN
					INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																							VALUES(CADENA,NOW(),'OFICIALIA INVALIDA',1,3,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE matrimonio m
									SET m.VALIDADO = 3,
										  m.DESCRICION_ERROR_VALIDACION ='OFICIALIA INVALIDA'
							WHERE m.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF (CADENA IS NULL OR LENGTH(TRIM(CADENA)) <> 20) THEN
					 INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																							VALUES(CADENA,NOW(),'CADENA INVALIDA',1,3,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE matrimonio m
									SET m.VALIDADO = 3,
										  m.DESCRICION_ERROR_VALIDACION ='CADENA INVALIDA'
							WHERE m.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF (ANIOREGISTRO IS NULL OR ANIOREGISTRO != YEAR(CO_FECHA_REGISTRO) OR ANIOREGISTRO = 0) THEN
					 INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																							VALUES(CADENA,NOW(),'AÑO DE REGISTRO INVALIDO',1,3,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE matrimonio m
									SET m.VALIDADO = 3,
										  m.DESCRICION_ERROR_VALIDACION ='AÑO DE REGISTRO INVALIDO'
							WHERE m.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF (CO_FECHA_REGISTRO IS NULL OR CO_FECHA_REGISTRO > NOW() ) THEN
					 INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																							VALUES(CADENA,NOW(),'FECHA DE REGISTRO INVALIDA',1,3,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE matrimonio m
									SET m.VALIDADO = 3,
										  m.DESCRICION_ERROR_VALIDACION ='FECHA DE REGISTRO INVALIDA'
							WHERE m.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF (OT_REGISTROPATRIMONIAL IS NUlL) THEN
					 INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																							VALUES(CADENA,NOW(),'REGISTRO PATRIMONIAL INVALIDO',1,3,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE matrimonio m
									SET m.VALIDADO = 3,
										  m.DESCRICION_ERROR_VALIDACION ='REGISTRO PATRIMONIAL INVALIDO'
							WHERE m.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF (P1_NOMBRES IS NULL OR LENGTH(TRIM(P1_NOMBRES)) = 0 OR P1_PRIMERAPELLIDO IS NULL OR LENGTH(TRIM(P1_PRIMERAPELLIDO)) = 0) THEN
					 INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																							VALUES(CADENA,NOW(),'NOMBRES DEL REGISTTRADO INVALIDOS',1,3,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE matrimonio m
									SET m.VALIDADO = 3,
										  m.DESCRICION_ERROR_VALIDACION ='NOMBRES DEL REGISTTRADO INVALIDOS'
							WHERE m.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF (P2_NOMBRES IS NULL OR LENGTH(TRIM(P2_NOMBRES)) = 0 OR P2_PRIMERAPELLIDO IS NULL OR LENGTH(TRIM(P2_PRIMERAPELLIDO)) = 0) THEN
					 INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																							VALUES(CADENA,NOW(),'NOMBRES DE LA REGISTRADA INVALIDOS',1,3,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE matrimonio m
									SET m.VALIDADO = 3,
										  m.DESCRICION_ERROR_VALIDACION ='NOMBRES DE LA REGISTRADA INVALIDOS'
							WHERE m.GUID = CO_LLAVEREGISTROCIVIL;
					ELSE
						insert into monitor(tipo,mensaje) Values('error -1', concat('insertar matrimonio, ',CADENA));
						select count(*) into contador from nrc_matrimonios m where m.CO_LLAVEREGISTROCIVIL=new.GUID;
						-- insert into monitor(tipo,mensaje) Values('error -1', concat('insertar nacimiento2, ',CADENA));
						IF (  contador=0 )THEN
								INSERT INTO nrc_matrimonios (NUMEROACTA,ANIOREGISTRO,TIPODOCUMENTO,ENTIDADREGISTRO,MUNICIPIOREGISTRO,OFICIALIA,ACTABIS,CADENA,CO_FECHA_REGISTRO,CO_LLAVEREGISTROCIVIL,CO_FOJA,CO_TOMO,CO_LIBRO,OT_CRIP_P1,OT_CRIP_P2,IM_NOMBREORIGINALIMAGEN,IM_ARCHIVO,OT_NOTASMARGINALES,OT_REGISTROPATRIMONIAL,P1_NOMBRES,P1_PRIMERAPELLIDO,P1_SEGUNDOAPELLIDO,P1_FECHANACIMIENTO,P1_SEXO,P1_EDAD,P1_NACIONALIDAD,P1_PAISNACIMIENTO,P1_ENTIDADNACIMIENTO,P1_MUNICIPIONACIMIENTO,P1_LOCALIDADNACIMIENTO,P1_NUMEROACTA,P1_ANIOREGISTRO,P1_TIPODOCUMENTO,P1_ENTIDADREGISTRO,P1_MUNICIPIOREGISTRO,P1_OFICIALIA,P1_ACTABIS,P1_CURP,P1_CADENA,P2_NOMBRES,P2_PRIMERAPELLIDO,P2_SEGUNDOAPELLIDO,P2_FECHANACIMIENTO,P2_SEXO,P2_EDAD,P2_NACIONALIDAD,P2_PAISNACIMIENTO,P2_ENTIDADNACIMIENTO,P2_MUNICIPIONACIMIENTO,P2_LOCALIDADNACIMIENTO,P2_NUMEROACTA,P2_ANIOREGISTRO,P2_TIPODOCUMENTO,P2_ENTIDADREGISTRO,P2_MUNICIPIOREGISTRO,P2_OFICIALIA,P2_ACTABIS,P2_CURP,P2_CADENA,P1_PA_NOMBRES,P1_PA_PRIMERAPELLIDO,P1_PA_SEGUNDOAPELLIDO,P1_PA_NUMEROACTA,P1_PA_ANIOREGISTRO,P1_PA_TIPODOCUMENTO,P1_PA_ENTIDADREGISTRO,P1_PA_MUNICIPIOREGISTRO,P1_PA_OFICIALIA,P1_PA_ACTABIS,P1_PA_CURP,P1_PA_NACIONALIDAD,P1_PA_CADENA,P1_MA_NOMBRES,P1_MA_PRIMERAPELLIDO,P1_MA_SEGUNDOAPELLIDO,P1_MA_NUMEROACTA,P1_MA_ANIOREGISTRO,P1_MA_TIPODOCUMENTO,P1_MA_ENTIDADREGISTRO,P1_MA_MUNICIPIOREGISTRO,P1_MA_OFICIALIA,P1_MA_ACTABIS,P1_MA_CURP,P1_MA_NACIONALIDAD,P1_MA_CADENA,P2_PA_NOMBRES,P2_PA_PRIMERAPELLIDO,P2_PA_SEGUNDOAPELLIDO,P2_PA_NUMEROACTA,P2_PA_ANIOREGISTRO,P2_PA_TIPODOCUMENTO,P2_PA_ENTIDADREGISTRO,P2_PA_MUNICIPIOREGISTRO,P2_PA_OFICIALIA,P2_PA_ACTABIS,P2_PA_CURP,P2_PA_NACIONALIDAD,P2_PA_CADENA,P2_MA_NOMBRES,P2_MA_PRIMERAPELLIDO,P2_MA_SEGUNDOAPELLIDO,P2_MA_NUMEROACTA,P2_MA_ANIOREGISTRO,P2_MA_TIPODOCUMENTO,P2_MA_ENTIDADREGISTRO,P2_MA_MUNICIPIOREGISTRO,P2_MA_OFICIALIA,P2_MA_ACTABIS,P2_MA_CURP,P2_MA_NACIONALIDAD,P2_MA_CADENA,P1_PA_SEXO,P1_MA_SEXO,P2_PA_SEXO,P2_MA_SEXO,CO_TIPO,CO_FECHAORIGINAL,CO_TRANSCRIPCION,CO_SOPORTE) 
									VALUES (NUMEROACTA,ANIOREGISTRO,TIPODOCUMENTO,ENTIDADREGISTRO,MUNICIPIOREGISTRO,OFICIALIA,ACTABIS,CADENA,CO_FECHA_REGISTRO,CO_LLAVEREGISTROCIVIL,CO_FOJA,CO_TOMO,CO_LIBRO,OT_CRIP_P1,OT_CRIP_P2,IM_NOMBREORIGINALIMAGEN,IM_ARCHIVO,OT_NOTASMARGINALES,OT_REGISTROPATRIMONIAL,P1_NOMBRES,P1_PRIMERAPELLIDO,P1_SEGUNDOAPELLIDO,P1_FECHANACIMIENTO,P1_SEXO,P1_EDAD,P1_NACIONALIDAD,P1_PAISNACIMIENTO,P1_ENTIDADNACIMIENTO,P1_MUNICIPIONACIMIENTO,P1_LOCALIDADNACIMIENTO,P1_NUMEROACTA,P1_ANIOREGISTRO,P1_TIPODOCUMENTO,P1_ENTIDADREGISTRO,P1_MUNICIPIOREGISTRO,P1_OFICIALIA,P1_ACTABIS,P1_CURP,P1_CADENA,P2_NOMBRES,P2_PRIMERAPELLIDO,P2_SEGUNDOAPELLIDO,P2_FECHANACIMIENTO,P2_SEXO,P2_EDAD,P2_NACIONALIDAD,P2_PAISNACIMIENTO,P2_ENTIDADNACIMIENTO,P2_MUNICIPIONACIMIENTO,P2_LOCALIDADNACIMIENTO,P2_NUMEROACTA,P2_ANIOREGISTRO,P2_TIPODOCUMENTO,P2_ENTIDADREGISTRO,P2_MUNICIPIOREGISTRO,P2_OFICIALIA,P2_ACTABIS,P2_CURP,P2_CADENA,P1_PA_NOMBRES,P1_PA_PRIMERAPELLIDO,P1_PA_SEGUNDOAPELLIDO,P1_PA_NUMEROACTA,P1_PA_ANIOREGISTRO,P1_PA_TIPODOCUMENTO,P1_PA_ENTIDADREGISTRO,P1_PA_MUNICIPIOREGISTRO,P1_PA_OFICIALIA,P1_PA_ACTABIS,P1_PA_CURP,P1_PA_NACIONALIDAD,P1_PA_CADENA,P1_MA_NOMBRES,P1_MA_PRIMERAPELLIDO,P1_MA_SEGUNDOAPELLIDO,P1_MA_NUMEROACTA,P1_MA_ANIOREGISTRO,P1_MA_TIPODOCUMENTO,P1_MA_ENTIDADREGISTRO,P1_MA_MUNICIPIOREGISTRO,P1_MA_OFICIALIA,P1_MA_ACTABIS,P1_MA_CURP,P1_MA_NACIONALIDAD,P1_MA_CADENA,P2_PA_NOMBRES,P2_PA_PRIMERAPELLIDO,P2_PA_SEGUNDOAPELLIDO,P2_PA_NUMEROACTA,P2_PA_ANIOREGISTRO,P2_PA_TIPODOCUMENTO,P2_PA_ENTIDADREGISTRO,P2_PA_MUNICIPIOREGISTRO,P2_PA_OFICIALIA,P2_PA_ACTABIS,P2_PA_CURP,P2_PA_NACIONALIDAD,P2_PA_CADENA,P2_MA_NOMBRES,P2_MA_PRIMERAPELLIDO,P2_MA_SEGUNDOAPELLIDO,P2_MA_NUMEROACTA,P2_MA_ANIOREGISTRO,P2_MA_TIPODOCUMENTO,P2_MA_ENTIDADREGISTRO,P2_MA_MUNICIPIOREGISTRO,P2_MA_OFICIALIA,P2_MA_ACTABIS,P2_MA_CURP,P2_MA_NACIONALIDAD,P2_MA_CADENA,P1_PA_SEXO,P1_MA_SEXO,P2_PA_SEXO,P2_MA_SEXO,CO_TIPO,CO_FECHAORIGINAL,CO_TRANSCRIPCION,CO_SOPORTE);
											IF (bandera = 1 ) THEN
												INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																							VALUES(CADENA,NOW(),'ERROR DESCONOCIDO',1,3,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
												UPDATE matrimonio m
														SET m.VALIDADO = 3,
																m.DESCRICION_ERROR_VALIDACION ='ERROR DESCONOCIDO'
												WHERE m.GUID = CO_LLAVEREGISTROCIVIL;
												SET bandera = 0;
											ELSEIF (bandera = 2 ) THEN
													INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																									VALUES(CADENA,NOW(),'CADENA DUPLICADA',1,3,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
													UPDATE matrimonio m
															SET m.VALIDADO = 3,
																	m.DESCRICION_ERROR_VALIDACION ='CADENA DUPLICADA'
													WHERE m.GUID = CO_LLAVEREGISTROCIVIL;
													SET bandera = 0;
											ELSE		
													INSERT INTO CIRR_TA09_MAPETICION(TA09_E_PRIORIDAD,TA09_E_OPERACIONACTO,TA09_C_CADENA,TA09_E_ESTATUS,TA09_E_CUANTOS) 
																									VALUES(1,1,CADENA,0,0);
													SET bandera = 0;
											END IF; -- if banderas
						ELSE	
								insert into monitor(tipo,mensaje) Values('error -1', concat('actualizar matrimonio, ',CADENA));
								UPDATE nrc_matrimonios mat SET mat.NUMEROACTA = NUMEROACTA,mat.ANIOREGISTRO = ANIOREGISTRO,mat.TIPODOCUMENTO = TIPODOCUMENTO,mat.ENTIDADREGISTRO = ENTIDADREGISTRO,mat.MUNICIPIOREGISTRO = MUNICIPIOREGISTRO,mat.OFICIALIA = OFICIALIA,mat.ACTABIS = ACTABIS,mat.CADENA = CADENA,mat.CO_FECHA_REGISTRO = CO_FECHA_REGISTRO,mat.CO_LLAVEREGISTROCIVIL = CO_LLAVEREGISTROCIVIL,mat.CO_FOJA = CO_FOJA,mat.CO_TOMO = CO_TOMO,mat.CO_LIBRO = CO_LIBRO,mat.OT_CRIP_P1 = OT_CRIP_P1,mat.OT_CRIP_P2 = OT_CRIP_P2,mat.IM_NOMBREORIGINALIMAGEN = IM_NOMBREORIGINALIMAGEN,mat.IM_ARCHIVO = IM_ARCHIVO,mat.OT_NOTASMARGINALES = OT_NOTASMARGINALES,mat.OT_REGISTROPATRIMONIAL = OT_REGISTROPATRIMONIAL,mat.P1_NOMBRES = P1_NOMBRES,mat.P1_PRIMERAPELLIDO = P1_PRIMERAPELLIDO,mat.P1_SEGUNDOAPELLIDO = P1_SEGUNDOAPELLIDO,mat.P1_FECHANACIMIENTO = P1_FECHANACIMIENTO,mat.P1_SEXO = P1_SEXO,mat.P1_EDAD = P1_EDAD,mat.P1_NACIONALIDAD = P1_NACIONALIDAD,mat.P1_PAISNACIMIENTO = P1_PAISNACIMIENTO,mat.P1_ENTIDADNACIMIENTO = P1_ENTIDADNACIMIENTO,mat.P1_MUNICIPIONACIMIENTO = P1_MUNICIPIONACIMIENTO,mat.P1_LOCALIDADNACIMIENTO = P1_LOCALIDADNACIMIENTO,mat.P1_NUMEROACTA = P1_NUMEROACTA,mat.P1_ANIOREGISTRO = P1_ANIOREGISTRO,mat.P1_TIPODOCUMENTO = P1_TIPODOCUMENTO,mat.P1_ENTIDADREGISTRO = P1_ENTIDADREGISTRO,mat.P1_MUNICIPIOREGISTRO = P1_MUNICIPIOREGISTRO,mat.P1_OFICIALIA = P1_OFICIALIA,mat.P1_ACTABIS = P1_ACTABIS,mat.P1_CURP = P1_CURP,mat.P1_CADENA = P1_CADENA,mat.P2_NOMBRES = P2_NOMBRES,mat.P2_PRIMERAPELLIDO = P2_PRIMERAPELLIDO,mat.P2_SEGUNDOAPELLIDO = P2_SEGUNDOAPELLIDO,mat.P2_FECHANACIMIENTO = P2_FECHANACIMIENTO,mat.P2_SEXO = P2_SEXO,mat.P2_EDAD = P2_EDAD,mat.P2_NACIONALIDAD = P2_NACIONALIDAD,mat.P2_PAISNACIMIENTO = P2_PAISNACIMIENTO,mat.P2_ENTIDADNACIMIENTO = P2_ENTIDADNACIMIENTO,mat.P2_MUNICIPIONACIMIENTO = P2_MUNICIPIONACIMIENTO,mat.P2_LOCALIDADNACIMIENTO = P2_LOCALIDADNACIMIENTO,mat.P2_NUMEROACTA = P2_NUMEROACTA,mat.P2_ANIOREGISTRO = P2_ANIOREGISTRO,mat.P2_TIPODOCUMENTO = P2_TIPODOCUMENTO,mat.P2_ENTIDADREGISTRO = P2_ENTIDADREGISTRO,mat.P2_MUNICIPIOREGISTRO = P2_MUNICIPIOREGISTRO,mat.P2_OFICIALIA = P2_OFICIALIA,mat.P2_ACTABIS = P2_ACTABIS,mat.P2_CURP = P2_CURP,mat.P2_CADENA = P2_CADENA,mat.P1_PA_NOMBRES = P1_PA_NOMBRES,mat.P1_PA_PRIMERAPELLIDO = P1_PA_PRIMERAPELLIDO,mat.P1_PA_SEGUNDOAPELLIDO = P1_PA_SEGUNDOAPELLIDO,mat.P1_PA_NUMEROACTA = P1_PA_NUMEROACTA,mat.P1_PA_ANIOREGISTRO = P1_PA_ANIOREGISTRO,mat.P1_PA_TIPODOCUMENTO = P1_PA_TIPODOCUMENTO,mat.P1_PA_ENTIDADREGISTRO = P1_PA_ENTIDADREGISTRO,mat.P1_PA_MUNICIPIOREGISTRO = P1_PA_MUNICIPIOREGISTRO,mat.P1_PA_OFICIALIA = P1_PA_OFICIALIA,mat.P1_PA_ACTABIS = P1_PA_ACTABIS,mat.P1_PA_CURP = P1_PA_CURP,mat.P1_PA_NACIONALIDAD = P1_PA_NACIONALIDAD,mat.P1_PA_CADENA = P1_PA_CADENA,mat.P1_MA_NOMBRES = P1_MA_NOMBRES,mat.P1_MA_PRIMERAPELLIDO = P1_MA_PRIMERAPELLIDO,mat.P1_MA_SEGUNDOAPELLIDO = P1_MA_SEGUNDOAPELLIDO,mat.P1_MA_NUMEROACTA = P1_MA_NUMEROACTA,mat.P1_MA_ANIOREGISTRO = P1_MA_ANIOREGISTRO,mat.P1_MA_TIPODOCUMENTO = P1_MA_TIPODOCUMENTO,mat.P1_MA_ENTIDADREGISTRO = P1_MA_ENTIDADREGISTRO,mat.P1_MA_MUNICIPIOREGISTRO = P1_MA_MUNICIPIOREGISTRO,mat.P1_MA_OFICIALIA = P1_MA_OFICIALIA,mat.P1_MA_ACTABIS = P1_MA_ACTABIS,mat.P1_MA_CURP = P1_MA_CURP,mat.P1_MA_NACIONALIDAD = P1_MA_NACIONALIDAD,mat.P1_MA_CADENA = P1_MA_CADENA,mat.P2_PA_NOMBRES = P2_PA_NOMBRES,mat.P2_PA_PRIMERAPELLIDO = P2_PA_PRIMERAPELLIDO,mat.P2_PA_SEGUNDOAPELLIDO = P2_PA_SEGUNDOAPELLIDO,mat.P2_PA_NUMEROACTA = P2_PA_NUMEROACTA,mat.P2_PA_ANIOREGISTRO = P2_PA_ANIOREGISTRO,mat.P2_PA_TIPODOCUMENTO = P2_PA_TIPODOCUMENTO,mat.P2_PA_ENTIDADREGISTRO = P2_PA_ENTIDADREGISTRO,mat.P2_PA_MUNICIPIOREGISTRO = P2_PA_MUNICIPIOREGISTRO,mat.P2_PA_OFICIALIA = P2_PA_OFICIALIA,mat.P2_PA_ACTABIS = P2_PA_ACTABIS,mat.P2_PA_CURP = P2_PA_CURP,mat.P2_PA_NACIONALIDAD = P2_PA_NACIONALIDAD,mat.P2_PA_CADENA = P2_PA_CADENA,mat.P2_MA_NOMBRES = P2_MA_NOMBRES,mat.P2_MA_PRIMERAPELLIDO = P2_MA_PRIMERAPELLIDO,mat.P2_MA_SEGUNDOAPELLIDO = P2_MA_SEGUNDOAPELLIDO,mat.P2_MA_NUMEROACTA = P2_MA_NUMEROACTA,mat.P2_MA_ANIOREGISTRO = P2_MA_ANIOREGISTRO,mat.P2_MA_TIPODOCUMENTO = P2_MA_TIPODOCUMENTO,mat.P2_MA_ENTIDADREGISTRO = P2_MA_ENTIDADREGISTRO,mat.P2_MA_MUNICIPIOREGISTRO = P2_MA_MUNICIPIOREGISTRO,mat.P2_MA_OFICIALIA = P2_MA_OFICIALIA,mat.P2_MA_ACTABIS = P2_MA_ACTABIS,mat.P2_MA_CURP = P2_MA_CURP,mat.P2_MA_NACIONALIDAD = P2_MA_NACIONALIDAD,mat.P2_MA_CADENA = P2_MA_CADENA,mat.P1_PA_SEXO = P1_PA_SEXO,mat.P1_MA_SEXO = P1_MA_SEXO,mat.P2_PA_SEXO = P2_PA_SEXO,mat.P2_MA_SEXO = P2_MA_SEXO,mat.CO_TIPO = CO_TIPO,mat.CO_FECHAORIGINAL = CO_FECHAORIGINAL,mat.CO_TRANSCRIPCION = CO_TRANSCRIPCION,mat.CO_SOPORTE = CO_SOPORTE
									WHERE mat.CADENA = CADENA;
											IF (bandera = 1 ) THEN
												INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																							VALUES(CADENA,NOW(),'ERROR DESCONOCIDO',1,3,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
													UPDATE matrimonio m
															SET m.VALIDADO = 3,
																	m.DESCRICION_ERROR_VALIDACION ='ERROR DESCONOCIDO'
													WHERE m.GUID = CO_LLAVEREGISTROCIVIL;
													SET bandera = 0;
											ELSEIF (bandera = 2 ) THEN
													INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																									VALUES(CADENA,NOW(),'CADENA DUPLICADA',1,3,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
													UPDATE matrimonio m
															SET m.VALIDADO = 3,
																	m.DESCRICION_ERROR_VALIDACION ='CADENA DUPLICADA'
													WHERE m.GUID = CO_LLAVEREGISTROCIVIL;
													SET bandera = 0;
											ELSE	
													if (cadena=o_cadena) then
														insert into monitor(tipo,mensaje) Values('paso4', concat('inserta peticion 3, ',CADENA));
														INSERT INTO CIRR_TA09_MAPETICION(TA09_E_PRIORIDAD,TA09_E_OPERACIONACTO,TA09_C_CADENA,TA09_E_ESTATUS,TA09_E_CUANTOS) 
																									VALUES(1,3,CADENA,0,0);
													ELSE
														insert into monitor(tipo,mensaje) Values('paso5', concat('inserta peticion 1, ',CADENA));
														INSERT INTO CIRR_TA09_MAPETICION(TA09_E_PRIORIDAD,TA09_E_OPERACIONACTO,TA09_C_CADENA,TA09_E_ESTATUS,TA09_E_CUANTOS) 
																									VALUES(1,1,CADENA,0,0);
													end if;	
													
													
													SET bandera = 0;
											END IF; -- if banderas
						END IF;
					END IF;
				END IF;
		ELSE 
			set bandera = 0;
			IF(NEW.VALIDADO > 1 AND NEW.VALIDADO IS NOT NULL)THEN
			INSERT INTO CIRR_TA09_MAPETICION(TA09_E_PRIORIDAD,TA09_E_OPERACIONACTO,TA09_C_CADENA,TA09_E_ESTATUS,TA09_E_CUANTOS) 
																						VALUES(1,2,NEW.CADENA,0,0);
			END IF;
			if(bandera=0) then

				insert into bitacora_cambio set
				bitacora_cambio.USUARIO= NEW.MODIFICA,
				bitacora_cambio.FECHA= now(),
				bitacora_cambio.TIPO = 'B',
				bitacora_cambio.Tabla = 'MATRIMONIO',
				bitacora_cambio.MOdificacion = txt;
			end if;
		enD IF;		
END