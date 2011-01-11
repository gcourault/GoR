class Listadocaucion < ActiveRecord::Base
belongs_to :sucursal
belongs_to :banco
belongs_to :listadobanco

#suma de los importes de todos los listados anteriores a la fecha de inicio 
def self.saldobancocaucion(fechadesde)
	@saldobancocaucions = Listadocaucion.find_by_sql(['select sum(lcau_importetotal) as saldo from  listadocaucion
        where id_sucursal = "11" 
        and lcau_fecha < ? GROUP BY id_sucursal', fechadesde])
end

#todos los con fecha vencimiento menor a fecha desde
def self.saldocaucion(fechadesde)
	@saldocaucions = Listadocaucion.find_by_sql(['select sum(cter_importe) as importecauc 
        from  chequetercero as ct
        where ct.id_sucursal = "11" and ct.cter_borradocaucion = "N" and ct.cter_vencimiento < ?  and ct.id_chequetercero NOT IN (select id_chequetercero  		from depositocaucion where id_conceptocaucion = "2" OR id_conceptocaucion = "3") and ct.id_listadocaucion IN (select id_listadocaucion from listadocaucion)
        GROUP BY ct.id_sucursal', fechadesde])
end

def self.reingreso(fechadesde) 
	#@reingresos = Devueltocaucion.find(:all, :conditions => ["devc_fecha <= ? ", "#{fechadesde}"])
         reingresos = Devueltocaucion.find_by_sql(['select sum(dc.devc_importe) as importereingresos 
         from devueltocaucions as dc
         where devc_tipo = "R" and dc.devc_fecha < ? GROUP BY dc.sucursal_id', fechadesde])
end

# ajustes manuales del mes anterior
def self.ajustemanualini(fechadesde, fecha)
   
      	@ajustemanualinis = Devueltocaucion.find(:all, :conditions => ["devc_tipo = 'G' and devc_fecha < ? and devc_fecha >= ? ", "#{fechadesde}",  "#{fecha}"])
	#@ajustemanualinis = Devueltocaucion.find(:all, :conditions => ["devc_tipo = 'G' and devc_fecha < ? and devc_fecha >= DATE_SUB('#{fechadesde}'(),INTERVAL 20 DAY) ", "#{fechadesde}"])

end

#HASTA ACA CALCULO DEL SALDO INICIAL

def self.listadoscaucion(fechadesde, fechahasta)
	@listadoscaucions = Listadocaucion.find(:all, :conditions => ["lcau_fecha >= ? and lcau_fecha <= ?", "#{fechadesde}", "#{fechahasta}"])
end

# cheques con vencimiento entre esas fechas
def self.valorescaucion(fechadesde, fechahasta)
	@valorcaucions = Listadocaucion.find_by_sql(['select Sum(ct.cter_importe) as importe, ct.cter_vencimiento as fechavenc
        from chequetercero as ct
        where ct.id_sucursal = "11" and ct.cter_borradocaucion = "N" and ct.cter_vencimiento >= ? and ct.cter_vencimiento <= ? and ct.id_chequetercero NOT IN (select id_chequetercero from depositocaucion where id_conceptocaucion = "2" OR id_conceptocaucion = "3") and  ct.id_listadocaucion IN (select id_listadocaucion from listadocaucion)
           GROUP BY ct.cter_vencimiento ', fechadesde, fechahasta])
end

#cheques reingresados entre esas fechas
def self.valoresreingresado(fechadesde, fechahasta) 
	@valorreingresados = Devueltocaucion.find(:all, :conditions => ["devc_tipo = 'R' and devc_fecha >= ? and devc_fecha <= ? ", "#{fechadesde}", "#{fechahasta}"])
end

#los listados del mes que no entraron al banco a la fecha de cierre
def self.ajuste(fechadesde, fechahasta)
	@ajustes = Listadobanco.find_by_sql(['SELECT `listadobancos`. * , listadocaucions.lcau_fecha as lcau_fecha, listadocaucions.lcau_importetotal as lcau_importetotal
	FROM `listadobancos`
	INNER JOIN `listadocaucions` ON `listadocaucions`.id = `listadobancos`.listadocaucion_id
	WHERE listadobancos.sucursal_id = "11"
	AND listadocaucions.lcau_fecha >= ? AND listadocaucions.lcau_fecha <= ?
	AND listadobancos.lisb_fecha > ?', fechadesde, fechahasta, fechahasta])
end

# ajuste de los reingresos que la fecha del banco de los listados sea mayor al cierre
def self.ajustereingresobanco(fechadesde, fechahasta)
	@ajustereingresobancos = Listadocaucion.find_by_sql(['select * from devueltocaucions as dc, chequeterceros as ct
        where dc.sucursal_id = "11" and dc.chequetercero_id = ct.id and dc.devc_tipo = "R" and dc.devc_fecha >= ? and dc.devc_fecha <= ? and   ct.listadocaucion_id IN (select listadocaucions.id from listadocaucions  
                         INNER JOIN listadobancos ON listadocaucions.id = listadobancos.listadocaucion_id
                         where listadobancos.sucursal_id = "11" AND listadobancos.lisb_fecha > ? )', fechadesde, fechahasta, fechahasta])
end

# ajustes manuales del mes
def self.ajustemanual(fechadesde, fechahasta)
	@ajustemanuals = Devueltocaucion.find(:all, :conditions => ["devc_tipo = 'A' and devc_fecha >= ? and devc_fecha <= ? ", "#{fechadesde}", "#{fechahasta}"])
end

# ajustes manuales deposito gestion del mes
def self.ajustemanualdg(fechadesde, fechahasta)
	@ajustemanualdgs = Devueltocaucion.find(:all, :conditions => ["devc_tipo = 'G' and devc_fecha >= ? and devc_fecha <= ? ", "#{fechadesde}", "#{fechahasta}"])
end

# para el listado de cheques pendientes
def self.pendiente(fechadesde, fechahasta)
	@pendientes = Listadocaucion.find_by_sql(['select cter_importe as importe, cter_vencimiento as fechavenc, cter_nrocheque as nro, id_listadocaucion as listado
        from  chequetercero as ct
        where ct.id_sucursal = "11" and ct.id_listadocaucion <> "0"  and ct.id_chequetercero NOT IN (SELECT id_chequetercero FROM depositocaucion)
	and ct.cter_vencimiento BETWEEN  ? AND ? ', fechadesde, fechahasta])
end

def self.busqueda()
	@listadocaucions = Listadocaucion.find_by_sql(['SELECT listadocaucions. * , listadobancos.lisb_importe AS importebanco, listadobancos.lisb_fecha AS fechabanco
	FROM listadocaucions
	LEFT JOIN listadobancos ON listadocaucions.id = listadobancos.listadocaucion_id
	WHERE listadocaucions.sucursal_id = "11" order by id DESC '])
end

end


