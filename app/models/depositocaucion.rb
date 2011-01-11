class Depositocaucion < ActiveRecord::Base
  belongs_to :chequetercero
  belongs_to :sucursal
  belongs_to :conceptocaucion

validates_presence_of :dcau_nroboletadeposito

def self.busqueda(fechadesde, fechahasta, nrocheq)
  if nrocheq.blank?

      #@depositocaucions = Depositocaucion.find(:all, :joins => [:chequetercero, :sucursal], :conditions => ["depositocaucions.sucursal_id = '11' AND chequeterceros.cter_vencimiento >= ? AND chequeterceros.cter_vencimiento <= ?", "#{fechadesde}", "#{fechahasta}"])
	@depositocaucionpendis = Depositocaucion.find_by_sql(['select cter_importe as importe, cter_vencimiento as fechavenc, cter_nrocheque as nro, id_listadocaucion as listado, id_chequetercero as idcheter
           from  chequetercero as ct
           where ct.id_sucursal = "11" and ct.id_listadocaucion <> "0" and ct.cter_borradocaucion = "N" and ct.id_chequetercero NOT IN (SELECT id_chequetercero FROM depositocaucion)
	   and ct.cter_vencimiento BETWEEN  ? AND ? ' , fechadesde, fechahasta])
  else
        @depositocaucionpendis = Depositocaucion.find_by_sql(['select cter_importe as importe, cter_vencimiento as fechavenc, cter_nrocheque as nro, id_listadocaucion as listado, id_chequetercero as idcheter
           from  chequetercero as ct
           where ct.id_sucursal = "11" and  ct.cter_borradocaucion = "N" and  ct.id_listadocaucion IN (select id_listadocaucion from listadocaucion) and ct.id_chequetercero NOT IN (SELECT id_chequetercero FROM depositocaucion)
	   and ct.cter_nrocheque = ? ' , nrocheq])
end
end

#consulta de los cheque que estan en caución que vencen entre esas fechas
def self.busquedatodo(fechadesde, fechahasta, nrocheq)
  if nrocheq.blank?
	@depositocaucions = Depositocaucion.find_by_sql(['SELECT depositocaucions. * , chequeterceros.cter_vencimiento as venc, conceptocaucions.ccau_detalle as concepto, chequeterceros.cter_nrocheque as nro, chequeterceros.cter_importe as importe, chequeterceros.listadocaucion_id as listado,  chequeterceros.id as idcheter, depositocaucions.id as id
	FROM depositocaucions
	INNER JOIN chequeterceros ON chequeterceros.id = depositocaucions.chequetercero_id
	LEFT JOIN conceptocaucions ON conceptocaucions.id = depositocaucions.conceptocaucion_id
	INNER JOIN sucursals ON sucursals.id = depositocaucions.sucursal_id
	WHERE (depositocaucions.sucursal_id = "11"
        AND chequeterceros.listadocaucion_id <> "0" 
	AND chequeterceros.sucursal_id = depositocaucions.sucursal_id
	AND depositocaucions.dcau_fechadeposito >= ?
 	AND depositocaucions.dcau_fechadeposito <= ?) ORDER BY depositocaucions.dcau_fechadeposito', fechadesde, fechahasta])
  else
   @depositocaucions = Depositocaucion.find_by_sql(['SELECT depositocaucions. * , chequeterceros.cter_vencimiento as venc, conceptocaucions.ccau_detalle as concepto, chequeterceros.cter_nrocheque as nro, chequeterceros.cter_importe as importe, chequeterceros.listadocaucion_id as listado,  chequeterceros.id as idcheter, depositocaucions.id as id
	FROM depositocaucions
	INNER JOIN chequeterceros ON chequeterceros.id = depositocaucions.chequetercero_id
	LEFT JOIN conceptocaucions ON conceptocaucions.id = depositocaucions.conceptocaucion_id
	INNER JOIN sucursals ON sucursals.id = depositocaucions.sucursal_id
	WHERE depositocaucions.sucursal_id = "11"
        AND chequeterceros.listadocaucion_id <> "0" 
	AND chequeterceros.sucursal_id = depositocaucions.sucursal_id
	AND chequeterceros.cter_nrocheque = ?', nrocheq])
end
end

# para el listado de cheques que vencen
def self.totalven(fechadesde, fechahasta)
	@totalvens = Listadocaucion.find_by_sql(['SELECT Sum(ct.cter_importe) as totalvenc
        FROM chequetercero as ct
        WHERE ct.id_sucursal = "11" and ct.cter_borradocaucion = "N" and ct.cter_vencimiento >= ? and ct.cter_vencimiento <= ? and ct.id_chequetercero NOT  IN (select id_chequetercero from depositocaucion where id_conceptocaucion = "2" OR id_conceptocaucion = "3") and  ct.id_listadocaucion IN (select id_listadocaucion from listadocaucion)
           GROUP BY ct.id_sucursal ', fechadesde, fechahasta])
end

#los acreditados
def self.acreditado(fechadesde, fechahasta)
	@acreditados = Depositocaucion.find_by_sql(['SELECT sum(chequeterceros.cter_importe) as totalacred
	FROM depositocaucions
	INNER JOIN chequeterceros ON chequeterceros.id = depositocaucions.chequetercero_id
	INNER JOIN sucursals ON sucursals.id = depositocaucions.sucursal_id
	WHERE (depositocaucions.sucursal_id = "11"
        AND chequeterceros.listadocaucion_id <> "0" 
	AND chequeterceros.sucursal_id = depositocaucions.sucursal_id
        AND chequeterceros.id NOT  IN (select chequetercero_id from depositocaucions where conceptocaucion_id = "2" OR conceptocaucion_id = "3") 
	AND chequeterceros.cter_vencimiento >= ?
 	AND chequeterceros.cter_vencimiento <= ?) Group by depositocaucions.sucursal_id', fechadesde, fechahasta])
end

#los pendientes agrupados por listados para los listados mayores al 01/01/2010
def self.listadopendiente()
	@listadopendientes = Depositocaucion.find_by_sql(['SELECT cter_importe as importe, cter_vencimiento as fechavenc, cter_nrocheque as nro, id_listadocaucion as listado, id_chequetercero as idcheter, listadocaucions.lcau_importetotal as importelist
           FROM  chequetercero as ct
           INNER JOIN listadocaucions ON ct.id_listadocaucion = listadocaucions.id
           WHERE ct.id_sucursal = "11" and ct.id_listadocaucion <> "0" and ct.cter_borradocaucion = "N" and ct.id_chequetercero NOT IN (SELECT id_chequetercero FROM depositocaucion)
	   and ct.cter_vencimiento >= "2010-01-01" order by listadocaucions.id DESC'])
end

end
