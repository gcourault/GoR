-- View rencomcaja
ALTER TABLE `rencomcaja` ADD `rcca_porcuentayorden` ENUM( 'D', 'M', 'F', 'U' ) NOT NULL DEFAULT 'D' AFTER `rcca_contado` ;

update rencomcaja as r, cabfactura as f set rcca_porcuentayorden=cfac_porcuentayorden where r.id_tipocomprobante=f.id_tipocomprobante and r.rcca_puntosventa=f.cfac_puntosventa and r.rcca_nrocomprobante=f.cfac_nrocomprobante 

CREATE ALGORITHM = UNDEFINED VIEW rencomcajas AS SELECT id_sucursal AS sucursal_id, id_cabcaja AS cabcaja_id, rcca_vendedor, id_tipocomprobante AS tipocomprobante_id, rcca_puntosventa, rcca_nrocomprobante, rcca_importe, rcca_contado, rcca_porcuentayorden, rcca_usuario, rcca_ultmod
FROM `rencomcaja`

-- View renrendcaja

CREATE ALGORITHM = UNDEFINED VIEW renrendcajas AS SELECT id_sucursal AS sucursal_id, id_cabcaja AS cabcaja_id, id_formapago AS formapago_id, rrca_importeoriginal, rrca_importemodi, rrca_importerepocheque, rrca_importerepocupon, rrca_usuario, rrca_ultmod FROM `renrendcaja`

--articulos para alliance
ALTER TABLE `articulo` ADD `arti_ancho` VARCHAR( 10 ) NULL AFTER `arti_telas` ;
ALTER TABLE `articulo` ADD `arti_diametro` VARCHAR( 10 ) NULL AFTER `arti_ancho` ,
ADD `arti_aro` VARCHAR( 10 ) NULL AFTER `arti_diametro` ;
DROP VIEW `articulos`;
CREATE  ALGORITHM = UNDEFINED VIEW articulos AS SELECT id_articulo as id, arti_codigo, arti_codigoviejo, arti_descripcion, id_marca as marca_id, id_rubro as rubro_id, arti_modelo, arti_medida, arti_conosincamara, arti_telas, arti_ancho, arti_diametro, arti_aro, arti_clavesecundaria, id_alicuotaiva as alicuotaiva_id, arti_codigolista, arti_impnac, arti_ventactaord, arti_habilitado, arti_promopirelli, arti_controlastock, arti_liquidacomision, arti_fechabaja,  id_consignatario as consignatario_id, arti_artinuevo, arti_usuario, arti_ultmod
FROM `articulo`

--vista stock

--View stock
CREATE  ALGORITHM = UNDEFINED VIEW stocks AS SELECT  id_articulo as id, id_sucursal as sucursal_id, stoc_actual, stoc_minimo, stoc_critico, stoc_inicial, stoc_transito, stoc_fechainicial, stoc_usuario, stoc_ultmod
FROM `stock`

--tabla de coeficientes
CREATE TABLE `gc`.`coeficientes` (
`id` BIGINT( 8 ) UNSIGNED NOT NULL AUTO_INCREMENT ,
`ejercicio_id` TINYINT( 3 ) UNSIGNED NOT NULL,
`coef_inicial` DECIMAL( 4, 2 ) NOT NULL DEFAULT '0.00',
`coef_mes1` DECIMAL( 4, 2 ) NOT NULL DEFAULT '0.00',
`coef_mes2` DECIMAL( 4, 2 ) NOT NULL DEFAULT '0.00',
`coef_mes3` DECIMAL( 4, 2 ) NOT NULL DEFAULT '0.00',
`coef_mes4` DECIMAL( 4, 2 ) NOT NULL DEFAULT '0.00',
`coef_mes5` DECIMAL( 4, 2 ) NOT NULL DEFAULT '0.00',
`coef_mes6` DECIMAL( 4, 2 ) NOT NULL DEFAULT '0.00',
`coef_mes7` DECIMAL( 4, 2 ) NOT NULL DEFAULT '0.00',
`coef_mes8` DECIMAL( 4, 2 ) NOT NULL DEFAULT '0.00',
`coef_mes9` DECIMAL( 4, 2 ) NOT NULL DEFAULT '0.00',
`coef_mes10` DECIMAL( 4, 2 ) NOT NULL DEFAULT '0.00',
`coef_mes11` DECIMAL( 4, 2 ) NOT NULL DEFAULT '0.00',
`coef_mes12` DECIMAL( 4, 2 ) NOT NULL DEFAULT '0.00',
`coef_usuario` VARCHAR( 8 ) NULL ,
`coef_ultmod` DATE NULL ,
PRIMARY KEY ( `id` )
);
ALTER TABLE `coeficientes` ADD `coef_descripcion` VARCHAR( 100 ) NULL AFTER `ejercicio_id` ;

--cambios en tipo de comprobante para los comprobantes de retenciones ***cambio realizado tambien en sucursales***
ALTER TABLE `tipocomprobante` ADD `tcom_cabecera` ENUM( 'N', 'S' ) NOT NULL DEFAULT 'N' AFTER `tcom_cierrecomp` ;
DROP VIEW `tipocomprobantes`;
CREATE ALGORITHM = UNDEFINED VIEW tipocomprobantes AS SELECT id_tipocomprobante AS id, tcom_codigo, tcom_nombre,   	tcom_discriminaiva, tcom_validanro, tcom_ambitocompra, tcom_letra, tcom_abreviatura, tcom_sumaresta, tcom_afecta, tcom_copias, tcom_tdf, tcom_tipocomprobante, tcom_aperturacomp, tcom_cierrecomp, tcom_cabecera, tcom_usuario, tcom_ultmod
FROM `tipocomprobante`;

INSERT INTO `gc`.`tipocomprobante` (
`id_tipocomprobante` ,
`tcom_codigo` ,
`tcom_nombre` ,
`tcom_discriminaiva` ,
`tcom_validanro` ,
`tcom_ambitocompra` ,
`tcom_letra` ,
`tcom_abreviatura` ,
`tcom_sumaresta` ,
`tcom_afecta` ,
`tcom_copias` ,
`tcom_tdf` ,
`tcom_tipocomprobante` ,
`tcom_aperturacomp` ,
`tcom_cierrecomp` ,
`tcom_cabecera` ,
`tcom_usuario` ,
`tcom_ultmod`
)
VALUES (
'106', '37', 'COMPROBANTE DE RETENCIONES', 'No', 'N', 'S', 'A', 'CRET', '+', 'S', '1', 'D', '', '0', '0', 'S', '', '0000-00-00'
);

--cambios en la tabla plan de cuentas y vista
ALTER TABLE `plandecuenta` ADD `pcue_ajustemonetario` ENUM( 'Si', 'No' ) NOT NULL DEFAULT 'No' AFTER `pcue_arqueo` ;
ALTER TABLE `plandecuenta` ADD `sucursal_id` INT NOT NULL DEFAULT '0' AFTER `pcue_ajustemonetario` ;
ALTER TABLE `plandecuenta` ADD `pcue_pbi` ENUM( 'STA.FE', 'E.RIOS' ) NULL AFTER `sucursal_id` ;
ALTER TABLE `plandecuenta` ADD `pcue_tesorecontab` ENUM( 'T', 'C' ) NOT NULL DEFAULT 'C' AFTER `pcue_pbi` ;
ALTER TABLE `plandecuenta` ADD `pcue_permiteasiento` ENUM( 'Si', 'No' ) NOT NULL DEFAULT 'Si' AFTER `pcue_tesorecontab` ;
ALTER TABLE `plandecuenta` ADD `pcue_cc` ENUM( 'Si', 'No' ) NOT NULL DEFAULT 'No' AFTER `pcue_permiteasiento` ;
ALTER TABLE `plandecuenta` ADD `pcue_naturaleza` ENUM( 'Activo', 'Pasivo', 'PatrimonioNeto', 'Resultados', 'CuentadeOrden' ) NULL AFTER `pcue_cc` ;
ALTER TABLE `plandecuenta` ADD `pcue_nivel` ENUM( '1', '2', '3', '4', '5' ) NOT NULL AFTER `pcue_naturaleza` ;
ALTER TABLE `plandecuenta` ADD `pcue_habilitada` ENUM( 'Si', 'No' ) NOT NULL DEFAULT 'Si' AFTER `pcue_nivel` ;
ALTER TABLE `plandecuenta` ADD `pcue_padre` INT  NULL DEFAULT 'NULL' AFTER `pcue_nivel` ;
ALTER TABLE `plandecuenta` DROP `pcue_codigocorto` 
DROP VIEW `plandecuentas`;


CREATE  ALGORITHM = UNDEFINED VIEW plandecuentas AS SELECT id_plandecuenta as id, pcue_cuenta,  pcue_descripcion, pcue_arqueo, pcue_ajustemonetario, id_sucursal as sucursal_id, pcue_pbi, pcue_tesorecontab, pcue_permiteasiento, pcue_cc, pcue_naturaleza, pcue_nivel, pcue_habilitada, pcue_padre, pcue_usuario, pcue_ultmod
FROM `plandecuenta`;

--Tabla de datos de la cabecera de carga de cheques de terceros


CREATE TABLE `gc`.`cabcargachequeter` (
`id` BIGINT( 8 ) UNSIGNED NOT NULL AUTO_INCREMENT ,
`sucursal_id` TINYINT( 3 ) UNSIGNED NOT NULL DEFAULT '0',
`ccht_fecha` DATE NULL ,
`ccht_total` DECIMAL( 13, 2 ) NOT NULL DEFAULT '0.00',
`ccht_cerrado` ENUM( 'No', 'Si' ) NOT NULL DEFAULT 'No',
`ccht_anulado` ENUM( 'No', 'Si' ) NOT NULL DEFAULT 'No',
`ccht_usuario` VARCHAR( 8 ) NULL ,
`ccht_ultmod` DATE NULL ,
PRIMARY KEY ( `id` )
) ENGINE = InnoDB COMMENT = 'Datos cabecera comprobante carga cheques de terceros' 

--Tabla de datos de la cabecera de carga de cheques de terceros
CREATE TABLE `gc`.`rencargachequeter` (
`id` INT( 4 ) UNSIGNED NOT NULL DEFAULT '0',
`cabcargachequeter_id` BIGINT( 8 ) UNSIGNED NOT NULL DEFAULT '0',
`chequetercero_id` INT( 7 ) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE = InnoDB COMMENT = 'Datos renglones comprobante carga cheques de terceros' 

-- Carga de la tabla del plan de cuentas de periolo

insert ignore into plandecuenta (pcue_cuenta, pcue_descripcion ) select * from plancuentaperiolo

-- Hasta el 10 de noviembre --

--View renfacturas
CREATE ALGORITHM = UNDEFINED VIEW renfacturas AS SELECT id_renfactura AS id, id_sucursal AS sucursal_id, id_cabfactura AS cabfactura_id, rfac_item, rfac_fecha, id_articulo as articulo_id, id_alicuotaiva as alicuotaiva_id, rfac_cantidad, rfac_preciocosto, rfac_preciounitario2, rfac_netogravado4, rfac_netogravado2, rfac_iva2, rfac_totalrenglon2, id_cabremito as cabremito_id, id_renremito as renremito_id, rfac_descpromocion, rfac_usuario, rfac_ultmod
FROM `renfactura`

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

--pasar hasta aca a las sucursales

--View cabrecibos
CREATE  ALGORITHM = UNDEFINED VIEW cabrecibos AS SELECT id_cabrecibo AS id, id_sucursal AS sucursal_id, id_tipocomprobante AS tipocomprobante_id, id_cabcaja AS cabcaja_id, id_cliente AS cliente_id, id_vendedor AS vendedor_id, id_condicionpago AS condicionpago_id, crec_puntosventa, crec_nrocomprobante, crec_fecha, crec_importe, crec_acuenta, crec_anulado, crec_usuario, crec_ultmod
FROM `cabrecibo`
--agregar valor al campo sucursal_id
ALTER TABLE `proveedor` ADD `prov_exentoretgan` ENUM( 'No', 'Si' ) NOT NULL DEFAULT 'No' AFTER `prov_baja` ;
UPDATE `gc`.`proveedor` SET `prov_exentoretgan` = 'Si' WHERE `proveedor`.`id_sucursal` =1 AND `proveedor`.`id_proveedor` =1 LIMIT 1 ;
UPDATE `gc`.`proveedor` SET `prov_exentoretgan` = 'Si' WHERE `proveedor`.`id_sucursal` =1 AND `proveedor`.`id_proveedor` =2 LIMIT 1 ;
--View Proveedors
CREATE  ALGORITHM = UNDEFINED VIEW proveedors AS SELECT id_sucursal as sucursal_id, id_proveedor as id, prov_codigo, prov_nombre, prov_calle, prov_puerta, id_localidad as localidad_id, prov_telefono, id_situacionafip as situacionafip_id, id_tipodocumento as tipodocumento_id, prov_cuit, prov_estado, prov_ingbrutos, prov_regimenretencion, prov_saldo, prov_observaciones, prov_consignatario, prov_baja, prov_exentoretgan, prov_usuario, prov_ultmod
FROM `proveedor`

ALTER TABLE `provincia` ADD PRIMARY KEY ( `id_provincia` );  
CREATE ALGORITHM = UNDEFINED VIEW provincias AS SELECT id_provincia AS id, pcia_nombre, pcia_abreviatura, pcia_codigoib, pcia_letra
FROM `provincia`
--agregar vistas tipodocumento, situacionafip, localidad en sucusales
--View cabcompras
CREATE ALGORITHM = UNDEFINED VIEW cabcompras AS SELECT id_cabcompra AS id, id_sucursal AS sucursal_id, ccom_fecha, id_tipocomprobante AS tipocomprobante_id, ccom_puntosventa, ccom_desdecompro, ccom_hastacompro, ccom_codigoaduana, ccom_codigodestinacion, ccom_nrodespacho, ccom_digverdespacho, id_proveedor AS proveedor_id, id_renplaegreso AS renplaegreso_id, id_cabplaegreso as cabplaegreso_id, id_pagocompra as pagocompra_id, retencionganancia_id, ccom_retencioniva, ccom_percepcioniva, ccom_retencionganancia, ccom_retencionib, ccom_percepcionib, ccom_retencionmunicipal, ccom_nogravado, ccom_impuestointerno, ccom_exento, ccom_netogravado, ccom_iva, ccom_total, ccom_cai, ccom_ctcc, id_jurisdiccion AS jurisdiccion_id, id_conceptoegreso AS conceptoegreso_id, ccom_nroplaegreso, ccom_gastocompra, ccom_usuario, ccom_ultmod
FROM `cabcompra` 

ALTER TABLE `cabcompra` ADD `id_pagocompra` INT( 3 ) NULL AFTER `id_cabcompra` ;
ALTER TABLE `cabcompra` ADD `ccom_gastocompra` ENUM( 'GASTO', 'COMPRA' ) NULL AFTER `id_conceptoegreso` ;
ALTER TABLE `cabcompra` ADD `id_renplaegreso` INT( 4 ) NULL AFTER `id_proveedor` ;
ALTER TABLE `cabcompra` ADD `retencionganancia_id` INT( 5 ) NULL AFTER `id_conceptoegreso` ;
ALTER TABLE `cabcompra` ADD `id_cabplaegreso` INT( 8 ) NULL AFTER `id_conceptoegreso` ;

--modificacion campo enum en cabcompra 
ALTER TABLE `cabcompra` CHANGE `ccom_ctcc` `ccom_ctcc` ENUM( 'Contado', 'Cta/Cte' ) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'Contado' 

--View rencompras
CREATE ALGORITHM = UNDEFINED VIEW rencompras AS SELECT id_rencompra AS id, id_sucursal AS sucursal_id, id_cabcompra AS cabcompra_id, id_alicuotaiva as alicuotaiva_id, rcom_netorenglon, rcom_ivarenglon, rcom_totalrenglon, rcom_usuario, rcom_ultmod
FROM `rencompra`

--View renplaegreso
CREATE ALGORITHM = UNDEFINED VIEW renplaegresos AS SELECT id_renplaegreso AS id, id_sucursal AS sucursal_id, id_cabplaegreso AS cabplaegreso_id, id_conceptoegreso as conceptoegreso_id, rpeg_observa, rpeg_importe, rpeg_usuario, rpeg_ultmod
FROM `renplaegreso`

--View cabplaegreso
CREATE ALGORITHM = UNDEFINED VIEW cabplaegresos AS SELECT id_cabplaegreso AS id, id_sucursal AS sucursal_id, cpeg_nroplanilla, cpeg_fecha, cpeg_acargode, cpeg_importe, id_cabcaja as cabcaja_id, cpeg_cerrada, cpeg_control, cpeg_fecharegistro, cpeg_exportada, cpeg_usuario, cpeg_ultmod
FROM `cabplaegreso`

ALTER TABLE `cabplaegreso` CHANGE `cpeg_fecharegistro` `cpeg_fecharegistro` DATE NULL DEFAULT '0000-00-00' 
ALTER TABLE `cabplaegreso` CHANGE `id_cabcaja` `id_cabcaja` INT( 5 ) UNSIGNED NULL DEFAULT '0' 

--- desde aca 17-08-2010

--View conceptoegresos
CREATE  ALGORITHM = UNDEFINED VIEW conceptoegresos AS SELECT id_conceptoegreso as id, cegr_codigo, cegr_detalle, cegr_tipoconcepto, cegr_baseretgan, id_planimpositivo as planimpositivo_id, id_plandecuenta as plandecuenta_id, cegr_retganancia, cegr_usuario, cegr_ultmod
FROM `conceptoegreso`
ALTER TABLE `conceptoegreso` ADD `cegr_baseretgan` DECIMAL( 12, 4 ) NULL AFTER `cegr_retganancia` ;

-- Tabla de pago retencion de ganancias
ALTER TABLE `retencionganancias` ADD `rtga_plaegresoid` INT( 5 ) NULL AFTER `rtga_nroorden` ;
 CREATE TABLE retencionganancias(
id int( 5 ) ,
sucursal_id int( 3 ) ,
rtga_importe decimal(12, 2),
rtga_nroorden VARCHAR(50),
rtga_usuario varchar( 10 ) ,
rtga_ultmod date
)

--View pagocompras
CREATE ALGORITHM = UNDEFINED VIEW pagocompras AS SELECT id_pagocompra AS id, id_sucursal as sucursal_id, id_cabcaja as cabcaja_id, pcpr_cheque, pcpr_efectivo, pcpr_depotransf, pcpr_otro, pcpr_observacion, pcpr_usuario, pcpr_ultmod
FROM `pagocompra`
 set primary key
 ALTER TABLE `pagocompra` CHANGE `id_pagocompra` `id_pagocompra` INT( 3 ) NOT NULL AUTO_INCREMENT  
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
)
--View jurisdiccion
CREATE ALGORITHM = UNDEFINED VIEW jurisdiccions AS SELECT id_jurisdiccion AS id, juri_codigo, juri_nombre, juri_usuario, juri_ultmod
FROM `jurisdiccion`

--View tipocomprobantes
CREATE ALGORITHM = UNDEFINED VIEW tipocomprobantes AS SELECT id_tipocomprobante AS id, tcom_codigo, tcom_nombre,   	tcom_discriminaiva, tcom_validanro, tcom_ambitocompra, tcom_letra, tcom_abreviatura, tcom_sumaresta, tcom_afecta, tcom_copias, tcom_tdf, tcom_tipocomprobante, tcom_aperturacomp, tcom_cierrecomp, tcom_usuario, tcom_ultmod
FROM `tipocomprobante`
ALTER TABLE `tipocomprobante` ADD `tcom_discriminaiva` ENUM( 'Si', 'No' ) NULL AFTER `tcom_nombre` ;


--hasta aca 17/08/2010
-- desde aca pase a gc el 02-08-2010


--View empresas
CREATE ALGORITHM = UNDEFINED VIEW empresas AS SELECT id_empresa as id, empr_razonsocial, id_sucursal AS sucursal_id, empr_calle, empr_puerta, id_localidad as localidad_id, empr_telefono, id_situacionafip as situacionafip_id, empr_cuit, empr_alicuotainscr, empr_ingbruto, empr_modoimpresion, empr_email, empr_listavigente, empr_fechavigencia, empr_usuario, empr_ultmod
FROM `empresa`
ALTER TABLE `empresa` ADD `id_empresa` INT( 3 ) NULL FIRST ;
ALTER TABLE `empresa` ADD `id_sucursal` INT( 10 ) NULL AFTER `empr_razonsocial` ;

--hasta aca 02/08/2010
-- desde aca no esta pasado
--View renremitos
CREATE ALGORITHM = UNDEFINED VIEW renremitos AS SELECT id_renremito AS id, id_sucursal AS sucursal_id, id_cabremito AS cabremito_id, rrem_item, rrem_fecha, id_articulo as articulo_id, rrem_cantidad, rrem_cantifactu, rrem_controlastock, rrem_usuario, rrem_ultmod
FROM `renremito`

--View cabremitos
CREATE ALGORITHM = UNDEFINED VIEW cabremitos AS SELECT id_cabremito AS id, id_sucursal AS sucursal_id, id_tipocomprobante AS tipocomprobante_id, crem_puntosventa, crem_nrocomprobante, crem_hojas, crem_fecha, id_cliente as cliente_id, id_vendedor as vendedor_id, id_codigomovimiento as codigomovimiento_id, crem_sucursaldestino, crem_observacion, crem_viajantepublico, crem_anulado, crem_porcuentayorden, crem_usuario, crem_ultmod
FROM `cabremito`

--View cabfacturas
CREATE ALGORITHM = UNDEFINED VIEW cabfacturas AS SELECT id_cabfactura AS id, id_sucursal AS sucursal_id, id_cabremito AS cabremito_id, id_tipocomprobante AS tipocomprobante_id, cfac_puntosventa, cfac_nrocomprobante, cfac_hojas, id_cabcaja AS cabcaja_id, id_codigomovimiento AS codigomovimiento_id, cfac_nrolistaprecio, id_jurisdiccion AS jurisdiccion_id, id_revendedor AS revendedor_id, cfac_fecha, cfac_vencimiento, id_cliente AS cliente_id, id_vendedor AS vendedor_id, id_condicionpago AS condicionpago_id, cfac_porcuentayorden, cfac_afectadotipo, cfac_afectadopunto, cfac_afectadonro, cfac_exento, cfac_netogravado, cfac_alicuotainscripto, cfac_iva, cfac_alicuotaperiva, cfac_percepcioniva, cfac_alicuotaperibr, cfac_percepcionibr, cfac_ajustebi, cfac_ajusteredondeo, cfac_total, cfac_viajantepublico, cfac_ncanulacion, cfac_vehiculo, cfac_patente, cfac_telefono, cfac_nropromocion, cfac_detallepromocion, cfac_porcpromocion, cfac_descpromocion, cfac_usuario, cfac_ultmod
FROM `cabfactura`
-- hasta aca no esta pasado
-- deploy 12/07/2010
--View regucheques
CREATE ALGORITHM = UNDEFINED VIEW regucheques AS SELECT id_regucheque AS id, id_sucursal as sucursal_id, regc_reguchequeviejo, id_chequetercero as chequetercero_id, regc_fecha, regc_abogado, regc_estadocobro, regc_denuncia, id_origenchereg as origenchereg_id, regc_detalleorigen, regc_importe, regc_gastos, regc_intereses, regc_anulado, id_motivochereg as motivochereg_id, id_vendedor as vendedor_id, regc_codbanco, regc_sucbanco, regc_cpcheque, regc_nrocheque, regc_vtocheque, regc_comprobante, regc_cliente, regc_usuario, regc_ultmod
FROM `regucheque`
-- Tabla de log para los update de chequeterceros
CREATE TABLE logchequeterceros (
         id INT,
         logc_cadenasql varchar(500),
         logc_fecha date
       );
ALTER TABLE `logchequeterceros` ADD `sucursal_id` INT( 3 ) NOT NULL AFTER `id` ;
 ALTER TABLE `logchequeterceros` CHANGE `id` `id` INT( 11 ) NOT NULL AUTO_INCREMENT  

-- hasta aca en el deploy 05/04/2010
--View vendedors
 CREATE ALGORITHM = UNDEFINED VIEW vendedors AS SELECT id_vendedor AS id, vend_codigo, vend_nombre, vend_nombreabrev, vend_domicilio, id_sucursal AS sucursal_id, vend_confeccionacaja, vend_agrupaconvendedor, vend_remuneracion, vend_comisionventas, vend_comisioncobran, vend_zona, vend_mercaderia, vend_ingreso, vend_local, vend_usuario, vend_ultmod
FROM `vendedor` 

--View revendedors
CREATE  ALGORITHM = UNDEFINED VIEW revendedors AS SELECT id_revendedor as id, reve_codigo, id_vendedor as vendedor_id, reve_nombre, reve_domicilio, id_sucursal as sucursal_id, id_cliente as cliente_id, reve_usuario, reve_ultmod
FROM `revendedor`

-- View tarjetacreditos
CREATE  ALGORITHM = UNDEFINED VIEW tarjetacreditos AS SELECT id_tarjetacredito as id, tarj_codigo, tarj_nombre, id_banco as banco_id, tarj_habilitada, tarj_usuario, tarj_ultmod
FROM `tarjetacredito`

--View Estadocheters se agrego el campo id_estadocheter a la tabla
CREATE  ALGORITHM = UNDEFINED VIEW estadocheters AS SELECT id_estadocheter as id, id_sucursal as sucursal_id, id_chequetercero as chequetercero_id, id_cabsalidacartera as cabsalidacartera_id, id_destinocheter as destinocheter_id, echt_usuario, echt_ultmod
FROM `estadocheter`
--Crear tabla de descuento de revendedores
CREATE TABLE descrevendedors(
id int( 5 ) ,
marca_id tinyint( 3 ) ,
rubro_id int( 3 ) ,
drev_descuento1 decimal( 6, 2 ) ,
drev_descuento2 decimal( 6, 2 ) ,
drev_descuento3 decimal( 6, 2 ) ,
drev_usuario VARCHAR( 10 ) ,
drev_ultmod DATE
);
 ALTER TABLE `descrevendedors` ADD PRIMARY KEY ( `id` )  
 ALTER TABLE `descrevendedors` CHANGE `id` `id` INT( 5 ) NOT NULL AUTO_INCREMENT  
-- View conceptocaucions 
CREATE  ALGORITHM = UNDEFINED VIEW conceptocaucions AS SELECT id_conceptocaucion as id, ccau_codigo, ccau_detalle, ccau_usuario, ccau_ultmod
FROM `conceptocaucion` 
-- ya esta en gc para probar!

--view depositocaucions
ALTER TABLE `depositocaucion` ADD `id` INT NULL DEFAULT '0'; -- ya esta en gc
ALTER TABLE `depositocaucion` CHANGE `id` `ids` INT( 11 ) NOT NULL DEFAULT '0' -- ver si lo cambiamos ahora o despues anda igual, hay verificar q ande el otro sistema antes de cambiar

CREATE ALGORITHM = UNDEFINED VIEW depositocaucions AS SELECT id, id_sucursal AS sucursal_id, id_chequetercero AS chequetercero_id, dcau_fechadeposito, id_conceptocaucion AS conceptocaucion_id, dcau_nroboletadeposito, dcau_usuario, dcau_ultmod
FROM depositocaucion


--agregar campo 
ALTER TABLE `devueltocaucions` ADD `devc_tipo` VARCHAR( 10 ) NULL AFTER `devc_importe` ;
ALTER TABLE `devueltocaucions` CHANGE `devc_tipo` `devc_tipo` ENUM( 'Reingreso', 'Asiento' ) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL  
ALTER TABLE `devueltocaucions` CHANGE `devc_importe` `devc_importe` DECIMAL( 10, 2 ) NULL DEFAULT NULL  
--view  listadocaucions
CREATE ALGORITHM = UNDEFINED VIEW listadocaucions AS SELECT id_listadocaucion AS id, id_sucursal AS sucursal_id, lcau_nrocaja, lcau_fecha, id_banco AS banco_id, lcau_sucursalbanco, lcau_cuenta, lcau_denominacion, lcau_importetotal, lcau_cerrada, lcau_importebanco, lcau_fechaimportebanco, lcau_usuario, lcau_ultmod
FROM listadocaucion

--Modificar tabla listadocaucion
ALTER TABLE `listadocaucion` ADD `lcau_importebanco` DECIMAL NULL AFTER `lcau_cerrada`  
ALTER TABLE `listadocaucion` ADD `lcau_fechaimportebanco` DATE NULL AFTER `lcau_importebanco`  

--Hasta aca esta en el ultimo deploy 15/01/2010
--View descuentolistas
CREATE  ALGORITHM = UNDEFINED VIEW descuentolistas AS SELECT id_descuentolista as id, desc_nrolista, desc_nrocolumna, id_articulo as articulo_id, desc_porcentaje, desc_titulo, desc_tipocond, desc_usuario, desc_ultmod 
FROM `descuentolista`

-- view chequeterceros
CREATE ALGORITHM = UNDEFINED VIEW chequeterceros AS SELECT id_chequetercero as id, id_sucursal as sucursal_id, id_cabrecibo as cabrecibo_id, id_cabfactura as cabfactura_id, id_cabcaja as cabcaja_id, id_cliente as cliente_id, id_banco as banco_id, cter_ingreso, cter_sucursalbanco, cter_codigopostal, cter_nrocheque, cter_nrocuenta, cter_cuitlibrador, cter_vencimiento, cter_emision, cter_importe, id_motivoingreso as motivoingreso_id, cter_observaciones, id_motivoegreso as motivoegreso_id, cter_egreso, cter_observadestino, id_listadocaucion as listadocaucion_id, cter_borradocaucion, cter_usuario, cter_ultmod
FROM `chequetercero` 

-- view usuarios
CREATE ALGORITHM = UNDEFINED VIEW usuarios AS SELECT id, usur_usuario, usur_rol, usur_nivelmenu, usur_nombre, usur_contrasena, usur_email, sucursal_id, cliente_id, usur_nivel
FROM `usuario` 

-- view clientes
CREATE  ALGORITHM = UNDEFINED VIEW clientes AS SELECT id_cliente AS id, id_sucursal AS sucursal_id, clie_codigo, clie_razonsocial, clie_contacto, clie_telefono, clie_email, clie_url, id_situacionafip AS situacionafip_id, id_tipodocumento AS tipodocumento_id, clie_cuit, clie_domicilio, clie_puerta, id_localidad AS localidad_id, id_vendedor AS vendedor_id, clie_ultimacompra, clie_saldo, clie_estado, clie_ingbrutos, clie_porcib, clie_cuentamadre, clie_observaciones, clie_movimiento, clie_baja, clie_saldofavor, clie_cpanterior, clie_factelectronica, clie_usuario, clie_ultmod
FROM `cliente`;

--Modoficar la tabla grillalista agregar campo id
ALTER TABLE `grillalista` ADD `id_grillalista` INT( 4 ) NULL FIRST ;
ALTER TABLE `grillalista` ADD INDEX ( `id_grillalista` ) ;
ALTER TABLE `grillalista` CHANGE `id_grillalista` `id_grillalista` INT( 4 ) NULL AUTO_INCREMENT  

--View grillalistas
CREATE  ALGORITHM = UNDEFINED VIEW grillalistas AS SELECT id_grillalista AS id, id_listaprecio AS listaprecio_id, glis_nrolista, glis_nrogrilla, glis_nrocolumna, glis_porcentaje, glis_usuario, glis_ultmod, maestrolista_id
FROM `grillalista`

--View marcas
CREATE  ALGORITHM = UNDEFINED VIEW marcas AS SELECT id_marca AS id, marc_codigo, marc_descripcion, marc_usuario, marc_ultmod
FROM `marca`

--View rubros
CREATE  ALGORITHM = UNDEFINED VIEW rubros AS SELECT id_rubro AS id, rubr_codigo, rubr_codigoviejo, rubr_descripcion, rubr_servicio, rubr_topeminimo, rubr_topemaximo, rubr_usuario, rubr_ultmod
FROM `rubro`


-- View articulos
CREATE  ALGORITHM = UNDEFINED VIEW articulos AS SELECT id_articulo as id, arti_codigo, arti_codigoviejo, arti_descripcion, id_marca as marca_id, id_rubro as rubro_id, arti_modelo, arti_medida, arti_conosincamara, arti_telas, arti_clavesecundaria, id_alicuotaiva as alicuotaiva_id, arti_codigolista, arti_impnac, arti_ventactaord, arti_habilitado, arti_promopirelli, arti_controlastock, arti_liquidacomision, arti_fechabaja, id_proveedor as proveedor_id, id_consignatario as consignatario_id, arti_artinuevo, arti_usuario, arti_ultmod
FROM `articulo`


--View bancos
CREATE  ALGORITHM = UNDEFINED VIEW bancos AS SELECT id_banco as id, banc_codigo, banc_nombre, banc_usuario, banc_ultmod   FROM `banco`

--View cabasientos
CREATE  ALGORITHM = UNDEFINED VIEW cabasientos AS SELECT  id_cabasiento as id, id_sucursal as sucursal_id, id_cabcaja as cabcaja_id, ejercicio_id, casi_fecha, casi_cerrado, casi_borrado, casi_importado, casi_descripcion, casi_usuario, casi_ultmod
FROM `cabasiento`

--View cabasientomodelos
CREATE  ALGORITHM = UNDEFINED VIEW cabasientomodelos AS SELECT id_cabasientomodelo as id, id_sucursal as sucursal_id, casi_tipo, casi_descripcion
FROM `cabasientomodelo`

--View codigomovimientos
CREATE  ALGORITHM = UNDEFINED VIEW codigomovimientos AS SELECT id_codmov as id, cmov_codigo, cmov_nombre, cmov_usuario, cmov_ultmod
FROM `codigomovimiento`



--View condicionpagos
CREATE  ALGORITHM = UNDEFINED VIEW condicionpagos AS SELECT id_condicionpago as id, cpag_codigo, cpag_nombre, cpag_contado, cpag_dias, cpag_usuario, cpag_ultmod
FROM `condicionpago`

--View cuentabancarias
CREATE  ALGORITHM = UNDEFINED VIEW cuentabancarias AS SELECT id_cuentabancaria as id, id_banco as banco_id, cban_descripcion, id_plandecuenta as plandecuenta_id, cban_usuario, cban_ultmod
FROM `cuentabancaria`

--View cuentacajas
CREATE  ALGORITHM = UNDEFINED VIEW cuentacajas AS SELECT id_cuentacaja as id, id_sucursal as sucursal_id, id_plandecuenta as plandecuenta_id, ccaj_tipoasiento, ccaj_detalle, ccaj_usuario, ccaj_ultmod
FROM `cuentacaja`



--View formapagos
CREATE  ALGORITHM = UNDEFINED VIEW formapagos AS SELECT id_formapago as id, fpag_codigo, id_plandecuenta as plandecuenta_id, fpag_detalleenlacaja, fpag_nombre, fpag_permiterepocheque, fpag_usuario, fpag_ultmod 
FROM `formapago`

--View listaprecios
CREATE  ALGORITHM = UNDEFINED VIEW listaprecios AS SELECT id_listaprecio as id, lpre_nrolista, lpre_codigolista, id_articulo as articulo_id, lpre_preciolista, lpre_preciocosto, lpre_precioventa, lpre_remarque, lpre_remarque2, lpre_remarque3, lpre_idlpreanterior, lpre_porcprovisorio, lpre_usuario, lpre_ultmod, maestrolista_id
FROM `listaprecio`


--View localidades
CREATE  ALGORITHM = UNDEFINED VIEW localidads AS SELECT id_localidad as id, loca_codigopostal, loca_estafeta, loca_nombre, loca_calle, loca_altura, id_provincia as provincia_id, loca_letraprovi, loca_usuario, loca_ultmod
FROM `localidad`


--View motivoingresos
CREATE  ALGORITHM = UNDEFINED VIEW motivoingresos AS SELECT id_motivoingreso as id, ming_codigo, ming_detalle, ming_usuario, ming_ultmod 
FROM `motivoingreso`


--View origencheregs
CREATE  ALGORITHM = UNDEFINED VIEW origencheregs AS SELECT id_origenchereg as id, oric_codigo, oric_detalle, id_plandecuenta as plandecuenta_id, oric_debehaber, oric_usuario, oric_ultmod
FROM `origenchereg`


--View plandecuentas
CREATE  ALGORITHM = UNDEFINED VIEW plandecuentas AS SELECT id_plandecuenta as id, pcue_cuenta, pcue_codigocorto, pcue_descripcion, pcue_arqueo, pcue_usuario, pcue_ultmod
FROM `plandecuenta`


--View planimpositivos
CREATE  ALGORITHM = UNDEFINED VIEW planimpositivos AS SELECT id_planimpositivo as id, pimp_codigo, pimp_descripcion, pimp_ambitodeuso, pimp_usuario, pimp_ultmod
FROM `planimpositivo`




--View puntoventas
CREATE  ALGORITHM = UNDEFINED VIEW puntoventas AS SELECT id_puntosventa as id, pven_punto, id_tipocomprobante as tipocomprobante_id, id_sucursal as sucursal_id, pven_ultimoimpreso, pven_ultimoexistencia, pven_modoimpresion, pven_usuario, pven_ultmod 
FROM `puntosventa`


--View relacionegreplanes
CREATE  ALGORITHM = UNDEFINED VIEW relacionegreplanes AS SELECT  id_relacionegreplan as id, id_conceptoegreso as conceptoegreso_id, id_sucursal as sucursal_id, id_planimpositivo as planimpositivo_id, rela_usuario, rela_ultmod
FROM `relacionegreplan`


-- View renasientos
CREATE  ALGORITHM = UNDEFINED VIEW renasientos AS SELECT id_renasiento as id, id_cabasiento as cabasiento_id, id_plandecuenta as plandecuenta_id, rasi_importe
FROM `renasiento`


--View renasientomodelos
CREATE  ALGORITHM = UNDEFINED VIEW renasientomodelos AS SELECT id_renasientomodelo as id, id_cabasientomodelo as cabasientomodelo_id, id_plandecuenta as plandecuenta_id, rasi_debeohaber, rasi_tipo, rasi_descripcion
FROM `renasientomodelo`


--View situacionafips
CREATE  ALGORITHM = UNDEFINED VIEW situacionafips AS SELECT id_situacionafip as id, situ_codigo, situ_nombre, situ_abreviatura, situ_tasageneral, situ_sobretasa, situ_discrimina, situ_letra, situ_controlacuit, situ_usuario, situ_ultmod
FROM `situacionafip`


--View tipodocumentos
CREATE  ALGORITHM = UNDEFINED VIEW tipodocumentos AS SELECT id_tipodocumento as id, tdoc_codigo, tdoc_nombre, tdoc_abreviatura, tdoc_tdi, tdoc_usuario, tdoc_ultmod
FROM `tipodocumento`


--View tiposconstancias
CREATE  ALGORITHM = UNDEFINED VIEW tiposconstancias AS SELECT id_tiposconstancia as id, tcon_detalle, tcon_abreviatura
FROM `tiposconstancia`


--View trabajostalleres
CREATE  ALGORITHM = UNDEFINED VIEW trabajostalleres AS SELECT id_trabajostaller as id, id_sucursal as sucursal_id, id_autos as autos_id, trat_fechatrabajo, trat_kmtrabajo, trat_trendelconvdiv, trat_trendelcombader, trat_trendelcombaizq, trat_trendelavance, trat_trentraconvdiv, trat_trentracombader, trat_trentracombaizq, trat_manoobra1, trat_manoobra2, trat_manoobra3, trat_fechapresupuesto, trat_kmpresupuesto, trat_repuestos1, trat_repuestos2, trat_repuestos3, trat_manobra1, trat_manobra2, trat_manobra3, trat_observa1, trat_observa2, trat_observa3, trat_observa4, trat_observa5, trat_operario, trat_usuario, trat_ultmod
FROM `trabajostaller`


--View vendedores
CREATE  ALGORITHM = UNDEFINED VIEW vendedores AS SELECT  id_vendedor as id, vend_codigo, vend_nombre, vend_nombreabrev, vend_domicilio, id_sucursal as sucursal_id, vend_confeccionacaja, vend_agrupaconvendedor, vend_remuneracion, vend_comisionventas, vend_comisioncobran, vend_zona, vend_mercaderia, vend_ingreso, vend_local, vend_usuario, vend_ultmod
FROM `vendedor`


-- View destinocheters
CREATE  ALGORITHM = UNDEFINED VIEW destinocheters AS SELECT id_destinocheter as id, dcht_codigo, dcht_detalle, dcht_tipodestino, dcht_tiposalida, id_proveedor as proveedor_id, dcht_proyeccion, dcht_idcuentadeudora, dcht_idcuentaacreedora, dcht_usuario, dcht_ultmod
FROM `destinocheter`


-- View motivocheregs
CREATE  ALGORITHM = UNDEFINED VIEW motivocheregs AS SELECT id_motivochereg as id, motc_codigo, motc_detalle, motc_tipo, motc_usuario, motc_ultmod
FROM `motivochereg`


-- View motivocupregs
CREATE  ALGORITHM = UNDEFINED VIEW motivocupregs AS SELECT id_motivocupreg as id, mocu_codigo, mocu_detalle, mocu_tipo, id_plandecuenta as plandecuenta_id, mocu_usuario, mocu_ultmod
FROM `motivocupreg`

--View motivoegresos
CREATE  ALGORITHM = UNDEFINED VIEW motivoegresos AS SELECT  id_motiegreso as id, megr_codigo, megr_detalle, megr_usuario, megr_ultmod
FROM `motivoegreso`


--View promopirellis
CREATE  ALGORITHM = UNDEFINED VIEW promopirellis AS SELECT id_promopirelli as id, ppir_codigo, ppir_detalle, ppir_bonificacionnormal, ppir_bonificacionfrances, ppir_usuario, ppir_ultmod
FROM `promopirelli`



--View cabcajas
CREATE  ALGORITHM = UNDEFINED VIEW cabcajas AS SELECT id_cabcaja AS id, id_sucursal AS sucursal_id, id_vendedor AS vendedor_id, ccaj_nrocaja, ccaj_fecha, ccaj_cerrada, ccaj_importar, ccaj_usuario, ccaj_ultmod
FROM cabcaja

--Table sucursal View sucursals
create algorithm = undefined view sucursals as SELECT id_sucursal as id, sucu_codigo, sucu_nombre, sucu_abreviatura, sucu_domicilio, sucu_telefono, sucu_impu_municipal, sucu_insc_municipal, sucu_provinciapib, sucu_agenteretpib, sucu_inicioactividades, sucu_porcuentayorden, sucu_codigoibafip, sucu_controlaservicio, sucu_email, sucu_emailpedidoweb, sucu_usuario, sucu_ultmod
FROM `sucursal`
