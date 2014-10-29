DROP TRIGGER IF EXISTS RCW_reconocimiento_AU;
delimiter $$
CREATE TRIGGER RCW_reconocimiento_AU 
AFTER UPDATE
ON reconocimiento
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
			DECLARE CO_FECHA_REGISTRO_INC	varchar(30);
			DECLARE CO_LLAVEREGISTROCIVIL	varchar(70);
			DECLARE CO_FOJA	decimal(5,0);
			DECLARE CO_TOMO	decimal(4,0);
			DECLARE CO_LIBRO	decimal(4,0);
			DECLARE NA_NUMEROACTA	decimal(5,0);
			DECLARE NA_ANIOREGISTRO	decimal(4,0);
			DECLARE NA_TIPODOCUMENTO	decimal(1,0);
			DECLARE NA_ENTIDADREGISTRO	decimal(2,0);
			DECLARE NA_MUNICIPIOREGISTRO	decimal(3,0);
			DECLARE NA_OFICIALIA	decimal(4,0);
			DECLARE NA_ACTABIS	varchar(20);
			DECLARE OT_NOTASMARGINALES	text;
			DECLARE OT_CRIP	varchar(2000);
			DECLARE OT_FIRMARC	varchar(2000);
			DECLARE PE_PRIMERAPELLIDO	varchar(50);
			DECLARE PE_SEGUNDOAPELLIDO	varchar(50);
			DECLARE PE_NOMBRES	varchar(50);
			DECLARE PE_EDAD	decimal(2,0);
			DECLARE PE_SEXO	varchar(50);
			DECLARE PE_FECHANACIMIENTO	date;
			DECLARE PE_FECHANACIMIENTO_INC	varchar(25);
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
			DECLARE PA_FECHANACIMIENTO_INC	varchar(25);
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
			DECLARE MA_FECHANACIMIENTO_INC	varchar(25);
			DECLARE MA_ENTIDADNACIMIENTO	decimal(2,0);
			DECLARE MA_MUNICIPIONACIMIENTO	decimal(3,0);
			DECLARE MA_LOCALIDADNACIMIENTO	varchar(70);
			DECLARE MA_NACIONALIDAD	decimal(3,0);
			DECLARE MA_PAISNACIMIENTO	decimal(3,0);
			DECLARE MA_CURP	varchar(18);
			DECLARE RE_PRIMERAPELLIDO	varchar(50);
			DECLARE RE_SEGUNDOAPELLIDO	varchar(50);
			DECLARE RE_NOMBRES	varchar(50);
			DECLARE RE_EDAD	decimal(2,0);
			DECLARE RE_SEXO	varchar(1);
			DECLARE RE_FECHANACIMIENTO_INC	varchar(25);
			DECLARE RE_ENTIDADNACIMIENTO	decimal(2,0);
			DECLARE RE_MUNICIPIONACIMIENTO	decimal(3,0);
			DECLARE RE_LOCALIDADNACIMIENTO	varchar(70);
			DECLARE RE_PAISNACIMIENTO	decimal(3,0);
			DECLARE RE_NUMEROACTA	decimal(5,0);
			DECLARE RE_ANIOREGISTRO	decimal(4,0);
			DECLARE RE_TIPODOCUMENTO	decimal(1,0);
			DECLARE RE_ENTIDADREGISTRO	decimal(2,0);
			DECLARE RE_MUNICIPIOREGISTRO	decimal(3,0);
			DECLARE RE_OFICIALIA	decimal(4,0);
			DECLARE RE_ACTABIS	varchar(1);
			DECLARE CN_FECHAACTUALIZACION_INC	varchar(25);
			DECLARE OT_ERRORORIGEN	longtext;
			DECLARE OT_SELLO	longblob;
			DECLARE OT_FIRMA	longblob;
			DECLARE OT_FECHAREGISTRONACIMIENTO_INC	char(20);
			DECLARE NA_LOCALIDAD_RECONOCIDO	char(80);
			DECLARE RE_NACIONALIDAD	decimal(3,0);
			DECLARE CO_FECHA_REGISTRO	datetime;
			DECLARE CN_FECHACAPTURA	datetime;
			DECLARE CN_FECHAACTUALIZACION	datetime;
			DECLARE RE_FECHANACIMIENTO	datetime;
			DECLARE MA_FECHANACIMIENTO	datetime;
			DECLARE PA_FECHANACIMIENTO	datetime;
			DECLARE OT_FECHAREGISTROENNACIMIENTO	datetime;
			DECLARE RE_CURP	varchar(18);
			declare contador int;	
			declare txt longtext;			
			DECLARE ID_NACIMIENTOS Varchar(255);
			DECLARE ID_RECONOCIDO bigint(20);
			DECLARE ID_RECONOCEDOR bigint(20);
			DECLARE ID_PADRE_REC bigint(20);
			DECLARE ID_MADRE_REC bigint(20);
			DECLARE bandera int(11);
			
			DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET bandera = 1;			 
			DECLARE CONTINUE HANDLER FOR 1062 SET bandera = 2; -- duplicated primary key
	

if ( trim(coalesce(new.notas,''))!='') then
  
  -- se busca primero la nota marginal abierta
  select count(*) into contador from nm_reconocimiento
  where ID_RECONOCIMIENTO=new.guid
  and tipo=26 ;
  
  if (contador<=0) THEN
	 select table_sequence_val+1 into contador from sequence_table where table_sequence_name='NM_RECONOCIMIENTO';
     update sequence_table set table_sequence_val=contador+1 where table_sequence_name='NM_RECONOCIMIENTO'; 
     insert into nm_reconocimiento(id,fecha_creacion,fecha_actualizacion,imprimible,tipo,ID_RECONOCIMIENTO,informacion)
     Values(contador,current_timestamp, current_timestamp, 1, 26, new.guid, new.notas);
  else
     update nm_reconocimiento set informacion=new.notas, fecha_actualizacion=current_timestamp
     where ID_RECONOCIMIENTO=new.guid and tipo=26;
  end if;
  
  
end if;
		
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
			if (new.fecha_registro_reconocido<>old.fecha_registro_reconocido)then
				set txt =concat(txt , 'FECHA REGISTRO RECONOCIDO actual: ' ,  cast(new.fecha_registro_reconocido as char) , 'antes: ' , cast(old.fecha_registro_reconocido as char));
			end if;
			if (new.foja_reconocido<>old.foja_reconocido)then
				set txt =concat(txt , 'FOJA RECONOCIDO actual: ' , new.foja_reconocido , ' antes: '  , old.foja_reconocido);
			end if;
			if (new.im_archivo<>old.im_archivo)then
				set txt =concat(txt , 'IM ARCHIVO actual: ' , new.im_archivo , ' antes: ' , old.im_archivo);
			end if;
			if (new.libro_reconocido<>old.libro_reconocido)then
				set txt =concat(txt , 'LIBRO RECONOCIDO actual: ' , new.libro_reconocido , ' antes: ' , old.libro_reconocido);
			end if;
			if (new.localidadregistroreconocido<>old.localidadregistroreconocido)then
				set txt =concat(txt , 'LOCALIDADREGISTRORECONOCIDO actual: ' , new.localidadregistroreconocido , ' antes: ' , old.localidadregistroreconocido);
			end if;
			if (new.numero_acta_reconocido<>old.numero_acta_reconocido)then
				set txt =concat(txt , 'NUMERO ACTA RECONOCIDO actual: ' , new.numero_acta_reconocido , ' antes: ' , old.numero_acta_reconocido);
			end if;
			if (new.ocupacion_testigo_dos<>old.ocupacion_testigo_dos)then
				set txt =concat(txt , 'OCUPACION TESTIGO DOS actual: ' , new.ocupacion_testigo_dos , ' antes: ' , old.ocupacion_testigo_dos);
			end if;
			if (new.ocupacion_testigo_uno<>old.ocupacion_testigo_uno)then
				set txt =concat(txt , 'OCUPACION TESTIGO UNO actual: ' , new.ocupacion_testigo_uno , ' antes: ' , old.ocupacion_testigo_uno);
			end if;
			if (new.persona_otorga_consentimiento<>old.persona_otorga_consentimiento)then
				set txt =concat(txt , 'PERSONA OTORGA CON actual: ' , cast(new.persona_otorga_consentimiento as char) , ' antes: ' , cast(old.persona_otorga_consentimiento as char));
			end if;
			if (new.sello<>old.sello)then
				set txt =concat(txt , 'SELLO actual: ' , new.sello , ' antes: ' , old.sello);
			end if;
			if (new.sello_img<>old.sello_img)then
				set txt =concat(txt , 'SELLO IMG actual: ' , new.sello , ' antes: ' , old.sello_img);
			end if;
			if (new.tomo_reconocido<>old.tomo_reconocido)then
				set txt =concat(txt , 'TOMO RECONOCIDO actual: ' , new.tomo_reconocido , ' antes: ' , old.tomo_reconocido);
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
			if (new.acta_nacimiento<>old.acta_nacimiento)then
				set txt =concat(txt , 'ACTA NACIMIENTO actual: ' , new.acta_nacimiento , ' antes: ' , old.acta_nacimiento);
			end if;
			if (new.entidad_registro_reconocido<>old.entidad_registro_reconocido)then
				set txt =concat(txt , 'ENTIDAD REGISTRO RECONOCIDO actual: ' , cast(new.entidad_registro_reconocido as char) , ' antes: ' , cast(old.entidad_registro_reconocido as char));
			end if;
			if (new.municipio_registro_reconocido<>old.municipio_registro_reconocido)then
				set txt =concat(txt , 'MUNICIPIO REGISTRO RECONOCIDO actual: ' , cast(new.municipio_registro_reconocido as char) , ' antes: ' , cast(old.municipio_registro_reconocido as char));
			end if;
			if (new.oficialia_reconocido<>old.oficialia_reconocido)then
				set txt =concat(txt´, 'OFICIALIA RECONOCIDO actual: ' , cast(new.oficialia_reconocido as char) , ' antes: ' , cast(old.oficialia_reconocido as char));
			end if;
			if (new.padre_sanguineo<>old.padre_sanguineo)then
				set txt =concat(txt , 'PADRE SANGUINEO  actual: ' , cast(new.padre_sanguineo as char) , ' antes: ' , cast(old.padre_sanguineo as char));
			end if;
			if (new.pa_testigo_dos<>old.pa_testigo_dos)then
				set txt =concat(txt , 'PA_TESTIGO DOS actual: ' , cast(new.pa_testigo_dos as char) , ' antes: ' , cast(old.pa_testigo_dos as char));
			end if;
			if (new.pa_testigo_uno<>old.pa_testigo_uno)then
				set txt =concat(txt , 'PA_TESTIGO UNO actual: ' , cast(new.pa_testigo_uno as char) , ' antes: ' , cast(old.pa_testigo_uno as char));
			end if;
			if (new.persona_consen<>old.persona_consen)then
				set txt =concat(txt , 'PERSONA CONSEN actual: ' , cast(new.persona_consen as char) , ' antes: '  , cast(old.persona_consen as char));
			end if;
			if (new.persona_consen_parent<>old.persona_consen_parent)then
				set txt =concat(txt , 'PERSONA CONSEN PARENT actual: ' , cast(new.persona_consen_parent as char) , ' antes: '  , cast(old.persona_consen_parent as char));
			end if;
			if (new.progenitor_dos_reconocedor<>old.progenitor_dos_reconocedor)then
				set txt =concat(txt , 'PROGENITOR DOS RECONOCEDOR actual: ' , cast(new.progenitor_dos_reconocedor as char) , ' antes: ' , cast(old.progenitor_dos_reconocedor as char));
			end if;
			if (new.progenitor_uno_reconocedor<>old.progenitor_uno_reconocedor)then
				set txt =concat(txt , 'PROGENITOR UNO RECONOCEDOR actual: ' , cast(new.progenitor_uno_reconocedor as char) , ' antes: ' , cast(old.progenitor_uno_reconocedor as char));
			end if;
			if (new.reconocedor<>old.reconocedor)then
				set txt =concat(txt , 'RECONOCEDOR actual: ' , cast(new.reconocedor as char) , ' antes: ' , cast(old.reconocedor as char));
			end if;
			if (new.reconocido<>old.reconocido)then
				set txt =concat(txt , 'RECONOCIDO actual: ' , cast(new.reconocido as char) , ' antes: ' , cast(old.reconocido as char));
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
			if (new.apellido_dos_antes<>old.apellido_dos_antes)then
				set txt =concat(txt , 'APELLIDO D ANTES actual: ' , new.apellido_dos_antes , ' antes: ' , old.apellido_dos_antes);
			end if;
			if (new.apellido_uno_antes<>old.apellido_uno_antes)then
				set txt =concat(txt , 'APELLIDO UNO ANTES actual: ' , new.apellido_uno_antes , ' antes: ' , old.apellido_uno_antes);
			end if;

			insert into bitacora_cambio set
			bitacora_cambio.USUARIO= NEW.MODIFICA,
			bitacora_cambio.FECHA= now(),
			bitacora_cambio.TIPO = 'M',
			bitacora_cambio.Tabla = 'RECONOCIMIENTO',
			bitacora_cambio.MOdificacion = txt;

			insert into monitor(tipo,mensaje) Values('inicia', concat('inserta de reconocimiento, ',CADENA,',',O_CADENA,','));
			set bandera=0;

			IF(NEW.FECHA_BORRADO IS NULL)THEN	
				IF( (NEW.VALIDADO = 1) or (cadena!=o_cadena and new.validado>0))THEN
					SET ID_NACIMIENTOS = NEW.ACTA_NACIMIENTO;
					SET ID_RECONOCIDO = NEW.RECONOCIDO;
					SET ID_RECONOCEDOR = NEW.RECONOCEDOR;
					SET ID_PADRE_REC = NEW.PROGENITOR_DOS_RECONOCEDOR;
					SET ID_MADRE_REC = NEW.PROGENITOR_UNO_RECONOCEDOR;
					
					SET NUMEROACTA	= NEW.NUMERO_ACTA;
					SET ANIOREGISTRO	= YEAR(NEW.FECHA_REGISTRO);
					SET TIPODOCUMENTO = 5;
					SET NA_TIPODOCUMENTO = 1;
					SET PA_TIPODOCUMENTO = 1;
					SET MA_TIPODOCUMENTO = 1;
					SET RE_TIPODOCUMENTO = 1;
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
					SET OT_NOTASMARGINALES = f_char_notas_reconocimiento(NEW.GUID);		
					SET NA_LOCALIDAD_RECONOCIDO =  f_char_limpiar_CE(NEW.localidadregistroreconocido);
					SET NA_ENTIDADREGISTRO = (SELECT cat_e.ID_RENAPO FROM cat_estado cat_e where cat_e.id = NEW.ENTIDAD_REGISTRO_RECONOCIDO);
					SET NA_MUNICIPIOREGISTRO =(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = NEW.MUNICIPIO_REGISTRO_RECONOCIDO);
					SET NA_OFICIALIA = (SELECT cat_of.ID_RENAPO FROM cat_oficialia cat_of WHERE cat_of.id = NEW.OFICIALIA_RECONOCIDO);
					set contador = 0;
					-- Datos de nacimiento del adooptado
					SELECT nac.NUMERO_ACTA,YEAR(nac.FECHA_REGISTRO),
						nac.ACTA_BIS,nac.FECHA_REGISTRO
						INTO NA_NUMEROACTA,NA_ANIOREGISTRO,NA_ACTABIS,OT_FECHAREGISTROENNACIMIENTO
					FROM nacimiento nac
					WHERE nac.REGISTRADO = ID_RECONOCIDO AND nac.GUID = ID_NACIMIENTOS limit 1;
							
					-- Datos de nacimiento de el adoptado
					SELECT per.CRIP, f_char_limpiar(per.NOMBRE), f_char_limpiar(per.PRIMER_APELLIDO), f_char_limpiar(per.SEGUNDO_APELLIDO),per.FECHA_NACIMIENTO,per.SEXO,per.EDAD,
							(SELECT cat_p.ID FROM cat_pais cat_p WHERE cat_p.id = per.PAIS),
							(SELECT cat_e.ID_RENAPO FROM cat_estado cat_e where cat_e.id = per.ENTIDAD),
							(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = per.MUNICIPIO),
							 f_char_limpiar_CE(per.LOCALIDAD),per.CURP
						INTO OT_CRIP,PE_NOMBRES,PE_PRIMERAPELLIDO,PE_SEGUNDOAPELLIDO,PE_FECHANACIMIENTO,PE_SEXO,PE_EDAD,PE_NACIONALIDAD,PE_ENTIDADNACIMIENTO,PE_MUNICIPIONACIMIENTO,PE_LOCALIDADNACIMIENTO,PE_CURP
					FROM persona per
					WHERE per.id = ID_RECONOCIDO limit 1;
					SET PE_PAISNACIMIENTO = PE_NACIONALIDAD;

					-- Datos de nacimiento del padre del reconocedor
					SELECT  f_char_limpiar(per.NOMBRE), f_char_limpiar(per.PRIMER_APELLIDO), f_char_limpiar(per.SEGUNDO_APELLIDO),per.FECHA_NACIMIENTO,per.SEXO,per.EDAD,
							(SELECT cat_p.ID FROM cat_pais cat_p WHERE cat_p.id = per.PAIS),
							(SELECT cat_e.ID_RENAPO FROM cat_estado cat_e where cat_e.id = per.ENTIDAD),
							(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = per.MUNICIPIO),
							 f_char_limpiar_CE(per.LOCALIDAD),per.CURP
						INTO PA_NOMBRES,PA_PRIMERAPELLIDO,PA_SEGUNDOAPELLIDO,PA_FECHANACIMIENTO,PA_SEXO,PA_EDAD,PA_NACIONALIDAD,PA_ENTIDADNACIMIENTO,PA_MUNICIPIONACIMIENTO,PA_LOCALIDADNACIMIENTO,PA_CURP
					FROM persona per
					WHERE per.id = ID_PADRE_REC limit 1;
					SET PA_PAISNACIMIENTO = PA_NACIONALIDAD;
				
					-- Datos de nacimiento del padre del reconocedor
					SELECT nac.NUMERO_ACTA,YEAR(nac.FECHA_REGISTRO),
						(SELECT cat_ent.ID_RENAPO FROM cat_estado cat_ent WHERE cat_ent.id = nac.ENTIDAD_REGISTRO),
						(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = nac.MUNICIPIO_REGISTRO),
						(SELECT cat_of.ID_RENAPO FROM cat_oficialia cat_of WHERE cat_of.id = nac.OFICIALIA),
						nac.ACTA_BIS
						INTO PA_NUMEROACTA,PA_ANIOREGISTRO,PA_ENTIDADREGISTRO,PA_MUNICIPIOREGISTRO,PA_OFICIALIA,PA_ACTABIS
					FROM nacimiento nac
					WHERE nac.REGISTRADO = ID_PADRE_REC limit 1;

					-- Datos de nacimiento de la madre del reconocedor
					SELECT nac.NUMERO_ACTA,YEAR(nac.FECHA_REGISTRO),
						(SELECT cat_ent.ID_RENAPO FROM cat_estado cat_ent WHERE cat_ent.id = nac.ENTIDAD_REGISTRO),
						(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = nac.MUNICIPIO_REGISTRO),
						(SELECT cat_of.ID_RENAPO FROM cat_oficialia cat_of WHERE cat_of.id = nac.OFICIALIA),
						nac.ACTA_BIS
						INTO MA_NUMEROACTA,MA_ANIOREGISTRO,MA_ENTIDADREGISTRO,MA_MUNICIPIOREGISTRO,MA_OFICIALIA,MA_ACTABIS
					FROM nacimiento nac
					WHERE nac.REGISTRADO = ID_MADRE_REC limit 1;
					
					-- Datos de nacimiento de la madre del reconocedor
					SELECT  f_char_limpiar(per.NOMBRE), f_char_limpiar(per.PRIMER_APELLIDO), f_char_limpiar(per.SEGUNDO_APELLIDO),per.FECHA_NACIMIENTO,per.SEXO,per.EDAD,
							(SELECT cat_p.ID FROM cat_pais cat_p WHERE cat_p.id = per.PAIS),
							(SELECT cat_e.ID_RENAPO FROM cat_estado cat_e where cat_e.id = per.ENTIDAD),
							(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = per.MUNICIPIO),
							 f_char_limpiar_CE(per.LOCALIDAD),per.CURP
						INTO MA_NOMBRES,MA_PRIMERAPELLIDO,MA_SEGUNDOAPELLIDO,MA_FECHANACIMIENTO,MA_SEXO,MA_EDAD,MA_NACIONALIDAD,MA_ENTIDADNACIMIENTO,MA_MUNICIPIONACIMIENTO,MA_LOCALIDADNACIMIENTO,MA_CURP
					FROM persona per
					WHERE per.id = ID_MADRE_REC limit 1;
					SET MA_PAISNACIMIENTO = MA_NACIONALIDAD;

					-- Datos de nacimiento del reconocedor
					SELECT nac.NUMERO_ACTA,YEAR(nac.FECHA_REGISTRO),
						(SELECT cat_ent.ID_RENAPO FROM cat_estado cat_ent WHERE cat_ent.id = nac.ENTIDAD_REGISTRO),
						(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = nac.MUNICIPIO_REGISTRO),
						(SELECT cat_of.ID_RENAPO FROM cat_oficialia cat_of WHERE cat_of.id = nac.OFICIALIA),
						nac.ACTA_BIS
						INTO RE_NUMEROACTA,RE_ANIOREGISTRO,RE_ENTIDADREGISTRO,RE_MUNICIPIOREGISTRO,RE_OFICIALIA,RE_ACTABIS
					FROM nacimiento nac
					WHERE nac.REGISTRADO = ID_RECONOCEDOR limit 1;
					
					-- Datos de nacimiento de la madre del reconocedor
					SELECT  f_char_limpiar(per.NOMBRE), f_char_limpiar(per.PRIMER_APELLIDO), f_char_limpiar(per.SEGUNDO_APELLIDO),per.FECHA_NACIMIENTO,per.SEXO,per.EDAD,
							(SELECT cat_p.ID FROM cat_pais cat_p WHERE cat_p.id = per.PAIS),
							(SELECT cat_e.ID_RENAPO FROM cat_estado cat_e where cat_e.id = per.ENTIDAD),
							(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = per.MUNICIPIO),
							 f_char_limpiar_CE(per.LOCALIDAD),per.CURP
						INTO RE_NOMBRES,RE_PRIMERAPELLIDO,RE_SEGUNDOAPELLIDO,RE_FECHANACIMIENTO,RE_SEXO,RE_EDAD,RE_NACIONALIDAD,RE_ENTIDADNACIMIENTO,RE_MUNICIPIONACIMIENTO,RE_LOCALIDADNACIMIENTO,RE_CURP
					FROM persona per
					WHERE per.id = ID_RECONOCEDOR limit 1;
					SET RE_PAISNACIMIENTO = RE_NACIONALIDAD;
					IF(PE_NACIONALIDAD IS NULL OR PE_NACIONALIDAD = 0)THEN			
							SET PE_NACIONALIDAD = 223;
					END IF;			
					IF(RE_NACIONALIDAD IS NULL OR RE_NACIONALIDAD = 0)THEN			
							SET RE_NACIONALIDAD = 223;
					END IF;			
					IF(PA_NACIONALIDAD IS NULL OR PA_NACIONALIDAD = 0)THEN			
							SET PA_NACIONALIDAD = 223;
					END IF;			
					IF(MA_NACIONALIDAD IS NULL OR MA_NACIONALIDAD = 0)THEN			
							SET MA_NACIONALIDAD = 223;
					END IF;			
					IF (LENGTH(OT_NOTASMARGINALES) > 8000 OR LENGTH(TRIM(OT_NOTASMARGINALES)) = 0) THEN
							SET OT_NOTASMARGINALES = null;
					END IF;
					-- se manda la baja cuando hay un cambio en los datos de la cadena
						if (cadena!=o_cadena) THEN	
						insert into monitor(tipo,mensaje) Values('dato1', concat('baja de reconocimiento, ',CADENA,',',O_CADENA,','));

						-- se da de baja la cadena anterior
						INSERT INTO CIRR_TA06_REPETICION(TA06_E_PRIORIDAD,TA06_E_OPERACIONACTO,TA06_C_CADENA,TA06_E_ESTATUS,TA06_E_CUANTOS) 
																								VALUES(1,2,O_CADENA,0,0);							
						end if;
					IF((PE_PRIMERAPELLIDO IS NULL OR LENGTH(PE_PRIMERAPELLIDO) = 0) AND(PE_SEGUNDOAPELLIDO IS NOT NULL OR LENGTH(PE_SEGUNDOAPELLIDO) > 0))THEN
						SET PE_PRIMERAPELLIDO  = PE_SEGUNDOAPELLIDO; 
						SET PE_SEGUNDOAPELLIDO = null; 
					END IF;

					insert into monitor(tipo,mensaje) Values('inicia', concat('inicia de reconocimiento, ',CADENA,',',O_CADENA,','));

					IF(LENGTH(CADENA) <> 20 OR CADENA IS NULL)THEN							
						INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'CADENA INVALIDA',1,5,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);	
							UPDATE reconocimiento re
								SET re.VALIDADO = 3,
										re.DESCRIPCION_ERROR_VALIDACION ='CADENA INVALIDA'
							WHERE re.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF((PE_NOMBRES IS NULL OR LENGTH(TRIM(PE_NOMBRES)) = 0 ) OR (PE_PRIMERAPELLIDO IS NULL OR LENGTH(TRIM(PE_PRIMERAPELLIDO)) = 0 ))THEN
						INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'EL NOMBRE Y APELLIDO DEL REGISTRADDO SON NULOS',1,5,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE reconocimiento re
								SET re.VALIDADO = 3,
										re.DESCRIPCION_ERROR_VALIDACION ='EL NOMBRE Y APELLIDO DEL REGISTRADDO SON NULOS'
							WHERE re.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF(PE_SEXO IS NULL OR (PE_SEXO <> 'F' AND PE_SEXO <> 'M'))THEN
						INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'SEXO DEL REGISTRADO ES INVALIDO',1,5,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE reconocimiento re
								SET re.VALIDADO = 3,
										re.DESCRIPCION_ERROR_VALIDACION ='SEXO DEL REGISTRADO ES INVALIDO'
							WHERE re.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF(NUMEROACTA IS NULL OR NUMEROACTA = 0)THEN
						INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'NUMERO DE ACTAINVALIDO',1,5,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE reconocimiento re
								SET re.VALIDADO = 3,
										re.DESCRIPCION_ERROR_VALIDACION ='NUMERO DE ACTAINVALIDO'
							WHERE re.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF(ANIOREGISTRO IS NULL OR ANIOREGISTRO = 0)THEN
						INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'AÑO DE REGISTRO INVALIDO',1,5,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE reconocimiento re
								SET re.VALIDADO = 3,
										re.DESCRIPCION_ERROR_VALIDACION ='AÑO DE REGISTRO INVALIDO'
							WHERE re.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF(MUNICIPIOREGISTRO IS NULL OR MUNICIPIOREGISTRO = 0)THEN
						INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'MUNICIPIO DE REGISTRO INVALIDO',1,5,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE reconocimiento re
								SET re.VALIDADO = 3,
										re.DESCRIPCION_ERROR_VALIDACION ='MUNICIPIO DE REGISTRO INVALIDO'
							WHERE re.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF(PE_ENTIDADNACIMIENTO IS NULL OR PE_ENTIDADNACIMIENTO = 0)THEN
						INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'ENTIDAD DE NACIMIENTO INVALIDA',1,5,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);		
							UPDATE reconocimiento re
								SET re.VALIDADO = 3,
										re.DESCRIPCION_ERROR_VALIDACION ='ENTIDAD DE NACIMIENTO INVALIDA'
							WHERE re.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF(CO_FECHA_REGISTRO IS NULL OR CO_FECHA_REGISTRO = '0000-00-00 00:00:00' or CO_FECHA_REGISTRO > NOW())THEN
						INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'FECHA DE REGISTRO INVALIDA',1,5,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE reconocimiento re
								SET re.VALIDADO = 3,
										re.DESCRIPCION_ERROR_VALIDACION ='FECHA DE REGISTRO INVALIDA'
							WHERE re.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF(NA_NUMEROACTA IS NULL OR NA_NUMEROACTA = 0)THEN
						INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'NUMERO DE ACTA DEL REGISTRO DE NACIMIENTO INVALIDA',1,6,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE reconocimiento re
								SET re.VALIDADO = 3,
										re.DESCRIPCION_ERROR_VALIDACION ='NUMERO DE ACTA DEL REGISTRO DE NACIMIENTO INVALIDA'
							WHERE re.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF(NA_ANIOREGISTRO IS NULL OR NA_ANIOREGISTRO = 0)THEN
						INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'AÑO DE REGISTRO DE NACIMIENTO INVALIDO',1,6,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE reconocimiento re
								SET re.VALIDADO = 3,
										re.DESCRIPCION_ERROR_VALIDACION ='AÑO DE REGISTRO DE NACIMIENTO INVALIDO'
							WHERE re.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF(NA_ENTIDADREGISTRO IS NULL OR NA_ENTIDADREGISTRO = 0)THEN
						INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'ENTIDAD DE REGISTRO DE NACIMIENTO INVALIDA',1,6,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE reconocimiento re
								SET re.VALIDADO = 3,
										re.DESCRIPCION_ERROR_VALIDACION ='ENTIDAD DE REGISTRO DE NACIMIENTO INVALIDA'
							WHERE re.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF(NA_MUNICIPIOREGISTRO IS NULL OR NA_MUNICIPIOREGISTRO = 0)THEN
						INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'MUNICIPIO DE REGISTRO DE NACIMIENTO INVALIDO',1,6,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE reconocimiento re
								SET re.VALIDADO = 3,
										re.DESCRIPCION_ERROR_VALIDACION ='MUNICIPIO DE REGISTRO DE NACIMIENTO INVALIDO'
							WHERE re.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF(NA_OFICIALIA IS NULL OR NA_OFICIALIA = 0)THEN
						INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'OFICIALIA DE REGISTRO DE NACIMIENTO INVALIDA',1,6,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE reconocimiento re
								SET re.VALIDADO = 3,
										re.DESCRIPCION_ERROR_VALIDACION ='OFICIALIA DE REGISTRO DE NACIMIENTO INVALIDA'
							WHERE re.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF(NA_ACTABIS IS NULL)THEN
						INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'ACTABIS DE NACIMIENTO INVALIDA',1,5,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE reconocimiento re
								SET re.VALIDADO = 3,
										re.DESCRIPCION_ERROR_VALIDACION ='ACTABIS DE NACIMIENTO INVALIDA'
							WHERE re.GUID = CO_LLAVEREGISTROCIVIL;																			
					ELSE		
					insert into monitor(tipo,mensaje) Values('inicia 1', concat('insertar RECONOCIMIENTO, ',CADENA));
					select count(*) into contador from nrc_reconocimientos where CO_LLAVEREGISTROCIVIL=new.GUID;
					-- insert into monitor(tipo,mensaje) Values('error -1', concat('insertar nacimiento2, ',CADENA));
					IF (  contador=0 )THEN
								INSERT INTO nrc_reconocimientos (NUMEROACTA,ANIOREGISTRO,TIPODOCUMENTO,ENTIDADREGISTRO,MUNICIPIOREGISTRO,OFICIALIA,ACTABIS,CADENA,CO_FECHA_REGISTRO_INC,CO_LLAVEREGISTROCIVIL,CO_FOJA,CO_TOMO,CO_LIBRO,NA_NUMEROACTA,NA_ANIOREGISTRO,NA_TIPODOCUMENTO,NA_ENTIDADREGISTRO,NA_MUNICIPIOREGISTRO,NA_OFICIALIA,NA_ACTABIS,OT_NOTASMARGINALES,OT_CRIP,OT_FIRMARC,PE_PRIMERAPELLIDO,PE_SEGUNDOAPELLIDO,PE_NOMBRES,PE_EDAD,PE_SEXO,PE_FECHANACIMIENTO,PE_FECHANACIMIENTO_INC,PE_ENTIDADNACIMIENTO,PE_MUNICIPIONACIMIENTO,PE_LOCALIDADNACIMIENTO,PE_NACIONALIDAD,PE_PAISNACIMIENTO,PE_CURP,PA_PRIMERAPELLIDO,PA_SEGUNDOAPELLIDO,PA_NOMBRES,PA_EDAD,PA_SEXO,PA_FECHANACIMIENTO_INC,PA_ENTIDADNACIMIENTO,PA_MUNICIPIONACIMIENTO,PA_LOCALIDADNACIMIENTO,PA_NACIONALIDAD,PA_PAISNACIMIENTO,PA_CURP,PA_NUMEROACTA,PA_ANIOREGISTRO,PA_TIPODOCUMENTO,PA_ENTIDADREGISTRO,PA_MUNICIPIOREGISTRO,PA_OFICIALIA,PA_ACTABIS,MA_NUMEROACTA,MA_ANIOREGISTRO,MA_TIPODOCUMENTO,MA_ENTIDADREGISTRO,MA_MUNICIPIOREGISTRO,MA_OFICIALIA,MA_ACTABIS,MA_PRIMERAPELLIDO,MA_SEGUNDOAPELLIDO,MA_NOMBRES,MA_EDAD,MA_SEXO,MA_FECHANACIMIENTO_INC,MA_ENTIDADNACIMIENTO,MA_MUNICIPIONACIMIENTO,MA_LOCALIDADNACIMIENTO,MA_NACIONALIDAD,MA_PAISNACIMIENTO,MA_CURP,RE_PRIMERAPELLIDO,RE_SEGUNDOAPELLIDO,RE_NOMBRES,RE_EDAD,RE_SEXO,RE_FECHANACIMIENTO_INC,RE_ENTIDADNACIMIENTO,RE_MUNICIPIONACIMIENTO,RE_LOCALIDADNACIMIENTO,RE_PAISNACIMIENTO,RE_NUMEROACTA,RE_ANIOREGISTRO,RE_TIPODOCUMENTO,RE_ENTIDADREGISTRO,RE_MUNICIPIOREGISTRO,RE_OFICIALIA,RE_ACTABIS,CN_FECHAACTUALIZACION_INC,OT_ERRORORIGEN,OT_SELLO,OT_FIRMA,OT_FECHAREGISTRONACIMIENTO_INC,NA_LOCALIDAD_RECONOCIDO,RE_NACIONALIDAD,CO_FECHA_REGISTRO,CN_FECHACAPTURA,CN_FECHAACTUALIZACION,RE_FECHANACIMIENTO,MA_FECHANACIMIENTO,PA_FECHANACIMIENTO,OT_FECHAREGISTROENNACIMIENTO,RE_CURP)
																					VALUES(NUMEROACTA,ANIOREGISTRO,TIPODOCUMENTO,ENTIDADREGISTRO,MUNICIPIOREGISTRO,OFICIALIA,ACTABIS,CADENA,CO_FECHA_REGISTRO_INC,CO_LLAVEREGISTROCIVIL,CO_FOJA,CO_TOMO,CO_LIBRO,NA_NUMEROACTA,NA_ANIOREGISTRO,NA_TIPODOCUMENTO,NA_ENTIDADREGISTRO,NA_MUNICIPIOREGISTRO,NA_OFICIALIA,NA_ACTABIS,OT_NOTASMARGINALES,OT_CRIP,OT_FIRMARC,PE_PRIMERAPELLIDO,PE_SEGUNDOAPELLIDO,PE_NOMBRES,PE_EDAD,PE_SEXO,PE_FECHANACIMIENTO,PE_FECHANACIMIENTO_INC,PE_ENTIDADNACIMIENTO,PE_MUNICIPIONACIMIENTO,PE_LOCALIDADNACIMIENTO,PE_NACIONALIDAD,PE_PAISNACIMIENTO,PE_CURP,PA_PRIMERAPELLIDO,PA_SEGUNDOAPELLIDO,PA_NOMBRES,PA_EDAD,PA_SEXO,PA_FECHANACIMIENTO_INC,PA_ENTIDADNACIMIENTO,PA_MUNICIPIONACIMIENTO,PA_LOCALIDADNACIMIENTO,PA_NACIONALIDAD,PA_PAISNACIMIENTO,PA_CURP,PA_NUMEROACTA,PA_ANIOREGISTRO,PA_TIPODOCUMENTO,PA_ENTIDADREGISTRO,PA_MUNICIPIOREGISTRO,PA_OFICIALIA,PA_ACTABIS,MA_NUMEROACTA,MA_ANIOREGISTRO,MA_TIPODOCUMENTO,MA_ENTIDADREGISTRO,MA_MUNICIPIOREGISTRO,MA_OFICIALIA,MA_ACTABIS,MA_PRIMERAPELLIDO,MA_SEGUNDOAPELLIDO,MA_NOMBRES,MA_EDAD,MA_SEXO,MA_FECHANACIMIENTO_INC,MA_ENTIDADNACIMIENTO,MA_MUNICIPIONACIMIENTO,MA_LOCALIDADNACIMIENTO,MA_NACIONALIDAD,MA_PAISNACIMIENTO,MA_CURP,RE_PRIMERAPELLIDO,RE_SEGUNDOAPELLIDO,RE_NOMBRES,RE_EDAD,RE_SEXO,RE_FECHANACIMIENTO_INC,RE_ENTIDADNACIMIENTO,RE_MUNICIPIONACIMIENTO,RE_LOCALIDADNACIMIENTO,RE_PAISNACIMIENTO,RE_NUMEROACTA,RE_ANIOREGISTRO,RE_TIPODOCUMENTO,RE_ENTIDADREGISTRO,RE_MUNICIPIOREGISTRO,RE_OFICIALIA,RE_ACTABIS,CN_FECHAACTUALIZACION_INC,OT_ERRORORIGEN,OT_SELLO,OT_FIRMA,OT_FECHAREGISTRONACIMIENTO_INC,NA_LOCALIDAD_RECONOCIDO,RE_NACIONALIDAD,CO_FECHA_REGISTRO,CN_FECHACAPTURA,CN_FECHAACTUALIZACION,RE_FECHANACIMIENTO,MA_FECHANACIMIENTO,PA_FECHANACIMIENTO,OT_FECHAREGISTROENNACIMIENTO,RE_CURP);
											IF (bandera = 1 ) THEN
												INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																							VALUES(CADENA,NOW(),'ERROR DESCONOCIDO',1,5,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
													UPDATE reconocimiento re
														SET re.VALIDADO = 3,
																re.DESCRIPCION_ERROR_VALIDACION ='ERROR DESCONOCIDO'
													WHERE re.GUID = CO_LLAVEREGISTROCIVIL;
													SET bandera = 0;
											ELSEIF (bandera = 2 ) THEN
													INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																									VALUES(CADENA,NOW(),'CADENA DUPLICADA',1,5,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
													UPDATE reconocimiento re
														SET re.VALIDADO = 3,
																re.DESCRIPCION_ERROR_VALIDACION ='CADENA DUPLICADA'
													WHERE re.GUID = CO_LLAVEREGISTROCIVIL;
													SET bandera = 0;
											ELSE		
													INSERT INTO CIRR_TA06_REPETICION(TA06_E_PRIORIDAD,TA06_E_OPERACIONACTO,TA06_C_CADENA,TA06_E_ESTATUS,TA06_E_CUANTOS) 
																									VALUES(1,1,CADENA,0,0);
													SET bandera = 0;
											END IF; -- if banderas
						ELSE
								UPDATE nrc_reconocimientos rec 
										SET rec.NUMEROACTA = NUMEROACTA, rec.ANIOREGISTRO = ANIOREGISTRO, rec.TIPODOCUMENTO = TIPODOCUMENTO, rec.ENTIDADREGISTRO = ENTIDADREGISTRO, rec.MUNICIPIOREGISTRO = MUNICIPIOREGISTRO, rec.OFICIALIA = OFICIALIA, rec.ACTABIS = ACTABIS, rec.CADENA = CADENA, rec.CO_FECHA_REGISTRO_INC = CO_FECHA_REGISTRO_INC, rec.CO_LLAVEREGISTROCIVIL = CO_LLAVEREGISTROCIVIL, rec.CO_FOJA = CO_FOJA, rec.CO_TOMO = CO_TOMO, rec.CO_LIBRO = CO_LIBRO, rec.NA_NUMEROACTA = NA_NUMEROACTA, rec.NA_ANIOREGISTRO = NA_ANIOREGISTRO, rec.NA_TIPODOCUMENTO = NA_TIPODOCUMENTO, rec.NA_ENTIDADREGISTRO = NA_ENTIDADREGISTRO, rec.NA_MUNICIPIOREGISTRO = NA_MUNICIPIOREGISTRO, rec.NA_OFICIALIA = NA_OFICIALIA, rec.NA_ACTABIS = NA_ACTABIS, rec.OT_NOTASMARGINALES = OT_NOTASMARGINALES, rec.OT_CRIP = OT_CRIP, rec.OT_FIRMARC = OT_FIRMARC, rec.PE_PRIMERAPELLIDO = PE_PRIMERAPELLIDO, rec.PE_SEGUNDOAPELLIDO = PE_SEGUNDOAPELLIDO, rec.PE_NOMBRES = PE_NOMBRES, rec.PE_EDAD = PE_EDAD, rec.PE_SEXO = PE_SEXO, rec.PE_FECHANACIMIENTO = PE_FECHANACIMIENTO, rec.PE_FECHANACIMIENTO_INC = PE_FECHANACIMIENTO_INC, rec.PE_ENTIDADNACIMIENTO = PE_ENTIDADNACIMIENTO, rec.PE_MUNICIPIONACIMIENTO = PE_MUNICIPIONACIMIENTO, rec.PE_LOCALIDADNACIMIENTO = PE_LOCALIDADNACIMIENTO, rec.PE_NACIONALIDAD = PE_NACIONALIDAD, rec.PE_PAISNACIMIENTO = PE_PAISNACIMIENTO, rec.PE_CURP = PE_CURP, rec.PA_PRIMERAPELLIDO = PA_PRIMERAPELLIDO, rec.PA_SEGUNDOAPELLIDO = PA_SEGUNDOAPELLIDO, rec.PA_NOMBRES = PA_NOMBRES, rec.PA_EDAD = PA_EDAD, rec.PA_SEXO = PA_SEXO, rec.PA_FECHANACIMIENTO_INC = PA_FECHANACIMIENTO_INC, rec.PA_ENTIDADNACIMIENTO = PA_ENTIDADNACIMIENTO, rec.PA_MUNICIPIONACIMIENTO = PA_MUNICIPIONACIMIENTO, rec.PA_LOCALIDADNACIMIENTO = PA_LOCALIDADNACIMIENTO, rec.PA_NACIONALIDAD = PA_NACIONALIDAD, rec.PA_PAISNACIMIENTO = PA_PAISNACIMIENTO, rec.PA_CURP = PA_CURP, rec.PA_NUMEROACTA = PA_NUMEROACTA, rec.PA_ANIOREGISTRO = PA_ANIOREGISTRO, rec.PA_TIPODOCUMENTO = PA_TIPODOCUMENTO, rec.PA_ENTIDADREGISTRO = PA_ENTIDADREGISTRO, rec.PA_MUNICIPIOREGISTRO = PA_MUNICIPIOREGISTRO, rec.PA_OFICIALIA = PA_OFICIALIA, rec.PA_ACTABIS = PA_ACTABIS, rec.MA_NUMEROACTA = MA_NUMEROACTA, rec.MA_ANIOREGISTRO = MA_ANIOREGISTRO, rec.MA_TIPODOCUMENTO = MA_TIPODOCUMENTO, rec.MA_ENTIDADREGISTRO = MA_ENTIDADREGISTRO, rec.MA_MUNICIPIOREGISTRO = MA_MUNICIPIOREGISTRO, rec.MA_OFICIALIA = MA_OFICIALIA, rec.MA_ACTABIS = MA_ACTABIS, rec.MA_PRIMERAPELLIDO = MA_PRIMERAPELLIDO, rec.MA_SEGUNDOAPELLIDO = MA_SEGUNDOAPELLIDO, rec.MA_NOMBRES = MA_NOMBRES, rec.MA_EDAD = MA_EDAD, rec.MA_SEXO = MA_SEXO, rec.MA_FECHANACIMIENTO_INC = MA_FECHANACIMIENTO_INC, rec.MA_ENTIDADNACIMIENTO = MA_ENTIDADNACIMIENTO, rec.MA_MUNICIPIONACIMIENTO = MA_MUNICIPIONACIMIENTO, rec.MA_LOCALIDADNACIMIENTO = MA_LOCALIDADNACIMIENTO, rec.MA_NACIONALIDAD = MA_NACIONALIDAD, rec.MA_PAISNACIMIENTO = MA_PAISNACIMIENTO, rec.MA_CURP = MA_CURP, rec.RE_PRIMERAPELLIDO = RE_PRIMERAPELLIDO, rec.RE_SEGUNDOAPELLIDO = RE_SEGUNDOAPELLIDO, rec.RE_NOMBRES = RE_NOMBRES, rec.RE_EDAD = RE_EDAD, rec.RE_SEXO = RE_SEXO, rec.RE_FECHANACIMIENTO_INC = RE_FECHANACIMIENTO_INC, rec.RE_ENTIDADNACIMIENTO = RE_ENTIDADNACIMIENTO, rec.RE_MUNICIPIONACIMIENTO = RE_MUNICIPIONACIMIENTO, rec.RE_LOCALIDADNACIMIENTO = RE_LOCALIDADNACIMIENTO, rec.RE_PAISNACIMIENTO = RE_PAISNACIMIENTO, rec.RE_NUMEROACTA = RE_NUMEROACTA, rec.RE_ANIOREGISTRO = RE_ANIOREGISTRO, rec.RE_TIPODOCUMENTO = RE_TIPODOCUMENTO, rec.RE_ENTIDADREGISTRO = RE_ENTIDADREGISTRO, rec.RE_MUNICIPIOREGISTRO = RE_MUNICIPIOREGISTRO, rec.RE_OFICIALIA = RE_OFICIALIA, rec.RE_ACTABIS = RE_ACTABIS, rec.CN_FECHAACTUALIZACION_INC = CN_FECHAACTUALIZACION_INC, rec.OT_ERRORORIGEN = OT_ERRORORIGEN, rec.OT_SELLO = OT_SELLO, rec.OT_FIRMA = OT_FIRMA, rec.OT_FECHAREGISTRONACIMIENTO_INC = OT_FECHAREGISTRONACIMIENTO_INC, rec.NA_LOCALIDAD_RECONOCIDO = NA_LOCALIDAD_RECONOCIDO, rec.RE_NACIONALIDAD = RE_NACIONALIDAD, rec.CO_FECHA_REGISTRO = CO_FECHA_REGISTRO, rec.CN_FECHACAPTURA = CN_FECHACAPTURA, rec.CN_FECHAACTUALIZACION = CN_FECHAACTUALIZACION, rec.RE_FECHANACIMIENTO = RE_FECHANACIMIENTO, rec.MA_FECHANACIMIENTO = MA_FECHANACIMIENTO, rec.PA_FECHANACIMIENTO = PA_FECHANACIMIENTO, rec.OT_FECHAREGISTROENNACIMIENTO = OT_FECHAREGISTROENNACIMIENTO, rec.RE_CURP = RE_CURP 
								WHERE rec.CADENA = CADENA;
											IF (bandera = 1 ) THEN
												INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																							VALUES(CADENA,NOW(),'ERROR DESCONOCIDO',1,5,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
													UPDATE reconocimiento re
														SET re.VALIDADO = 3,
																re.DESCRIPCION_ERROR_VALIDACION ='ERROR DESCONOCIDO'
													WHERE re.GUID = CO_LLAVEREGISTROCIVIL;
													SET bandera = 0;
											ELSEIF (bandera = 2 ) THEN
													INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																									VALUES(CADENA,NOW(),'CADENA DUPLICADA',1,5,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
													UPDATE reconocimiento re
														SET re.VALIDADO = 3,
																re.DESCRIPCION_ERROR_VALIDACION ='CADENA DUPLICADA'
													WHERE re.GUID = CO_LLAVEREGISTROCIVIL;
													SET bandera = 0;
											ELSE	
													if (cadena=o_cadena) then
														INSERT INTO CIRR_TA06_REPETICION(TA06_E_PRIORIDAD,TA06_E_OPERACIONACTO,TA06_C_CADENA,TA06_E_ESTATUS,TA06_E_CUANTOS) 
																									VALUES(1,3,CADENA,0,0);
													ELSE
														INSERT INTO CIRR_TA06_REPETICION(TA06_E_PRIORIDAD,TA06_E_OPERACIONACTO,TA06_C_CADENA,TA06_E_ESTATUS,TA06_E_CUANTOS) 
																									VALUES(1,1,CADENA,0,0);
													end if;	
													
													SET bandera = 0;
											END IF; -- if banderas
						END IF;
					END IF;
					END IF;
			ELSE		
					INSERT INTO CIRR_TA06_REPETICION(TA06_E_PRIORIDAD,TA06_E_OPERACIONACTO,TA06_C_CADENA,TA06_E_ESTATUS,TA06_E_CUANTOS) 
																		VALUES(1,2,NEW.CADENA,0,0);
			END IF;
END