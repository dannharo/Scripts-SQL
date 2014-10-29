DROP TRIGGER IF EXISTS RCW_defuncion_AU;
delimiter $$
CREATE TRIGGER RCW_defuncion_AU
AFTER UPDATE
ON defuncion
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
		DECLARE N_CADENA	varchar(20);
		DECLARE O_CADENA	varchar(20);
		DECLARE CO_FECHA_REGISTRO	datetime;
		DECLARE CO_FECHA_REGISTRO_INC	varchar(25);
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
		DECLARE OT_ESTADOCIVILDIFUNTO	varchar(1);
		DECLARE OT_CAUSADEFUNCION	varchar(2000);
		DECLARE OT_FECHADEFUNCION	datetime;
		DECLARE OT_FECHADEFUNCION_INC	varchar(25);
		DECLARE OT_TIPODEFUNCION	varchar(1);
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
		DECLARE CY_PRIMERAPELLIDO	varchar(50);
		DECLARE CY_SEGUNDOAPELLIDO	varchar(50);
		DECLARE CY_NOMBRES	varchar(50);
		DECLARE CY_EDAD	decimal(2,0);
		DECLARE CY_SEXO	varchar(1);
		DECLARE CY_FECHANACIMIENTO	date;
		DECLARE CY_FECHANACIMIENTO_INC	varchar(25);
		DECLARE CY_ENTIDADNACIMIENTO	decimal(2,0);
		DECLARE CY_MUNICIPIONACIMIENTO	decimal(3,0);
		DECLARE CY_LOCALIDADNACIMIENTO	varchar(70);
		DECLARE CY_NACIONALIDAD	decimal(3,0);
		DECLARE CY_PAISNACIMIENTO	decimal(3,0);
		DECLARE CY_CURP	varchar(18);
		DECLARE CY_NUMEROACTA	decimal(5,0);
		DECLARE CY_ANIOREGISTRO	decimal(4,0);
		DECLARE CY_TIPODOCUMENTO	decimal(1,0);
		DECLARE CY_ENTIDADREGISTRO	decimal(2,0);
		DECLARE CY_MUNICIPIOREGISTRO	decimal(3,0);
		DECLARE CY_OFICIALIA	decimal(4,0);
		DECLARE CY_ACTABIS	varchar(1);
		DECLARE CN_FECHAACTUALIZACION	datetime;
		DECLARE CN_FECHAACTUALIZACION_INC	varchar(25);
		DECLARE OT_LOCALIDADDEFUNCION	varchar(120);
		DECLARE OT_FECHAREGISTROENNACIMIENTO	datetime;
		DECLARE OT_CERTIFICADO_DE	varchar(20);
		DECLARE OT_MESES	int(11);
		DECLARE OT_DIAS	int(11);
		DECLARE OT_HORAS	int(11);
		DECLARE OT_MINUTOS	int(11);
		DECLARE OT_SEGUNDOS	int(11);
		DECLARE OT_LLAVERENADI	varchar(2);
		DECLARE CO_TIPO	varchar(1);
		DECLARE CO_FECHAORIGINAL	date;
		DECLARE CO_TRANSCRIPCION	longtext;
		DECLARE CO_SOPORTE	longblob;
		DECLARE bandera int(11);
		declare contador int;
		DECLARE ID_DIFUNTO bigint(20);
		DECLARE ID_PADRE bigint(20);
		DECLARE ID_MADRE bigint(20);
		DECLARE ID_CONYUGE bigint(20);
		declare txt longtext;
		declare vrmatrimonio varchar(200);
	    declare vrreconocimiento varchar(200);
	    declare vradopcion varchar(200);
	    declare vrconyuge bigint;
		DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET bandera = 1;			 
		DECLARE CONTINUE HANDLER FOR 1062 SET bandera = 2; -- duplicated primary key
	
		if ( trim(coalesce(new.notas,''))!='') then
  
  -- se busca primero la nota marginal abierta
  select count(*) into contador from nm_defuncion
  where ID_DEFUNCION=new.guid
  and tipo=26 ;
  
  if (contador<=0) THEN
	 select table_sequence_val+1 into contador from sequence_table where table_sequence_name='NM_DEFUNCION';
     update sequence_table set table_sequence_val=contador+1 where table_sequence_name='NM_DEFUNCION'; 

     insert into nm_defuncion(id, fecha_creacion,fecha_actualizacion,imprimible,tipo,ID_DEFUNCION,informacion)
     Values(contador,current_timestamp, current_timestamp, 1, 26, new.guid, new.notas);
  else
     update nm_defuncion set informacion=new.notas, fecha_actualizacion=current_timestamp
     where ID_DEFUNCION=new.guid and tipo=26;
  end if;
  end if;
  

		set txt = '';
		if (new.acta_bis<>old.acta_bis)then
			set txt =concat(txt , 'ACTA BIS actual: ' , cast(new.acta_bis as char) , ' antes: ' , cast(old.acta_bis as char));
		end if;
		if (new.cadena<>old.cadena)then
			set txt =concat(txt , 'CADENA actual: ' , cast(new.cadena as char) , ' antes: ', cast(old.cadena as char));
		end if;
		if (new.fecha_registro<>old.fecha_registro)then
			set txt =concat(txt , 'FECHA REGISTRO actual: ' , cast(new.fecha_registro as char ) , ' antes: ' , cast(old.fecha_registro as char));
		end if;
		if (new.foja<>old.foja)then
			set txt =concat(txt , 'FOJA actual: ' , new.foja , ' antes: ' , old.foja);
		end if;
		if (new.libro<>old.libro)then
			set txt =concat(txt , 'LIBRO actual: ' , new.libro , ' antes: ' , old.libro);
		end if;
		if (new.llave_original<>old.llave_original)then
			set txt =concat(txt , 'LLAVE ORIGINAL actual: ' , new.llave_original , ' antes: ' , old.llave_original);
		end if;
		if (new.localidad_registro<>old.localidad_registro)then
			set txt =concat(txt , 'LOCALIDAD REGISTRO actual: ' , new.localidad_registro , ' antes: ' , old.localidad_registro);
		end if;
		if (new.nombre_oficial<>old.nombre_oficial)then
			set txt =concat(txt , 'NOMBRE OFICIAL actual: ' , new.nombre_oficial , ' antes: ' ,  old.nombre_oficial);
		end if;
		if (new.numero_acta<>old.numero_acta)then
			set txt =concat(txt , 'NUMERO ACTA actual: ' , new.numero_acta , ' antes: ' , old.numero_acta);
		end if;
		if (new.tipo_captura<>old.tipo_captura)then
			set txt =concat(txt , 'TIPO CAPTURA actual: ' , new.tipo_captura , ' antes: ' , old.tipo_captura);
		end if;
		if (new.tomo<>old.tomo)then
			set txt =concat(txt , 'TOMO actual: ' , new.tomo , ' antes: ' , old.tomo);
		end if;
		if (new.validado<>old.validado)then
			set txt =concat(txt , 'VALIDADO actual: ' , cast(new.validado as char) , ' antes: '  , cast(old.validado as char));
		end if;
		if (new.version<>old.version)then
			set txt =concat(txt , 'VERSION actual: ' , cast(new.version as char) , ' antes: ' , cast(old.version as char));
		end if;
		if (new.domicilio_destino_finado<>old.domicilio_destino_finado)then
			set txt =concat(txt , 'DOMICILIO DESTINO FINADO actual: ' , new.domicilio_destino_finado , old.domicilio_destino_finado);
		end if;
		if (new.asist_medica<>old.asist_medica)then
			set txt =concat(txt , 'ASIST MEDICA actual: ' , cast(new.asist_medica as char) , ' antes: ' , cast(old.asist_medica as char));
		end if;
		if (new.causa_fallece<>old.causa_fallece)then
			set txt =concat(txt , 'CAUSA FALLECE actual: ' , cast(new.causa_fallece as char) ,  ' antes: ' , cast(old.causa_fallece as char));
		end if;
		if (new.cedula_medico<>old.cedula_medico)then
			set txt =concat(txt , 'CEDULA MEDICO actual: ' , new.cedula_medico , ' antes: ' , old.cedula_medico);
		end if;
		if (new.domicilio_medico<>old.domicilio_medico)then
			set txt =concat(txt , 'DOMICILIO MEDICO actual: ' , new.domicilio_medico , ' antes: ' , old. domicilio_medico);
		end if;
		if (new.fecha_defuncion<>old.fecha_defuncion)then
			set txt =concat(txt , 'FECHA DEFUNCION actual: ' , cast(new.fecha_defuncion as char) , ' antes: ', cast(old.fecha_defuncion as char));
		end if;
		if (new.hora_defuncion<>old.hora_defuncion)then	
			set txt =concat(txt , 'HORA DEFUNCION actual : ' , cast(new.hora_defuncion as char) , ' antes: ´ ', cast(old.hora_defuncion as char));
		end if;
		if (new.im_archivo<>old.im_archivo)then
			set txt =concat(txt , 'IM ARCHIVO actual: ' , new.im_archivo , ' antes: ' , old.im_archivo);
		end if;
		if (new.im_nombre<>old.im_nombre)then
			set txt =concat(txt , 'IM NOMBRE actual: ' , new.im_nombre , ' antes: ' , old.im_nombre);
		end if;
		if (new.inhumacion<>old.inhumacion)then
			set txt =concat(txt	, 'INHUMACION actual: ' , cast(new.inhumacion as char) , ' antes: ' , cast(old.inhumacion as char));
		end if;
		if (new.nombre_destino<>old.nombre_destino)then
			set txt =concat(txt , 'NOMBRE DESTINO actual: ' , new.nombre_destino , ' antes: ' , old.nombre_destino);
		end if;
		if (new.nombre_medico<>old.nombre_medico)then
			set txt =concat(txt , 'NOMBRE MEDICO actual: ' , new.nombre_medico , ' antes: ' , old.nombre_medico);
		end if;
		if (new.num_cert_defuncion<>old.num_cert_defuncion)then
			set txt =concat(txt , 'NUM CERT DEFUNCION actual: ' , new.num_cert_defuncion , ' antes: ' , old.num_cert_defuncion);
		end if;
		if (new.num_orden<>old.num_orden)then 
			set txt =concat(txt , 'NUM ORDEN actual: ' , cast(new.num_orden as char) , ' antes: ' , cast(old.num_orden as char));
		end if;
		if (new.ocupacion_declarante<>old.ocupacion_declarante)then
			set txt =concat(txt , 'OCUPACION DECLARANTE actual: ' , new.ocupacion_declarante , ' antes: ' , old.ocupacion_declarante);
		end if;
		if (new.ocupacion_testigo_dos<>old.ocupacion_testigo_dos)then
			set txt =concat(txt , 'OCUPACION TESTIGO DOS actual: ' , new.ocupacion_testigo_dos , ' antes: ' , old.ocupacion_testigo_dos);
		end if;
		if (new.ocupacion_testigo_uno<>old.ocupacion_testigo_uno)then
			set txt =concat(txt , 'OCUPACION TESTIGO UNO actual: ' , new.ocupacion_testigo_uno , ' antes: ' , old.ocupacion_testigo_uno);
		end if;
		if (new.sello<>old.sello)then
			set txt =concat(txt , 'SELLO actual: ' , new.sello , ' antes: ' , old.sello);
		end if;
		if (new.sello_img<>old.sello_img)then 
			set txt =concat(txt , 'SELLO IMG actual: ' , new.sello_img , ' antes: ' , old.sello_img);
		end if;
		if (new.tipo_operacion<>old.tipo_operacion)then
			set txt =concat(txt , 'TIPO OPERACION actual: ' , cast(new.tipo_operacion as char) , ' antes: ' , cast(old.tipo_operacion as char));
		end if;
		if (new.entidad_registro<>old.entidad_registro)then
			set txt =concat(txt , 'ENTIDAD REGISTRO	 actual: ' , cast(new.entidad_registro as char) , ' antes: ' , cast(old.entidad_registro as char));
		end if;
		if (new.municipio_registro<>old.municipio_registro)then
			set txt =concat(txt , 'MUNICIPIO REGISTRO actual: ' , cast(new.municipio_registro as char) , ' antes: ' , cast(old.municipio_registro as char));
		end if;
		if (new.oficialia<>old.oficialia)then
			set txt =concat(txt , 'OFICIALIA actual: ' , cast(new.oficialia as char) , ' antes: ' , cast(old.oficialia as char));
		end if;
		if (new.tipo_documento<>old.tipo_documento)then
			set txt =concat(txt , 'TIPO DOCUMENTO actual: ' , cast(new.tipo_documento as char) , ' antes: ' , cast(old.tipo_documento as char));
		end if;
		if (new.conyuge<>old.conyuge)then
			set txt =concat(txt , 'CONYUGE actual: ' , cast(new.conyuge as char) , ' antes: ' , cast(old.conyuge as char));
		end if;
		if (new.declarante<>old.declarante)then
			set txt =concat(txt , 'DECLARANTE actual: ' , cast(new.declarante as char) , ' antes: ' , cast(old.declarante as char));
		end if;
		if ( new.destino_cadaver<>old.destino_cadaver)then
			set txt =concat(txt , 'DESTINO CADAVER actual: ' , cast(new.destino_cadaver as char) ,  ' antes: ' , cast(old.destino_cadaver as char));
		end if;
		if (new.dom_lug_fallece<>old.dom_lug_fallece)then
			set txt =concat(txt , 'DOM LUG FALLECE actual: ' ,  cast(new.dom_lug_fallece as char) , ' antes: ' , cast(old.dom_lug_fallece as char));
		end if;
		if (new.escolaridad_fallecido<>old.escolaridad_fallecido)then
			set txt =concat(txt , 'ESCOLARIDAD FALLECIDO actual: ' , cast(new.escolaridad_fallecido as char) , ' antes: ' , cast(old.escolaridad_fallecido as char));
		end if;
		if (new.fallecido<>old.fallecido)then
			set txt =concat(txt , 'FALLECIDO actual: ' , cast(new.fallecido as char) , ' antes: ' , cast(old.fallecido as char));
		end if;
		if (new.lugar_fallece<>old.lugar_fallece)then
			set txt =concat(txt , 'LUGAR FALLECE actual: ' , cast(new.lugar_fallece as char) , ' antes: ' , cast(old.lugar_fallece as char));
		end if;
		if (new.madre_fallecido<>old.madre_fallecido)then
			set txt =concat(txt , 'MADRE FALLECIDO actual: ' , cast(new.madre_fallecido as char) , ' antes: ' ,  cast(old.madre_fallecido as char));
		end if;
		if (new.acta_nacimiento_difunto<>old.acta_nacimiento_difunto)then
			set txt =concat(txt , 'ACTA NACIMIENTO DIFUNTO actual: ' , new.acta_nacimiento_difunto , ' antes: ' , old.acta_nacimiento_difunto);
		end if;
		if (new.padre_fallecido<>old.padre_fallecido)then
			set txt =concat(txt , 'PADRE FALLECIDO actual: ' , cast(new.padre_fallecido as char) , ' antes: ' , cast(old.padre_fallecido as char));
		end if;
		if (new.parent_declarante<>old.parent_declarante)then	
			set txt =concat(txt , 'PARENT DECLARANTE actual: ' , cast(new.parent_declarante as char) , ' antes: ' , cast(old.parent_declarante as char));
		end if;
		if (new.pa_testigo_dos<>old.pa_testigo_dos)then
			set txt =concat(txt , 'PARENT TESTIGO DOS actual: ' , cast(new.pa_testigo_dos as char) , ' antes: ' , cast(old.pa_testigo_dos as char));
		end if;
		if (new.pa_testigo_uno<>old.pa_testigo_uno)then 
			set txt =concat(txt , 'PARENT TESTIGO UNO actual: ' , cast(new.pa_testigo_uno as char) , ' antes: ' , cast(old.pa_testigo_uno as char));
		end if;
		if (new.puesto_trab_fallecido<>old.puesto_trab_fallecido)then
			set txt =concat(txt , 'PUESTO TRAB FALLECIDO atual: ' , cast(new.puesto_trab_fallecido as char) , ' antes: ' , cast(old.puesto_trab_fallecido as char));
		end if;
		if (new.sit_lab_finado<>old.sit_lab_finado)then
			set txt =concat(txt , 'SIT LAB FINADO actual: ' , cast(new.sit_lab_finado as char) , ' antes: ' , cast(sit_lab_finado as char));
		end if;
		if (new.testigo_dos<>old.testigo_dos)then
			set txt =concat(txt , 'TESTIGO DOS actual: ' , cast(new.testigo_dos as char) , ' antes: ' , cast(old.testigo_dos as char));
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
		if (new.tipo_muerte<>old.tipo_muerte)then
			set txt =concat(txt , 'TIPO MUERTE actual: ' , cast(new.tipo_muerte as char) , ' antes: ' , cast(old.tipo_muerte as char));
		end if;
		if (new.causa_baja<>old.causa_baja)then
			set txt =concat(txt , 'CAUSA BAJA actual: ' , cast(new.causa_baja as char) , ' antes: ' , cast(old.causa_baja as char));
		end if;
		if (new.modifica<>old.modifica)then
			set txt =concat(txt , 'MODIFICA actual: ' , cast(new.modifica as char) , ' antes: ' , cast(old.modifica as char));
		end if;
		if (new.CLAVE_ESTADISTICA<>old.CLAVE_ESTADISTICA)then
			set txt =concat(txt , 'CLAVE_ESTADISTICA actual: ' , cast(new.CLAVE_ESTADISTICA as char) , ' antes: ' , cast(old.CLAVE_ESTADISTICA as char));
		end if;
		if (new.EDAD_UNIDAD<>old.EDAD_UNIDAD)then
			set txt =concat(txt , ' EDAD_UNIDAD actual: ' , new.EDAD_UNIDAD , ' antes: ' ,  old.EDAD_UNIDAD);
		end if;
		if (new.CAUSA_FALLECE_B<>old.CAUSA_FALLECE_B)then
			set txt =concat(txt , 'CAUSA_FALLECE_B actual: ' , new.CAUSA_FALLECE_B , ' antes: ' , oldCAUSA_FALLECE_B);
		end if;
		if (new.CAUSA_FALLECE_C<>old.CAUSA_FALLECE_C)then
			set txt =concat(txt , 'CAUSA_FALLECE_C actual: ' , new.CAUSA_FALLECE_C , ' antes: ' , old.CAUSA_FALLECE_C);
		end if;
		if (new.DURACION_A<>old.DURACION_A)then
			set txt =concat(txt , 'DURACION_A actual: ' , new.DURACION_A , ' antes: ' , old.DURACION_A);
		end if;
		if (new.DURACION_B<>old.DURACION_B)then
			set txt =concat(txt , 'DURACION_B actual: ' , new.DURACION_B , ' antes: ' , old.DURACION_B);
		end if;
		if (new.DURACION_C<>old.DURACION_C)then
			set txt =concat(txt , 'DURACION_C actual: ' , new.DURACION_C , ' antes: ' , old.DURACION_C);
		end if;
		if (new.VARIABLE_CONTROL<>old.VARIABLE_CONTROL)then
			set txt =concat(txt , 'VARIABLE_CONTROL actual: ' , cast(new.VARIABLE_CONTROL as char) , ' antes: ' , cast(old.VARIABLE_CONTROL as char));
		end if;
		if (new.NOTAS_COMPLEMENTARIAS<>old.NOTAS_COMPLEMENTARIAS)then
			set txt =concat(txt , 'NOTAS_COMPLEMENTARIAS actual: ' , new.NOTAS_COMPLEMENTARIAS , ' antes: ' , old.NOTAS_COMPLEMENTARIAS);
		end if;


		insert into bitacora_cambio set
		bitacora_cambio.USUARIO= NEW.MODIFICA,
		bitacora_cambio.FECHA= now(),
		bitacora_cambio.TIPO = 'M',
		bitacora_cambio.Tabla = 'DEFUNCION',
		bitacora_cambio.MOdificacion = txt;

		-- PROCESO DE NOTAS MARGINALES
		  if (new.validado=1 and old.validado<>1) then
		   
			
		    -- se busca el matrimonio de la persona que es difunto
		    set  vrmatrimonio= ( select coalesce(max(m.guid),'no') from defuncion d
								inner join matrimonio m on (m.CONTRAYENTE_UNO=d.FALLECIDO or m.CONTRAYENTE_DOS=d.FALLECIDO)
								where m.VALIDADO=1 
								and m.FECHA_BORRADO is null);
			
			if (vrmatrimonio<>'no') then  
				-- se genera la baja 
				update matrimonio set FECHA_BORRADO= current_date where guid=vrmatrimonio;

				-- se genera la nota marginal
		        insert into nm_matrimonio(fecha_creacion,fecha_actualizacion,imprimible,tipo,id_matrimonio,informacion)
		        Values(current_timestamp,current_timestamp,1,3,vrmatrimonio, concat('CON FECHA ', cast(current_date as char), 'SE LEVANTÓ EL ACTA DE DEFUNCIÓN NO. ', NEW.numero_Acta,' EN LA OFICIALIA ',(select coalesce(descripcion,'') from cat_oficialia where id=new.oficialia),
				' DE  ',(select coalesce(nombre) from cat_municipio where id=new.municipio_registro),',',(select coalesce(descripcion,'') from cat_estado where id=new.entidad_registro) ,' A NOMBRE DE ',
				 (select  concat(coalesce(nombre,''),' ',coalesce(primer_apellido,''),' ',coalesce(segundo_apellido,'')) from  persona where id=new.fallecido) ));

				-- se busca el conyuge y se anexa la nota marginal en el nacimiento
				set  vrconyuge= ( select coalesce(max(m.contrayente_dos), -1)
								 from matrimonio m 
								where m.guid=vrmatrimonio 
								and m.contrayente_uno=new.fallecido);
				if (vrconyuge<>-1) then
						insert into nm_nacimiento(fecha_creacion,fecha_actualizacion,imprimible,tipo,id_nacimiento,informacion)
						select current_timestamp,current_timestamp,1,3,guid, concat('CON FECHA ', cast(current_date as char), 'SE LEVANTÓ EL ACTA DE DEFUNCIÓN NO. ', NEW.numero_Acta,' EN LA OFICIALIA ',(select coalesce(descripcion,'') from cat_oficialia where id=new.oficialia),
						' DE  ',(select coalesce(nombre,'') from cat_municipio where id=new.municipio_registro),',',(select coalesce(descripcion,'') from cat_estado where id=new.entidad_registro) ,' A NOMBRE DE ',
						(select  concat(coalesce(nombre,''),' ',coalesce(primer_apellido,''),' ',coalesce(segundo_apellido,'')) from  persona where id=new.fallecido), ', POR LO QUE EN LO SUCESIVO EL ESTADO CIVIL DE ',
						(SELECT concat(coalesce(nombre,''),' ',coalesce(primer_apellido,''),' ',coalesce(segundo_apellido,'')) FROM PERSONA WHERE ID = REGISTRADO), 'DEBERA SER VIUDO')
						from nacimiento
						where registrado=vrconyuge
						and Validado=1
						and fecha_borrado is null;

				else
					set  vrconyuge= ( select coalesce(max(m.contrayente_uno), -1)
								 from matrimonio m 
								where m.guid=vrmatrimonio 
								and m.contrayente_dos=new.fallecido);
					if (vrconyuge<>-1) then
						insert into nm_nacimiento(fecha_creacion,fecha_actualizacion,imprimible,tipo,id_nacimiento,informacion)
						select current_timestamp,current_timestamp,1,3,guid, concat('CON FECHA ', cast(current_date as char), 'SE LEVANTÓ EL ACTA DE DEFUNCIÓN NO. ', NEW.numero_Acta,' EN LA OFICIALIA ',(select descripcion from cat_oficialia where id=new.oficialia),
						' DE  ',(select nombre from cat_municipio where id=new.municipio_registro),',',(select descripcion from cat_estado where id=new.entidad_registro) ,' A NOMBRE DE ',
						(select  concat(coalesce(nombre,''),' ',coalesce(primer_apellido,''),' ',coalesce(segundo_apellido,'')) from  persona where id=new.fallecido) , ', POR LO QUE EN LO SUCESIVO EL ESTADO CIVIL DE ',
						(SELECT concat(coalesce(nombre,''),' ',coalesce(primer_apellido,''),' ',coalesce(segundo_apellido,'')) FROM PERSONA WHERE ID = REGISTRADO), 'DEBERA SER VIUDO')
						from nacimiento
						where registrado=vrconyuge
						and Validado=1
						and fecha_borrado is null;
					END if;
				end if;

			end if;

			 -- se busca el reconocimiento de la persona que es difunto
		    set  vrreconocimiento= ( select coalesce(max(r.guid),'no') from defuncion d
								inner join reconocimiento r on (r.RECONOCIDO=d.FALLECIDO )
								where r.VALIDADO=1 
								and r.FECHA_BORRADO is not null);
			if (vrreconocimiento<>'no') then  
				-- se genera la baja 
				update reconocimiento set FECHA_BORRADO= current_date where guid=vrreconocimiento;
				-- se genera la nota marginal
		        insert into nm_reconocimiento(fecha_creacion,fecha_actualizacion,imprimible,tipo,id_reconocimiento,informacion)
		        Values(current_timestamp,current_timestamp,1,5,vrreconocimiento, concat('CON FECHA ', cast(current_date as char), 'SE LEVANTÓ EL ACTA DE DEFUNCIÓN NO. ', new.numero_Acta,' EN LA OFICIALIA ',(select descripcion from cat_oficialia where id=new.oficialia),
				' DE  ',(select nombre from cat_municipio where id=new.municipio_registro),',',(select descripcion from cat_estado where id=new.entidad_registro) ,' A NOMBRE DE ',
				 (select  concat(coalesce(nombre,''),' ',coalesce(primer_apellido,''),' ',coalesce(segundo_apellido,'')) from  persona where id=new.fallecido) ));

			end if;

			 -- se busca la adopcion de la persona que es difunto
		    set  vradopcion= ( select coalesce(max(a.guid),'no') from defuncion d
								inner join adopcion a on (a.ADOPTADO=d.FALLECIDO )
								where a.VALIDADO=1 
								and a.FECHA_BORRADO is not null);
			if (vradopcion<>'no') then  
				-- se genera la baja 
				update adopcion set FECHA_BORRADO= current_date where guid=vradopcion;
				-- se genera la nota marginal
		        insert into nm_adopcion(fecha_creacion,fecha_actualizacion,imprimible,tipo,id_adopcion,informacion)
		        Values(current_timestamp,current_timestamp,1,6,vradopcion, concat('CON FECHA ', cast(current_date as char), 'SE LEVANTÓ EL ACTA DE DEFUNCIÓN NO. ', new.numero_Acta,' EN LA OFICIALIA ',(select descripcion from cat_oficialia where id=new.oficialia),
				' DE  ',(select nombre from cat_municipio where id=new.municipio_registro),',',(select descripcion from cat_estado where id=new.entidad_registro) ,' A NOMBRE DE ',
				 (select  concat(coalesce(nombre,''),' ',coalesce(primer_apellido,''),' ',coalesce(segundo_apellido,'')) from  persona where id=new.fallecido) ));

			end if;

 
  			end if;

		set bandera=0;
		--  PROCESO DE CIRR
		IF (NEW.FECHA_BORRADO IS NULL)THEN	
				IF( (NEW.VALIDADO = 1) or (new.cadena!=old.cadena and new.validado>0))THEN
					SET ID_DIFUNTO = NEW.FALLECIDO;
					SET ID_PADRE = NEW.PADRE_FALLECIDO;
					SET ID_MADRE = NEW.MADRE_FALLECIDO;
					SET ID_CONYUGE = NEW.CONYUGE;

					SET NUMEROACTA	= NEW.NUMERO_ACTA;
					SET ANIOREGISTRO	= YEAR(NEW.FECHA_REGISTRO);
					SET TIPODOCUMENTO	= 2;
					SET PA_TIPODOCUMENTO = 1; 
					SET MA_TIPODOCUMENTO = 1; 
					SET CY_TIPODOCUMENTO = 1; 
					SET ENTIDADREGISTRO	= (SELECT cat_e.ID_RENAPO FROM cat_estado cat_e where cat_e.id = NEW.ENTIDAD_REGISTRO);
				SET O_ENTIDADREGISTRO	= (SELECT cat_e.ID_RENAPO FROM cat_estado cat_e where cat_e.id = OLD.ENTIDAD_REGISTRO);
				SET MUNICIPIOREGISTRO	= (SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = NEW.MUNICIPIO_REGISTRO);
				SET O_MUNICIPIOREGISTRO	= (SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = OLD.MUNICIPIO_REGISTRO);

				SET OFICIALIA	= (SELECT cat_of.ID_RENAPO FROM cat_oficialia cat_of WHERE cat_of.id = NEW.OFICIALIA);
				SET O_OFICIALIA	= (SELECT cat_of.ID_RENAPO FROM cat_oficialia cat_of WHERE cat_of.id = OLD.OFICIALIA);
				SET ACTABIS	= COALESCE(NEW.ACTA_BIS,'0');
				SET N_CADENA	= CONCAT(TIPODOCUMENTO,	LPAD(ENTIDADREGISTRO,2,'0'),	LPAD(MUNICIPIOREGISTRO,3,'0'),	LPAD(OFICIALIA,4,'0'),	LPAD(ANIOREGISTRO,4,'0'),	LPAD(NUMEROACTA,5,'0'),ACTABIS);
				SET O_CADENA	= CONCAT(TIPODOCUMENTO,	LPAD(O_ENTIDADREGISTRO,2,'0'),	LPAD(O_MUNICIPIOREGISTRO,3,'0'),	LPAD(O_OFICIALIA,4,'0'),	LPAD(ANIOREGISTRO,4,'0'),	LPAD(OLD.numero_Acta,5,'0'),ACTABIS);
				SET CO_FECHA_REGISTRO	= NEW.FECHA_REGISTRO;
					SET CO_LLAVEREGISTROCIVIL	= NEW.GUID;
					SET CO_FOJA	= IF(LENGTH(TRIM(NEW.FOJA)) = 0, null,NEW.FOJA);
					SET CO_TOMO	= IF(LENGTH(TRIM(NEW.TOMO)) = 0, null,NEW.TOMO);
					SET CO_LIBRO = IF(LENGTH(TRIM(NEW.LIBRO)) = 0, null,NEW.LIBRO);
					SET OT_CAUSADEFUNCION =  f_char_limpiar_CE(NEW.CAUSA_FALLECE);
					SET OT_FECHADEFUNCION = NEW.FECHA_DEFUNCION;
					SET CO_TIPO = NEW.TIPO_OPERACION;
					SET CO_FECHAORIGINAL = NEW.FECHA_REGISTRO;
					SET CO_SOPORTE =  NEW.IM_ARCHIVO;
					SET NA_TIPODOCUMENTO = 1;
					SET OT_NOTASMARGINALES = f_char_notas_defuncion(NEW.GUID);
					set contador = 0;
					SET OT_TIPODEFUNCION = new.TIPO_MUERTE;
					CASE OT_TIPODEFUNCION 
						WHEN 1 THEN SET OT_TIPODEFUNCION = 0;
						WHEN 2 THEN SET OT_TIPODEFUNCION = 1;
						ELSE SET OT_TIPODEFUNCION = 2;
					END CASE;
					CASE CO_TIPO 
						WHEN '1' THEN SET CO_TIPO = 'N';
						WHEN '2' THEN SET CO_TIPO = 'I';
						ELSE SET CO_TIPO = 'N';
					END CASE;
					-- datos de nacimiento del difunto
					SELECT nac.NUMERO_ACTA,YEAR(nac.FECHA_REGISTRO),
							(SELECT cat_e.ID_RENAPO FROM cat_estado cat_e where cat_e.id = nac.ENTIDAD_REGISTRO),
							(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = nac.MUNICIPIO_REGISTRO),
							(SELECT cat_of.ID_RENAPO FROM cat_oficialia cat_of WHERE cat_of.id = nac.OFICIALIA),
							 nac.ACTA_BIS,nac.FECHA_REGISTRO	
						INTO NA_NUMEROACTA,NA_ANIOREGISTRO,NA_ENTIDADREGISTRO,NA_MUNICIPIOREGISTRO,NA_OFICIALIA,NA_ACTABIS,OT_FECHAREGISTROENNACIMIENTO
							FROM nacimiento nac 
						WHERE nac.REGISTRADO = ID_DIFUNTO limit 1;
					
					-- datos personales del difunto
					SELECT per.CRIP,per.ESTADO_CIVIL, f_char_limpiar(per.PRIMER_APELLIDO), f_char_limpiar(per.SEGUNDO_APELLIDO), f_char_limpiar(per.NOMBRE),per.EDAD,per.SEXO,per.FECHA_NACIMIENTO,
							(SELECT cat_ent.ID_RENAPO FROM cat_estado cat_ent WHERE cat_ent.id = per.ENTIDAD) AS entidad,
							(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = per.MUNICIPIO), f_char_limpiar_CE(per.LOCALIDAD),
							(SELECT cat_p.ID FROM cat_pais cat_p WHERE cat_p.id = per.PAIS),per.CURP	
						INTO OT_CRIP,OT_ESTADOCIVILDIFUNTO,PE_PRIMERAPELLIDO,PE_SEGUNDOAPELLIDO,PE_NOMBRES,PE_EDAD,PE_SEXO,PE_FECHANACIMIENTO,PE_ENTIDADNACIMIENTO,PE_MUNICIPIONACIMIENTO,PE_LOCALIDADNACIMIENTO,PE_NACIONALIDAD,PE_CURP
							FROM persona per	
					WHERE per.id = ID_DIFUNTO limit 1;						
					SET PE_PAISNACIMIENTO = PE_NACIONALIDAD;
					-- valores para nrc_defnciones
					CASE OT_ESTADOCIVILDIFUNTO
						WHEN '0' THEN SET OT_ESTADOCIVILDIFUNTO = '6';
						WHEN '1' THEN SET OT_ESTADOCIVILDIFUNTO = '1';
						WHEN '2' THEN SET OT_ESTADOCIVILDIFUNTO = '2';
						WHEN '3' THEN SET OT_ESTADOCIVILDIFUNTO = '7';
						WHEN '4' THEN SET OT_ESTADOCIVILDIFUNTO = '3';
						WHEN '5' THEN SET OT_ESTADOCIVILDIFUNTO = '4';
						WHEN '6' THEN SET OT_ESTADOCIVILDIFUNTO = '5';
						WHEN '7' THEN SET OT_ESTADOCIVILDIFUNTO = '6';
						WHEN '8' THEN SET OT_ESTADOCIVILDIFUNTO = '5';
						WHEN '9' THEN SET OT_ESTADOCIVILDIFUNTO = '5';
						ELSE SET OT_ESTADOCIVILDIFUNTO = '6';
					END CASE;
					-- datos personales del padre
					SELECT  f_char_limpiar(per.PRIMER_APELLIDO), f_char_limpiar(per.SEGUNDO_APELLIDO), f_char_limpiar(per.NOMBRE),per.EDAD,per.SEXO,per.FECHA_NACIMIENTO,
							(SELECT cat_ent.ID_RENAPO FROM cat_estado cat_ent WHERE cat_ent.id = per.ENTIDAD) AS entidad,
							(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = per.MUNICIPIO), f_char_limpiar_CE(per.LOCALIDAD),
							(SELECT cat_p.ID FROM cat_pais cat_p WHERE cat_p.id = per.PAIS),per.CURP	
						INTO PA_PRIMERAPELLIDO,PA_SEGUNDOAPELLIDO,PA_NOMBRES,PA_EDAD,PA_SEXO,PA_FECHANACIMIENTO,PA_ENTIDADNACIMIENTO,PA_MUNICIPIONACIMIENTO,PA_LOCALIDADNACIMIENTO,PA_NACIONALIDAD,PA_CURP
							FROM persona per	
					WHERE per.id = ID_PADRE limit 1;						
					SET PA_PAISNACIMIENTO = PA_NACIONALIDAD;
					-- datos personales de la madre
					SELECT  f_char_limpiar(per.PRIMER_APELLIDO), f_char_limpiar(per.SEGUNDO_APELLIDO), f_char_limpiar(per.NOMBRE),per.EDAD,per.SEXO,per.FECHA_NACIMIENTO,
							(SELECT cat_ent.ID_RENAPO FROM cat_estado cat_ent WHERE cat_ent.id = per.ENTIDAD) AS entidad,
							(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = per.MUNICIPIO), f_char_limpiar_CE(per.LOCALIDAD),
							(SELECT cat_p.ID FROM cat_pais cat_p WHERE cat_p.id = per.PAIS),per.CURP	
						INTO MA_PRIMERAPELLIDO,MA_SEGUNDOAPELLIDO,MA_NOMBRES,MA_EDAD,MA_SEXO,MA_FECHANACIMIENTO,MA_ENTIDADNACIMIENTO,MA_MUNICIPIONACIMIENTO,MA_LOCALIDADNACIMIENTO,MA_NACIONALIDAD,MA_CURP
							FROM persona per	
					WHERE per.id = ID_MADRE limit 1;						
					SET MA_PAISNACIMIENTO = MA_NACIONALIDAD;
					-- datos personales del  conyuge
					SELECT  f_char_limpiar(per.PRIMER_APELLIDO), f_char_limpiar(per.SEGUNDO_APELLIDO), f_char_limpiar(per.NOMBRE),per.EDAD,per.SEXO,per.FECHA_NACIMIENTO,
							(SELECT cat_ent.ID_RENAPO FROM cat_estado cat_ent WHERE cat_ent.id = per.ENTIDAD) AS entidad,
							(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = per.MUNICIPIO), f_char_limpiar_CE(per.LOCALIDAD),
							(SELECT cat_p.ID FROM cat_pais cat_p WHERE cat_p.id = per.PAIS),per.CURP	
						INTO CY_PRIMERAPELLIDO,CY_SEGUNDOAPELLIDO,CY_NOMBRES,CY_EDAD,CY_SEXO,CY_FECHANACIMIENTO,CY_ENTIDADNACIMIENTO,CY_MUNICIPIONACIMIENTO,CY_LOCALIDADNACIMIENTO,CY_NACIONALIDAD,CY_CURP
							FROM persona per	
					WHERE per.id = ID_MADRE limit 1;						
					SET CY_PAISNACIMIENTO = CY_NACIONALIDAD;
					
					-- datos de nacimiento de padre
                    insert into monitor(tipo,mensaje) Values('Monitor 1', concat('Revision 1, ',N_CADENA));
					SELECT nac.NUMERO_ACTA,YEAR(nac.FECHA_REGISTRO),
							(SELECT cat_e.ID_RENAPO FROM cat_estado cat_e where cat_e.id = nac.ENTIDAD_REGISTRO),
							(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = nac.MUNICIPIO_REGISTRO),
							(SELECT cat_of.ID_RENAPO FROM cat_oficialia cat_of WHERE cat_of.id = nac.OFICIALIA),
							 nac.ACTA_BIS
						INTO PA_NUMEROACTA,PA_ANIOREGISTRO,PA_ENTIDADREGISTRO,PA_MUNICIPIOREGISTRO,PA_OFICIALIA,PA_ACTABIS
							FROM nacimiento nac 
						WHERE nac.REGISTRADO = ID_PADRE limit 1;
	
					-- datos de nacimiento de LA Madre
					SELECT nac.NUMERO_ACTA,YEAR(nac.FECHA_REGISTRO),
							(SELECT cat_e.ID_RENAPO FROM cat_estado cat_e where cat_e.id = nac.ENTIDAD_REGISTRO),
							(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = nac.MUNICIPIO_REGISTRO),
							(SELECT cat_of.ID_RENAPO FROM cat_oficialia cat_of WHERE cat_of.id = nac.OFICIALIA),
							 nac.ACTA_BIS
						INTO MA_NUMEROACTA,MA_ANIOREGISTRO,MA_ENTIDADREGISTRO,MA_MUNICIPIOREGISTRO,MA_OFICIALIA,MA_ACTABIS
							FROM nacimiento nac 
						WHERE nac.REGISTRADO = ID_MADRE limit 1;
					-- datos de nacimiento del conyuge
					SELECT nac.NUMERO_ACTA,YEAR(nac.FECHA_REGISTRO),
							(SELECT cat_e.ID_RENAPO FROM cat_estado cat_e where cat_e.id = nac.ENTIDAD_REGISTRO),
							(SELECT cat_mun.ID_RENAPO FROM cat_municipio cat_mun WHERE cat_mun.id = nac.MUNICIPIO_REGISTRO),
							(SELECT cat_of.ID_RENAPO FROM cat_oficialia cat_of WHERE cat_of.id = nac.OFICIALIA),
							 nac.ACTA_BIS
						INTO CY_NUMEROACTA,CY_ANIOREGISTRO,CY_ENTIDADREGISTRO,CY_MUNICIPIOREGISTRO,CY_OFICIALIA,CY_ACTABIS
							FROM nacimiento nac 
						WHERE nac.REGISTRADO = ID_CONYUGE limit 1;

					IF (LENGTH(OT_NOTASMARGINALES) > 4000 OR LENGTH(TRIM(OT_NOTASMARGINALES)) = 0) THEN
								SET OT_NOTASMARGINALES = null;
					END IF;
					-- se manda la baja cuando hay un cambio en los datos de la cadena
					if (n_cadena!=o_cadena) THEN	
						insert into monitor(tipo,mensaje) Values('dato1', concat('baja de defunciones, ',N_CADENA,',',O_CADENA,','));

					-- se da de baja la cadena anterior
						INSERT INTO CIRR_TA03_DEPETICION(TA03_E_PRIORIDAD,TA03_E_OPERACIONACTO,TA03_C_CADENA,TA03_E_ESTATUS,TA03_E_CUANTOS) 
																								VALUES(1,2,O_CADENA,0,0);							
					end if;
					IF(LENGTH(N_CADENA) <> 20 OR N_CADENA IS NULL)THEN	
							INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																									VALUES(N_CADENA,NOW(),'LA CADENA ES INVALIDA',1,2,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
									UPDATE defuncion d
										SET d.VALIDADO = 3,
												d.DESCRICION_ERROR_VALIDACION ='LA CADENA ES INVALIDA'
									WHERE d.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF(NUMEROACTA IS NULL OR NUMEROACTA = 0 OR LENGTH(NUMEROACTA) > 5 )THEN
							INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																									VALUES(N_CADENA,NOW(),'NUMERO DE ACTA INVALIDO',1,2,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);	
									UPDATE defuncion d
										SET d.VALIDADO = 3,
												d.DESCRICION_ERROR_VALIDACION ='LA CADENA ES INVALIDA'
									WHERE d.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF(OFICIALIA IS NULL OR OFICIALIA = 0)THEN
							INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																									VALUES(N_CADENA,NOW(),'NUMERO DE OFICIALIA INVALIDA',1,2,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);	
									UPDATE defuncion d
										SET d.VALIDADO = 3,
												d.DESCRICION_ERROR_VALIDACION ='NUMERO DE OFICIALIA INVALIDA'
									WHERE d.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF(MUNICIPIOREGISTRO = 0 OR  MUNICIPIOREGISTRO IS NULL)THEN
							INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																									VALUES(N_CADENA,NOW(),'MUNICIPIO DE REGISTRO INVALIDO',1,2,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
									UPDATE defuncion d
										SET d.VALIDADO = 3,
												d.DESCRICION_ERROR_VALIDACION ='MUNICIPIO DE REGISTRO INVALIDO'
									WHERE d.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF(CO_FECHA_REGISTRO = '0000-00-00' OR CO_FECHA_REGISTRO IS NULL OR CO_FECHA_REGISTRO > NOW() OR CO_FECHA_REGISTRO < PE_FECHANACIMIENTO OR CO_FECHA_REGISTRO < OT_FECHADEFUNCION)THEN
							INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																									VALUES(N_CADENA,NOW(),'FECHA DE REGISTRO INVALIDA',1,2,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);	
									UPDATE defuncion d
										SET d.VALIDADO = 3,
												d.DESCRICION_ERROR_VALIDACION ='FECHA DE REGISTRO INVALIDA'
									WHERE d.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF(PE_SEXO != 'M' AND PE_SEXO != 'F')THEN
							INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																									VALUES(N_CADENA,NOW(),'SEXO DEL REGISTRADO INVALIDO',1,2,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
									UPDATE defuncion d
										SET d.VALIDADO = 3,
												d.DESCRICION_ERROR_VALIDACION ='SEXO DEL REGISTRADO INVALIDO'
									WHERE d.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF(PE_FECHANACIMIENTO > NOW())THEN
							INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																									VALUES(N_CADENA,NOW(),'FECHA DE NACIMIENTO INVALIDA',1,2,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);	
									UPDATE defuncion d
										SET d.VALIDADO = 3,
												d.DESCRICION_ERROR_VALIDACION ='FECHA DE NACIMIENTO INVALIDA'
									WHERE d.GUID = CO_LLAVEREGISTROCIVIL;
					ELSEIF(OT_CAUSADEFUNCION IS NULL OR LENGTH(TRIM(OT_CAUSADEFUNCION)) = 0)THEN
							INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																									VALUES(N_CADENA,NOW(),'CAUSA DEFUNCION INVALIDA',1,2,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
									UPDATE defuncion d
										SET d.VALIDADO = 3,
												d.DESCRICION_ERROR_VALIDACION ='CAUSA DEFUNCION INVALIDA'
									WHERE d.GUID = CO_LLAVEREGISTROCIVIL;
					ELSE		
                        set bandera= 0; set contador=0;
						insert into monitor(tipo,mensaje) Values('Revision 2', concat('antes de evaluar, ',coalesce(N_CADENA,''),', ',new.guid, ', ',contador));
						select count(*) into contador from nrc_defunciones where CO_LLAVEREGISTROCIVIL=new.GUID;
						insert into monitor(tipo,mensaje) Values('Revision 3', concat('antes de evaluar, ',N_CADENA,', Contador:,',contador));
						IF (  contador<=0 )THEN
							insert into monitor(tipo,mensaje) Values('Insertar 1', concat('insertar defuncion, ',N_CADENA));
									INSERT INTO nrc_defunciones(NUMEROACTA,ANIOREGISTRO,TIPODOCUMENTO,ENTIDADREGISTRO,MUNICIPIOREGISTRO,OFICIALIA,ACTABIS,CADENA,CO_FECHA_REGISTRO,CO_FECHA_REGISTRO_INC,CO_LLAVEREGISTROCIVIL,CO_FOJA,CO_TOMO,CO_LIBRO,IM_NOMBREORIGINALIMAGEN,IM_ARCHIVO,NA_NUMEROACTA,NA_ANIOREGISTRO,NA_TIPODOCUMENTO,NA_ENTIDADREGISTRO,NA_MUNICIPIOREGISTRO,NA_OFICIALIA,NA_ACTABIS,OT_NOTASMARGINALES,OT_CRIP,OT_ESTADOCIVILDIFUNTO,OT_CAUSADEFUNCION,OT_FECHADEFUNCION,OT_FECHADEFUNCION_INC,OT_TIPODEFUNCION,PE_PRIMERAPELLIDO,PE_SEGUNDOAPELLIDO,PE_NOMBRES,PE_EDAD,PE_SEXO,PE_FECHANACIMIENTO,PE_FECHANACIMIENTO_INC,PE_ENTIDADNACIMIENTO,PE_MUNICIPIONACIMIENTO,PE_LOCALIDADNACIMIENTO,PE_NACIONALIDAD,PE_PAISNACIMIENTO,PE_CURP,PA_PRIMERAPELLIDO,PA_SEGUNDOAPELLIDO,PA_NOMBRES,PA_EDAD,PA_SEXO,PA_FECHANACIMIENTO,PA_FECHANACIMIENTO_INC,PA_ENTIDADNACIMIENTO,PA_MUNICIPIONACIMIENTO,PA_LOCALIDADNACIMIENTO,PA_NACIONALIDAD,PA_PAISNACIMIENTO,PA_CURP,PA_NUMEROACTA,PA_ANIOREGISTRO,PA_TIPODOCUMENTO,PA_ENTIDADREGISTRO,PA_MUNICIPIOREGISTRO,PA_OFICIALIA,PA_ACTABIS,MA_NUMEROACTA,MA_ANIOREGISTRO,MA_TIPODOCUMENTO,MA_ENTIDADREGISTRO,MA_MUNICIPIOREGISTRO,MA_OFICIALIA,MA_ACTABIS,MA_PRIMERAPELLIDO,MA_SEGUNDOAPELLIDO,MA_NOMBRES,MA_EDAD,MA_SEXO,MA_FECHANACIMIENTO,MA_FECHANACIMIENTO_INC,MA_ENTIDADNACIMIENTO,MA_MUNICIPIONACIMIENTO,MA_LOCALIDADNACIMIENTO,MA_NACIONALIDAD,MA_PAISNACIMIENTO,MA_CURP,CY_PRIMERAPELLIDO,CY_SEGUNDOAPELLIDO,CY_NOMBRES,CY_EDAD,CY_SEXO,CY_FECHANACIMIENTO,CY_FECHANACIMIENTO_INC,CY_ENTIDADNACIMIENTO,CY_MUNICIPIONACIMIENTO,CY_LOCALIDADNACIMIENTO,CY_NACIONALIDAD,CY_PAISNACIMIENTO,CY_CURP,CY_NUMEROACTA,CY_ANIOREGISTRO,CY_TIPODOCUMENTO,CY_ENTIDADREGISTRO,CY_MUNICIPIOREGISTRO,CY_OFICIALIA,CY_ACTABIS,CN_FECHAACTUALIZACION,CN_FECHAACTUALIZACION_INC,OT_LOCALIDADDEFUNCION,OT_FECHAREGISTROENNACIMIENTO,OT_CERTIFICADO_DE,OT_MESES,OT_DIAS,OT_HORAS,OT_MINUTOS,OT_SEGUNDOS,OT_LLAVERENADI,CO_TIPO,CO_FECHAORIGINAL,CO_TRANSCRIPCION,CO_SOPORTE) 
																			VALUES (NUMEROACTA,ANIOREGISTRO,TIPODOCUMENTO,ENTIDADREGISTRO,MUNICIPIOREGISTRO,OFICIALIA,ACTABIS,N_CADENA,CO_FECHA_REGISTRO,CO_FECHA_REGISTRO_INC,CO_LLAVEREGISTROCIVIL,CO_FOJA,CO_TOMO,CO_LIBRO,IM_NOMBREORIGINALIMAGEN,IM_ARCHIVO,NA_NUMEROACTA,NA_ANIOREGISTRO,NA_TIPODOCUMENTO,NA_ENTIDADREGISTRO,NA_MUNICIPIOREGISTRO,NA_OFICIALIA,NA_ACTABIS,OT_NOTASMARGINALES,OT_CRIP,OT_ESTADOCIVILDIFUNTO,OT_CAUSADEFUNCION,OT_FECHADEFUNCION,OT_FECHADEFUNCION_INC,OT_TIPODEFUNCION,PE_PRIMERAPELLIDO,PE_SEGUNDOAPELLIDO,PE_NOMBRES,PE_EDAD,PE_SEXO,PE_FECHANACIMIENTO,PE_FECHANACIMIENTO_INC,PE_ENTIDADNACIMIENTO,PE_MUNICIPIONACIMIENTO,PE_LOCALIDADNACIMIENTO,PE_NACIONALIDAD,PE_PAISNACIMIENTO,PE_CURP,PA_PRIMERAPELLIDO,PA_SEGUNDOAPELLIDO,PA_NOMBRES,PA_EDAD,PA_SEXO,PA_FECHANACIMIENTO,PA_FECHANACIMIENTO_INC,PA_ENTIDADNACIMIENTO,PA_MUNICIPIONACIMIENTO,PA_LOCALIDADNACIMIENTO,PA_NACIONALIDAD,PA_PAISNACIMIENTO,PA_CURP,PA_NUMEROACTA,PA_ANIOREGISTRO,PA_TIPODOCUMENTO,PA_ENTIDADREGISTRO,PA_MUNICIPIOREGISTRO,PA_OFICIALIA,PA_ACTABIS,MA_NUMEROACTA,MA_ANIOREGISTRO,MA_TIPODOCUMENTO,MA_ENTIDADREGISTRO,MA_MUNICIPIOREGISTRO,MA_OFICIALIA,MA_ACTABIS,MA_PRIMERAPELLIDO,MA_SEGUNDOAPELLIDO,MA_NOMBRES,MA_EDAD,MA_SEXO,MA_FECHANACIMIENTO,MA_FECHANACIMIENTO_INC,MA_ENTIDADNACIMIENTO,MA_MUNICIPIONACIMIENTO,MA_LOCALIDADNACIMIENTO,MA_NACIONALIDAD,MA_PAISNACIMIENTO,MA_CURP,CY_PRIMERAPELLIDO,CY_SEGUNDOAPELLIDO,CY_NOMBRES,CY_EDAD,CY_SEXO,CY_FECHANACIMIENTO,CY_FECHANACIMIENTO_INC,CY_ENTIDADNACIMIENTO,CY_MUNICIPIONACIMIENTO,CY_LOCALIDADNACIMIENTO,CY_NACIONALIDAD,CY_PAISNACIMIENTO,CY_CURP,CY_NUMEROACTA,CY_ANIOREGISTRO,CY_TIPODOCUMENTO,CY_ENTIDADREGISTRO,CY_MUNICIPIOREGISTRO,CY_OFICIALIA,CY_ACTABIS,CN_FECHAACTUALIZACION,CN_FECHAACTUALIZACION_INC,OT_LOCALIDADDEFUNCION,OT_FECHAREGISTROENNACIMIENTO,OT_CERTIFICADO_DE,OT_MESES,OT_DIAS,OT_HORAS,OT_MINUTOS,OT_SEGUNDOS,OT_LLAVERENADI,CO_TIPO,CO_FECHAORIGINAL,CO_TRANSCRIPCION,CO_SOPORTE);
									IF (bandera = 1 ) THEN
											INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																							VALUES(N_CADENA,NOW(),'ERROR DESCONOCIDO',1,2,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
											UPDATE defuncion d
												SET d.VALIDADO = 3,
														d.DESCRICION_ERROR_VALIDACION ='ERROR DESCONOCIDO'
											WHERE d.GUID = CO_LLAVEREGISTROCIVIL;
									ELSEIF (bandera = 2 ) THEN
											INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																							VALUES(N_CADENA,NOW(),'CADENA DUPLICADA',1,2,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
											UPDATE defuncion d
												SET d.VALIDADO = 3,
														d.DESCRICION_ERROR_VALIDACION ='CADENA DUPLICADA'
											WHERE d.GUID = CO_LLAVEREGISTROCIVIL;
											SET bandera = 0;
									ELSE		
											INSERT INTO CIRR_TA03_DEPETICION(TA03_E_PRIORIDAD,TA03_E_OPERACIONACTO,TA03_C_CADENA,TA03_E_ESTATUS,TA03_E_CUANTOS) 
																							VALUES(1,1,N_CADENA,0,0);
											SET bandera = 0;
									END IF; -- if banderas

						ELSE
									insert into monitor(tipo,mensaje) Values('Actualizar 1', concat('actualizar defuncion, ',N_CADENA));
									UPDATE nrc_defunciones def 
													SET def.NUMEROACTA = NUMEROACTA,def.ANIOREGISTRO = ANIOREGISTRO,def.TIPODOCUMENTO = TIPODOCUMENTO,def.ENTIDADREGISTRO = ENTIDADREGISTRO,def.MUNICIPIOREGISTRO = MUNICIPIOREGISTRO,def.OFICIALIA = OFICIALIA,def.ACTABIS = ACTABIS,def.CADENA = N_CADENA,def.CO_FECHA_REGISTRO = CO_FECHA_REGISTRO,def.CO_FECHA_REGISTRO_INC = CO_FECHA_REGISTRO_INC,def.CO_LLAVEREGISTROCIVIL = CO_LLAVEREGISTROCIVIL,def.CO_FOJA = CO_FOJA,def.CO_TOMO = CO_TOMO,def.CO_LIBRO = CO_LIBRO,def.IM_NOMBREORIGINALIMAGEN = IM_NOMBREORIGINALIMAGEN,def.IM_ARCHIVO = IM_ARCHIVO,def.NA_NUMEROACTA = NA_NUMEROACTA,def.NA_ANIOREGISTRO = NA_ANIOREGISTRO,def.NA_TIPODOCUMENTO = NA_TIPODOCUMENTO,def.NA_ENTIDADREGISTRO = NA_ENTIDADREGISTRO,def.NA_MUNICIPIOREGISTRO = NA_MUNICIPIOREGISTRO,def.NA_OFICIALIA = NA_OFICIALIA,def.NA_ACTABIS = NA_ACTABIS,def.OT_NOTASMARGINALES = OT_NOTASMARGINALES,def.OT_CRIP = OT_CRIP,def.OT_ESTADOCIVILDIFUNTO = OT_ESTADOCIVILDIFUNTO,def.OT_CAUSADEFUNCION = OT_CAUSADEFUNCION,def.OT_FECHADEFUNCION = OT_FECHADEFUNCION,def.OT_FECHADEFUNCION_INC = OT_FECHADEFUNCION_INC,def.OT_TIPODEFUNCION = OT_TIPODEFUNCION,def.PE_PRIMERAPELLIDO = PE_PRIMERAPELLIDO,def.PE_SEGUNDOAPELLIDO = PE_SEGUNDOAPELLIDO,def.PE_NOMBRES = PE_NOMBRES,def.PE_EDAD = PE_EDAD,def.PE_SEXO = PE_SEXO,def.PE_FECHANACIMIENTO = PE_FECHANACIMIENTO,def.PE_FECHANACIMIENTO_INC = PE_FECHANACIMIENTO_INC,def.PE_ENTIDADNACIMIENTO = PE_ENTIDADNACIMIENTO,def.PE_MUNICIPIONACIMIENTO = PE_MUNICIPIONACIMIENTO,def.PE_LOCALIDADNACIMIENTO = PE_LOCALIDADNACIMIENTO,def.PE_NACIONALIDAD = PE_NACIONALIDAD,def.PE_PAISNACIMIENTO = PE_PAISNACIMIENTO,def.PE_CURP = PE_CURP,def.PA_PRIMERAPELLIDO = PA_PRIMERAPELLIDO,def.PA_SEGUNDOAPELLIDO = PA_SEGUNDOAPELLIDO,def.PA_NOMBRES = PA_NOMBRES,def.PA_EDAD = PA_EDAD,def.PA_SEXO = PA_SEXO,def.PA_FECHANACIMIENTO = PA_FECHANACIMIENTO,def.PA_FECHANACIMIENTO_INC = PA_FECHANACIMIENTO_INC,def.PA_ENTIDADNACIMIENTO = PA_ENTIDADNACIMIENTO,def.PA_MUNICIPIONACIMIENTO = PA_MUNICIPIONACIMIENTO,def.PA_LOCALIDADNACIMIENTO = PA_LOCALIDADNACIMIENTO,def.PA_NACIONALIDAD = PA_NACIONALIDAD,def.PA_PAISNACIMIENTO = PA_PAISNACIMIENTO,def.PA_CURP = PA_CURP,def.PA_NUMEROACTA = PA_NUMEROACTA,def.PA_ANIOREGISTRO = PA_ANIOREGISTRO,def.PA_TIPODOCUMENTO = PA_TIPODOCUMENTO,def.PA_ENTIDADREGISTRO = PA_ENTIDADREGISTRO,def.PA_MUNICIPIOREGISTRO = PA_MUNICIPIOREGISTRO,def.PA_OFICIALIA = PA_OFICIALIA,def.PA_ACTABIS = PA_ACTABIS,def.MA_NUMEROACTA = MA_NUMEROACTA,def.MA_ANIOREGISTRO = MA_ANIOREGISTRO,def.MA_TIPODOCUMENTO = MA_TIPODOCUMENTO,def.MA_ENTIDADREGISTRO = MA_ENTIDADREGISTRO,def.MA_MUNICIPIOREGISTRO = MA_MUNICIPIOREGISTRO,def.MA_OFICIALIA = MA_OFICIALIA,def.MA_ACTABIS = MA_ACTABIS,def.MA_PRIMERAPELLIDO = MA_PRIMERAPELLIDO,def.MA_SEGUNDOAPELLIDO = MA_SEGUNDOAPELLIDO,def.MA_NOMBRES = MA_NOMBRES,def.MA_EDAD = MA_EDAD,def.MA_SEXO = MA_SEXO,def.MA_FECHANACIMIENTO = MA_FECHANACIMIENTO,def.MA_FECHANACIMIENTO_INC = MA_FECHANACIMIENTO_INC,def.MA_ENTIDADNACIMIENTO = MA_ENTIDADNACIMIENTO,def.MA_MUNICIPIONACIMIENTO = MA_MUNICIPIONACIMIENTO,def.MA_LOCALIDADNACIMIENTO = MA_LOCALIDADNACIMIENTO,def.MA_NACIONALIDAD = MA_NACIONALIDAD,def.MA_PAISNACIMIENTO = MA_PAISNACIMIENTO,def.MA_CURP = MA_CURP,def.CY_PRIMERAPELLIDO = CY_PRIMERAPELLIDO,def.CY_SEGUNDOAPELLIDO = CY_SEGUNDOAPELLIDO,def.CY_NOMBRES = CY_NOMBRES,def.CY_EDAD = CY_EDAD,def.CY_SEXO = CY_SEXO,def.CY_FECHANACIMIENTO = CY_FECHANACIMIENTO,def.CY_FECHANACIMIENTO_INC = CY_FECHANACIMIENTO_INC,def.CY_ENTIDADNACIMIENTO = CY_ENTIDADNACIMIENTO,def.CY_MUNICIPIONACIMIENTO = CY_MUNICIPIONACIMIENTO,def.CY_LOCALIDADNACIMIENTO = CY_LOCALIDADNACIMIENTO,def.CY_NACIONALIDAD = CY_NACIONALIDAD,def.CY_PAISNACIMIENTO = CY_PAISNACIMIENTO,def.CY_CURP = CY_CURP,def.CY_NUMEROACTA = CY_NUMEROACTA,def.CY_ANIOREGISTRO = CY_ANIOREGISTRO,def.CY_TIPODOCUMENTO = CY_TIPODOCUMENTO,def.CY_ENTIDADREGISTRO = CY_ENTIDADREGISTRO,def.CY_MUNICIPIOREGISTRO = CY_MUNICIPIOREGISTRO,def.CY_OFICIALIA = CY_OFICIALIA,def.CY_ACTABIS = CY_ACTABIS,def.CN_FECHAACTUALIZACION = CN_FECHAACTUALIZACION,def.CN_FECHAACTUALIZACION_INC = CN_FECHAACTUALIZACION_INC,def.OT_LOCALIDADDEFUNCION = OT_LOCALIDADDEFUNCION,def.OT_FECHAREGISTROENNACIMIENTO = OT_FECHAREGISTROENNACIMIENTO,def.OT_CERTIFICADO_DE = OT_CERTIFICADO_DE,def.OT_MESES = OT_MESES,def.OT_DIAS = OT_DIAS,def.OT_HORAS = OT_HORAS,def.OT_MINUTOS = OT_MINUTOS,def.OT_SEGUNDOS = OT_SEGUNDOS,def.OT_LLAVERENADI = OT_LLAVERENADI,def.CO_TIPO = CO_TIPO,def.CO_FECHAORIGINAL = CO_FECHAORIGINAL,def.CO_TRANSCRIPCION = CO_TRANSCRIPCION,def.CO_SOPORTE = CO_SOPORTE 
													WHERE def.CO_LLAVEREGISTROCIVIL = CO_LLAVEREGISTROCIVIL;
									IF (bandera = 1 ) THEN
											INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																							VALUES(N_CADENA,NOW(),'ERROR DESCONOCIDO',3,1,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
											UPDATE defuncion d
												SET d.VALIDADO = 3,
														d.DESCRICION_ERROR_VALIDACION ='ERROR DESCONOCIDO'
											WHERE d.GUID = CO_LLAVEREGISTROCIVIL;
											SET bandera = 0;
									ELSEIF (bandera = 2 ) THEN
											INSERT INTO bitacora_rnp(CADENA,FECHA_INSERT,ESTATUS,MOVIMIENTO,ACTO,CVE_OFICIALIA,ANO,TRAMITE,SERVICIO,LLAVE_RC)
																							VALUES(N_CADENA,NOW(),'CADENA DUPLICADA',3,1,OFICIALIA,ANIOREGISTRO,1,1,CO_LLAVEREGISTROCIVIL);
											UPDATE defuncion d
												SET d.VALIDADO = 3,
														d.DESCRICION_ERROR_VALIDACION ='CADENA DUPLICADA'
											WHERE d.GUID = CO_LLAVEREGISTROCIVIL;
											SET bandera = 0;
									ELSE	
											if (n_cadena=o_cadena) then
												insert into monitor(tipo,mensaje) Values('Actualizar 3', concat('actualizar defuncion, ',N_CADENA));
													INSERT INTO CIRR_TA03_DEPETICION(TA03_E_PRIORIDAD,TA03_E_OPERACIONACTO,TA03_C_CADENA,TA03_E_ESTATUS,TA03_E_CUANTOS) 
																							VALUES(1,3,N_CADENA,0,0);
											ELSE
													insert into monitor(tipo,mensaje) Values('Actualizar 4', concat('actualizar defuncion, ',CADENA));
													INSERT INTO CIRR_TA03_DEPETICION(TA03_E_PRIORIDAD,TA03_E_OPERACIONACTO,TA03_C_CADENA,TA03_E_ESTATUS,TA03_E_CUANTOS) 
																							VALUES(1,1,N_CADENA,0,0);
											end if;											
											SET bandera = 0;
									END IF; -- if banderas

						END IF;
					END IF;
				END IF;
		ELSE 
			set bandera = 0;
				IF(NEW.VALIDADO > 2 AND NEW.VALIDADO IS NOT NULL)THEN
			INSERT INTO CIRR_TA03_DEPETICION(TA03_E_PRIORIDAD,TA03_E_OPERACIONACTO,TA03_C_CADENA,TA03_E_ESTATUS,TA03_E_CUANTOS) 
																						VALUES(1,2,N_CADENA,0,0);
				END IF;
			if(bandera=0) then

				insert into bitacora_cambio set
				bitacora_cambio.USUARIO= NEW.MODIFICA,
				bitacora_cambio.FECHA= now(),
				bitacora_cambio.TIPO = 'B',
				bitacora_cambio.Tabla = 'DEFUNCION',
				bitacora_cambio.MOdificacion = txt;
			end if;
		END IF;
			
END