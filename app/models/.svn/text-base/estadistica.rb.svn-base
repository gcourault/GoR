class Estadistica < ActiveRecord::Base

def self.ventasb(fechadesde, fechahasta)
	@ventasbs =  Marca.find_by_sql(['SELECT s.sucu_abreviatura as sucursal, r.rubr_descripcion as rubro, r.id_rubro as idr, sum(if(tc.tcom_sumaresta="+", rf.rfac_cantidad ,  -rf.rfac_cantidad)) as cantidad,  sum(if(tc.tcom_sumaresta="+", rf.rfac_totalrenglon2 ,  -rf.rfac_totalrenglon2)) as monto
	FROM 
	renfactura as rf,
	cabfactura as cf, 
	articulo as a,
	tipocomprobante as tc,
	rubro as r,
	sucursal as s
	WHERE 
      	rf.id_sucursal   = cf.id_sucursal
	and  rf.id_sucursal   = s.id_sucursal
	and  rf.id_cabfactura = cf.id_cabfactura 
	and  cf.id_tipocomprobante = tc.id_tipocomprobante
	and  rf.id_articulo = a.id_articulo
	and  a.id_rubro    = r.id_rubro
	and  a.id_marca = 1 
	and  cf.cfac_fecha >= ? and cf.cfac_fecha <= ?
	GROUP BY s.id_sucursal, a.id_rubro', fechadesde, fechahasta])
end

#cubiertas sin camaras/protectores
def self.ventasagruprubro (fechadesde, fechahasta)
	@ventasagruprubros =  Marca.find_by_sql(['SELECT r.rubr_descripcion as rubro, r.id_rubro as idr, sum(if(tc.tcom_sumaresta="+", rf.rfac_cantidad ,  -rf.rfac_cantidad)) as totalrubros, sum(if(tc.tcom_sumaresta="+", rf.rfac_totalrenglon2 ,  -rf.rfac_totalrenglon2)) as totalmontos
	FROM 
	renfactura as rf,
	cabfactura as cf, 
	articulo as a,
	tipocomprobante as tc,
	rubro as r,
	sucursal as s
	WHERE 
      	rf.id_sucursal   = cf.id_sucursal
	and  rf.id_sucursal   = s.id_sucursal
	and  rf.id_cabfactura = cf.id_cabfactura 
	and  cf.id_tipocomprobante = tc.id_tipocomprobante
	and  rf.id_articulo = a.id_articulo
	and  a.id_rubro    = r.id_rubro
	and  a.id_marca = 1 
	and  cf.cfac_fecha >= ? and cf.cfac_fecha <= ?  and r.id_rubro NOT IN (Select id_rubro from rubro WHERE rubr_descripcion LIKE "%Camaras%" OR rubr_descripcion LIKE "%Protectores%")
	GROUP BY  a.id_rubro', fechadesde, fechahasta])
end

#toatal camaras/protectores
def self.ventasagruprubrocp (fechadesde, fechahasta)
	@ventasagruprubrocps =  Marca.find_by_sql(['SELECT r.rubr_descripcion as rubro, r.id_rubro as idr, sum(if(tc.tcom_sumaresta="+", rf.rfac_cantidad ,  -rf.rfac_cantidad)) as totalrubros, sum(if(tc.tcom_sumaresta="+", rf.rfac_totalrenglon2 ,  -rf.rfac_totalrenglon2)) as totalmontos
	FROM 
	renfactura as rf,
	cabfactura as cf, 
	articulo as a,
	tipocomprobante as tc,
	rubro as r,
	sucursal as s
	WHERE 
      	rf.id_sucursal   = cf.id_sucursal
	and  rf.id_sucursal   = s.id_sucursal
	and  rf.id_cabfactura = cf.id_cabfactura 
	and  cf.id_tipocomprobante = tc.id_tipocomprobante
	and  rf.id_articulo = a.id_articulo
	and  a.id_rubro    = r.id_rubro
	and  a.id_marca = 1 
	and  cf.cfac_fecha >= ? and cf.cfac_fecha <= ?  and r.id_rubro IN (Select id_rubro from rubro WHERE rubr_descripcion LIKE "%Camaras%" OR rubr_descripcion LIKE "%Protectores%")
	GROUP BY  a.id_rubro', fechadesde, fechahasta])
end

#costos de las ventas sacandolo del renglon de la factura
#def self.costoventa(fechadesde, fechahasta)
#	@costoventas =  Marca.find_by_sql(['select m.marc_descripcion as marca, s.sucu_abreviatura as sucursal,  a.arti_descripcion as arti, a.id_articulo as idar, r.rubr_descripcion as rubro, r.id_rubro as idr, sum(if(tc.tcom_sumaresta="+", rf.rfac_cantidad ,  -rf.rfac_cantidad)) as totalarti,  sum(if(tc.tcom_sumaresta="+", rf.rfac_preciocosto ,  -rf.rfac_preciocosto)) as totalcosto
#	from 
#	renfactura as rf,
#	cabfactura as cf, 
#	articulo as a,
#	tipocomprobante as tc,
#	rubro as r,
#	sucursal as s, 
#        marca as m,
#	where 
#      	rf.id_sucursal   = cf.id_sucursal
#	and  rf.id_sucursal   = s.id_sucursal
#	and  rf.id_cabfactura = cf.id_cabfactura 
#	and  cf.id_tipocomprobante = tc.id_tipocomprobante
#	and  rf.id_articulo = a.id_articulo
#	and  a.id_rubro    = r.id_rubro
#	and  a.id_marca = m.id_marca
#        and  m.id_marca != 99
#	and  cf.cfac_fecha >= ? and cf.cfac_fecha <= ?
#	GROUP BY rf.id_sucursal, a.id_articulo ORDER BY s.id_sucursal, m.id_marca, r.id_rubro', fechadesde, fechahasta])
#end

#costos de las ventas valuado por la lista de la cabecera
def self.costoventa(fechadesde, fechahasta)
	@costoventas =  Marca.find_by_sql(['select m.marc_descripcion as marca, s.sucu_abreviatura as sucursal,  a.arti_descripcion as arti, a.id_articulo as idar, r.rubr_descripcion as rubro, r.id_rubro as idr, sum(if(tc.tcom_sumaresta="+", rf.rfac_cantidad ,  -rf.rfac_cantidad)) as totalarti,  sum(if(l.lpre_preciolista IS NULL, 0, (l.lpre_preciolista * ((100 + g.glis_porcentaje) / 100)) * (if(tc.tcom_sumaresta="+", CONVERT(rf.rfac_cantidad,SIGNED) , -rf.rfac_cantidad)))) as totalcosto
	FROM 
	renfactura as rf LEFT JOIN (listaprecio AS l, grillalista AS g) ON (rf.id_articulo = l.id_articulo  and  g.id_listaprecio = l.id_listaprecio and  g.glis_nrogrilla = 1  and  g.glis_nrocolumna =1 ),
	articulo as a,
	tipocomprobante as tc,
	rubro as r,
	sucursal as s, 
        marca as m,
        cabfactura as cf 
	wHERE 
      	rf.id_sucursal = cf.id_sucursal
	and  rf.id_sucursal = s.id_sucursal
	and  rf.id_cabfactura = cf.id_cabfactura
        and  cf.cfac_nrolistaprecio = l.lpre_nrolista
     	and  cf.id_tipocomprobante = tc.id_tipocomprobante
   	and  rf.id_articulo = a.id_articulo
	and  a.id_rubro = r.id_rubro
	and  a.id_marca = m.id_marca
        and  m.id_marca != 99
	and  cf.cfac_fecha >= ? and cf.cfac_fecha <= ?
	GROUP BY s.id_sucursal, a.id_articulo', fechadesde, fechahasta])
end

#cantidad vendidas de unidades que no estan en la lista de precios
def self.costoventaud(nrolista, fechadesde, fechahasta)
	@costoventauds =  Marca.find_by_sql(['select m.marc_descripcion as marca, a.arti_descripcion as arti, a.id_articulo as idar, r.rubr_descripcion as rubro, r.id_rubro as idr, sum(if(tc.tcom_sumaresta="+", rf.rfac_cantidad ,  -rf.rfac_cantidad)) as totalarti
	FROM 
	renfactura as rf,
	articulo as a,
	tipocomprobante as tc,
	rubro as r,
	sucursal as s, 
        marca as m,
        cabfactura as cf
      	wHERE 
      	rf.id_sucursal = cf.id_sucursal
	and  rf.id_sucursal = s.id_sucursal
	and  rf.id_cabfactura = cf.id_cabfactura
     	and  cf.id_tipocomprobante = tc.id_tipocomprobante
   	and  rf.id_articulo = a.id_articulo
        and  a.id_articulo NOT IN (SELECT id_articulo FROM listaprecio WHERE lpre_nrolista = ? )
	and  a.id_rubro = r.id_rubro
	and  a.id_marca = m.id_marca
        and  m.id_marca != 99
	and  cf.cfac_fecha >= ? and cf.cfac_fecha <= ?
	GROUP BY  a.id_articulo', nrolista, fechadesde, fechahasta])
end

#costos de las ventas 03 canceladas
def self.costoventa03(nrolista, fechadesde, fechahasta)
	@costoventas03 =  Marca.find_by_sql(['SELECT s.sucu_abreviatura AS sucursal, m.marc_descripcion AS marca, a.arti_descripcion as arti, r.rubr_descripcion AS rubro, sum(rr.rrem_cantifactu) AS totalarti, sum( if( l.lpre_preciolista IS NULL , 0, (rr.rrem_cantifactu  * l.lpre_preciolista * ((100 + g.glis_porcentaje) / 100) ) ) ) AS totalcosto
	FROM marca AS m, cabremito AS cr, articulo AS a, rubro AS r, sucursal AS s,
	renremito AS rr	LEFT JOIN (listaprecio AS l, grillalista AS g) ON (rr.id_articulo = l.id_articulo AND l.lpre_nrolista = ?  and  g.id_listaprecio = l.id_listaprecio and  g.glis_nrogrilla = 1  and  g.glis_nrocolumna = 1)
	WHERE rr.id_sucursal = cr.id_sucursal
	and rr.id_sucursal = s.id_sucursal
	and rr.id_cabremito = cr.id_cabremito
	and rr.id_articulo = a.id_articulo
	and a.id_rubro = r.id_rubro
	and a.id_marca = m.id_marca
	and m.id_marca != 99
	and cr.id_codigomovimiento =3
     	and cr.crem_anulado != "S"
        and rr.rrem_cantifactu != 0
	and cr.crem_fecha >= ?
	and cr.crem_fecha <= ?
	GROUP BY s.id_sucursal, a.id_articulo', nrolista, fechadesde, fechahasta])
end

#costos de las ventas 03 pendientes
def self.costoventapen03(nrolista, fechadesde, fechahasta)
	@costoventaspen03 =  Marca.find_by_sql(['SELECT s.sucu_abreviatura AS sucursal, m.marc_descripcion AS marca, a.arti_descripcion as arti, r.rubr_descripcion AS rubro, sum( rr.rrem_cantidad - rr.rrem_cantifactu ) AS totalarti, sum( if( l.lpre_preciolista IS NULL , 0, ( (rr.rrem_cantidad - rr.rrem_cantifactu) * l.lpre_preciolista * ((100 + g.glis_porcentaje) / 100)) ) ) AS totalcosto
	FROM marca AS m, cabremito AS cr, articulo AS a, rubro AS r, sucursal AS s,
	renremito AS rr	LEFT JOIN (listaprecio AS l, grillalista AS g) ON (rr.id_articulo = l.id_articulo AND l.lpre_nrolista = ?  and  g.id_listaprecio = l.id_listaprecio and  g.glis_nrogrilla = 1  and  g.glis_nrocolumna = 1)
	WHERE rr.id_sucursal = cr.id_sucursal
	and rr.id_sucursal = s.id_sucursal
	and rr.id_cabremito = cr.id_cabremito
	and rr.id_articulo = a.id_articulo
	and a.id_rubro = r.id_rubro
	and a.id_marca = m.id_marca
	and m.id_marca != 99
	and cr.id_codigomovimiento =3
        and (rr.rrem_cantidad - rr.rrem_cantifactu) != 0
	and cr.crem_anulado != "S"
	and cr.crem_fecha >= ?
	and cr.crem_fecha <= ?
	GROUP BY s.id_sucursal, a.id_articulo', nrolista, fechadesde, fechahasta])
end

#ventas 03
def self.ventasb03(fechadesde, fechahasta)
	@ventasbs03 =  Marca.find_by_sql(['SELECT s.sucu_abreviatura as sucursal, r.id_rubro as idr, r.rubr_descripcion as rubro, sum(rr.rrem_cantidad) as cantidad
	FROM 
	renremito as rr,
	cabremito as cr, 
	articulo as a,
	rubro as r,
	sucursal as s
	WHERE 
      	rr.id_sucursal   = cr.id_sucursal
	and  rr.id_sucursal   = s.id_sucursal
	and  rr.id_cabremito = cr.id_cabremito 
	and  rr.id_articulo = a.id_articulo
	and  a.id_rubro    = r.id_rubro
	and  a.id_marca = 1 
	and  cr.id_codigomovimiento = 3
        and  cr.crem_anulado != "S"
	and  cr.crem_fecha >= ? and cr.crem_fecha <= ?
	GROUP BY s.id_sucursal, a.id_rubro', fechadesde, fechahasta])
end

#agrupadas cubiertas s c|p
def self.ventasagruprubro03 (fechadesde, fechahasta)
	@ventasagruprubros03 =  Marca.find_by_sql(['SELECT s.sucu_abreviatura as sucursal, r.id_rubro as idr, r.rubr_descripcion as rubro, sum(rr.rrem_cantidad) as totalrubros
	FROM 
	renremito as rr,
	cabremito as cr, 
	articulo as a,
	rubro as r,
	sucursal as s
	WHERE 
      	rr.id_sucursal   = cr.id_sucursal
	and  rr.id_sucursal   = s.id_sucursal
	and  rr.id_cabremito = cr.id_cabremito 
	and  rr.id_articulo = a.id_articulo
	and  a.id_rubro    = r.id_rubro
	and  a.id_marca = 1 
	and  cr.id_codigomovimiento = 3
        and  cr.crem_anulado != "S"
	and  cr.crem_fecha >= ? and cr.crem_fecha <= ? and r.id_rubro NOT IN (Select id_rubro from rubro WHERE rubr_descripcion LIKE "%Camaras%" OR rubr_descripcion LIKE "%Protectores%")
	GROUP BY  a.id_rubro', fechadesde, fechahasta])
end

#agrupadas camaras protectores
def self.ventasagruprubrocp03 (fechadesde, fechahasta)
	@ventasagruprubroscp03 =  Marca.find_by_sql(['SELECT s.sucu_abreviatura as sucursal, r.id_rubro as idr, r.rubr_descripcion as rubro, sum(rr.rrem_cantidad) as totalrubros
	FROM 
	renremito as rr,
	cabremito as cr, 
	articulo as a,
	rubro as r,
	sucursal as s
	WHERE 
      	rr.id_sucursal   = cr.id_sucursal
	and  rr.id_sucursal   = s.id_sucursal
	and  rr.id_cabremito = cr.id_cabremito 
	and  rr.id_articulo = a.id_articulo
	and  a.id_rubro    = r.id_rubro
	and  a.id_marca = 1 
	and  cr.id_codigomovimiento = 3
	and  cr.crem_fecha >= ? and cr.crem_fecha <= ? and r.id_rubro IN (Select id_rubro from rubro WHERE rubr_descripcion LIKE "%Camaras%" OR rubr_descripcion LIKE "%Protectores%")
	GROUP BY  a.id_rubro', fechadesde, fechahasta])
end

# ventas totales incluye 03
def self.ventasbtotale(fechadesde, fechahasta)
	@ventasbtotales =  Marca.find_by_sql(['(SELECT s.sucu_abreviatura as sucursal, r.rubr_descripcion as rubro, r.id_rubro as idr, sum(if(tc.tcom_sumaresta="+", rf.rfac_cantidad ,  -rf.rfac_cantidad)) as cantidad
	FROM 
	renfactura as rf,
	cabfactura as cf, 
	articulo as a,
	tipocomprobante as tc,
	rubro as r,
	sucursal as s
	WHERE 
      	rf.id_sucursal   = cf.id_sucursal
	and  rf.id_sucursal   = s.id_sucursal
	and  rf.id_cabfactura = cf.id_cabfactura 
	and  cf.id_tipocomprobante = tc.id_tipocomprobante
	and  rf.id_articulo = a.id_articulo
	and  a.id_rubro    = r.id_rubro
	and  a.id_marca = 1 
	and  cf.cfac_fecha >= ? and cf.cfac_fecha <= ?
	GROUP BY s.id_sucursal, a.id_rubro)
UNION 
	(SELECT s.sucu_abreviatura as sucursal, r.id_rubro as idr, r.rubr_descripcion as rubro, sum(rr.rrem_cantidad) as cantidad
	FROM 
	renremito as rr,
	cabremito as cr, 
	articulo as a,
	rubro as r,
	sucursal as s
	WHERE 
      	rr.id_sucursal   = cr.id_sucursal
	and  rr.id_sucursal   = s.id_sucursal
	and  rr.id_cabremito = cr.id_cabremito 
	and  rr.id_articulo = a.id_articulo
	and  a.id_rubro    = r.id_rubro
	and  a.id_marca = 1 
	and  cr.id_codigomovimiento = 3
	and  cr.crem_fecha >= ? and cr.crem_fecha <= ?
	GROUP BY s.id_sucursal, a.id_rubro)', fechadesde, fechahasta, fechadesde, fechahasta])
end

# todas las ventas sin camaras ni pretectores
def self.ventasagruprubrototal (fechadesde, fechahasta)
	@ventasagruprubrototals =  Marca.find_by_sql(['SELECT r.rubr_descripcion as rubro, r.id_rubro as idr, sum(if(tc.tcom_sumaresta="+", rf.rfac_cantidad ,  -rf.rfac_cantidad)) as totalrubros
	FROM 
	renfactura as rf,
	cabfactura as cf, 
	articulo as a,
	tipocomprobante as tc,
	rubro as r,
	sucursal as s
	WHERE 
     	rf.id_sucursal   = cf.id_sucursal
	and  rf.id_sucursal   = s.id_sucursal
	and  rf.id_cabfactura = cf.id_cabfactura 
	and  cf.id_tipocomprobante = tc.id_tipocomprobante
	and  rf.id_articulo = a.id_articulo
	and  a.id_rubro    = r.id_rubro
	and  a.id_marca = 1 
	and  cf.cfac_fecha >= ? and cf.cfac_fecha <= ?  and r.id_rubro NOT IN (Select id_rubro from rubro WHERE rubr_descripcion LIKE "%Camaras%" OR rubr_descripcion LIKE "%Protectores%")
	GROUP BY  a.id_rubro
UNION
	SELECT r.rubr_descripcion as rubro, r.id_rubro as idr,  sum(rr.rrem_cantidad) as totalrubros
	FROM 
	renremito as rr,
	cabremito as cr, 
	articulo as a,
	rubro as r,
	sucursal as s
	WHERE 
      	rr.id_sucursal   = cr.id_sucursal
	and  rr.id_sucursal   = s.id_sucursal
	and  rr.id_cabremito = cr.id_cabremito 
	and  rr.id_articulo = a.id_articulo
	and  a.id_rubro    = r.id_rubro
	and  a.id_marca = 1 
	and  cr.id_codigomovimiento = 3
	and  cr.crem_fecha >= ? and cr.crem_fecha <= ? and r.id_rubro NOT IN (Select id_rubro from rubro WHERE rubr_descripcion LIKE "%Camaras%" OR rubr_descripcion LIKE "%Protectores%")
	GROUP BY  a.id_rubro', fechadesde, fechahasta, fechadesde, fechahasta])
end

# todas las ventas de camaras y pretectores
def self.ventasagruprubrototalcp (fechadesde, fechahasta)
	@ventasagruprubrototalcps =  Marca.find_by_sql(['SELECT r.rubr_descripcion as rubro, r.id_rubro as idr, sum(if(tc.tcom_sumaresta="+", rf.rfac_cantidad ,  -rf.rfac_cantidad)) as totalrubros
	FROM 
	renfactura as rf,
	cabfactura as cf, 
	articulo as a,
	tipocomprobante as tc,
	rubro as r,
	sucursal as s
	WHERE 
     	rf.id_sucursal   = cf.id_sucursal
	and  rf.id_sucursal   = s.id_sucursal
	and  rf.id_cabfactura = cf.id_cabfactura 
	and  cf.id_tipocomprobante = tc.id_tipocomprobante
	and  rf.id_articulo = a.id_articulo
	and  a.id_rubro    = r.id_rubro
	and  a.id_marca = 1 
	and  cf.cfac_fecha >= ? and cf.cfac_fecha <= ?  and r.id_rubro IN (Select id_rubro from rubro WHERE rubr_descripcion LIKE "%Camaras%" OR rubr_descripcion LIKE "%Protectores%")
	GROUP BY  a.id_rubro
UNION
	select r.rubr_descripcion as rubro, r.id_rubro as idr,  sum( rr.rrem_cantidad  ) as totalrubros
	FROM 
	renremito as rr,
	cabremito as cr, 
	articulo as a,
	rubro as r,
	sucursal as s
	WHERE 
      	rr.id_sucursal   = cr.id_sucursal
	and  rr.id_sucursal   = s.id_sucursal
	and  rr.id_cabremito = cr.id_cabremito 
	and  rr.id_articulo = a.id_articulo
	and  a.id_rubro    = r.id_rubro
	and  a.id_marca = 1 
	and  cr.id_codigomovimiento = 3
	and  cr.crem_fecha >= ? and cr.crem_fecha <= ? and r.id_rubro IN (Select id_rubro from rubro WHERE rubr_descripcion LIKE "%Camaras%" OR rubr_descripcion LIKE "%Protectores%")
	GROUP BY  a.id_rubro', fechadesde, fechahasta, fechadesde, fechahasta])
end

#desde aca consulta por meses por sucursal y rubros
def self.ventasrubrosucu(sucursal,fechadesde, fechahasta)
	@ventasrubrosucus =  Marca.find_by_sql(['select s.sucu_abreviatura as sucursal, MONTH(cr.crem_fecha) as mes, r.id_rubro as idr, r.rubr_descripcion as rubro, sum(rr.rrem_cantidad) as cantidad
	FROM 
	renremito as rr,
	cabremito as cr, 
	articulo as a,
	rubro as r,
	sucursal as s
	WHERE 
      	rr.id_sucursal   = cr.id_sucursal
	and  rr.id_sucursal   =  ?
	and  rr.id_cabremito = cr.id_cabremito 
	and  rr.id_articulo = a.id_articulo
	and  a.id_rubro    = r.id_rubro
	and  a.id_marca = 1 
	and  cr.id_codigomovimiento = 3
	and  cr.crem_fecha >= ? and cr.crem_fecha <= ?
	GROUP BY MONTH(cr.crem_fecha), a.id_rubro', sucursal, fechadesde, fechahasta])
end

#consulta de compras
def self.comprasucu(fechadesde, fechahasta)
	@comprasucus = Marca.find_by_sql(['select s.sucu_abreviatura as sucursal, r.rubr_descripcion as rubro, sum(rr.rent_cantidad) as cantidad
	FROM 
	renentradastock as rr,
	cabentradastock as cr, 
	articulo as a,
	rubro as r,
	sucursal as s
	WHERE 
 	rr.id_sucursal   = cr.id_sucursal
	and  rr.id_sucursal   = s.id_sucursal
	and  cr.id_proveedor = 1
	and  rr.id_cabentradastock = cr.id_cabentradastock 
	and  rr.id_articulo = a.id_articulo
	and  a.id_rubro    = r.id_rubro
	and  a.id_marca = 1 
	and  cr.cent_fecha >= ? and cr.cent_fecha <= ?
	group by s.id_sucursal, a.id_rubro', fechadesde, fechahasta])
end

def self.comprasucuagrup(fechadesde, fechahasta)
	@comprasucusagrups = Marca.find_by_sql(['select  r.rubr_descripcion as rubro, sum(rr.rent_cantidad) as cantidad
	FROM 
	renentradastock as rr,
	cabentradastock as cr, 
	articulo as a,
	rubro as r,
	sucursal as s
	WHERE 
      	rr.id_sucursal   = cr.id_sucursal
	and  rr.id_sucursal   = s.id_sucursal
	and  cr.id_proveedor = 1
	and  rr.id_cabentradastock = cr.id_cabentradastock 
	and  rr.id_articulo = a.id_articulo
	and  a.id_rubro    = r.id_rubro
	and  a.id_marca = 1 
	and  cr.cent_fecha >= ? and cr.cent_fecha <= ?
	group by  a.id_rubro', fechadesde, fechahasta])
end

#consulta de compras valuadas con LP
def self.comprasucuval(nrolista,fechadesde, fechahasta)
	@comprasucuvals = Marca.find_by_sql(['select s.sucu_abreviatura as sucursal, r.rubr_descripcion as rubro, sum(rr.rent_cantidad) as cantidad, sum(if( l.lpre_preciolista IS NULL , 0, ROUND(rr.rent_cantidad * (l.lpre_preciolista * ((100 + g.glis_porcentaje) / 100)),2))) as costo, a.arti_descripcion as arti
	FROM 
	renentradastock as rr,
	cabentradastock as cr, 
	rubro as r,
	sucursal as s,
        articulo as a  LEFT JOIN (listaprecio AS l, grillalista AS g) ON (a.id_articulo = l.id_articulo AND l.lpre_nrolista = ? and g.id_listaprecio = l.id_listaprecio and  g.glis_nrogrilla = 1  and  g.glis_nrocolumna = 1 )
	WHERE 
 	rr.id_sucursal   = cr.id_sucursal
	and  rr.id_sucursal   = s.id_sucursal
	and  cr.id_proveedor = 1
	and  rr.id_cabentradastock = cr.id_cabentradastock 
	and  rr.id_articulo = a.id_articulo
	and  a.id_rubro    = r.id_rubro
	and  a.id_marca = 1
       	and  cr.cent_fecha >= ? and cr.cent_fecha <= ?
	group by s.id_sucursal, a.id_articulo', nrolista, fechadesde, fechahasta])
end

def self.comprasucuagrupval(nrolista, fechadesde, fechahasta)
	@comprasucusagrupvals = Marca.find_by_sql(['select  r.rubr_descripcion as rubro, sum(rr.rent_cantidad) as cantidad, sum(if( l.lpre_preciolista IS NULL , 0, rr.rent_cantidad * (l.lpre_preciolista * ((100 + g.glis_porcentaje) / 100)))) as costo
	FROM 
	renentradastock as rr,
	cabentradastock as cr, 
	rubro as r,
	sucursal as s,
       articulo as a  LEFT JOIN (listaprecio AS l, grillalista AS g) ON (a.id_articulo = l.id_articulo AND l.lpre_nrolista = ? and g.id_listaprecio = l.id_listaprecio and  g.glis_nrogrilla = 1  and  g.glis_nrocolumna = 1 )
	WHERE 
      	rr.id_sucursal   = cr.id_sucursal
	and  rr.id_sucursal   = s.id_sucursal
	and  cr.id_proveedor = 1
	and  rr.id_cabentradastock = cr.id_cabentradastock 
	and  rr.id_articulo = a.id_articulo
	and  a.id_rubro    = r.id_rubro
	and  a.id_marca = 1 
	and  cr.cent_fecha >= ? and cr.cent_fecha <= ?
	group by  a.id_rubro', nrolista, fechadesde, fechahasta])
end

# consulta de ventas montos por sucursal
def self.ventamonto(fechadesde, fechahasta)
	@ventamontos = Marca.find_by_sql(['select s.sucu_abreviatura as sucursal, YEAR(cf.cfac_fecha) as anio, MONTH(cf.cfac_fecha) as mes, sum(if(tc.tcom_sumaresta="+", cf.cfac_total ,  -cf.cfac_total)) as cantidad
	FROM 
	cabfactura as cf, 
	tipocomprobante as tc,
	sucursal as s
	wHERE 
        cf.id_sucursal   = s.id_sucursal
	and  cf.id_tipocomprobante = tc.id_tipocomprobante
	and  cf.cfac_fecha >= ? and cf.cfac_fecha <= ?
	GROUP BY s.id_sucursal, YEAR(cf.cfac_fecha),  MONTH(cf.cfac_fecha)', fechadesde, fechahasta])
end 
# consulta de ventas montos agrupada
def self.ventamontogrup(fechadesde, fechahasta)
	@ventamontogrups = Marca.find_by_sql(['select  YEAR(cf.cfac_fecha) as anio, MONTH(cf.cfac_fecha) as mes, sum(if(tc.tcom_sumaresta="+", cf.cfac_total ,  -cf.cfac_total)) as cantidad
	FROM 
	cabfactura as cf, 
	tipocomprobante as tc,
	sucursal as s
	wHERE 
        cf.id_sucursal   = s.id_sucursal
	and  cf.id_tipocomprobante = tc.id_tipocomprobante
	and  cf.cfac_fecha >= ? and cf.cfac_fecha <= ?
	GROUP BY  YEAR(cf.cfac_fecha),  MONTH(cf.cfac_fecha)', fechadesde, fechahasta])
end 

#consulta para el pie gruff de ventas con tarjeta, cheque y efectivo TODO: ver indexar o algo cabrecibo demora la consulta
def self.ventatipo(fechadesde, fechahasta)
	@ventatipo = Sucursal.find_by_sql(['SELECT fp.fpag_nombre AS formap, pc.id_formapago AS idpago, sum(pc.pcom_importe) AS importe
	FROM pagocomprobante pc, cabfactura cf, formapago fp, sucursal s
	WHERE cf.id_sucursal = pc.id_sucursal
	and pc.id_sucursal = s.id_sucursal
	and cf.id_cabfactura = pc.id_cabfactura
	and pc.id_formapago = fp.id_formapago
	and cf.cfac_fecha >= ?
	and cf.cfac_fecha <= ?
	GROUP BY pc.id_formapago
UNION
	SELECT fp.fpag_nombre AS formap, pc.id_formapago AS idpago, sum(pc.pcom_importe) AS importe
	FROM pagocomprobante pc, cabrecibo cr, formapago fp, sucursal s
	WHERE cr.id_sucursal = pc.id_sucursal
	AND pc.id_sucursal = s.id_sucursal
	AND cr.id_cabrecibo = pc.id_cabrecibo
	AND pc.id_formapago = fp.id_formapago
	AND cr.crec_fecha >= ?
	AND cr.crec_fecha <= ?
	GROUP BY pc.id_formapago',  fechadesde, fechahasta, fechadesde, fechahasta])
end

#consultas para porcentajes de cada tarjeta
def self.tarjeta(fechadesde, fechahasta)
	@tarjetas = Sucursal.find_by_sql(['SELECT tc.tarj_nombre AS nombre, tc.tarj_codigo AS codigo, sum(ct.ctar_importe) AS importe
	FROM cupontarjeta ct, tarjetacredito tc, sucursal s
	WHERE ct.id_sucursal = s.id_sucursal
	AND ct.id_tarjetacredito = tc.id_tarjetacredito
	AND ct.ctar_emision >= ?
	AND ct.ctar_emision <= ?
	GROUP BY tc.tarj_codigo ',  fechadesde, fechahasta])
end

def self.tarjetasucu(sucursal, fechadesde, fechahasta)
	@tarjetasucus = Sucursal.find_by_sql(['SELECT s.sucu_abreviatura AS sucursal,tc.tarj_nombre AS nombre, tc.tarj_codigo AS codigo, sum(ct.ctar_importe) AS importe
	FROM cupontarjeta ct, tarjetacredito tc, sucursal s
	WHERE s.id_sucursal = ?
	AND ct.id_sucursal = s.id_sucursal
	AND ct.id_tarjetacredito = tc.id_tarjetacredito
	AND ct.ctar_emision >= ?
	AND ct.ctar_emision <= ?
	GROUP BY s.id_sucursal, tc.tarj_codigo ', sucursal, fechadesde, fechahasta])
end
end
