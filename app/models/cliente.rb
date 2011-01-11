require 'composite_primary_keys'
 class Cliente < ActiveRecord::Base
  has_many :reclamos
  has_many :cabfactura
  has_many :chequetercero
  has_many :cabrecibo
  belongs_to :sucursal
  belongs_to :localidad
  belongs_to :tipodocumento
  belongs_to :situacionafip
  has_one :usuario
  set_primary_keys :id, :sucursal_id 

 def self.movimiento(cliente, fechadesde, fechahasta, sucursal)
   @movimientos = Cliente.find_by_sql(['select  ccc.cccl_fecha as fecha, ccc.cccl_importedebe as debe, ccc.cccl_importehaber as haber, v.vend_codigo as vendedor, tc.tcom_abreviatura as comprobante, ccc.cccl_puntosventa as puntov, ccc.cccl_puntoafectado as ptoafectado, ccc.cccl_nroafectado as nroafectado, ccc.cccl_nrocomprobante as nro, ccc.cccl_tipoafectado as tafect
            from cccliente as ccc, tipocomprobante as tc, vendedor as v
            where ccc.id_sucursal = ?
            and ccc.id_cliente  = ? 
            and ccc.cccl_fecha >= ? 
            and ccc.cccl_fecha <= ? 
            and ccc.id_tipocomprobante = tc.id_tipocomprobante
            and ccc.id_vendedor = v.id_vendedor', sucursal, cliente, fechadesde, fechahasta])
 end

 #calcula saldo anterior
 def self.saldoant(sucursal, fechadesde, cliente)
   @saldoant = Cliente.find_by_sql([' select *, sum(ccc.cccl_importedebe - ccc.cccl_importehaber) as SaldoAnterior 
              from cccliente as ccc 
              where ccc.id_sucursal = ? 
              and ccc.id_cliente  = ? 
              and ccc.cccl_fecha  < ?
	      group by ccc.id_cliente', sucursal, cliente, fechadesde]) 
 end

 #calcula saldo final a la fecha solicitada
 def self.saldomov(sucursal, fechadesde, fechahasta, cliente)
   @saldomov = Cliente.find_by_sql(['select *, sum(ccc.cccl_importedebe - ccc.cccl_importehaber) as SaldoMovi
              from cccliente as ccc 
              where ccc.id_sucursal = ?  
              and ccc.id_cliente  = ?
            
              and ccc.cccl_fecha <= ?  
	      group by ccc.id_cliente', sucursal, cliente,  fechahasta]) 
 end

 #articulos comprados por el cliente entre estas fechas
 def self.articulo(cliente, fechadesde, fechahasta, sucursal)
   @articulos = Cliente.find_by_sql(['SELECT a.id_articulo as artid, a.arti_descripcion as articulo, sum(if(tc.tcom_sumaresta="+", rf.rfac_cantidad ,  -rf.rfac_cantidad)) as cantidad, sum(if(tc.tcom_sumaresta="+", rf.rfac_totalrenglon2 ,  -rf.rfac_totalrenglon2)) as monto
	FROM 
	renfactura as rf,
	cabfactura as cf, 
	articulo as a,
	tipocomprobante as tc,
	sucursal as s
	WHERE 
      	rf.id_sucursal   = cf.id_sucursal
	and  rf.id_sucursal   = s.id_sucursal
        and  s.id_sucursal = ?
        and  cf.id_cliente = ?
	and  rf.id_cabfactura = cf.id_cabfactura 
	and  cf.id_tipocomprobante = tc.id_tipocomprobante
	and  rf.id_articulo = a.id_articulo
	and  cf.cfac_fecha >= ? and cf.cfac_fecha <= ?
	GROUP BY  a.id_articulo ORDER BY a.id_rubro', sucursal, cliente, fechadesde, fechahasta])
 end
 #articulos comprados por el cliente entre estas fechas agrupados por mes
 def self.articulopormes(cliente, fechadesde, fechahasta, sucursal)
   @articulospormes = Cliente.find_by_sql(['SELECT MONTH(cf.cfac_fecha) as mes, YEAR(cf.cfac_fecha)as anio, sum(if(tc.tcom_sumaresta="+", rf.rfac_cantidad ,  -rf.rfac_cantidad)) as cantidad, sum(if(tc.tcom_sumaresta="+", rf.rfac_totalrenglon2 ,  -rf.rfac_totalrenglon2)) as monto
	FROM 
	renfactura as rf,
	cabfactura as cf, 
	articulo as a,
	tipocomprobante as tc,
	sucursal as s
	WHERE 
      	rf.id_sucursal   = cf.id_sucursal
	and  rf.id_sucursal   = s.id_sucursal
        and  s.id_sucursal = ?
        and  cf.id_cliente = ?
	and  rf.id_cabfactura = cf.id_cabfactura 
	and  cf.id_tipocomprobante = tc.id_tipocomprobante
	and  rf.id_articulo = a.id_articulo
	and  cf.cfac_fecha >= ? and cf.cfac_fecha <= ?
	GROUP BY YEAR(cf.cfac_fecha),  MONTH(cf.cfac_fecha)', sucursal, cliente, fechadesde, fechahasta])
 end
 

 #articulos comprados por el cliente entre estas fechas agrupados por rubro 
 def self.articulorubro(cliente, fechadesde, fechahasta, sucursal)
   @articulorubros = Cliente.find_by_sql(['SELECT r.rubr_descripcion as rubro, r.id_rubro as idr, sum(if(tc.tcom_sumaresta="+", rf.rfac_cantidad ,  -rf.rfac_cantidad)) as cantidad, sum(if(tc.tcom_sumaresta="+", rf.rfac_totalrenglon2 ,  -rf.rfac_totalrenglon2)) as monto
	FROM 
        rubro as r,
	renfactura as rf,
	cabfactura as cf, 
	articulo as a,
	tipocomprobante as tc,
	sucursal as s
	WHERE 
      	rf.id_sucursal   = cf.id_sucursal
	and  rf.id_sucursal   = s.id_sucursal
        and  s.id_sucursal = ?
        and  cf.id_cliente = ?
	and  rf.id_cabfactura = cf.id_cabfactura 
	and  cf.id_tipocomprobante = tc.id_tipocomprobante
	and  rf.id_articulo = a.id_articulo
        and  a.id_rubro  = r.id_rubro
	and  cf.cfac_fecha >= ? and cf.cfac_fecha <= ?
	GROUP BY a.id_rubro', sucursal, cliente, fechadesde, fechahasta])
 end

   def self.graficorubro(cliente, fechadesde, fechahasta, sucursal, i)
    
      @articulorubros = Cliente.articulorubro(cliente, fechadesde, fechahasta, sucursal)
      if @articulorubros.size > 0
      
        gt = Gruff::Pie.new("450x300")
        gt.title_font_size = 20
        gt.legend_box_size = 8
        gt.legend_font_size = 12
        gt.theme = {:colors => ['#FF4500', '#0066FF', '#CC00FF','#FFFFFF', '#339933', '#800000', '#FFFF66', '#FFA500', '#BEF781', '#088A85', '#084311'], :marker_color => '#FFFFFF', :background_colors => ['#000000', '#191970']}
        gt.font_color = '#FFFFFF'
        gt.title = 'Porcentajes de los artículos por rubros que compra el cliente'
        total = 0
        @articulorubros.each do |t|
          total = total + t.cantidad.to_i
        end
        cant = 0
        nombre = " "
        porc = 0
        @articulorubros.each do |tarj| 
          porc = (tarj.cantidad.to_i * 100) / total if total > 0
          if porc >= 1
              gt.data(tarj.rubro, [tarj.cantidad.to_i])
          end
       end

      # gt.data(formapago, cant)
       gt.write('public/images/rubrocliente'+i.to_s+''+sucursal.to_s+'.png') 
     end
  end

 #cheques del cliente pendientes
 def self.cheque(cliente, fechahasta, sucursal)
    @cheques = Cliente.find_by_sql(['select * from  chequetercero 
        where id_sucursal = ?
	and id_cliente = ?
	and cter_vencimiento >= ?', sucursal, cliente, fechahasta])
 end

 #cheques rechazados del cliente
 def self.chequerechazado(cliente, sucursal)
    @chequerechazados = Chequetercero.find_by_sql(['select * from chequetercero as c, sucursal as s, regucheque as r, motivochereg as m
        where c.id_sucursal = r.id_sucursal
        and c.id_chequetercero = r.id_chequetercero
        and m.id_motivochereg = r.id_motivochereg
        and c.id_sucursal = s.id_sucursal 
        and s.id_sucursal = ?
        and m.motc_tipo = "H"
        and c.id_cliente = ?', sucursal, cliente])
 end
 #cheques del cliente y factura a la estan asociados
def self.chequefactura(idcliente, fechadesde, fechahasta, sucursal)
	@chequefacturas = Chequetercero.find_by_sql(['select * from  chequetercero as ct 
            where ct.id_sucursal = ?
	    and ct.id_cliente = ?
	    and ct.cter_ingreso >= ?
            and ct.cter_ingreso <= ?', sucursal, idcliente, fechadesde, fechahasta])
end

 # facturas entre fechas
 def self.factura(cliente, fechadesde, fechahasta, sucursal)
   @facturas = Cabfactura.find_by_sql(['SELECT  * , if(tc.tcom_sumaresta="+", cf.cfac_total, -cf.cfac_total) as monto
	FROM 
	cabfactura as cf, 
	tipocomprobante as tc,
	sucursal as s
	WHERE 
      	s.id_sucursal = cf.id_sucursal
	and  s.id_sucursal = ?
        and  cf.id_cliente = ?
	and  cf.id_tipocomprobante = tc.id_tipocomprobante
	and  cf.cfac_fecha >= ? and cf.cfac_fecha <= ?', sucursal, cliente, fechadesde, fechahasta])
 end

 #detalle facturas entre fechas
 def self.facturadetalle(id, sucursal)
   @facturadetalles = Cliente.find_by_sql(['SELECT a.arti_descripcion as articulo, if(tc.tcom_sumaresta="+", rf.rfac_cantidad ,  -rf.rfac_cantidad) as cantidad, if(tc.tcom_sumaresta="+", rf.rfac_totalrenglon2 ,  -rf.rfac_totalrenglon2) as monto
	FROM 
	renfactura as rf,
	cabfactura as cf, 
	articulo as a,
	tipocomprobante as tc,
	sucursal as s
	WHERE 
      	rf.id_sucursal   = cf.id_sucursal
	and  cf.id_sucursal   = s.id_sucursal
        and  s.id_sucursal = ?
       	and  rf.id_cabfactura = cf.id_cabfactura 
        and  cf.id_cabfactura = ?
	and  cf.id_tipocomprobante = tc.id_tipocomprobante
	and  rf.id_articulo = a.id_articulo', sucursal, id])
 end

 #articulos comprados por el cliente entre estas fechas
 def self.articulocliente(cliente, fechadesde, fechahasta, articulo, sucursal)
   @articuloclientes = Cliente.find_by_sql(['SELECT  a.arti_descripcion as articulo, if(tc.tcom_sumaresta="+", rf.rfac_cantidad ,  -rf.rfac_cantidad) as cantidad, if(tc.tcom_sumaresta="+", rf.rfac_totalrenglon2 ,  -rf.rfac_totalrenglon2) as monto, tc.tcom_abreviatura as comprobante, cf.cfac_puntosventa as ptoventa, cf.cfac_nrocomprobante as nrocompro, cf.cfac_fecha as fecha, rf.rfac_preciounitario2 as preciounitario
	FROM 
	renfactura as rf,
	cabfactura as cf, 
	articulo as a,
	tipocomprobante as tc,
	sucursal as s
	WHERE 
      	rf.id_sucursal   = cf.id_sucursal
	and  rf.id_sucursal   = s.id_sucursal
        and  s.id_sucursal = ?
        and  cf.id_cliente = ?
	and  rf.id_cabfactura = cf.id_cabfactura 
	and  cf.id_tipocomprobante = tc.id_tipocomprobante
	and  rf.id_articulo = a.id_articulo
        and  a.id_articulo = ?
        and  cf.cfac_fecha >= ? and cf.cfac_fecha <= ?', sucursal, cliente, articulo, fechadesde, fechahasta]) 
 
 end
 #articulos comprados entre estas fechas por clientes
 def self.articuloclientetodos( fechadesde, fechahasta, articulo, sucursal)
   @articuloclientes = Cliente.find_by_sql(['SELECT  a.arti_descripcion as articulo, if(tc.tcom_sumaresta="+", rf.rfac_cantidad ,  -rf.rfac_cantidad) as cantidad, if(tc.tcom_sumaresta="+", rf.rfac_totalrenglon2 ,  -rf.rfac_totalrenglon2) as monto, tc.tcom_abreviatura as comprobante, cf.cfac_puntosventa as ptoventa, cf.cfac_nrocomprobante as nrocompro, cf.cfac_fecha as fecha, rf.rfac_preciounitario2 as preciounitario, c.clie_cuit as cuit, c.clie_razonsocial as nombre
	FROM 
	renfactura as rf,
	cabfactura as cf, 
	articulo as a,
	tipocomprobante as tc,
	sucursal as s, 
        cliente as c
	WHERE 
      	rf.id_sucursal   = cf.id_sucursal
	and  rf.id_sucursal   = s.id_sucursal
        and  c.id_sucursal = s.id_sucursal
        and  s.id_sucursal = ?
        and  cf.id_cliente = c.id_cliente
	and  rf.id_cabfactura = cf.id_cabfactura 
	and  cf.id_tipocomprobante = tc.id_tipocomprobante
	and  rf.id_articulo = a.id_articulo
        and  a.id_articulo = ?
        and  cf.cfac_fecha >= ? and cf.cfac_fecha <= ?
        Order by c.clie_razonsocial ', sucursal,  articulo, fechadesde, fechahasta]) 
 
 end

#remitos pendientes del cliente pendientes
def self.remitospendiente(cliente, nrolista, fechadesde, fechahasta, sucursal)
	@remitospendientes =  Marca.find_by_sql(['SELECT s.sucu_abreviatura AS sucursal,  a.arti_descripcion as arti, r.rubr_descripcion AS rubro, sum( rr.rrem_cantidad - rr.rrem_cantifactu ) AS totalarti, sum( if( l.lpre_precioventa IS NULL , 0,  (rr.rrem_cantidad - rr.rrem_cantifactu) * l.lpre_precioventa) ) AS totalcosto
	FROM  cabremito AS cr, articulo AS a, rubro AS r, sucursal AS s,
	renremito AS rr	LEFT JOIN listaprecio AS l ON rr.id_articulo = l.id_articulo AND l.lpre_nrolista = ?  
	WHERE rr.id_sucursal = cr.id_sucursal
	and rr.id_sucursal = s.id_sucursal
        and s.id_sucursal = ?
        and cr.id_cliente = ?
	and rr.id_cabremito = cr.id_cabremito
	and rr.id_articulo = a.id_articulo
	and a.id_rubro = r.id_rubro
        and (rr.rrem_cantidad - rr.rrem_cantifactu) != 0
	and cr.crem_anulado != "S"
	and cr.crem_fecha >= ?
	and cr.crem_fecha <= ?
	GROUP BY s.id_sucursal, a.id_articulo', nrolista, sucursal, cliente, fechadesde, fechahasta])
end

#clientes que superan un monto en un periodo
def self.clientepormonto(monto, sucursal, fechadesde, fechahasta)
   @clientepormontos = Cliente.find_by_sql(['SELECT *, sum(if(tc.tcom_sumaresta="+", rf.rfac_totalrenglon2 ,  -rf.rfac_totalrenglon2)) as monto,  sum(if(tc.tcom_sumaresta="+", rf.rfac_cantidad ,  -rf.rfac_cantidad)) as cantidad
	FROM 
	renfactura as rf,
	cabfactura as cf, 
	articulo as a,
	tipocomprobante as tc,
	sucursal as s,
        cliente as c
	WHERE 
      	rf.id_sucursal   = cf.id_sucursal
	and  rf.id_sucursal   = s.id_sucursal
        and  c.id_sucursal = s.id_sucursal
        and  s.id_sucursal = ?
        and  cf.id_cliente = c.id_cliente
	and  rf.id_cabfactura = cf.id_cabfactura 
	and  cf.id_tipocomprobante = tc.id_tipocomprobante
	and  rf.id_articulo = a.id_articulo
	and  cf.cfac_fecha >= ? and cf.cfac_fecha <= ?
	GROUP BY c.id_cliente  HAVING sum(if(tc.tcom_sumaresta="+", rf.rfac_totalrenglon2 ,  -rf.rfac_totalrenglon2)) >= ? ORDER BY monto DESC', sucursal, fechadesde, fechahasta, monto])
end

#clientes que superan un monto en un periodo por mes y anio
def self.clientepormontome(cliente, sucursal, fechadesde, fechahasta)
   @clientepormontomes = Cliente.find_by_sql(['SELECT *, MONTH(cf.cfac_fecha) as mes, YEAR(cf.cfac_fecha)as anio, sum(if(tc.tcom_sumaresta="+", rf.rfac_totalrenglon2 ,  -rf.rfac_totalrenglon2)) as monto,  sum(if(tc.tcom_sumaresta="+", rf.rfac_cantidad ,  -rf.rfac_cantidad)) as cantidad, r.rubr_descripcion as rubro
	FROM 
	renfactura as rf,
	cabfactura as cf, 
	articulo as a,
	tipocomprobante as tc,
	sucursal as s,
        rubro as r
	WHERE 
      	rf.id_sucursal   = cf.id_sucursal
	and  rf.id_sucursal   = s.id_sucursal
        and  s.id_sucursal = ?
        and  cf.id_cliente = ?
	and  rf.id_cabfactura = cf.id_cabfactura 
	and  cf.id_tipocomprobante = tc.id_tipocomprobante
	and  rf.id_articulo = a.id_articulo
        and  a.id_rubro = r.id_rubro
	and  cf.cfac_fecha >= ? and cf.cfac_fecha <= ?
	GROUP BY  a.id_rubro, YEAR(cf.cfac_fecha),  MONTH(cf.cfac_fecha) order by YEAR(cf.cfac_fecha),  MONTH(cf.cfac_fecha) ', sucursal, cliente, fechadesde, fechahasta])
end
end
