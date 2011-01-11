
INSERT INTO `gc`.`tipocomprobante` (
`id_tipocomprobante` ,
`tcom_codigo` ,
`tcom_nombre` ,
`tcom_discriminaiva` ,
`tcom_letra` ,
`tcom_abreviatura` ,
`tcom_sumaresta` ,
`tcom_afecta` ,
`tcom_copias` ,
`tcom_tdf` ,
`tcom_tipocomprobante` ,
`tcom_aperturacomp` ,
`tcom_cierrecomp` ,
`tcom_usuario` ,
`tcom_ultmod`
)
VALUES (
'105', '15', 'RECIBO C', 'No', 'C', 'RECC', '+', 'S', '1', 'F', '', '0', '0', '', '0000-00-00'
); -- falta en chaj 
--pasar tablas enteras de tipocomprobante, conceptoegreso, localidad, sucursal (estructura y datos) ejecutar pasatablas.sh
--ALTER TABLE `usuario` ADD `id` INT( 10 ) NOT NULL FIRST ;
--ver si lo hacemos con un programita lo de los actualizar los  id 

--empresa para leer la sucursal
--View empresas
--ALTER TABLE `empresa` ADD `id_empresa` INT( 3 ) NULL FIRST ;
--ALTER TABLE `empresa` ADD `id_sucursal` INT( 10 ) NULL AFTER `empr_razonsocial` ;
-- FALTA SOLO EN ROSB, RECONQ, SAN LORENZO CENTRO Y CHAJARI

CREATE ALGORITHM = UNDEFINED VIEW empresas AS SELECT id_empresa as id, empr_razonsocial, id_sucursal AS sucursal_id, empr_calle, empr_puerta, id_localidad as localidad_id, empr_telefono, id_situacionafip as situacionafip_id, empr_cuit, empr_alicuotainscr, empr_ingbruto, empr_modoimpresion, empr_email, empr_listavigente, empr_fechavigencia, empr_usuario, empr_ultmod
FROM `empresa`

-- DESDE ACA
ALTER TABLE `usuario` ADD PRIMARY KEY ( `id` ) ;
ALTER TABLE `usuario` CHANGE `id` `id` INT( 10 ) NOT NULL AUTO_INCREMENT; 
ALTER TABLE `usuario` ADD `usur_nivelmenu` TINYINT( 3 ) NULL ;
ALTER TABLE `usuario` ADD `usur_contrasena` VARCHAR( 50 ) NULL ;
ALTER TABLE `usuario` ADD `usur_email` VARCHAR( 50 ) NULL ;
ALTER TABLE `usuario` ADD `sucursal_id` TINYINT( 3 ) NULL ;
ALTER TABLE `usuario` ADD `cliente_id` INT( 11 ) NULL ;
-- view usuarios
CREATE ALGORITHM = UNDEFINED VIEW usuarios AS SELECT id, usur_usuario, usur_rol, usur_nivelmenu, usur_nombre, usur_contrasena, usur_email, sucursal_id, cliente_id, usur_nivel
FROM `usuario`;

--table roles
CREATE TABLE roles(
id int( 11 ) ,
titulo VARCHAR( 50 )
);
ALTER TABLE `roles` ADD PRIMARY KEY ( `id` ); 
ALTER TABLE `roles` CHANGE `id` `id` INT( 11 ) NOT NULL AUTO_INCREMENT ; 
INSERT INTO `roles` (
`id` ,
`titulo`
)
VALUES ('1', 'rol 1'), ('2', 'rol 2'), ('3', 'rol 3'), ('4', 'rol 4'), ('5', 'rol 5'), ('6', 'rol 6'), ('7', 'rol 7'); 

--tabla roles-usuarios
CREATE TABLE roles_usuarios(
role_id int( 11 ) ,
usuario_id int( 11 )
);
--crear usuario administardor
INSERT INTO `usuario` (
`id`,
`usur_usuario`,
`usur_rol`,
`usur_nombre`,
`usur_nivel`,
`usur_nivelmenu`,
`usur_contrasena`,
`usur_email`,
`sucursal_id`,
`cliente_id`
)
VALUES (
10 , 'admin', '7', 'administrador', '5', '7', SHA1( 'tachiwaza' ) , NULL , NULL , NULL
);
INSERT INTO `gc`.`roles_usuarios` (
`role_id` ,
`usuario_id`
)
VALUES (
'7', '10'
);

--View jurisdiccion
CREATE ALGORITHM = UNDEFINED VIEW jurisdiccions AS SELECT id_jurisdiccion AS id, juri_codigo, juri_nombre, juri_usuario, juri_ultmod
FROM `jurisdiccion`;

--View localidades
CREATE  ALGORITHM = UNDEFINED VIEW localidads AS SELECT id_localidad as id, loca_codigopostal, loca_estafeta, loca_nombre, loca_calle, loca_altura, id_provincia as provincia_id, loca_letraprovi, loca_usuario, loca_ultmod
FROM `localidad`;

--View provincias
ALTER TABLE `provincia` ADD PRIMARY KEY ( `id_provincia` );  
CREATE ALGORITHM = UNDEFINED VIEW provincias AS SELECT id_provincia AS id, pcia_nombre, pcia_abreviatura, pcia_codigoib, pcia_letra
FROM `provincia`;

--View tipocomprobantes
UPDATE `gc`.`tipocomprobante` SET `tcom_copias` = '3' WHERE `tipocomprobante`.`id_tipocomprobante` = 1 LIMIT 1 ;
UPDATE `gc`.`tipocomprobante` SET `tcom_copias` = '3' WHERE `tipocomprobante`.`id_tipocomprobante` = 2 LIMIT 1 ;
UPDATE `gc`.`tipocomprobante` SET `tcom_copias` = '3' WHERE `tipocomprobante`.`id_tipocomprobante` = 3 LIMIT 1 ;
UPDATE `gc`.`tipocomprobante` SET `tcom_copias` = '3' WHERE `tipocomprobante`.`id_tipocomprobante` = 6 LIMIT 1 ;
UPDATE `gc`.`tipocomprobante` SET `tcom_copias` = '3' WHERE `tipocomprobante`.`id_tipocomprobante` = 7 LIMIT 1 ;
UPDATE `gc`.`tipocomprobante` SET `tcom_copias` = '3' WHERE `tipocomprobante`.`id_tipocomprobante` = 8 LIMIT 1 ;
UPDATE `gc`.`tipocomprobante` SET `tcom_copias` = '3' WHERE `tipocomprobante`.`id_tipocomprobante` = 45 LIMIT 1 ;
--parana 3, rosb 3, 

CREATE ALGORITHM = UNDEFINED VIEW tipocomprobantes AS SELECT id_tipocomprobante AS id, tcom_codigo, tcom_nombre,   	tcom_discriminaiva, tcom_letra, tcom_abreviatura, tcom_sumaresta, tcom_afecta, tcom_copias, tcom_tdf, tcom_tipocomprobante, tcom_aperturacomp, tcom_cierrecomp, tcom_usuario, tcom_ultmod
FROM `tipocomprobante`;

--View conceptoegresos
CREATE  ALGORITHM = UNDEFINED VIEW conceptoegresos AS SELECT id_conceptoegreso as id, cegr_codigo, cegr_detalle, cegr_tipoconcepto, cegr_baseretgan, id_planimpositivo as planimpositivo_id, id_plandecuenta as plandecuenta_id, cegr_retganancia, cegr_usuario, cegr_ultmod
FROM `conceptoegreso`;

--cabcompra
DROP TABLE IF EXISTS `cabcompra`; 
 CREATE  TABLE  `cabcompra` (  `id_sucursal` tinyint( 3  )  unsigned NOT  NULL default  '0',
 `id_cabcompra` int( 7  )  unsigned NOT  NULL default  '0',
 `id_pagocompra` int( 3  )  default NULL ,
 `ccom_fecha` date NOT  NULL default  '0000-00-00',
 `id_tipocomprobante` tinyint( 3  )  unsigned NOT  NULL default  '0',
 `ccom_puntosventa` int( 4  )  unsigned NOT  NULL default  '0',
 `ccom_desdecompro` int( 8  ) unsigned default  '0',
 `ccom_hastacompro` int( 8  ) unsigned default  '0',
 `ccom_codigoaduana` tinyint( 3  ) unsigned default  '0',
 `ccom_codigodestinacion` varchar( 4  )  default NULL ,
 `ccom_nrodespacho` int( 6  ) unsigned default  '0',
 `ccom_digverdespacho` varchar( 1  )  default NULL ,
 `id_proveedor` int( 5  )  unsigned NOT  NULL default  '0',
 `id_renplaegreso` int( 4  )  default NULL ,
 `ccom_retencioniva` decimal( 12, 2  ) default  '0.00',
 `ccom_percepcioniva` decimal( 12, 2  ) default  '0.00',
 `ccom_retencionganancia` decimal( 12, 2  ) default  '0.00',
 `ccom_retencionib` decimal( 12, 2  ) default  '0.00',
 `ccom_percepcionib` decimal( 12, 2  ) default  '0.00',
 `ccom_retencionmunicipal` decimal( 12, 2  ) default  '0.00',
 `ccom_nogravado` decimal( 12, 2  ) default  '0.00',
 `ccom_impuestointerno` decimal( 12, 2  ) default  '0.00',
 `ccom_exento` decimal( 12, 2  )  NOT  NULL default  '0.00',
 `ccom_netogravado` decimal( 12, 2  ) default  '0.00',
 `ccom_iva` decimal( 12, 2  ) default  '0.00',
 `ccom_total` decimal( 12, 2  )  NOT  NULL default  '0.00',
 `ccom_cai` varchar( 14  )  NOT  NULL default  '0',
 `ccom_ctcc` enum(  'Contado',  'Cta/Cte'  )  NOT  NULL default  'Contado',
 `id_jurisdiccion` int( 3  )  unsigned NOT  NULL default  '0',
 `id_conceptoegreso` int( 5  )  unsigned NOT  NULL ,
 `id_cabplaegreso` int( 8  )  default NULL ,
 `retencionganancia_id` int( 5  )  default NULL ,
 `ccom_gastocompra` enum(  'GASTO',  'COMPRA'  )  default NULL ,
 `ccom_nroplaegreso` int( 5  )  NOT  NULL default  '0',
 `ccom_usuario` varchar( 8  )  NOT  NULL default  '',
 `ccom_ultmod` date NOT  NULL default  '0000-00-00',
 PRIMARY  KEY (  `id_sucursal` ,  `id_cabcompra`  ) ,
 KEY  `por_fechacompro` (  `ccom_fecha` ,  `id_tipocomprobante` ,  `ccom_puntosventa` ,  `ccom_desdecompro`  )  ) ENGINE  = InnoDB  DEFAULT CHARSET  = latin1 COMMENT  =  'Tabla de datos cabecera de compras';
--View cabcompras
CREATE ALGORITHM = UNDEFINED VIEW cabcompras AS SELECT id_cabcompra AS id, id_sucursal AS sucursal_id, ccom_fecha, id_tipocomprobante AS tipocomprobante_id, ccom_puntosventa, ccom_desdecompro, ccom_hastacompro, ccom_codigoaduana, ccom_codigodestinacion, ccom_nrodespacho, ccom_digverdespacho, id_proveedor AS proveedor_id, id_renplaegreso AS renplaegreso_id, id_cabplaegreso as cabplaegreso_id, id_pagocompra as pagocompra_id, retencionganancia_id, ccom_retencioniva, ccom_percepcioniva, ccom_retencionganancia, ccom_retencionib, ccom_percepcionib, ccom_retencionmunicipal, ccom_nogravado, ccom_impuestointerno, ccom_exento, ccom_netogravado, ccom_iva, ccom_total, ccom_cai, ccom_ctcc, id_jurisdiccion AS jurisdiccion_id, id_conceptoegreso AS conceptoegreso_id, ccom_nroplaegreso, ccom_gastocompra, ccom_usuario, ccom_ultmod
FROM `cabcompra` 

--estructura de la tabla rencompras
DROP TABLE IF EXISTS `rencompra` ; 

CREATE TABLE `rencompra` (
`id_sucursal` tinyint( 3 ) unsigned NOT NULL default '0',
`id_rencompra` int( 7 ) unsigned NOT NULL default '0',
`id_cabcompra` int( 7 ) unsigned NOT NULL default '0',
`rcom_netorenglon` decimal( 12, 2 ) NOT NULL default '0.00',
`rcom_ivarenglon` decimal( 12, 2 ) NOT NULL default '0.00',
`rcom_totalrenglon` decimal( 12, 2 ) NOT NULL default '0.00',
`id_alicuotaiva` tinyint( 3 ) unsigned NOT NULL default '0',
`rcom_usuario` varchar( 8 ) NOT NULL default '',
`rcom_ultmod` date NOT NULL default '0000-00-00',
PRIMARY KEY ( `id_sucursal` , `id_rencompra` ) ,
KEY `por_cabcompra` ( `id_sucursal` , `id_cabcompra` )
) ENGINE = InnoDB DEFAULT CHARSET = latin1 COMMENT = 'Tabla de renglones de compra';

--View rencompras
CREATE ALGORITHM = UNDEFINED VIEW rencompras AS SELECT id_rencompra AS id, id_sucursal AS sucursal_id, id_cabcompra AS cabcompra_id, id_alicuotaiva as alicuotaiva_id, rcom_netorenglon, rcom_ivarenglon, rcom_totalrenglon, rcom_usuario, rcom_ultmod
FROM `rencompra`;

--View renplaegreso
CREATE ALGORITHM = UNDEFINED VIEW renplaegresos AS SELECT id_renplaegreso AS id, id_sucursal AS sucursal_id, id_cabplaegreso AS cabplaegreso_id, id_conceptoegreso as conceptoegreso_id, rpeg_observa, rpeg_importe, rpeg_usuario, rpeg_ultmod
FROM `renplaegreso`;

--cabplaegresos
ALTER TABLE `cabplaegreso` CHANGE `cpeg_fecharegistro` `cpeg_fecharegistro` DATE NULL DEFAULT '0000-00-00'; 
ALTER TABLE `cabplaegreso` CHANGE `id_cabcaja` `id_cabcaja` INT( 5 ) UNSIGNED NULL DEFAULT '0'; 

--View cabplaegreso
CREATE ALGORITHM = UNDEFINED VIEW cabplaegresos AS SELECT id_cabplaegreso AS id, id_sucursal AS sucursal_id, cpeg_nroplanilla, cpeg_fecha, cpeg_acargode, cpeg_importe, id_cabcaja as cabcaja_id, cpeg_cerrada, cpeg_control, cpeg_fecharegistro, cpeg_exportada, cpeg_usuario, cpeg_ultmod
FROM `cabplaegreso`;


-- Tabla de pago de compras
CREATE TABLE pagocompra(
id_pagocompra int( 3 ) ,
id_sucursal int( 3 ) ,
id_cabcaja int( 5 ) ,
pcpr_efectivo decimal(12, 2),
pcpr_cheque decimal(12, 2),
pcpr_depotransf decimal(12, 2),
pcpr_otro decimal (12, 2),
pcpr_observacion VARCHAR( 150 ),
pcpr_usuario varchar( 10 ) ,
pcpr_ultmod date
);
ALTER TABLE `pagocompra` ADD PRIMARY KEY ( `id_pagocompra` , `id_sucursal` ) ;
ALTER TABLE `pagocompra` CHANGE `id_pagocompra` `id_pagocompra` INT( 3 ) NOT NULL AUTO_INCREMENT ;

--View pagocompras
CREATE ALGORITHM = UNDEFINED VIEW pagocompras AS SELECT id_pagocompra AS id, id_sucursal as sucursal_id, id_cabcaja as cabcaja_id, pcpr_cheque, pcpr_efectivo, pcpr_depotransf, pcpr_otro, pcpr_observacion, pcpr_usuario, pcpr_ultmod
FROM `pagocompra`;

-- Tabla de pago retencion de ganancias
 CREATE TABLE retencionganancias(
id int( 5 ) ,
sucursal_id int( 3 ) ,
rtga_importe decimal(12, 2),
rtga_nroorden VARCHAR(50),
rtga_usuario varchar( 10 ) ,
rtga_ultmod date
);
ALTER TABLE `retencionganancias` ADD `rtga_plaegresoid` INT( 5 ) NULL AFTER `rtga_nroorden` ;
ALTER TABLE `retencionganancias` ADD PRIMARY KEY ( `id` , `sucursal_id` ) ;

--Table sucursal View sucursals
create algorithm = undefined view sucursals as SELECT id_sucursal as id, sucu_codigo, sucu_nombre, sucu_abreviatura, sucu_domicilio, sucu_telefono, sucu_impu_municipal, sucu_insc_municipal, sucu_provinciapib, sucu_agenteretpib, sucu_inicioactividades, sucu_porcuentayorden, sucu_controlaservicio, sucu_email, sucu_emailpedidoweb, sucu_usuario, sucu_ultmod
FROM `sucursal`;

--View tipodocumentos
CREATE  ALGORITHM = UNDEFINED VIEW tipodocumentos AS SELECT id_tipodocumento as id, tdoc_codigo, tdoc_nombre, tdoc_abreviatura, tdoc_tdi, tdoc_usuario, tdoc_ultmod
FROM `tipodocumento`;

--View situacionafips
CREATE  ALGORITHM = UNDEFINED VIEW situacionafips AS SELECT id_situacionafip as id, situ_codigo, situ_nombre, situ_abreviatura, situ_tasageneral, situ_sobretasa, situ_discrimina, situ_letra, situ_controlacuit, situ_usuario, situ_ultmod
FROM `situacionafip`;

--View alicuotaivas
CREATE  ALGORITHM = UNDEFINED VIEW alicuotaivas AS SELECT id_alicuotaiva as id, aiva_alicuota, aiva_inicio, aiva_final, aiva_usuario, aiva_ultmod
FROM `alicuotaiva`;

--tablas para informes y estadisticas

--View vendedors
CREATE ALGORITHM = UNDEFINED VIEW vendedors AS SELECT id_vendedor AS id, vend_codigo, vend_nombre, vend_nombreabrev, vend_domicilio, id_sucursal AS sucursal_id, vend_confeccionacaja, vend_agrupaconvendedor, vend_remuneracion, vend_comisionventas, vend_comisioncobran, vend_zona, vend_mercaderia, vend_ingreso, vend_local, vend_usuario, vend_ultmod
FROM `vendedor`;
--View revendedors
CREATE  ALGORITHM = UNDEFINED VIEW revendedors AS SELECT id_revendedor as id, reve_codigo, id_vendedor as vendedor_id, reve_nombre, reve_domicilio, id_sucursal as sucursal_id, id_cliente as cliente_id, reve_usuario, reve_ultmod
FROM `revendedor`;

--View marcas
CREATE  ALGORITHM = UNDEFINED VIEW marcas AS SELECT id_marca AS id, marc_codigo, marc_descripcion, marc_usuario, marc_ultmod
FROM `marca`;


--View Proveedors por ultimoooo hasta aca en las sucursales

ALTER TABLE `proveedor` ADD `id_sucursal` INT( 3 ) NOT NULL DEFAULT '05' AFTER `id_proveedor`; -- cambiar por id de la sucursal!!!
ALTER TABLE `proveedor` DROP PRIMARY KEY, ADD PRIMARY KEY(`id_proveedor`, `id_sucursal`);
ALTER TABLE `proveedor` ADD `prov_exentoretgan` ENUM( 'No', 'Si' ) NOT NULL DEFAULT 'No' AFTER `prov_baja` ;
UPDATE `gc`.`proveedor` SET `prov_exentoretgan` = 'Si' WHERE  `proveedor`.`id_proveedor` =1 LIMIT 1 ;
UPDATE `gc`.`proveedor` SET `prov_exentoretgan` = 'Si' WHERE  `proveedor`.`id_proveedor` =2 LIMIT 1 ; 
CREATE  ALGORITHM = UNDEFINED VIEW proveedors AS SELECT id_sucursal as sucursal_id, id_proveedor as id, prov_codigo, prov_nombre, prov_calle, prov_puerta, id_localidad as localidad_id, prov_telefono, id_situacionafip as situacionafip_id, id_tipodocumento as tipodocumento_id, prov_cuit, prov_estado, prov_ingbrutos, prov_regimenretencion, prov_saldo, prov_observaciones, prov_consignatario, prov_baja, prov_exentoretgan, prov_usuario, prov_ultmod
FROM `proveedor`;

--desde aca 27/09/2010 falta pasar chajari 
ALTER TABLE `tipocomprobante` ADD `tcom_validanro` ENUM( 'N', 'S' ) NULL DEFAULT 'S' AFTER `tcom_discriminaiva` ;
UPDATE `gc`.`tipocomprobante` SET `tcom_validanro` = 'N' WHERE `tipocomprobante`.`id_tipocomprobante` =37;
UPDATE `gc`.`tipocomprobante` SET `tcom_validanro` = 'N' WHERE `tipocomprobante`.`id_tipocomprobante` =38;
UPDATE `gc`.`tipocomprobante` SET `tcom_validanro` = 'N' WHERE `tipocomprobante`.`id_tipocomprobante` =100;
UPDATE `gc`.`tipocomprobante` SET `tcom_validanro` = 'N' WHERE `tipocomprobante`.`id_tipocomprobante` =101;
UPDATE `gc`.`tipocomprobante` SET `tcom_validanro` = 'N' WHERE `tipocomprobante`.`id_tipocomprobante` =102;

ALTER TABLE `tipocomprobante` ADD `tcom_ambitocompra` ENUM( 'N', 'S' ) NULL DEFAULT 'S' AFTER `tcom_validanro`;
UPDATE `gc`.`tipocomprobante` SET `tcom_ambitocompra` = 'N' WHERE `tipocomprobante`.`id_tipocomprobante` =19 LIMIT 1 ;
UPDATE `gc`.`tipocomprobante` SET `tcom_ambitocompra` = 'N' WHERE `tipocomprobante`.`id_tipocomprobante` =20 LIMIT 1 ;
UPDATE `gc`.`tipocomprobante` SET `tcom_ambitocompra` = 'N' WHERE `tipocomprobante`.`id_tipocomprobante` =40 LIMIT 1 ;
UPDATE `gc`.`tipocomprobante` SET `tcom_ambitocompra` = 'N' WHERE `tipocomprobante`.`id_tipocomprobante` =45 LIMIT 1 ;
UPDATE `gc`.`tipocomprobante` SET `tcom_ambitocompra` = 'N' WHERE `tipocomprobante`.`id_tipocomprobante` =60 LIMIT 1 ;
UPDATE `gc`.`tipocomprobante` SET `tcom_ambitocompra` = 'N' WHERE `tipocomprobante`.`id_tipocomprobante` =84 LIMIT 1 ;
UPDATE `gc`.`tipocomprobante` SET `tcom_ambitocompra` = 'N' WHERE `tipocomprobante`.`id_tipocomprobante` =90 LIMIT 1 ;
UPDATE `gc`.`tipocomprobante` SET `tcom_ambitocompra` = 'N' WHERE `tipocomprobante`.`id_tipocomprobante` =100 LIMIT 1 ;
UPDATE `gc`.`tipocomprobante` SET `tcom_ambitocompra` = 'N' WHERE `tipocomprobante`.`id_tipocomprobante` =101 LIMIT 1 ;

UPDATE `gc`.`tipocomprobante` SET `tcom_ambitocompra` = 'N' WHERE `tipocomprobante`.`id_tipocomprobante` =102 LIMIT 1 ;

ALTER TABLE `tipocomprobante` CHANGE `tcom_nombre` `tcom_nombre` VARCHAR( 30 ) ;
UPDATE `tipocomprobante` SET `tcom_nombre` = 'COMPROBANTES VARIOS SIN IVA' WHERE `tipocomprobante`.`id_tipocomprobante` =37;
DROP VIEW `tipocomprobantes`;
CREATE ALGORITHM = UNDEFINED VIEW tipocomprobantes AS SELECT id_tipocomprobante AS id, tcom_codigo, tcom_nombre,   	tcom_discriminaiva, tcom_validanro, tcom_ambitocompra, tcom_letra, tcom_abreviatura, tcom_sumaresta, tcom_afecta, tcom_copias, tcom_tdf, tcom_tipocomprobante, tcom_aperturacomp, tcom_cierrecomp, tcom_usuario, tcom_ultmod
FROM `tipocomprobante`;
--View Proveedors
CREATE  ALGORITHM = UNDEFINED VIEW proveedors AS SELECT id_sucursal as sucursal_id, id_proveedor as id, prov_codigo, prov_nombre, prov_calle, prov_puerta, id_localidad as localidad_id, prov_telefono, id_situacionafip as situacionafip_id, id_tipodocumento as tipodocumento_id, prov_cuit, prov_estado, prov_ingbrutos, prov_regimenretencion, prov_saldo, prov_observaciones, prov_consignatario, prov_baja, prov_exentoretgan, prov_usuario, prov_ultmod
FROM `proveedor`

-- Pasar esto solo si habilita la opcion de cargar comprobantes por afuera de la planilla de egreso
INSERT INTO `gc`.`cabplaegreso` (
`id_sucursal` ,
`id_cabplaegreso` ,
`cpeg_nroplanilla` ,
`cpeg_fecha` ,
`cpeg_acargode` ,
`cpeg_importe` ,
`id_cabcaja` ,
`cpeg_cerrada` ,
`cpeg_control` ,
`cpeg_fecharegistro` ,
`cpeg_exportada` ,
`cpeg_usuario` ,
`cpeg_ultmod`
)
VALUES (
'1', '0', '0', '2010-01-21', 'C', '0.00', '0', 'N', 'N', '0000-00-00', 'N', '', '0000-00-00'
);
--hasta aca comprobantes por afuera de la planilla de egreso

--deploy 18/10/2010
-- view clientes
CREATE  ALGORITHM = UNDEFINED VIEW clientes AS SELECT id_cliente AS id, id_sucursal AS sucursal_id, clie_codigo, clie_razonsocial, clie_contacto, clie_telefono, clie_email, clie_url, id_situacionafip AS situacionafip_id, id_tipodocumento AS tipodocumento_id, clie_cuit, clie_domicilio, clie_puerta, id_localidad AS localidad_id, id_vendedor AS vendedor_id, clie_ultimacompra, clie_saldo, clie_estado, clie_ingbrutos, clie_porcib, clie_cuentamadre, clie_observaciones, clie_movimiento, clie_baja, clie_saldofavor, clie_cpanterior, clie_factelectronica, clie_usuario, clie_ultmod
FROM `cliente`;
-- View articulos
CREATE  ALGORITHM = UNDEFINED VIEW articulos AS SELECT id_articulo as id, arti_codigo, arti_codigoviejo, arti_descripcion, id_marca as marca_id, id_rubro as rubro_id, arti_modelo, arti_medida, arti_conosincamara, arti_telas, arti_clavesecundaria, id_alicuotaiva as alicuotaiva_id, arti_codigolista, arti_impnac, arti_ventactaord, arti_habilitado, arti_promopirelli, arti_controlastock, arti_liquidacomision, arti_fechabaja, id_proveedor as proveedor_id, arti_artinuevo, arti_usuario, arti_ultmod
FROM `articulo`
--deploy 18/10/2010

