DROP TRIGGER IF EXISTS RCW_adopcion_AU;
delimiter $$
CREATE TRIGGER RCW_adopcion_AU
AFTER UPDATE
ON adopcion
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
		DECLARE CO_FECHA_REGISTRO	datetime;
		DECLARE CO_LLAVEREGISTROCIVIL	varchar(70);
		DECLARE CO_FOJA	decimal(5,0);
		DECLARE CO_TOMO	decimal(4,0);
		DECLARE CO_LIBRO	decimal(4,0);
		DECLARE IM_NOMBREORIGINALIMAGEN	varchar(250);
		DECLARE IM_ARCHIVO	longblob;
		DECLARE NA_NUMEROACTA	decimal(5,0);
		DECLARE NA_ANIOREGISTRO	decimal(4,0);
		DECLARE NA_TIPODOCUMENTO	decimal(1,0);
		DECLARE NA_ENTIDADREGISTRO	decimal(2,0);
		DECLARE NA_MUNICIPIOREGISTRO	decimal(3,0);
		DECLARE NA_OFICIALIA	decimal(4,0);
		DECLARE NA_ACTABIS	varchar(1);
		DECLARE OT_NOTASMARGINALES	text;
		DECLARE OT_CRIP	varchar(2000);
		DECLARE OT_FECHARESOLUTIVOJUDICIAL	datetime;
		DECLARE OT_LOCALIDADADOPTADO	varchar(40);
		DECLARE OT_LOCADOPTADOENNACIMIENTO	varchar(40);
		DECLARE OT_PARTERESOLUTIVAJUDICIAL	text;
		DECLARE OT_FECHAREGISTROENNACIMIENTO	datetime;
		DECLARE PE_PRIMERAPELLIDO	varchar(50);
		DECLARE PE_SEGUNDOAPELLIDO	varchar(50);
		DECLARE PE_NOMBRES	varchar(50);
		DECLARE PE_EDAD	decimal(2,0);
		DECLARE PE_SEXO	varchar(1);
		DECLARE PE_FECHANACIMIENTO	datetime;
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
		DECLARE PA_FECHANACIMIENTO	datetime;
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
		DECLARE MA_FECHANACIMIENTO	datetime;
		DECLARE MA_FECHANACIMIENTO_INC	varchar(25);
		DECLARE MA_ENTIDADNACIMIENTO	decimal(2,0);
		DECLARE MA_MUNICIPIONACIMIENTO	decimal(3,0);
		DECLARE MA_LOCALIDADNACIMIENTO	varchar(70);
		DECLARE MA_NACIONALIDAD	decimal(3,0);
		DECLARE MA_PAISNACIMIENTO	decimal(3,0);
		DECLARE MA_CURP	varchar(18);
		DECLARE bandera int(11);
		declare contador int;
		DECLARE ID_ADOPTADO bigint(20);
		DECLARE ID_PADRE bigint(20);
		DECLARE ID_MADRE bigint(20);
		declare txt longtext;
		DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET bandera = 1;			 
		DECLARE CONTINUE HANDLER FOR 1062 SET bandera = 2; -- duplicated primary key

  if ( trim(coalesce(new.notas,''))!='') then
  
  -- se busca primero la nota marginal abierta
  select count(*) into contador from nm_adopcion
  where id_adopcion=new.guid
  and tipo=26 ;
  
  if (contador<=0) THEN
	 select table_sequence_val+1 into contador from sequence_table where table_sequence_name='NM_ADOPCION';
     update sequence_table set table_sequence_val=contador+1 where table_sequence_name='NM_ADOPCION'; 

     insert into nm_adopcion(id, fecha_creacion,fecha_actualizacion,imprimible,tipo,id_adopcion,informacion)
     Values(contador,current_timestamp, current_timestamp, 1, 26, new.guid, new.notas);
  else
     update nm_adopcion set new.notas=new.notas, fecha_actualizacion=current_timestamp
     where id_adopcion=new.guid and tipo=26;
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
		if (new.fecha_registro_adoptado<>old.fecha_registro_adoptado)then
			set txt =concat(txt , 'FECHA REGISTRO ADOPTADO actual: ' ,  cast(new.fecha_registro_adoptado as char) , 'antes: ' , cast(old.fecha_registro_adoptado as char));
		end if;
		if (new.fecha_resolucion<>old.fecha_resolucion)then 
			set txt =concat(txt , 'FECHA RESOLUCION actual: ' , cast(new.fecha_resolucion as char) , ' antes: ' , cast(old.fecha_resolucion as char));
		end if;
		if (new.foja_adoptado<>old.foja_adoptado)then
			set txt =concat(txt , 'FOJA ADOPTADO actual: ' , new.foja_adoptado , ' antes: '  , old.foja_adoptado);
		end if;
		
		if (new.libro_adoptado<>old.libro_adoptado)then
			set txt =concat(txt , 'LIBRO ADOPTADO actual: ' , new.libro_adoptado , ' antes: ' , old.libro_adoptado);
		end if;
		if (new.numero_acta_adoptado<>old.numero_acta_adoptado)then
			set txt =concat(txt , 'NUMERO ACTA ADOPTADO actual: ' , new.numero_acta_adoptado , ' antes: ' , old.numero_acta_adoptado);
		end if;
		/*
		if (new.resolucion_sentencia<>old.resolucion_sentencia)then
			set txt =concat(txt , 'RESOLUCION SENTENCIA actual: ' , new.resolucion_sentencia , ' antes: ' , old.resolucion_sentencia);
		end if;
		if (new.sello<>old.sello)then
			set txt =concat(txt , 'SELLO actual: ' , new.sello , ' antes: ' , old.sello);
		end if;		
		if (new.sello_img<>old.sello_img)then
			set txt =concat(txt , 'SELLO IMG actual: ' , new.sello , ' antes: ' , old.sello_img);
		end if;
		*/
		if (new.tomo_adoptado<>old.tomo_adoptado)then
			set txt =concat(txt , 'TOMO ADOPTADO actual: ' , new.tomo_adoptado , ' antes: ' , old.tomo_adoptado);
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
		if (new.adoptado<>old.adoptado)then
			set txt =concat(txt , 'ADOPTADO actual: ' , new.adoptado , ' antes: ' , old.adoptado);
		end if;
		if (new.adoptante_dos<>old.adoptante_dos)then
			set txt =concat(txt , 'ADOPTANTE DOS actual: ' , cast(new.adoptante_dos as char) , ' antes: ' , cast(old.adoptante_dos as char));
		end if;
		if (new.adoptante_uno<>old.adoptante_uno)then
			set txt =concat(txt , 'ADOPTANTE UNO actual: ' , cast(new.adoptante_dos as char) , ' antes: ' , cast(old.adoptante_uno as char));
		end if;
		if (new.entidad_registro_adoptado<>old.entidad_registro_adoptado)then
			set txt =concat(txt , 'ENTIDAD REGISTRO ADOPTADO actual: ' , cast(new.entidad_registro_adoptado as char) , ' antes: ' , cast(old.entidad_registro_adoptado as char));
		end if;
		if (new.municipio_registro_adoptado<>old.municipio_registro_adoptado)then
			set txt =concat(txt , 'MUNICIPIO REGISTRO ADOPTADO actual: ' , cast(new.municipio_registro_adoptado as char) , ' antes: ' , cast(old.municipio_registro_adoptado as char));
		end if;
		if (new.oficialia_adoptado<>old.oficialia_adoptado)then
			set txt =concat(txt´, 'OFICIALIA ADOPTADO actual: ' , cast(new.oficialia_adoptado as char) , ' antes: ' , cast(old.oficialia_adoptado as char));
		end if;
		if (new.padre_dos_adoptante<>old.padre_dos_adoptante)then
			set txt =concat(txt , 'PADRE DOS ADOPTANTE actual: ' , cast(new.padre_dos_adoptante as char) , ' antes: ' , cast(old.padre_dos_adoptante as char));
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
		
		if (new.num_expediente<>old.num_expediente)then
			set txt =concat(txt , 'NUM EXPEDIENTE actual: ' , new.num_expediente , ' antes: ' , old.num_expediente);
		end if;
		*/
		if (new.modifica<>old.modifica)then
			set txt =concat(txt , 'MODIFICA actual: ' , cast(new.modifica as char) , ' antes: ' , cast(old.modifica as char));
		end if;
		if (new.apellido_dos_antes<>old.apellido_dos_antes)then
			set txt =concat(txt , 'APELLIDO DOS ANTES actual: ' , new.apellido_dos_antes , ' antes: ' , old.apellido_dos_antes);
		end if;
		if (new.apellido_uno_antes<>old.apellido_uno_antes)then
			set txt =concat(txt , 'APELLIDO UNO ANTES actual: ' , new.apellido_uno_antes , ' antes: ' , old.apellido_uno_antes);
		end if;

		insert into bitacora_cambio set
		bitacora_cambio.USUARIO= NEW.MODIFICA,
		bitacora_cambio.FECHA= now(),
		bitacora_cambio.TIPO = 'M',
		bitacora_cambio.Tabla = 'ADOPCION',
		bitacora_cambio.MOdificacion = txt;
		
		insert into monitor(tipo,mensaje) Values('inicia 2', concat('insertar adopcion, '));
		IF (NEW.FECHA_BORRADO IS NULL)THEN	
				IF( (NEW.VALIDADO = 1) or (cadena!=o_cadena and new.validado>0))THEN
					
					SET ID_ADOPTADO = NEW.ADOPTADO;
					SET ID_PADRE = NEW.ADOPTANTE_DOS;
					SET ID_MADRE = NEW.ADOPTANTE_UNO;
					
					SET NUMEROACTA	= NEW.NUMERO_ACTA;
					SET ANIOREGISTRO	= YEAR(NEW.FECHA_REGISTRO);
					SET TIPODOCUMENTO = 6;
					SET NA_TIPODOCUMENTO = 1;
					SET PA_TIPODOCUMENTO = 1;
					SET MA_TIPODOCUMENTO = 1;
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
					set contador = 0;
					SET CO_FOJA	= IF(LENGTH(TRIM(NEW.FOJA)) = 0, null,NEW.FOJA);
					SET CO_TOMO	= IF(LENGTH(TRIM(NEW.TOMO)) = 0, null,NEW.TOMO);
					SET CO_LIBRO = IF(LENGTH(TRIM(NEW.LIBRO)) = 0, null,NEW.LIBRO);
					SET OT_FECHARESOLUTIVOJUDICIAL = NEW.FECHA_RESOLUCION;
					SET OT_LOCALIDADADOPTADO =  f_char_limpiar_CE(NEW.localidadRegistroAdoptado);
					SET OT_PARTERESOLUTIVAJUDICIAL = NEW.RESOLUCION_SENTENCIA;
					SET OT_NOTASMARGINALES = f_char_notas_adopcion(NEW.GUID);		

					-- Datos de nacimiento del adoptado
					SELECT nac.NUMERO_ACTA,YEAR(nac.FECHA_REGISTRO),
						(SELECT cat_ent.ID_RENAPO FROM cat_estado cat_ent WHERE cat_ent.id = nac.ENTIDAD_REGISTRO),
						(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = nac.MUNICIPIO_REGISTRO),
						(SELECT cat_of.ID_RENAPO FROM cat_oficialia cat_of WHERE cat_of.id = nac.OFICIALIA),
						nac.ACTA_BIS,nac.FECHA_REGISTRO
						INTO NA_NUMEROACTA,NA_ANIOREGISTRO,NA_ENTIDADREGISTRO,NA_MUNICIPIOREGISTRO,NA_OFICIALIA,NA_ACTABIS,OT_FECHAREGISTROENNACIMIENTO
					FROM nacimiento nac
					WHERE nac.REGISTRADO = ID_ADOPTADO AND nac.GUID = NEW.ACTA_NACIMIENTO limit 1;
					
					-- Datos de nacimiento de el adoptado
					SELECT per.CRIP, f_char_limpiar(per.NOMBRE), f_char_limpiar(per.PRIMER_APELLIDO), f_char_limpiar(per.SEGUNDO_APELLIDO),per.FECHA_NACIMIENTO,per.SEXO,per.EDAD,
							(SELECT cat_p.ID FROM cat_pais cat_p WHERE cat_p.id = per.PAIS),
							(SELECT cat_e.ID_RENAPO FROM cat_estado cat_e where cat_e.id = per.ENTIDAD),
							(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = per.MUNICIPIO),
							 f_char_limpiar_CE(per.LOCALIDAD),per.CURP
						INTO OT_CRIP,PE_NOMBRES,PE_PRIMERAPELLIDO,PE_SEGUNDOAPELLIDO,PE_FECHANACIMIENTO,PE_SEXO,PE_EDAD,PE_NACIONALIDAD,PE_ENTIDADNACIMIENTO,PE_MUNICIPIONACIMIENTO,PE_LOCALIDADNACIMIENTO,PE_CURP
					FROM persona per
					WHERE per.id = ID_ADOPTADO limit 1;
					SET PE_PAISNACIMIENTO = PE_NACIONALIDAD;
					
					-- datos de padre
					SELECT  f_char_limpiar(per.NOMBRE), f_char_limpiar(per.PRIMER_APELLIDO), f_char_limpiar(per.SEGUNDO_APELLIDO),per.FECHA_NACIMIENTO,per.SEXO,per.EDAD,
							(SELECT cat_p.ID FROM cat_pais cat_p WHERE cat_p.id = per.PAIS),
							(SELECT cat_e.ID_RENAPO FROM cat_estado cat_e where cat_e.id = per.ENTIDAD),
							(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = per.MUNICIPIO),
							 f_char_limpiar_CE(per.LOCALIDAD),per.CURP
						INTO PA_NOMBRES,PA_PRIMERAPELLIDO,PA_SEGUNDOAPELLIDO,PA_FECHANACIMIENTO,PA_SEXO,PA_EDAD,PA_NACIONALIDAD,PA_ENTIDADNACIMIENTO,PA_MUNICIPIONACIMIENTO,PA_LOCALIDADNACIMIENTO,PA_CURP
					FROM persona per
					WHERE per.id = ID_PADRE limit 1;
					SET PA_PAISNACIMIENTO = PA_NACIONALIDAD;
					-- Datos del registro de nacimiento del padre
					SELECT nac.NUMERO_ACTA,YEAR(nac.FECHA_REGISTRO),
						(SELECT cat_ent.ID_RENAPO FROM cat_estado cat_ent WHERE cat_ent.id = nac.ENTIDAD_REGISTRO),
						(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = nac.MUNICIPIO_REGISTRO),
						(SELECT cat_of.ID_RENAPO FROM cat_oficialia cat_of WHERE cat_of.id = nac.OFICIALIA),
						nac.ACTA_BIS
						INTO PA_NUMEROACTA,PA_ANIOREGISTRO,PA_ENTIDADREGISTRO,PA_MUNICIPIOREGISTRO,PA_OFICIALIA,PA_ACTABIS
					FROM nacimiento nac
					WHERE nac.REGISTRADO = ID_PADRE limit 1;
					-- datos de la madre
					SELECT  f_char_limpiar(per.NOMBRE), f_char_limpiar(per.PRIMER_APELLIDO), f_char_limpiar(per.SEGUNDO_APELLIDO),per.FECHA_NACIMIENTO,per.SEXO,per.EDAD,
							(SELECT cat_p.ID FROM cat_pais cat_p WHERE cat_p.id = per.PAIS),
							(SELECT cat_e.ID_RENAPO FROM cat_estado cat_e where cat_e.id = per.ENTIDAD),
							(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = per.MUNICIPIO),
							 f_char_limpiar_CE(per.LOCALIDAD),per.CURP
						INTO MA_NOMBRES,MA_PRIMERAPELLIDO,MA_SEGUNDOAPELLIDO,MA_FECHANACIMIENTO,MA_SEXO,MA_EDAD,MA_NACIONALIDAD,MA_ENTIDADNACIMIENTO,MA_MUNICIPIONACIMIENTO,MA_LOCALIDADNACIMIENTO,MA_CURP
					FROM persona per
					WHERE per.id = ID_MADRE limit 1;
					SET MA_PAISNACIMIENTO = MA_NACIONALIDAD;
					-- Datos del registro de nacimiento del padre
					SELECT nac.NUMERO_ACTA,YEAR(nac.FECHA_REGISTRO),
						(SELECT cat_ent.ID_RENAPO FROM cat_estado cat_ent WHERE cat_ent.id = nac.ENTIDAD_REGISTRO),
						(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = nac.MUNICIPIO_REGISTRO),
						(SELECT cat_of.ID_RENAPO FROM cat_oficialia cat_of WHERE cat_of.id = nac.OFICIALIA),
						nac.ACTA_BIS
						INTO MA_NUMEROACTA,MA_ANIOREGISTRO,MA_ENTIDADREGISTRO,MA_MUNICIPIOREGISTRO,MA_OFICIALIA,MA_ACTABIS
					FROM nacimiento nac
					WHERE nac.REGISTRADO = ID_MADRE limit 1;
					
					IF((PE_PRIMERAPELLIDO IS NULL OR LENGTH(PE_PRIMERAPELLIDO) = 0) AND(PE_SEGUNDOAPELLIDO IS NOT NULL OR LENGTH(PE_SEGUNDOAPELLIDO) > 0))THEN
						SET PE_PRIMERAPELLIDO  = PE_SEGUNDOAPELLIDO; 
						SET PE_SEGUNDOAPELLIDO = null; 
					END IF;
					IF(PE_NACIONALIDAD IS NULL OR PE_NACIONALIDAD = 0)THEN			
							SET PE_NACIONALIDAD = 223;
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
					IF (LENGTH(OT_PARTERESOLUTIVAJUDICIAL) > 2000 OR LENGTH(TRIM(OT_PARTERESOLUTIVAJUDICIAL)) = 0) THEN
							SET OT_PARTERESOLUTIVAJUDICIAL = null;
					END IF;
					-- se manda la baja cuando hay un cambio en los datos de la cadena
					if (cadena!=o_cadena) THEN							
						insert into monitor(tipo,mensaje) Values('dato1', concat('baja de adopcion, ',CADENA,',',O_CADENA,','));

					-- se da de baja la cadena anterior
						INSERT INTO CIRR_TA05_ASPETICION(TA05_E_PRIORIDAD,TA05_E_OPERACIONACTO,TA05_C_CADENA,TA05_E_ESTATUS,TA05_E_CUANTOS) 
																								VALUES(1,2,O_CADENA,0,0);							
					end if;
					SET BANDERA=0;
					insert into monitor(tipo,mensaje) Values('inicia 3', concat('VALIDAR adopcion, '));
					IF(LENGTH(CADENA) <> 20 OR CADENA IS NULL)THEN
						INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'CADENA INVALIDA',1,6,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE adopcion ad
								SET ad.VALIDADO = 3,
										ad.DESCRICION_ERROR_VALIDACION ='CADENA INVALIDA'
							WHERE ad.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF(PE_SEXO IS NULL OR (PE_SEXO <> 'F' AND PE_SEXO <> 'M'))THEN
						INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'SEXO DEL REGISTRADO ES INVALIDO',1,6,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE adopcion ad
								SET ad.VALIDADO = 3,
										ad.DESCRICION_ERROR_VALIDACION ='SEXO DEL REGISTRADO ES INVALIDO'
							WHERE ad.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF((PE_NOMBRES IS NULL OR LENGTH(TRIM(PE_NOMBRES)) = 0 ) OR (PE_PRIMERAPELLIDO IS NULL OR LENGTH(TRIM(PE_PRIMERAPELLIDO)) = 0 ))THEN
						INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'EL NOMBRE Y APELLIDO DEL REGISTRADDO SON NULOS',1,6,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE adopcion ad
								SET ad.VALIDADO = 3,
										ad.DESCRICION_ERROR_VALIDACION ='EL NOMBRE Y APELLIDO DEL REGISTRADDO SON NULOS'
							WHERE ad.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF(NUMEROACTA IS NULL OR NUMEROACTA = 0)THEN
						INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'NUMERO DE ACTAINVALIDO',1,6,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE adopcion ad
								SET ad.VALIDADO = 3,
										ad.DESCRICION_ERROR_VALIDACION ='NUMERO DE ACTAINVALIDO'
							WHERE ad.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF(ANIOREGISTRO IS NULL OR ANIOREGISTRO = 0)THEN
						INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'AÑO DE REGISTRO INVALIDO',1,6,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE adopcion ad
								SET ad.VALIDADO = 3,
										ad.DESCRICION_ERROR_VALIDACION ='AÑO DE REGISTRO INVALIDO'
							WHERE ad.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF(MUNICIPIOREGISTRO IS NULL OR MUNICIPIOREGISTRO = 0)THEN
						INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'MUNICIPIO DE REGISTRO INVALIDO',1,6,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE adopcion ad
								SET ad.VALIDADO = 3,
										ad.DESCRICION_ERROR_VALIDACION ='MUNICIPIO DE REGISTRO INVALIDO'
							WHERE ad.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF(PE_ENTIDADNACIMIENTO IS NULL OR PE_ENTIDADNACIMIENTO = 0)THEN
						INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'ENTIDAD DE NACIMIENTO INVALIDA',1,6,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE adopcion ad
								SET ad.VALIDADO = 3,
										ad.DESCRICION_ERROR_VALIDACION ='ENTIDAD DE NACIMIENTO INVALIDA'
							WHERE ad.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF(CO_FECHA_REGISTRO IS NULL OR CO_FECHA_REGISTRO = '0000-00-00 00:00:00' or CO_FECHA_REGISTRO > NOW())THEN
						INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'FECHA DE REGISTRO INVALIDA',1,6,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE adopcion ad
								SET ad.VALIDADO = 3,
										ad.DESCRICION_ERROR_VALIDACION ='FECHA DE REGISTRO INVALIDA'
							WHERE ad.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF(OT_FECHARESOLUTIVOJUDICIAL IS NULL OR OT_FECHARESOLUTIVOJUDICIAL > NOW())THEN
						INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'FECHA DE RESOLUCION INVALIDA',1,6,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE adopcion ad
								SET ad.VALIDADO = 3,
										ad.DESCRICION_ERROR_VALIDACION ='FECHA DE RESOLUCION INVALIDA'
							WHERE ad.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF(NA_NUMEROACTA IS NULL OR NA_NUMEROACTA = 0)THEN
						INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'NUMERO DE ACTA DEL REGISTRO DE NACIMIENTO INVALIDA',1,6,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE adopcion ad
								SET ad.VALIDADO = 3,
										ad.DESCRICION_ERROR_VALIDACION ='NUMERO DE ACTA DEL REGISTRO DE NACIMIENTO INVALIDA'
							WHERE ad.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF(NA_ANIOREGISTRO IS NULL OR NA_ANIOREGISTRO = 0)THEN
						INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'AÑO DE REGISTRO DE NACIMIENTO INVALIDO',1,6,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE adopcion ad
								SET ad.VALIDADO = 3,
										ad.DESCRICION_ERROR_VALIDACION ='AÑO DE REGISTRO DE NACIMIENTO INVALIDO'
							WHERE ad.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF(NA_ENTIDADREGISTRO IS NULL OR NA_ENTIDADREGISTRO = 0)THEN
						INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'ENTIDAD DE REGISTRO DE NACIMIENTO INVALIDA',1,6,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE adopcion ad
								SET ad.VALIDADO = 3,
										ad.DESCRICION_ERROR_VALIDACION ='ENTIDAD DE REGISTRO DE NACIMIENTO INVALIDA'
							WHERE ad.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF(NA_MUNICIPIOREGISTRO IS NULL OR NA_MUNICIPIOREGISTRO = 0)THEN
						INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'MUNICIPIO DE REGISTRO DE NACIMIENTO INVALIDO',1,6,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE adopcion ad
								SET ad.VALIDADO = 3,
										ad.DESCRICION_ERROR_VALIDACION ='MUNICIPIO DE REGISTRO DE NACIMIENTO INVALIDO'
							WHERE ad.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF(NA_OFICIALIA IS NULL OR NA_OFICIALIA = 0)THEN
						INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'OFICIALIA DE REGISTRO DE NACIMIENTO INVALIDA',1,6,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE adopcion ad
								SET ad.VALIDADO = 3,
										ad.DESCRICION_ERROR_VALIDACION ='OFICIALIA DE REGISTRO DE NACIMIENTO INVALIDA'
							WHERE ad.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF(NA_ACTABIS IS NULL)THEN
						INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'ACTABIS DE NACIMIENTO INVALIDA',1,6,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE adopcion ad
								SET ad.VALIDADO = 3,
										ad.DESCRICION_ERROR_VALIDACION ='ACTABIS DE NACIMIENTO INVALIDA'
							WHERE ad.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF(OT_PARTERESOLUTIVAJUDICIAL IS NULL OR LENGTH(TRIM(OT_PARTERESOLUTIVAJUDICIAL)) < 2 )THEN
						INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																						VALUES(CADENA,NOW(),'RESOLUCION ADMINISTRATIVA NULA',1,6,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
							UPDATE adopcion ad
								SET ad.VALIDADO = 3,
										ad.DESCRICION_ERROR_VALIDACION ='RESOLUCION ADMINISTRATIVA NULA'
							WHERE ad.GUID = CO_LLAVEREGISTROCIVIL;
					ELSE
						set bandera =0;
						set  contador=0;
						
						select count(*) into contador from nrc_adopciones where CO_LLAVEREGISTROCIVIL=new.GUID;
						insert into monitor(tipo,mensaje) Values('error -1', concat('insertar adopcion2, ',CADENA, ',',cast(contador as char), ',',cast(bandera as char)));
						IF (  contador<=0 )THEN
						-- insert into monitor(tipo,mensaje) Values('error 0', 'insertar adopcion');
						insert into monitor(tipo,mensaje) Values('dato1', concat('inserta cadena, ',CADENA,',',O_CADENA,',  old ',cast(old.validado as char),',  new ',cast(new.validado as char)));
								insert into monitor(tipo,mensaje) Values('inicia', concat('insertar adopcion, '));	
								INSERT INTO nrc_adopciones (NUMEROACTA,ANIOREGISTRO,TIPODOCUMENTO,ENTIDADREGISTRO,MUNICIPIOREGISTRO,OFICIALIA,ACTABIS,CADENA,CO_FECHA_REGISTRO,CO_LLAVEREGISTROCIVIL,CO_FOJA,CO_TOMO,CO_LIBRO,IM_NOMBREORIGINALIMAGEN,IM_ARCHIVO,NA_NUMEROACTA,NA_ANIOREGISTRO,NA_TIPODOCUMENTO,NA_ENTIDADREGISTRO,NA_MUNICIPIOREGISTRO,NA_OFICIALIA,NA_ACTABIS,OT_NOTASMARGINALES,OT_CRIP,OT_FECHARESOLUTIVOJUDICIAL,OT_LOCALIDADADOPTADO,OT_LOCADOPTADOENNACIMIENTO,OT_PARTERESOLUTIVAJUDICIAL,OT_FECHAREGISTROENNACIMIENTO,PE_PRIMERAPELLIDO,PE_SEGUNDOAPELLIDO,PE_NOMBRES,PE_EDAD,PE_SEXO,PE_FECHANACIMIENTO,PE_FECHANACIMIENTO_INC,PE_ENTIDADNACIMIENTO,PE_MUNICIPIONACIMIENTO,PE_LOCALIDADNACIMIENTO,PE_NACIONALIDAD,PE_PAISNACIMIENTO,PE_CURP,PA_PRIMERAPELLIDO,PA_SEGUNDOAPELLIDO,PA_NOMBRES,PA_EDAD,PA_SEXO,PA_FECHANACIMIENTO,PA_FECHANACIMIENTO_INC,PA_ENTIDADNACIMIENTO,PA_MUNICIPIONACIMIENTO,PA_LOCALIDADNACIMIENTO,PA_NACIONALIDAD,PA_PAISNACIMIENTO,PA_CURP,PA_NUMEROACTA,PA_ANIOREGISTRO,PA_TIPODOCUMENTO,PA_ENTIDADREGISTRO,PA_MUNICIPIOREGISTRO,PA_OFICIALIA,PA_ACTABIS,MA_NUMEROACTA,MA_ANIOREGISTRO,MA_TIPODOCUMENTO,MA_ENTIDADREGISTRO,MA_MUNICIPIOREGISTRO,MA_OFICIALIA,MA_ACTABIS,MA_PRIMERAPELLIDO,MA_SEGUNDOAPELLIDO,MA_NOMBRES,MA_EDAD,MA_SEXO,MA_FECHANACIMIENTO,MA_FECHANACIMIENTO_INC,MA_ENTIDADNACIMIENTO,MA_MUNICIPIONACIMIENTO,MA_LOCALIDADNACIMIENTO,MA_NACIONALIDAD,MA_PAISNACIMIENTO,MA_CURP) 
																			VALUES (NUMEROACTA,ANIOREGISTRO,TIPODOCUMENTO,ENTIDADREGISTRO,MUNICIPIOREGISTRO,OFICIALIA,ACTABIS,CADENA,CO_FECHA_REGISTRO,CO_LLAVEREGISTROCIVIL,CO_FOJA,CO_TOMO,CO_LIBRO,IM_NOMBREORIGINALIMAGEN,IM_ARCHIVO,NA_NUMEROACTA,NA_ANIOREGISTRO,NA_TIPODOCUMENTO,NA_ENTIDADREGISTRO,NA_MUNICIPIOREGISTRO,NA_OFICIALIA,NA_ACTABIS,OT_NOTASMARGINALES,OT_CRIP,OT_FECHARESOLUTIVOJUDICIAL,OT_LOCALIDADADOPTADO,OT_LOCADOPTADOENNACIMIENTO,OT_PARTERESOLUTIVAJUDICIAL,OT_FECHAREGISTROENNACIMIENTO,PE_PRIMERAPELLIDO,PE_SEGUNDOAPELLIDO,PE_NOMBRES,PE_EDAD,PE_SEXO,PE_FECHANACIMIENTO,PE_FECHANACIMIENTO_INC,PE_ENTIDADNACIMIENTO,PE_MUNICIPIONACIMIENTO,PE_LOCALIDADNACIMIENTO,PE_NACIONALIDAD,PE_PAISNACIMIENTO,PE_CURP,PA_PRIMERAPELLIDO,PA_SEGUNDOAPELLIDO,PA_NOMBRES,PA_EDAD,PA_SEXO,PA_FECHANACIMIENTO,PA_FECHANACIMIENTO_INC,PA_ENTIDADNACIMIENTO,PA_MUNICIPIONACIMIENTO,PA_LOCALIDADNACIMIENTO,PA_NACIONALIDAD,PA_PAISNACIMIENTO,PA_CURP,PA_NUMEROACTA,PA_ANIOREGISTRO,PA_TIPODOCUMENTO,PA_ENTIDADREGISTRO,PA_MUNICIPIOREGISTRO,PA_OFICIALIA,PA_ACTABIS,MA_NUMEROACTA,MA_ANIOREGISTRO,MA_TIPODOCUMENTO,MA_ENTIDADREGISTRO,MA_MUNICIPIOREGISTRO,MA_OFICIALIA,MA_ACTABIS,MA_PRIMERAPELLIDO,MA_SEGUNDOAPELLIDO,MA_NOMBRES,MA_EDAD,MA_SEXO,MA_FECHANACIMIENTO,MA_FECHANACIMIENTO_INC,MA_ENTIDADNACIMIENTO,MA_MUNICIPIONACIMIENTO,MA_LOCALIDADNACIMIENTO,MA_NACIONALIDAD,MA_PAISNACIMIENTO,MA_CURP);
											IF (bandera = 1 ) THEN
												INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																							VALUES(CADENA,NOW(),'ERROR DESCONOCIDO',1,6,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
												UPDATE adopcion ad
													SET ad.VALIDADO = 3,
															ad.DESCRICION_ERROR_VALIDACION ='ERROR DESCONOCIDO'
												WHERE ad.GUID = CO_LLAVEREGISTROCIVIL;
												SET bandera = 0;
											ELSEIF (bandera = 2 ) THEN
													INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																									VALUES(CADENA,NOW(),'CADENA DUPLICADA',1,6,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
												UPDATE adopcion ad
													SET ad.VALIDADO = 3,
															ad.DESCRICION_ERROR_VALIDACION ='CADENA DUPLICADA'
												WHERE ad.GUID = CO_LLAVEREGISTROCIVIL;
												SET bandera = 0;
											ELSE		
													INSERT INTO CIRR_TA05_ASPETICION(TA05_E_PRIORIDAD,TA05_E_OPERACIONACTO,TA05_C_CADENA,TA05_E_ESTATUS,TA05_E_CUANTOS) 
																									VALUES(1,1,CADENA,0,0);
													SET bandera = 0;
											END IF; -- if banderas
								ELSE	

									insert into monitor(tipo,mensaje) Values('inicia', concat('actualiza adopcion, '));
									UPDATE nrc_adopciones adop SET 
										adop.NUMEROACTA = NUMEROACTA, adop.ANIOREGISTRO = ANIOREGISTRO, adop.TIPODOCUMENTO = TIPODOCUMENTO, adop.ENTIDADREGISTRO = ENTIDADREGISTRO, adop.MUNICIPIOREGISTRO = MUNICIPIOREGISTRO, adop.OFICIALIA = OFICIALIA, adop.ACTABIS = ACTABIS, adop.CADENA = CADENA, adop.CO_FECHA_REGISTRO = CO_FECHA_REGISTRO, adop.CO_LLAVEREGISTROCIVIL = CO_LLAVEREGISTROCIVIL, adop.CO_FOJA = CO_FOJA, adop.CO_TOMO = CO_TOMO, adop.CO_LIBRO = CO_LIBRO, adop.IM_NOMBREORIGINALIMAGEN = IM_NOMBREORIGINALIMAGEN, adop.IM_ARCHIVO = IM_ARCHIVO, adop.NA_NUMEROACTA = NA_NUMEROACTA, adop.NA_ANIOREGISTRO = NA_ANIOREGISTRO, adop.NA_TIPODOCUMENTO = NA_TIPODOCUMENTO, adop.NA_ENTIDADREGISTRO = NA_ENTIDADREGISTRO, adop.NA_MUNICIPIOREGISTRO = NA_MUNICIPIOREGISTRO, adop.NA_OFICIALIA = NA_OFICIALIA, adop.NA_ACTABIS = NA_ACTABIS, adop.OT_NOTASMARGINALES = OT_NOTASMARGINALES, adop.OT_CRIP = OT_CRIP, adop.OT_FECHARESOLUTIVOJUDICIAL = OT_FECHARESOLUTIVOJUDICIAL, adop.OT_LOCALIDADADOPTADO = OT_LOCALIDADADOPTADO, adop.OT_LOCADOPTADOENNACIMIENTO = OT_LOCADOPTADOENNACIMIENTO, adop.OT_PARTERESOLUTIVAJUDICIAL = OT_PARTERESOLUTIVAJUDICIAL, adop.OT_FECHAREGISTROENNACIMIENTO = OT_FECHAREGISTROENNACIMIENTO, adop.PE_PRIMERAPELLIDO = PE_PRIMERAPELLIDO, adop.PE_SEGUNDOAPELLIDO = PE_SEGUNDOAPELLIDO, adop.PE_NOMBRES = PE_NOMBRES, adop.PE_EDAD = PE_EDAD, adop.PE_SEXO = PE_SEXO, adop.PE_FECHANACIMIENTO = PE_FECHANACIMIENTO, adop.PE_FECHANACIMIENTO_INC = PE_FECHANACIMIENTO_INC, adop.PE_ENTIDADNACIMIENTO = PE_ENTIDADNACIMIENTO, adop.PE_MUNICIPIONACIMIENTO = PE_MUNICIPIONACIMIENTO, adop.PE_LOCALIDADNACIMIENTO = PE_LOCALIDADNACIMIENTO, adop.PE_NACIONALIDAD = PE_NACIONALIDAD, adop.PE_PAISNACIMIENTO = PE_PAISNACIMIENTO, adop.PE_CURP = PE_CURP, adop.PA_PRIMERAPELLIDO = PA_PRIMERAPELLIDO, adop.PA_SEGUNDOAPELLIDO = PA_SEGUNDOAPELLIDO, adop.PA_NOMBRES = PA_NOMBRES, adop.PA_EDAD = PA_EDAD, adop.PA_SEXO = PA_SEXO, adop.PA_FECHANACIMIENTO = PA_FECHANACIMIENTO, adop.PA_FECHANACIMIENTO_INC = PA_FECHANACIMIENTO_INC, adop.PA_ENTIDADNACIMIENTO = PA_ENTIDADNACIMIENTO, adop.PA_MUNICIPIONACIMIENTO = PA_MUNICIPIONACIMIENTO, adop.PA_LOCALIDADNACIMIENTO = PA_LOCALIDADNACIMIENTO, adop.PA_NACIONALIDAD = PA_NACIONALIDAD, adop.PA_PAISNACIMIENTO = PA_PAISNACIMIENTO, adop.PA_CURP = PA_CURP, adop.PA_NUMEROACTA = PA_NUMEROACTA, adop.PA_ANIOREGISTRO = PA_ANIOREGISTRO, adop.PA_TIPODOCUMENTO = PA_TIPODOCUMENTO, adop.PA_ENTIDADREGISTRO = PA_ENTIDADREGISTRO, adop.PA_MUNICIPIOREGISTRO = PA_MUNICIPIOREGISTRO, adop.PA_OFICIALIA = PA_OFICIALIA, adop.PA_ACTABIS = PA_ACTABIS, adop.MA_NUMEROACTA = MA_NUMEROACTA, adop.MA_ANIOREGISTRO = MA_ANIOREGISTRO, adop.MA_TIPODOCUMENTO = MA_TIPODOCUMENTO, adop.MA_ENTIDADREGISTRO = MA_ENTIDADREGISTRO, adop.MA_MUNICIPIOREGISTRO = MA_MUNICIPIOREGISTRO, adop.MA_OFICIALIA = MA_OFICIALIA, adop.MA_ACTABIS = MA_ACTABIS, adop.MA_PRIMERAPELLIDO = MA_PRIMERAPELLIDO, adop.MA_SEGUNDOAPELLIDO = MA_SEGUNDOAPELLIDO, adop.MA_NOMBRES = MA_NOMBRES, adop.MA_EDAD = MA_EDAD, adop.MA_SEXO = MA_SEXO, adop.MA_FECHANACIMIENTO = MA_FECHANACIMIENTO, adop.MA_FECHANACIMIENTO_INC = MA_FECHANACIMIENTO_INC, adop.MA_ENTIDADNACIMIENTO = MA_ENTIDADNACIMIENTO, adop.MA_MUNICIPIONACIMIENTO = MA_MUNICIPIONACIMIENTO, adop.MA_LOCALIDADNACIMIENTO = MA_LOCALIDADNACIMIENTO, adop.MA_NACIONALIDAD = MA_NACIONALIDAD, adop.MA_PAISNACIMIENTO = MA_PAISNACIMIENTO, adop.MA_CURP = MA_CURP 
									WHERE adop.CO_LLAVEREGISTROCIVIL = CO_LLAVEREGISTROCIVIL;
											IF (bandera = 1 ) THEN
												INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																							VALUES(CADENA,NOW(),'ERROR DESCONOCIDO',1,6,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
												UPDATE adopcion ad
													SET ad.VALIDADO = 3,
															ad.DESCRICION_ERROR_VALIDACION ='ERROR DESCONOCIDO'
												WHERE ad.GUID = CO_LLAVEREGISTROCIVIL;
												SET bandera = 0;
											ELSEIF (bandera = 2 ) THEN
													INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																									VALUES(CADENA,NOW(),'CADENA DUPLICADA',1,6,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
													UPDATE adopcion ad
														SET ad.VALIDADO = 3,
																ad.DESCRICION_ERROR_VALIDACION ='CADENA DUPLICADA'
													WHERE ad.GUID = CO_LLAVEREGISTROCIVIL;
													SET bandera = 0;
											ELSE		
												if (cadena=o_cadena) then
													insert into monitor(tipo,mensaje) Values('dato2', concat('actualizar 3 adopcion, '));
													INSERT INTO CIRR_TA05_ASPETICION(TA05_E_PRIORIDAD,TA05_E_OPERACIONACTO,TA05_C_CADENA,TA05_E_ESTATUS,TA05_E_CUANTOS) 
																									VALUES(1,3,CADENA,0,0);
												ELSE
													insert into monitor(tipo,mensaje) Values('dato2', concat('actualizar 1 adopcion, '));
													INSERT INTO CIRR_TA05_ASPETICION(TA05_E_PRIORIDAD,TA05_E_OPERACIONACTO,TA05_C_CADENA,TA05_E_ESTATUS,TA05_E_CUANTOS) 
																									VALUES(1,1,CADENA,0,0);
												end if;
													SET bandera = 0;
											END IF; -- if banderas
								END IF;
					END IF;
				END IF;
		ELSE
			if (old.FECHA_BORRADO!=null) then			
				insert into monitor(tipo,mensaje) Values('paso30', concat('baja adopcion, '));
				set bandera=0;
				INSERT INTO CIRR_TA05_ASPETICION(TA05_E_PRIORIDAD,TA05_E_OPERACIONACTO,TA05_C_CADENA,TA05_E_ESTATUS,TA05_E_CUANTOS) 
																						VALUES(1,2,NEW.CADENA,0,0);
				if (bandera=0) then

				insert into bitacora_cambio set
				bitacora_cambio.USUARIO= NEW.MODIFICA,
				bitacora_cambio.FECHA= now(),
				bitacora_cambio.TIPO = 'B',
				bitacora_cambio.Tabla = 'ADOPCION',
				bitacora_cambio.MOdificacion = txt;
				end if;
			end if;
		END IF;
END