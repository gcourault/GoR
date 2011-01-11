class Rg1361afip < ActiveRecord::Base

#VENTAS
def self.consultarenfac(id, sucursal)
@rg1361afiprens = Cabfactura.find_by_sql(['SELECT *, rf.rfac_fecha as fecha, sum(rf.rfac_netogravado2) as neto, sum(rf.rfac_iva2) as iva, aliva.aiva_alicuota as aliiva, sum(if(tc.tcom_sumaresta="+", rf.rfac_netogravado2 ,  -rf.rfac_netogravado2)) as netotipo, sum(if(tc.tcom_sumaresta="+", rf.rfac_iva2 ,  -rf.rfac_iva2)) as ivatipo, sum(if(tc.tcom_sumaresta="+", rf.rfac_totalrenglon2 ,  -rf.rfac_totalrenglon2)) as totalrenglontipo 
	FROM 
	renfactura as rf,
	cabfactura as cf, 
	tipocomprobante as tc,
	sucursal as s,
        alicuotaiva as aliva
	WHERE 
      	rf.id_sucursal   = s.id_sucursal
        and cf.id_sucursal = s.id_sucursal
	and  s.id_sucursal   = ?
	and  rf.id_cabfactura = cf.id_cabfactura 
        and cf.id_cabfactura = ?
        and rf.id_alicuotaiva = aliva.id_alicuotaiva
	and  cf.id_tipocomprobante = tc.id_tipocomprobante
        GROUP BY  rf.id_alicuotaiva', sucursal, id])

end
def self.consultarenncv(id, sucursal)
@rg1361afiprenncs = Cabfactura.find_by_sql(['SELECT *, rnc.rcd_fecha as fecha, sum(rnc.rcd_netogravado2) as neto, sum(rnc.rcd_iva2) as iva, aliva.aiva_alicuota as aliiva, sum(if(tc.tcom_sumaresta="+", rnc.rcd_netogravado2 ,  -rnc.rcd_netogravado2)) as netotipo, sum(if(tc.tcom_sumaresta="+", rnc.rcd_iva2 ,  -rnc.rcd_iva2)) as ivatipo, sum(if(tc.tcom_sumaresta="+", rnc.rcd_totalrenglon2 ,  -rnc.rcd_totalrenglon2)) as totalrenglontipo 
	FROM 
	renncndvarios as rnc,
	cabfactura as cf, 
	tipocomprobante as tc,
	sucursal as s, 
        alicuotaiva as aliva
	WHERE 
      	rnc.id_sucursal = s.id_sucursal
        and cf.id_sucursal = s.id_sucursal
        and s.id_sucursal = ?
	and  rnc.id_cabfactura = cf.id_cabfactura 
        and cf.id_cabfactura = ?
        and rnc.id_alicuotaiva = aliva.id_alicuotaiva
	and  cf.id_tipocomprobante = tc.id_tipocomprobante
        GROUP BY  rnc.id_alicuotaiva', sucursal, id])

end
def self.consultacab(fecha)
@rg1361afipcabs = Cabfactura.find_by_sql(['SELECT *,  tc.tcom_codigo as comprobante, td.tdoc_codigo as codigodoc, c.clie_cuit as cuitclie, c.clie_razonsocial as nombrecli, safip.situ_codigo as tiporesponsable, if(tc.tcom_sumaresta="+", cf.cfac_netogravado ,  -cf.cfac_netogravado) as netofac, cf.cfac_netogravado as neto, if(tc.tcom_sumaresta="+", cf.cfac_iva ,  -cf.cfac_iva) as ivafac, cf.cfac_iva as iva, if(tc.tcom_sumaresta="+", cf.cfac_total ,  -cf.cfac_total) as totalfac , if(tc.tcom_sumaresta="+", cf. cfac_exento ,  -cf. cfac_exento) as exentofac, if(tc.tcom_sumaresta="+", cf. cfac_percepcionibr ,  -cf. cfac_percepcionibr) as percepcionibrfac, s.sucu_codigoibafip as codibafip 
	FROM 
	cabfactura as cf,
        tipocomprobante as tc, 
        sucursal as s, 
        cliente as c,
        situacionafip as safip,
        tipodocumento as td
	WHERE 
        cf.id_sucursal   = s.id_sucursal
        and c.id_sucursal = s.id_sucursal
        and cf.id_cliente = c.id_cliente
        and c.id_situacionafip = safip.id_situacionafip
        and c.id_tipodocumento = td.id_tipodocumento
        and cf.id_tipocomprobante = tc.id_tipocomprobante
       	and MONTH(cf.cfac_fecha) = MONTH(?) and YEAR(cf.cfac_fecha) = YEAR(?)
        ORDER BY cf.cfac_fecha, cf.id_tipocomprobante, cf.cfac_puntosventa, cf.cfac_nrocomprobante', fecha, fecha])
end
 def self.cantidadreng(fecha)
@cantidadrengs = Cabfactura.find_by_sql(['(SELECT rf.id_renfactura as alicuota
	FROM 
	renfactura as rf,
	cabfactura as cf, 
	sucursal as s
    
	WHERE 
      	cf.id_sucursal = s.id_sucursal
	and  rf.id_sucursal   = s.id_sucursal
	and  rf.id_cabfactura = cf.id_cabfactura 
        and MONTH(cf.cfac_fecha) = MONTH(?) and YEAR(cf.cfac_fecha) = YEAR(?)
        GROUP BY  rf.id_alicuotaiva, rf.id_cabfactura, rf.id_sucursal)
        UNION
        (SELECT rnc.id_renncndvarios as alicuota
	FROM 
	renncndvarios as rnc,
	cabfactura as cf, 
	sucursal as s
    
	WHERE 
      	rnc.id_sucursal   = s.id_sucursal
	and  cf.id_sucursal   = s.id_sucursal
	and  rnc.id_cabfactura = cf.id_cabfactura 
        and MONTH(cf.cfac_fecha) = MONTH(?) and YEAR(cf.cfac_fecha) = YEAR(?)
        GROUP BY  rnc.id_alicuotaiva, rnc.id_cabfactura, rnc.id_sucursal)', fecha, fecha, fecha, fecha ])

 end

#COMPRAS

def self.consultacabcompra(fecha)
@rg1361afipcabcompras = Cabcompra.find_by_sql(['SELECT *,  tc.tcom_codigo as comprobante, td.tdoc_codigo as codigodoc, p.prov_cuit as cuitprove, p.prov_nombre as nombreprove, safip.situ_codigo as tiporesponsable, if(tc.tcom_sumaresta="+", cc.ccom_netogravado ,  -cc.ccom_netogravado) as netocom, cc.ccom_netogravado as neto, if(tc.tcom_sumaresta="+", cc.ccom_iva ,  -cc.ccom_iva) as ivacom, cc.ccom_iva as ivacc, if(tc.tcom_sumaresta="+", cc.ccom_total ,  -cc.ccom_total) as totalcom , if(tc.tcom_sumaresta="+", cc.ccom_exento ,  -cc.ccom_exento) as exentocom, if(tc.tcom_sumaresta="+", cc.ccom_percepcionib ,  -cc.ccom_percepcionib) as percepcionibrcom, s.sucu_codigoibafip as codibafip, cc.ccom_fecha as fecha, if(tc.tcom_sumaresta="+", cc.ccom_retencionib , -cc.ccom_retencionib) as retencionibrcom, if(tc.tcom_sumaresta="+", cc.ccom_percepcioniva ,  -cc.ccom_percepcioniva) as percepcionivarcom, if(tc.tcom_sumaresta="+", cc.ccom_retencioniva ,  -cc.ccom_retencioniva) as retencionivacom, if(tc.tcom_sumaresta="+", cc.ccom_nogravado , -cc.ccom_nogravado) as nogravadototcom, if(tc.tcom_sumaresta="+", cc.ccom_impuestointerno ,  -cc.ccom_impuestointerno) as impinttotcom, if(tc.tcom_sumaresta="+", cc.ccom_retencionmunicipal , -cc.ccom_retencionmunicipal) as retmunitotcom, if(tc.tcom_sumaresta="+", cc.ccom_retencionganancia , -cc.ccom_retencionganancia) as retgantotcom
	FROM 
	cabcompra as cc,
        tipocomprobante as tc, 
        sucursal as s, 
        proveedor as p,
        situacionafip as safip,
        tipodocumento as td
	WHERE 
        cc.id_sucursal   = s.id_sucursal
        and p.id_sucursal = s.id_sucursal
        and cc.id_proveedor = p.id_proveedor
        and p.id_situacionafip = safip.id_situacionafip
        and p.id_tipodocumento = td.id_tipodocumento
        and cc.id_tipocomprobante = tc.id_tipocomprobante
        and cc.ccom_gastocompra = "COMPRA"
       	and MONTH(cc.ccom_fecha) = MONTH(?) and YEAR(cc.ccom_fecha) = YEAR(?)
        ORDER BY cc.ccom_fecha, cc.id_tipocomprobante, cc.ccom_puntosventa, cc.ccom_desdecompro', fecha, fecha])
end

def self.consultarencom(id, sucursal)
@rg1361afiprenccs = Cabcompra.find_by_sql(['SELECT *, sum(rc.rcom_netorenglon) as neto, sum(rc.rcom_ivarenglon) as iva, aliva.aiva_alicuota as aliiva, sum(if(tc.tcom_sumaresta="+", rc.rcom_netorenglon ,  -rc.rcom_netorenglon)) as netotipo, sum(if(tc.tcom_sumaresta="+", rc.rcom_ivarenglon ,  -rc.rcom_ivarenglon)) as ivatipo, sum(if(tc.tcom_sumaresta="+", rc.rcom_totalrenglon ,  -rc.rcom_totalrenglon)) as totalrenglontipo 
	FROM 
	rencompra as rc,
	cabcompra as cc, 
	tipocomprobante as tc,
	sucursal as s,
        alicuotaiva as aliva
	WHERE 
      	rc.id_sucursal   = s.id_sucursal
        and cc.id_sucursal = s.id_sucursal
	and s.id_sucursal   = ?
	and rc.id_cabcompra = cc.id_cabcompra 
        and cc.id_cabcompra = ?
        and rc.id_alicuotaiva = aliva.id_alicuotaiva
	and cc.id_tipocomprobante = tc.id_tipocomprobante
        GROUP BY  rc.id_alicuotaiva', sucursal, id])

end

end
