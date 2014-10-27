DROP TRIGGER IF EXISTS RCW_divorcio_AU;
delimiter $$
CREATE TRIGGER RCW_divorcio_AU
AFTER UPDATE
ON divorcio
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
		DECLARE CO_LLAVEREGISTROCIVIL	varchar(60);
		DECLARE CO_FOJA	decimal(5,0);
		DECLARE CO_TOMO	decimal(4,0);
		DECLARE CO_LIBRO	decimal(4,0);
		DECLARE OT_NOTASMARGINALES	text;
		DECLARE OT_CRIP_P1	varchar(15);
		DECLARE OT_CRIP_P2	varchar(15);
		DECLARE OT_RESOLUCION_ADMIN	longtext;
		DECLARE P1_NOMBRES	varchar(50);
		DECLARE P1_PRIMERAPELLIDO	varchar(50);
		DECLARE P1_SEGUNDOAPELLIDO	varchar(50);
		DECLARE P1_FECHANACIMIENTO	date;
		DECLARE P1_SEXO	varchar(1);
		DECLARE P1_EDAD	int(2);
		DECLARE P1_NACIONALIDAD	decimal(3,0);
		DECLARE P1_PAISNACIMIENTO	decimal(3,0);
		DECLARE P1_ENTIDADNACIMIENTO	decimal(2,0);
		DECLARE P1_MUNICIPIONACIMIENTO	decimal(3,0);
		DECLARE P1_LOCALIDADNACIMIENTO	varchar(120);
		DECLARE P1_TOMO	decimal(4,0);
		DECLARE P1_LIBRO	decimal(4,0);
		DECLARE P1_FOJA	decimal(5,0);
		DECLARE P1_FECHA_REGISTRO	date;
		DECLARE P1_NUMEROACTA	decimal(5,0);
		DECLARE P1_ANIOREGISTRO	decimal(4,0);
		DECLARE P1_TIPODOCUMENTO	smallint(1);
		DECLARE P1_ENTIDADREGISTRO	smallint(2);
		DECLARE P1_MUNICIPIOREGISTRO	decimal(3,0);
		DECLARE P1_OFICIALIA	decimal(4,0);
		DECLARE P1_ACTABIS	varchar(1);
		DECLARE P1_CURP	varchar(18);
		DECLARE P1_CADENA	varchar(20);
		DECLARE P2_NOMBRES	varchar(50);
		DECLARE P2_PRIMERAPELLIDO	varchar(50);
		DECLARE P2_SEGUNDOAPELLIDO	varchar(50);
		DECLARE P2_FECHANACIMIENTO	date;
		DECLARE P2_SEXO	varchar(1);
		DECLARE P2_EDAD	decimal(2,0);
		DECLARE P2_NACIONALIDAD	decimal(3,0);
		DECLARE P2_PAISNACIMIENTO	decimal(3,0);
		DECLARE P2_ENTIDADNACIMIENTO	decimal(2,0);
		DECLARE P2_MUNICIPIONACIMIENTO	decimal(3,0);
		DECLARE P2_LOCALIDADNACIMIENTO	varchar(120);
		DECLARE P2_TOMO	decimal(4,0);
		DECLARE P2_LIBRO	decimal(4,0);
		DECLARE P2_FOJA	decimal(5,0);
		DECLARE P2_FECHA_REGISTRO	date;
		DECLARE P2_NUMEROACTA	decimal(5,0);
		DECLARE P2_ANIOREGISTRO	decimal(4,0);
		DECLARE P2_TIPODOCUMENTO	smallint(1);
		DECLARE P2_ENTIDADREGISTRO	smallint(2);
		DECLARE P2_MUNICIPIOREGISTRO	decimal(3,0);
		DECLARE P2_OFICIALIA	decimal(4,0);
		DECLARE P2_ACTABIS	varchar(1);
		DECLARE P2_CURP	varchar(18);
		DECLARE P2_CADENA	varchar(20);
		DECLARE ENTIDADREGISTRO_MATRIMONIO	smallint(2);
		DECLARE MUNICIPIOREGISTRO_MATRIMONIO	decimal(3,0);
		DECLARE OFICIALIA_MATRIMONIO	decimal(4,0);
		DECLARE TOMO_MATRIMONIO	decimal(4,0);
		DECLARE LIBRO_MATRIMONIO	decimal(4,0);
		DECLARE FOJA_MATRIMONIO	decimal(5,0);
		DECLARE NUMEROACTA_MATRIMONIO	decimal(5,0);
		DECLARE FECHA_REGISTRO_MATRIMONIO	date;
		DECLARE OT_TIPO_DIVORCIO	varchar(1);
		DECLARE OT_FECHARESOLUCION	date;
		DECLARE MA_ACTABIS	varchar(1);
		DECLARE MA_CADENA	varchar(20);
		DECLARE CO_TIPO	varchar(1);
		DECLARE CO_FECHAORIGINAL	date;
		DECLARE CO_TRANSCRIPCION	longtext;
		DECLARE CO_SOPORTE	longblob;
		DECLARE bandera int(11);
		declare contador int;
		declare txt longtext;
		declare vrmatrimonio varchar(200);
		declare vrreconocimiento varchar(200);
		declare vradopcion varchar(200);
		declare vrconyuge bigint;		
		DECLARE ID_EL bigint(20);
		DECLARE ID_ELLA bigint(20);
		DECLARE ID_MATRIMONIO VARCHAR(255);
		DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET bandera = 1;			 
		DECLARE CONTINUE HANDLER FOR 1062 SET bandera = 2; -- duplicated primary key
		
	
if ( trim(coalesce(new.notas,''))!='') then
  
  -- se busca primero la nota marginal abierta
  select count(*) into contador from nm_divorcio
  where ID_DIVORCIO=new.guid
  and tipo=26 ;
  
  if (contador<=0) THEN
	 select table_sequence_val+1 into contador from sequence_table where table_sequence_name='NM_DIVORCIO';
     update sequence_table set table_sequence_val=contador+1 where table_sequence_name='NM_DIVORCIO'; 
     insert into nm_divorcio(ID,fecha_creacion,fecha_actualizacion,imprimible,tipo,ID_DIVORCIO,informacion)
     Values(CONTADOR,current_timestamp, current_timestamp, 1, 26, new.guid, new.notas);
  else
     update nm_divorcio set INFORMACION=new.notas, fecha_actualizacion=current_timestamp
     where ID_DIVORCIO=new.guid and tipo=26;
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
		if (new.acta_bis_matrimonio<>old.acta_bis_matrimonio)then
			set txt =concat(txt , 'ACTA BIS MATRIMONIO actual: ' , cast(new.acta_bis_matrimonio as char) , ' antes: ' , cast(old.acta_bis_matrimonio as char));
		end if;
		if (new.autoridad<>old.autoridad)then 
			set txt =concat(txt , 'AUTORIDAD actual: ' , new.autoridad , ' antes: ' , old.autoridad);
		end if;
		if (new.fecha_ejecutoria<>old.fecha_ejecutoria)then
			set txt =concat(txt , 'FECHA EJECUTORIA actual: ' , cast(new.fecha_ejecutoria as char) , ' antes: ' , cast(old.fecha_ejecutoria as char));
		end if;
		if (new.fecha_registro_matrimonio<>old.fecha_registro_matrimonio)then
			set txt =concat(txt , 'FECHA REGISTRO MATRIMONIO actual: ' , cast(new.fecha_registro_matrimonio as char) , ' antes: ' , cast(old.fecha_registro_matrimonio as char));
		end if;
		if (new.fecha_resolucion<>old.fecha_resolucion)then 
			set txt =concat(txt , 'FECHA RESOLUCION actual: ' , cast(new.fecha_resolucion as char) , ' antes: ' , cast(old.fecha_resolucion as char));
		end if;
		if (new.foja_matrimonio<>old.foja_matrimonio)then
			set txt =concat(txt , 'FOJA MATRIMONIO actual: ' , new.foja_matrimonio , ' antes: '  , old.foja_matrimonio);
		end if;
		if (new.im_archivo<>old.im_archivo)then
			set txt =concat(txt , 'IM ARCHIVO actual: ' , new.im_archivo , ' antes: ' , old.im_archivo);
		end if;
		if (new.libro_matrimonio<>old.libro_matrimonio)then
			set txt =concat(txt , 'LIBRO MATRIMONIO actual: ' , new.libro_matrimonio , ' antes: ' , old.libro_matrimonio);
		end if;
		if (new.numero_acta_matrimonio<>old.numero_acta_matrimonio)then
			set txt =concat(txt , 'NUMERO ACTA MATRIMONIO actual: ' , new.numero_acta_matrimonio , ' antes: ' , old.numero_acta_matrimonio);
		end if;
		if (new.resolucion_admin<>old.resolucion_admin)then
		 set txt =concat(txt , 'RESOLUCION ADMIN actual: ' , new.resolucion_admin , ' antes: ' , old.resolucion_admin);
		end if;
		/*
		if (new.sello<>old.sello)then
			set txt =concat(txt , 'SELLO actual: ' , new.sello , ' antes: ' , old.sello);
		end if;
		if (new.sello_img<>old.sello_img)then
			set txt =concat(txt , 'SELLO IMG actual: ' , new.sello , ' antes: ' , old.sello_img);
		end if;
		*/
		if (new.tomo_matrimonio<>old.tomo_matrimonio)then
			set txt =concat(txt , 'TOMO MATRIMONIO actual: ' , new.tomo_matrimonio , ' antes: ' , old.tomo_matrimonio);
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
		if (new.acta_matrimonio<>old.acta_matrimonio)then
			set txt =concat(txt , 'ACTA MATRIMONIO actual: ' , new.acta_matrimonio , ' antes: ' , old.acta_matrimonio);
		end if;
		if (new.divorciado_dos<>old.divorciado_dos)then
			set txt =concat(txt , 'DIVORCIADO DOS actual: ' , cast(new.divorciado_dos as char) , ' antes: ' , cast(old.divorciado_dos as char));
		end if;
		if (new.divorciado_uno<>old.divorciado_uno)then
			set txt =concat(txt , 'DIVORCIADO UNO actual: ' , cast(new.divorciado_dos as char) , ' antes: ' , cast(old.divorciado_uno as char));
		end if;
		if (new.escolaridad_divorciado_dos<>old.escolaridad_divorciado_dos)then
			set txt =concat(txt , 'ESCOLARIDAD DIVORCIADO DOS actual: ' , cast(new.escolaridad_divorciado_dos as char) , ' antes: ' , cast(old.escolaridad_divorciado_dos as char));
		end if;
		if (new.oficialia_matrimonio<>old.oficialia_matrimonio)then
			set txt =concat(txt´, 'OFICIALIA MATRIMONIO actual: ' , cast(new.oficialia_matrimonio as char) , ' antes: ' , cast(old.oficialia_matrimonio as char));
		end if;
		if (new.pa_testigo_dos<>old.pa_testigo_dos)then
			set txt =concat(txt , 'PA TESTIGO DOS actual: ' , cast(new.pa_testigo_dos as char) ,  ' antes: ' , cast(old.pa_testigo_dos as char));
		end if;
		if (new.pa_testigo_uno<>old.pa_testigo_uno)then
			set txt =concat(txt , 'PÁ TESTIGO UNO actual: ' , cast(new.pa_testigo_uno as char) ,  ' antes: ' , cast(old.pa_testigo_uno as char));
		end if;
		if (new.pos_trab_divorciado_dos<>old.pos_trab_divorciado_dos)then
			set txt =concat(txt , 'POS TRAB DIVORCIADO DOS actual: ' , cast(new.pos_trab_divorciado_dos as char) , ' antes: ' , cast(old.pos_trab_divorciado_dos as char));
		end if;
		if (new.pos_trab_divorciado_uno<>old.pos_trab_divorciado_uno)then
			set txt =concat(txt , 'POS TRAB DIVORCIADO UNO actual: ' , cast(new.pos_trab_divorciado_uno as char) , ' antes: ' , cast(old.pos_trab_divorciado_dos as char));
		end if;
		if (new.regimen_matrimonio<>old.regimen_matrimonio)then
			set txt =concat(txt , 'REGIMEN MATRIMONIO actual: ' , cast(new.regimen_matrimonio as char) , ' antes: ' , cast(old.regimen_matrimonio as char));
		end if;
		if (new.sit_lab_divorciado_dos<>old.sit_lab_divorciado_dos)then
			set txt =concat(txt , 'SIT LAB DIVORCIADO DOS actual: ' , cast(new.sit_lab_divorciado_dos as char) , ' antes: ' , cast(old.sit_lab_divorciado_dos as char));
		end if;
		if (new.sit_lab_divorciado_uno<>old.sit_lab_divorciado_uno)then
			set txt =concat(txt , 'SIT LAB DIVORCIADO UNO actual: ' , cast(new.sit_lab_divorciado_uno as char) , ' antes: ' , cast(old.sit_lab_divorciado_dos as char));
		end if;
		if (new.testigo_dos<>old.testigo_dos)then
			set txt =concat(txt , 'TESTIGO DOS actual: ' , cast(new.testigo_dos as char) , ' antes: ' , cast(old.testigo_dos as char));
		end if;
		if (new.testigo_uno<>old.testigo_uno)then
			set txt =concat(txt , 'TESTIGO UNO actual: ' , cast(new.testigo_uno as char) , ' antes: ' , cast(old.testigo_uno as char));
		end if;
		if (new.tipo_divorcio<>old.tipo_divorcio)then
			set txt =concat(txt , 'TIPO DIVORCIO actual: ' , cast(new.tipo_divorcio as char) , ' antes: ' , cast(old.tipo_divorcio as char));
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
		
		if (new.num_expediente<>old.num_expediente)then
			set txt =concat(txt , 'NUM EXPEDIENTE actual: ' , new.num_expediente , ' antes: ' , old.num_expediente);
		end if;
		*/
		if (new.modifica<>old.modifica)then
			set txt =concat(txt , 'MODIFICA actual: ' , cast(new.modifica as char) , ' antes: ' , cast(old.modifica as char));
		end if;
		/*
		if (new.transcripcion<>old.transcripcion)then
			set txt =concat(txt , 'TRANSCRIPCION actual: ' , new.transcripcion , ' antes: ' , old.transcripcion);
		end if;
		*/
		if (new.tipo_operacion<>old.tipo_operacion)then
			set txt =concat(txt , 'TIPO_OPERACION actual: ' , cast(new.tipo_operacion as char) , ' antes: ' , cast(old.tipo_operacion as char));
		end if;

		insert into bitacora_cambio set
		bitacora_cambio.USUARIO= NEW.MODIFICA,
		bitacora_cambio.FECHA= now(),
		bitacora_cambio.TIPO = 'A',
		bitacora_cambio.Tabla = 'DIVORCIO',
		bitacora_cambio.MOdificacion = txt;

		-- se inserta notas marginales
		if (new.validado=1 and old.validado<>1) then
				select table_sequence_val+1 into contador from sequence_table where table_sequence_name='NM_NACIMIENTO';
				update sequence_table set table_sequence_val=contador+1 where table_sequence_name='NM_NACIMIENTO'; 
				insert into nm_nacimiento(id,fecha_creacion,fecha_actualizacion,imprimible,tipo,id_nacimiento,informacion)
						select contador,current_timestamp,current_timestamp,1,3,guid,  concat('EL MATRIMONIO CON ACTA NO. ', new.numero_acta_matrimonio ,' DE FECHA', cast(new.fecha_registro_matrimonio as char),' EN LA OFICIALIA ',(select descripcion from cat_oficialia where id=new.oficialia),
						' DE  ',(select nombre from cat_municipio where id=new.municipio_registro),',',(select descripcion from cat_estado where id=new.entidad_registro) ,' QUEDA ANULADO POR EL ACTA DE DIVORCIO NO.', NEW.NUMERO_ACTA,
						' DE FECHA ', cast(fecha_registro as char),', POR LO QUE EN LO SUCESIVO EL ESTADO CIVIL DE ',
						(SELECT concat(coalesce(nombre,''),' ',coalesce(primer_apellido,''),' ',coalesce(segundo_apellido,'')) FROM PERSONA WHERE ID = REGISTRADO), 'DEBERA SER DIVORCIADO.')
						from nacimiento 
						where (n.registrado=new.divorciado_uno)
						and Validado=1
						and fecha_borrado is null;
				
                select table_sequence_val+1 into contador from sequence_table where table_sequence_name='NM_NACIMIENTO';
				update sequence_table set table_sequence_val=contador+1 where table_sequence_name='NM_NACIMIENTO'; 
                
				insert into nm_nacimiento(id,fecha_creacion,fecha_actualizacion,imprimible,tipo,id_nacimiento,informacion)
						select contador,current_timestamp,current_timestamp,1,3,guid,  concat('EL MATRIMONIO CON ACTA NO. ', new.numero_acta_matrimonio ,' DE FECHA', cast(new.fecha_registro_matrimonio as char),' EN LA OFICIALIA ',(select descripcion from cat_oficialia where id=new.oficialia),
						' DE  ',(select nombre from cat_municipio where id=new.municipio_registro),',',(select descripcion from cat_estado where id=new.entidad_registro) ,' QUEDA ANULADO POR EL ACTA DE DIVORCIO NO.', NEW.NUMERO_ACTA,
						' DE FECHA ', cast(fecha_registro as char),', POR LO QUE EN LO SUCESIVO EL ESTADO CIVIL DE ',
						(SELECT concat(coalesce(nombre,''),' ',coalesce(primer_apellido,''),' ',coalesce(segundo_apellido,'')) FROM PERSONA WHERE ID = REGISTRADO), 'DEBERA SER DIVORCIADO.')
						from nacimiento 
						where (n.registrado=new.divorciado_dos)
						and Validado=1
						and fecha_borrado is null;
		 end if;

		set bandera=0;
		-- se manda a RENAPO CIRR
		insert into monitor(tipo,mensaje) Values('inicia', concat('proceso de divorcio, ',CADENA,',',O_CADENA,','));
		IF (NEW.FECHA_BORRADO IS NULL)THEN	
				IF( (NEW.VALIDADO = 1) or (cadena!=o_cadena and new.validado>0))THEN
					SET ID_EL = NEW.DIVORCIADO_DOS;
					SET ID_ELLA = NEW.DIVORCIADO_UNO;
					SET ID_MATRIMONIO = NEW.ACTA_MATRIMONIO;
					
					SET NUMEROACTA	= NEW.NUMERO_ACTA;
					SET ANIOREGISTRO	= YEAR(NEW.FECHA_REGISTRO);
					SET TIPODOCUMENTO = 4;
					SET P1_TIPODOCUMENTO = 1; 
					SET P2_TIPODOCUMENTO = 1; 
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
					SET CO_TIPO = null;
					SET CO_FECHAORIGINAL = NEW.FECHA_REGISTRO;
					SET CO_TRANSCRIPCION =  null;
					SET CO_SOPORTE =  NEW.IM_ARCHIVO;
					set contador = 0;
					SET OT_NOTASMARGINALES = f_char_notas_divorcio(NEW.GUID);
					SET OT_TIPO_DIVORCIO = NEW.TIPO_DIVORCIO;
					CASE OT_TIPO_DIVORCIO 		
							WHEN '0' THEN SET OT_TIPO_DIVORCIO = 3;
							WHEN '1' THEN SET OT_TIPO_DIVORCIO = 1;
							WHEN '2' THEN SET OT_TIPO_DIVORCIO = 2;
							ELSE SET OT_TIPO_DIVORCIO = 3;
					END CASE;
					SET OT_FECHARESOLUCION = NEW.FECHA_RESOLUCION;
					SET OFICIALIA_MATRIMONIO = (SELECT cat_of.ID_RENAPO FROM cat_oficialia cat_of WHERE cat_of.id = NEW.OFICIALIA_MATRIMONIO);
					SET TOMO_MATRIMONIO = IF(LENGTH(TRIM(NEW.TOMO_MATRIMONIO)) = 0, null,NEW.TOMO_MATRIMONIO);
					SET LIBRO_MATRIMONIO = IF(LENGTH(TRIM(NEW.LIBRO_MATRIMONIO)) = 0, null,NEW.LIBRO_MATRIMONIO);
					SET FOJA_MATRIMONIO = IF(LENGTH(TRIM(NEW.FOJA_MATRIMONIO)) = 0, null,NEW.FOJA_MATRIMONIO);
					SET NUMEROACTA_MATRIMONIO = IF(LENGTH(TRIM(NEW.NUMERO_ACTA_MATRIMONIO)) = 0, null,NEW.NUMERO_ACTA_MATRIMONIO);
					SET FECHA_REGISTRO_MATRIMONIO = NEW.FECHA_REGISTRO_MATRIMONIO;
					SET OT_RESOLUCION_ADMIN =  f_char_limpiar_CE(NEW.RESOLUCION_ADMIN);
					
					-- Datos de nacimiento de el
					SELECT per.CRIP, f_char_limpiar(per.NOMBRE), f_char_limpiar(per.PRIMER_APELLIDO), f_char_limpiar(per.SEGUNDO_APELLIDO),per.FECHA_NACIMIENTO,per.SEXO,per.EDAD,
							(SELECT cat_p.ID FROM cat_pais cat_p WHERE cat_p.id = per.PAIS),
							(SELECT cat_e.ID_RENAPO FROM cat_estado cat_e where cat_e.id = per.ENTIDAD),
							(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = per.MUNICIPIO),
							 f_char_limpiar_CE(per.LOCALIDAD),per.CURP
						INTO OT_CRIP_P1,P1_NOMBRES,P1_PRIMERAPELLIDO,P1_SEGUNDOAPELLIDO,P1_FECHANACIMIENTO,P1_SEXO,P1_EDAD,P1_NACIONALIDAD,P1_ENTIDADNACIMIENTO,P1_MUNICIPIONACIMIENTO,P1_LOCALIDADNACIMIENTO,P1_CURP
					FROM persona per
					WHERE per.id = ID_EL;
					SET P1_PAISNACIMIENTO = P1_NACIONALIDAD;
					-- Datos de registro de nacimiento 
					SELECT nac.NUMERO_ACTA,YEAR(nac.FECHA_REGISTRO),
						(SELECT cat_ent.ID_RENAPO FROM cat_estado cat_ent WHERE cat_ent.id = nac.ENTIDAD_REGISTRO),
						(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = nac.MUNICIPIO_REGISTRO),
						(SELECT cat_of.ID_RENAPO FROM cat_oficialia cat_of WHERE cat_of.id = nac.OFICIALIA),
						nac.ACTA_BIS,nac.CADENA,nac.TOMO,nac.LIBRO,nac.FOJA,nac.FECHA_REGISTRO
						INTO P1_NUMEROACTA,P1_ANIOREGISTRO,P1_ENTIDADREGISTRO,P1_MUNICIPIOREGISTRO,P1_OFICIALIA,P1_ACTABIS,P1_CADENA,P1_TOMO,P1_LIBRO,P1_FOJA,P1_FECHA_REGISTRO
					FROM nacimiento nac
					WHERE nac.REGISTRADO = ID_EL;
					
					-- Datos de nacimiento de ella
					SELECT per.CRIP, f_char_limpiar(per.NOMBRE), f_char_limpiar(per.PRIMER_APELLIDO), f_char_limpiar(per.SEGUNDO_APELLIDO),per.FECHA_NACIMIENTO,per.SEXO,per.EDAD,
							(SELECT cat_p.ID FROM cat_pais cat_p WHERE cat_p.id = per.PAIS),
							(SELECT cat_e.ID_RENAPO FROM cat_estado cat_e where cat_e.id = per.ENTIDAD),
							(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = per.MUNICIPIO),
							 f_char_limpiar_CE(per.LOCALIDAD),per.CURP
						INTO OT_CRIP_P2,P2_NOMBRES,P2_PRIMERAPELLIDO,P2_SEGUNDOAPELLIDO,P2_FECHANACIMIENTO,P2_SEXO,P2_EDAD,P2_NACIONALIDAD,P2_ENTIDADNACIMIENTO,P2_MUNICIPIONACIMIENTO,P2_LOCALIDADNACIMIENTO,P2_CURP
					FROM persona per
					WHERE per.id = ID_ELLA;
					SET P2_PAISNACIMIENTO = P2_NACIONALIDAD;
					-- Datos de registro de nacimiento 
					SELECT nac.NUMERO_ACTA,YEAR(nac.FECHA_REGISTRO),
						(SELECT cat_ent.ID_RENAPO FROM cat_estado cat_ent WHERE cat_ent.id = nac.ENTIDAD_REGISTRO),
						(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = nac.MUNICIPIO_REGISTRO),
						(SELECT cat_of.ID_RENAPO FROM cat_oficialia cat_of WHERE cat_of.id = nac.OFICIALIA),
						nac.ACTA_BIS,nac.CADENA,nac.TOMO,nac.LIBRO,nac.FOJA,nac.FECHA_REGISTRO
						INTO P2_NUMEROACTA,P2_ANIOREGISTRO,P2_ENTIDADREGISTRO,P2_MUNICIPIOREGISTRO,P2_OFICIALIA,P2_ACTABIS,P2_CADENA,P2_TOMO,P2_LIBRO,P2_FOJA,P2_FECHA_REGISTRO
					FROM nacimiento nac
					WHERE nac.REGISTRADO = ID_ELLA limit 1;

					SELECT mat.ACTA_BIS,mat.CADENA,
						(SELECT cat_ent.ID_RENAPO FROM cat_estado cat_ent WHERE cat_ent.id = mat.ENTIDAD_REGISTRO),
						(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = mat.MUNICIPIO_REGISTRO)
						INTO	MA_ACTABIS,MA_CADENA,ENTIDADREGISTRO_MATRIMONIO,MUNICIPIOREGISTRO_MATRIMONIO
					FROM matrimonio mat 
					WHERE mat.GUID = ID_MATRIMONIO LIMIT 1;
						IF (LENGTH(OT_NOTASMARGINALES) > 4000 OR LENGTH(TRIM(OT_NOTASMARGINALES)) = 0) THEN
								SET OT_NOTASMARGINALES = null;
					END IF;
						IF (LENGTH(OT_RESOLUCION_ADMIN) > 8000 OR LENGTH(TRIM(OT_RESOLUCION_ADMIN)) = 0) THEN
								SET OT_RESOLUCION_ADMIN = null;
					END IF;
						IF(P1_NACIONALIDAD IS NULL OR P1_NACIONALIDAD = 0)THEN			
							SET P1_NACIONALIDAD = 223;
						END IF;
						IF(P2_NACIONALIDAD IS NULL OR P2_NACIONALIDAD = 0)THEN			
							SET P2_NACIONALIDAD = 223;
						END IF;
						-- se manda la baja cuando hay un cambio en los datos de la cadena
						if (cadena!=o_cadena) THEN	
							insert into monitor(tipo,mensaje) Values('dato1', concat('baja de divorcio, ',CADENA,',',O_CADENA,','));

							-- se da de baja la cadena anterior
							INSERT INTO CIRR_TA25_DIPETICION(TA25_E_PRIORIDAD,TA25_E_OPERACIONACTO,TA25_C_CADENA,TA25_E_ESTATUS,TA25_E_CUANTOS) 
																								VALUES(1,2,O_CADENA,0,0);							
						end if;
						IF(MUNICIPIOREGISTRO IS NULL OR MUNICIPIOREGISTRO < 1) THEN -- IF validaciones
								INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'MUNICIPIO DE REGISTRO INVALIDO',1,4,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
								UPDATE divorcio di
									SET di.VALIDADO = 3,
											di.DESCRICION_ERROR_VALIDACION ='MUNICIPIO DE REGISTRO INVALIDO'
								WHERE di.GUID = CO_LLAVEREGISTROCIVIL;
						ELSEIF(NUMEROACTA IS NULL OR NUMEROACTA < 1) THEN 
								INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'NUMERO DE ACTA INVALIDA',1,4,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);	
								UPDATE divorcio di
									SET di.VALIDADO = 3,
											di.DESCRICION_ERROR_VALIDACION ='NUMERO DE ACTA INVALIDA'
								WHERE di.GUID = CO_LLAVEREGISTROCIVIL;
						ELSEIF (ANIOREGISTRO IS NULL OR ANIOREGISTRO = 0 OR ANIOREGISTRO <> YEAR(CO_FECHA_REGISTRO)) THEN
								INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'AÑO DE REGISTRO INVALIDO O DIFERENTE DEL AÑO DE LA FECHA DE REGISTRO',1,4,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
								UPDATE divorcio di
									SET di.VALIDADO = 3,
											di.DESCRICION_ERROR_VALIDACION ='AÑO DE REGISTRO INVALIDO O DIFERENTE DEL AÑO DE LA FECHA DE REGISTRO'
								WHERE di.GUID = CO_LLAVEREGISTROCIVIL;
						ELSEIF (OFICIALIA IS NULL OR OFICIALIA < 1) THEN
								INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'OFICIALIA INVALIDA',1,4,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
								UPDATE divorcio di
									SET di.VALIDADO = 3,
											di.DESCRICION_ERROR_VALIDACION ='OFICIALIA INVALIDA'
								WHERE di.GUID = CO_LLAVEREGISTROCIVIL;
						ELSEIF (P1_NOMBRES IS NULL OR LENGTH(TRIM(P1_NOMBRES)) < 2 OR P1_PRIMERAPELLIDO IS NULL OR LENGTH(TRIM(P1_PRIMERAPELLIDO)) < 2 ) THEN
								INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'EL NOMBRE Y APELLIDO DEL REGISTRADO SON OBLIGATORIOS',1,4,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
								UPDATE divorcio di
									SET di.VALIDADO = 3,
											di.DESCRICION_ERROR_VALIDACION ='EL NOMBRE Y APELLIDO DEL REGISTRADO SON OBLIGATORIOS'
								WHERE di.GUID = CO_LLAVEREGISTROCIVIL;
						ELSEIF (P2_NOMBRES IS NULL OR LENGTH(TRIM(P2_NOMBRES)) < 2 OR P2_PRIMERAPELLIDO IS NULL OR LENGTH(TRIM(P2_PRIMERAPELLIDO)) < 2 ) THEN
								INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'EL NOMBRE Y APELLIDO DE LA REGISTRADA SON OBLIGATORIOS',1,4,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
								UPDATE divorcio di
									SET di.VALIDADO = 3,
											di.DESCRICION_ERROR_VALIDACION ='EL NOMBRE Y APELLIDO DE LA REGISTRADA SON OBLIGATORIOS'
								WHERE di.GUID = CO_LLAVEREGISTROCIVIL;
						ELSEIF (CADENA IS NULL OR LENGTH(CADENA) <> 20) THEN
								INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'LA CADENA ES INVALIDA',1,4,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
								UPDATE divorcio di
									SET di.VALIDADO = 3,
											di.DESCRICION_ERROR_VALIDACION ='LA CADENA ES INVALIDA'
								WHERE di.GUID = CO_LLAVEREGISTROCIVIL;
						ELSEIF (OT_RESOLUCION_ADMIN IS NULL ) THEN
								INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'LA RESOLUCION ES NULA',1,4,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
								UPDATE divorcio di
									SET di.VALIDADO = 3,
											di.DESCRICION_ERROR_VALIDACION ='LA RESOLUCION ES NULA'
								WHERE di.GUID = CO_LLAVEREGISTROCIVIL;
						ELSE
								set bandera =0;
								insert into monitor(tipo,mensaje) Values('dato1', concat('insertar divorcio, ',CADENA));
								select count(*) into contador from nrc_divorcios where CO_LLAVEREGISTROCIVIL=new.GUID;
								-- insert into monitor(tipo,mensaje) Values('error -1', concat('insertar nacimiento2, ',CADENA));
								IF (  contador=0 )THEN
										insert into monitor(tipo,mensaje) Values('dato2', concat('insertar divorcio, ',CADENA));	
										INSERT INTO nrc_divorcios (NUMEROACTA,ANIOREGISTRO,TIPODOCUMENTO,ENTIDADREGISTRO,MUNICIPIOREGISTRO,OFICIALIA,ACTABIS,CADENA,CO_FECHA_REGISTRO,CO_LLAVEREGISTROCIVIL,CO_FOJA,CO_TOMO,CO_LIBRO,OT_NOTASMARGINALES,OT_CRIP_P1,OT_CRIP_P2,OT_RESOLUCION_ADMIN,P1_NOMBRES,P1_PRIMERAPELLIDO,P1_SEGUNDOAPELLIDO,P1_FECHANACIMIENTO,P1_SEXO,P1_EDAD,P1_NACIONALIDAD,P1_PAISNACIMIENTO,P1_ENTIDADNACIMIENTO,P1_MUNICIPIONACIMIENTO,P1_LOCALIDADNACIMIENTO,P1_TOMO,P1_LIBRO,P1_FOJA,P1_FECHA_REGISTRO,P1_NUMEROACTA,P1_ANIOREGISTRO,P1_TIPODOCUMENTO,P1_ENTIDADREGISTRO,P1_MUNICIPIOREGISTRO,P1_OFICIALIA,P1_ACTABIS,P1_CURP,P1_CADENA,P2_NOMBRES,P2_PRIMERAPELLIDO,P2_SEGUNDOAPELLIDO,P2_FECHANACIMIENTO,P2_SEXO,P2_EDAD,P2_NACIONALIDAD,P2_PAISNACIMIENTO,P2_ENTIDADNACIMIENTO,P2_MUNICIPIONACIMIENTO,P2_LOCALIDADNACIMIENTO,P2_TOMO,P2_LIBRO,P2_FOJA,P2_FECHA_REGISTRO,P2_NUMEROACTA,P2_ANIOREGISTRO,P2_TIPODOCUMENTO,P2_ENTIDADREGISTRO,P2_MUNICIPIOREGISTRO,P2_OFICIALIA,P2_ACTABIS,P2_CURP,P2_CADENA,ENTIDADREGISTRO_MATRIMONIO,MUNICIPIOREGISTRO_MATRIMONIO,OFICIALIA_MATRIMONIO,TOMO_MATRIMONIO,LIBRO_MATRIMONIO,FOJA_MATRIMONIO,NUMEROACTA_MATRIMONIO,FECHA_REGISTRO_MATRIMONIO,OT_TIPO_DIVORCIO,OT_FECHARESOLUCION,MA_ACTABIS,MA_CADENA,CO_TIPO,CO_FECHAORIGINAL,CO_TRANSCRIPCION,CO_SOPORTE) 
										VALUES(NUMEROACTA,ANIOREGISTRO,TIPODOCUMENTO,ENTIDADREGISTRO,MUNICIPIOREGISTRO,OFICIALIA,ACTABIS,CADENA,CO_FECHA_REGISTRO,CO_LLAVEREGISTROCIVIL,CO_FOJA,CO_TOMO,CO_LIBRO,OT_NOTASMARGINALES,OT_CRIP_P1,OT_CRIP_P2,OT_RESOLUCION_ADMIN,P1_NOMBRES,P1_PRIMERAPELLIDO,P1_SEGUNDOAPELLIDO,P1_FECHANACIMIENTO,P1_SEXO,P1_EDAD,P1_NACIONALIDAD,P1_PAISNACIMIENTO,P1_ENTIDADNACIMIENTO,P1_MUNICIPIONACIMIENTO,P1_LOCALIDADNACIMIENTO,P1_TOMO,P1_LIBRO,P1_FOJA,P1_FECHA_REGISTRO,P1_NUMEROACTA,P1_ANIOREGISTRO,P1_TIPODOCUMENTO,P1_ENTIDADREGISTRO,P1_MUNICIPIOREGISTRO,P1_OFICIALIA,P1_ACTABIS,P1_CURP,P1_CADENA,P2_NOMBRES,P2_PRIMERAPELLIDO,P2_SEGUNDOAPELLIDO,P2_FECHANACIMIENTO,P2_SEXO,P2_EDAD,P2_NACIONALIDAD,P2_PAISNACIMIENTO,P2_ENTIDADNACIMIENTO,P2_MUNICIPIONACIMIENTO,P2_LOCALIDADNACIMIENTO,P2_TOMO,P2_LIBRO,P2_FOJA,P2_FECHA_REGISTRO,P2_NUMEROACTA,P2_ANIOREGISTRO,P2_TIPODOCUMENTO,P2_ENTIDADREGISTRO,P2_MUNICIPIOREGISTRO,P2_OFICIALIA,P2_ACTABIS,P2_CURP,P2_CADENA,ENTIDADREGISTRO_MATRIMONIO,MUNICIPIOREGISTRO_MATRIMONIO,OFICIALIA_MATRIMONIO,TOMO_MATRIMONIO,LIBRO_MATRIMONIO,FOJA_MATRIMONIO,NUMEROACTA_MATRIMONIO,FECHA_REGISTRO_MATRIMONIO,OT_TIPO_DIVORCIO,OT_FECHARESOLUCION,MA_ACTABIS,MA_CADENA,CO_TIPO,CO_FECHAORIGINAL,CO_TRANSCRIPCION,CO_SOPORTE);
											IF (bandera = 1 ) THEN
												INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																							VALUES(CADENA,NOW(),'ERROR DESCONOCIDO',1,4,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
												UPDATE divorcio di
													SET di.VALIDADO = 3,
															di.DESCRICION_ERROR_VALIDACION ='ERROR DESCONOCIDO'
												WHERE di.GUID = CO_LLAVEREGISTROCIVIL;
												SET bandera = 0;
											ELSEIF (bandera = 2 ) THEN
													INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																									VALUES(CADENA,NOW(),'CADENA DUPLICADA',1,4,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
												UPDATE divorcio di
													SET di.VALIDADO = 3,
															di.DESCRICION_ERROR_VALIDACION ='CADENA DUPLICADA'
												WHERE di.GUID = CO_LLAVEREGISTROCIVIL;
												SET bandera = 0;
											ELSE		
													INSERT INTO CIRR_TA25_DIPETICION(TA25_E_PRIORIDAD,TA25_E_OPERACIONACTO,TA25_C_CADENA,TA25_E_ESTATUS,TA25_E_CUANTOS) 
																									VALUES(1,1,CADENA,0,0);
													SET bandera = 0;
											END IF; -- if banderas
									ELSE
										insert into monitor(tipo,mensaje) Values('dato2', concat('actualizar divorcio, ',CADENA));
										UPDATE nrc_divorcios divor SET 
												divor.NUMEROACTA = NUMEROACTA ,divor.ANIOREGISTRO = ANIOREGISTRO ,divor.TIPODOCUMENTO = TIPODOCUMENTO ,divor.ENTIDADREGISTRO = ENTIDADREGISTRO ,divor.MUNICIPIOREGISTRO = MUNICIPIOREGISTRO ,divor.OFICIALIA = OFICIALIA ,divor.ACTABIS = ACTABIS ,divor.CADENA = CADENA ,divor.CO_FECHA_REGISTRO = CO_FECHA_REGISTRO ,divor.CO_LLAVEREGISTROCIVIL = CO_LLAVEREGISTROCIVIL ,divor.CO_FOJA = CO_FOJA ,divor.CO_TOMO = CO_TOMO ,divor.CO_LIBRO = CO_LIBRO ,divor.OT_NOTASMARGINALES = OT_NOTASMARGINALES ,divor.OT_CRIP_P1 = OT_CRIP_P1 ,divor.OT_CRIP_P2 = OT_CRIP_P2 ,divor.OT_RESOLUCION_ADMIN = OT_RESOLUCION_ADMIN ,divor.P1_NOMBRES = P1_NOMBRES ,divor.P1_PRIMERAPELLIDO = P1_PRIMERAPELLIDO ,divor.P1_SEGUNDOAPELLIDO = P1_SEGUNDOAPELLIDO ,divor.P1_FECHANACIMIENTO = P1_FECHANACIMIENTO ,divor.P1_SEXO = P1_SEXO ,divor.P1_EDAD = P1_EDAD ,divor.P1_NACIONALIDAD = P1_NACIONALIDAD ,divor.P1_PAISNACIMIENTO = P1_PAISNACIMIENTO ,divor.P1_ENTIDADNACIMIENTO = P1_ENTIDADNACIMIENTO ,divor.P1_MUNICIPIONACIMIENTO = P1_MUNICIPIONACIMIENTO ,divor.P1_LOCALIDADNACIMIENTO = P1_LOCALIDADNACIMIENTO ,divor.P1_TOMO = P1_TOMO ,divor.P1_LIBRO = P1_LIBRO ,divor.P1_FOJA = P1_FOJA ,divor.P1_FECHA_REGISTRO = P1_FECHA_REGISTRO ,divor.P1_NUMEROACTA = P1_NUMEROACTA ,divor.P1_ANIOREGISTRO = P1_ANIOREGISTRO ,divor.P1_TIPODOCUMENTO = P1_TIPODOCUMENTO ,divor.P1_ENTIDADREGISTRO = P1_ENTIDADREGISTRO ,divor.P1_MUNICIPIOREGISTRO = P1_MUNICIPIOREGISTRO ,divor.P1_OFICIALIA = P1_OFICIALIA ,divor.P1_ACTABIS = P1_ACTABIS ,divor.P1_CURP = P1_CURP ,divor.P1_CADENA = P1_CADENA ,divor.P2_NOMBRES = P2_NOMBRES ,divor.P2_PRIMERAPELLIDO = P2_PRIMERAPELLIDO ,divor.P2_SEGUNDOAPELLIDO = P2_SEGUNDOAPELLIDO ,divor.P2_FECHANACIMIENTO = P2_FECHANACIMIENTO ,divor.P2_SEXO = P2_SEXO ,divor.P2_EDAD = P2_EDAD ,divor.P2_NACIONALIDAD = P2_NACIONALIDAD ,divor.P2_PAISNACIMIENTO = P2_PAISNACIMIENTO ,divor.P2_ENTIDADNACIMIENTO = P2_ENTIDADNACIMIENTO ,divor.P2_MUNICIPIONACIMIENTO = P2_MUNICIPIONACIMIENTO ,divor.P2_LOCALIDADNACIMIENTO = P2_LOCALIDADNACIMIENTO ,divor.P2_TOMO = P2_TOMO ,divor.P2_LIBRO = P2_LIBRO ,divor.P2_FOJA = P2_FOJA ,divor.P2_FECHA_REGISTRO = P2_FECHA_REGISTRO ,divor.P2_NUMEROACTA = P2_NUMEROACTA ,divor.P2_ANIOREGISTRO = P2_ANIOREGISTRO ,divor.P2_TIPODOCUMENTO = P2_TIPODOCUMENTO ,divor.P2_ENTIDADREGISTRO = P2_ENTIDADREGISTRO ,divor.P2_MUNICIPIOREGISTRO = P2_MUNICIPIOREGISTRO ,divor.P2_OFICIALIA = P2_OFICIALIA ,divor.P2_ACTABIS = P2_ACTABIS ,divor.P2_CURP = P2_CURP ,divor.P2_CADENA = P2_CADENA ,divor.ENTIDADREGISTRO_MATRIMONIO = ENTIDADREGISTRO_MATRIMONIO ,divor.MUNICIPIOREGISTRO_MATRIMONIO = MUNICIPIOREGISTRO_MATRIMONIO ,divor.OFICIALIA_MATRIMONIO = OFICIALIA_MATRIMONIO ,divor.TOMO_MATRIMONIO = TOMO_MATRIMONIO ,divor.LIBRO_MATRIMONIO = LIBRO_MATRIMONIO ,divor.FOJA_MATRIMONIO = FOJA_MATRIMONIO ,divor.NUMEROACTA_MATRIMONIO = NUMEROACTA_MATRIMONIO ,divor.FECHA_REGISTRO_MATRIMONIO = FECHA_REGISTRO_MATRIMONIO ,divor.OT_TIPO_DIVORCIO = OT_TIPO_DIVORCIO ,divor.OT_FECHARESOLUCION = OT_FECHARESOLUCION ,divor.MA_ACTABIS = MA_ACTABIS ,divor.MA_CADENA = MA_CADENA ,divor.CO_TIPO = CO_TIPO ,divor.CO_FECHAORIGINAL = CO_FECHAORIGINAL ,divor.CO_TRANSCRIPCION = CO_TRANSCRIPCION ,divor.CO_SOPORTE = CO_SOPORTE 
										WHERE divor.CADENA = CADENA;
											IF (bandera = 1 ) THEN
												INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																							VALUES(CADENA,NOW(),'ERROR DESCONOCIDO',1,4,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
												UPDATE divorcio di
													SET di.VALIDADO = 3,
															di.DESCRICION_ERROR_VALIDACION ='ERROR DESCONOCIDO'
												WHERE di.GUID = CO_LLAVEREGISTROCIVIL;
												SET bandera = 0;
											ELSEIF (bandera = 2 ) THEN
													INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																									VALUES(CADENA,NOW(),'CADENA DUPLICADA',1,4,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
													UPDATE divorcio di
														SET di.VALIDADO = 3,
																di.DESCRICION_ERROR_VALIDACION ='CADENA DUPLICADA'
													WHERE di.GUID = CO_LLAVEREGISTROCIVIL;
													SET bandera = 0;
											ELSE		
												if (cadena=o_cadena) then
													insert into monitor(tipo,mensaje) Values('dato3', concat('actualizar 3 divorcio, ',CADENA));
													INSERT INTO CIRR_TA25_DIPETICION(TA25_E_PRIORIDAD,TA25_E_OPERACIONACTO,TA25_C_CADENA,TA25_E_ESTATUS,TA25_E_CUANTOS) 
																									VALUES(1,3,CADENA,0,0);
													insert into monitor(tipo,mensaje) Values('dato3', concat('actualizar 3 divorcio 2, ',bandera));
												ELSE
													insert into monitor(tipo,mensaje) Values('dato3', concat('actualizar 1 divorcio, ',CADENA));
													INSERT INTO CIRR_TA25_DIPETICION(TA25_E_PRIORIDAD,TA25_E_OPERACIONACTO,TA25_C_CADENA,TA25_E_ESTATUS,TA25_E_CUANTOS) 
																									VALUES(1,1,CADENA,0,0);
													insert into monitor(tipo,mensaje) Values('dato3', concat('actualizar 1 divorcio 2, ',bandera));
												end if;	
													
													SET bandera = 0;
											END IF; -- if banderas									
								END IF;
						END IF;
				END IF;
			ELSE 
			set bandera=0;
			INSERT INTO CIRR_TA25_DIPETICION(TA25_E_PRIORIDAD,TA25_E_OPERACIONACTO,TA25_C_CADENA,TA25_E_ESTATUS,TA25_E_CUANTOS) 
																						VALUES(1,2,NEW.CADENA,0,0);
			if(bandera=0) then

				insert into bitacora_cambio set
				bitacora_cambio.USUARIO= NEW.MODIFICA,
				bitacora_cambio.FECHA= now(),
				bitacora_cambio.TIPO = 'B',
				bitacora_cambio.Tabla = 'DIVORCIO',
				bitacora_cambio.MOdificacion = txt;
			end if;
		END IF;
	
END