require 'composite_primary_keys'
class Cabplaegreso < ActiveRecord::Base
 belongs_to :sucursal
 set_primary_keys :id, :sucursal_id
belongs_to :cabcaja, :foreign_key => [:cabcaja_id, :sucursal_id]

 validates_uniqueness_of :cpeg_nroplanilla,  :scope => :sucursal_id, :on => :create, :message => "Se modificó el número porque se genero otra planilla de egreso con el número anterior, presione crear"
 
# validates_numericality_of :cpeg_importe, :greater_than_or_equal_to => 0, :on => :update

#valida que las planillas anteriores esten cerradas
 validates_each :cpeg_cerrada,  :on => :update do |record, attr, value|
 @planillasanteriores = Cabplaegreso.find(:all, :conditions => ['cpeg_nroplanilla <= ? and cpeg_nroplanilla > 0 and sucursal_id = ?', $nroplaegant, $sucursal])
  @planillasanteriores.each do |database_record|
    record.errors.add(attr, "Primero debe cerrar la planilla de egresos anterior número #{database_record.cpeg_nroplanilla.to_i} del usuario #{database_record.cpeg_usuario.to_s} ") if ((value.to_s == "S") &&   (database_record.cpeg_cerrada.to_s == "N"))
  end
 end


validates_each :cpeg_fecha do |record, attr, value|
   database_record = Cabplaegreso.find_by_cpeg_nroplanilla_and_sucursal_id($nroplaegant, $sucursal)
   record.errors.add(attr, "La fecha de la planilla de egreso debe ser mayor o igual a la fecha de la planilla de egreso anterior") if (!database_record.nil? && value.to_date < database_record.cpeg_fecha.to_date )
 end

#valida que si se modifica la fecha de la planilla no haya ningun comprobante con fecha mayor
validates_each :cpeg_fecha,  :on => :update do |record, attr, value|
 @comprobantes = Cabcompra.find(:all, :conditions => ['cabplaegreso_id = ? and sucursal_id = ?', $idpeg, $sucursal])
 @comprobantes.each do |database_record|
 record.errors.add(attr, "La fecha de la planilla de egreso debe ser mayor o igual a la de sus comprobantes.") if (database_record.ccom_fecha.to_date > value.to_date )
 end
end

#valida si se modifica la fecha de la planilla de egreso no sea mayor a la planillas posteriores
validates_each :cpeg_fecha,  :on => :update do |record, attr, value|
 @planillas = Cabplaegreso.find(:all, :conditions => ['cpeg_nroplanilla > ? and sucursal_id = ?', $nroplaeg, $sucursal])
 @planillas.each do |database_record|
 record.errors.add(attr, "La fecha de la planilla de egreso debe ser menor o igual a la fecha de las planillas creadas posteriormente.") if (value.to_date > database_record.cpeg_fecha.to_date)
 end
end

# validates_each :cpeg_importe,  :on => :update do |record, attr, value|
#  if ($cerrar.to_s == 'S')
#   database_record =  Cabcompra.sum(:ccom_total, :conditions => ['ccom_nroplaegreso = ?', $nroplaeg])
#   record.errors.add(attr, "La suma de los totales de los comprobantes cargados para esta planilla #{database_record.to_f} #no coincide con el total ingresado #{value.to_f}. Verifique los comprobantes de la planilla o cambie el total" ) if #((value.to_f < database_record.to_f) || (value.to_f > database_record.to_f))
# end
# end
 
 def self.totalproveedor(nroplanilla, sucursal)
   @totalproveedors = Cabplaegreso.find_by_sql(['SELECT cc.proveedor_id, cc.ccom_nroplaegreso, cc.cabplaegreso_id, cc.pagocompra_id, cc.conceptoegreso_id,  sum(if(tc.tcom_sumaresta="+", cc.ccom_total , -cc.ccom_total)) as total
   FROM cabcompras AS cc, tipocomprobante as tc
   WHERE cc.tipocomprobante_id = tc.id_tipocomprobante and cc.cabplaegreso_id = ? and cc.sucursal_id = ? GROUP BY cc.proveedor_id, cc.conceptoegreso_id having sum(if(tc.tcom_sumaresta="+", cc.ccom_total , -cc.ccom_total)) >= 1000', nroplanilla, sucursal])
 end

 def self.comprobantepagonulo(nroplanilla, proveedor, concepto, sucursal)
  @comprobantepagonulos = Cabcompra.find(:all, :conditions =>['cabplaegreso_id = ? and proveedor_id = ? and conceptoegreso_id = ? and sucursal_id = ? and (pagocompra_id is null or pagocompra_id = 0)', "#{nroplanilla}", "#{proveedor}", "#{concepto}", "#{sucursal}"]) 
 end

 #retencion ganacia
 def self.retencionganancia(peid, fecha, sucursal)
   @retencionganancias = Cabplaegreso.find_by_sql(['SELECT p.id as provid, cpe.cpeg_nroplanilla,  ce.id as conceptoegresoid,  sum(if(tc.tcom_sumaresta="+", cc.ccom_netogravado , -cc.ccom_netogravado)) as total, ce.cegr_baseretgan, p.prov_nombre, ce.cegr_detalle, cpe.cpeg_fecha as fecha
FROM cabplaegresos as cpe, cabcompras as cc, conceptoegresos as ce, sucursals as s, proveedors as p, tipocomprobantes as tc
WHERE cpe.sucursal_id = s.id and cc.sucursal_id = s.id and p.sucursal_id = s.id and s.id = ? and cpe.id <= ? and MONTH(cpe.cpeg_fecha) = MONTH( ? ) and YEAR(cpe.cpeg_fecha) = YEAR( ? )  and cpe.cpeg_fecha <= ? and cc.cabplaegreso_id = cpe.id and cc.proveedor_id = p.id and cc.conceptoegreso_id = ce.id and ce.cegr_retganancia = "S" and p.prov_exentoretgan = "No" and cc.tipocomprobante_id = tc.id and tc.tcom_discriminaiva = "Si" and tc.tcom_letra = "A" and (cc.retencionganancia_id is null or cc.retencionganancia_id = 0)
GROUP BY p.id, ce.id
HAVING sum(if(tc.tcom_sumaresta="+", cc.ccom_netogravado , -cc.ccom_netogravado)) >= ce.cegr_baseretgan', sucursal, peid, fecha, fecha, fecha]) 
 end

 def self.comprobanteretgen(sucursal, fecha, provid, conceptoegresoid)
   @comprobanteretgens = Cabplaegreso.find_by_sql(['SELECT cc.proveedor_id, cpe.cpeg_nroplanilla as nropleeg, cc.id as cabcid, ce.id as conceptoegresoid, ce.cegr_baseretgan, p.prov_nombre, ce.cegr_detalle, cc.ccom_fecha as fecha, cpe.cpeg_fecha, cc.ccom_netogravado as neto, cc.retencionganancia_id, cc.id as idcomp
FROM cabplaegresos as cpe, cabcompras as cc, conceptoegresos as ce, sucursals as s, proveedors as p, tipocomprobantes as tc
WHERE cpe.sucursal_id = s.id and cc.sucursal_id = s.id and p.sucursal_id = s.id and s.id = ? and MONTH(cpe.cpeg_fecha) = MONTH( ? )  and YEAR(cpe.cpeg_fecha) = YEAR( ? ) and cc.cabplaegreso_id = cpe.id and p.id = cc.proveedor_id and  cc.proveedor_id = ? and ce. id = cc.conceptoegreso_id and cc.conceptoegreso_id = ? and ce.cegr_retganancia = "S" and cc.tipocomprobante_id = tc.id and tc.tcom_discriminaiva = "Si" and tc.tcom_letra = "A" and p.prov_exentoretgan = "No" and (cc.retencionganancia_id is null or cc.retencionganancia_id = 0)
', sucursal, fecha, fecha, provid, conceptoegresoid]) 
 end

 def self.retgan(nroplanilla, sucursal)
   @retgans = Retencionganancia.find(:all, :conditions => ['rtga_plaegresoid = ? and sucursal_id = ?', nroplanilla, sucursal])
 end

 def self.agrupconcepto(cabplaegresoid, sucursalid)
   @agrupconceptos = Cabcompra.find_by_sql(['SELECT cc.cabplaegreso_id, cc.conceptoegreso_id, sum(if(tc.tcom_sumaresta="+", cc.ccom_total , -cc.ccom_total)) as total
   FROM cabcompras as cc, tipocomprobante as tc
   WHERE cc.tipocomprobante_id = tc.id_tipocomprobante and cc.cabplaegreso_id  = ? and cc.sucursal_id = ? GROUP BY cc.conceptoegreso_id', cabplaegresoid, sucursalid])
 end

 #suma el total de la planilla de egreso
 def self.totalpe(id, sucursal)
   @total = Cabcompra.find_by_sql(['SELECT sum(if(tc.tcom_sumaresta="+", cc.ccom_total , -cc.ccom_total)) as total
   FROM cabcompras as cc, tipocomprobante as tc
   WHERE cc.tipocomprobante_id = tc.id_tipocomprobante and cc.cabplaegreso_id  = ? and cc.sucursal_id = ?', id, sucursal])
 end

 #devuelve los id de las retenciones para ese concepto y esa pla de eg
 def self.retenciongancid(conceptoid, cabplaegresoid, sucursalid)
   @retenciongancids = Cabcompra.find_by_sql(['SELECT cp.cabplaegreso_id , cp.conceptoegreso_id, rtg.rtga_importe as importeretg
   FROM cabcompras as cp, retencionganancias as rtg 
   WHERE cp.conceptoegreso_id = ? and cp.cabplaegreso_id  = ? and cp.sucursal_id = ? and cp.retencionganancia_id = rtg.id and rtg.sucursal_id = cp.sucursal_id GROUP BY rtg.id', conceptoid, cabplaegresoid, sucursalid])
 end

 def self.consulta(fechadesde, fechahasta, proveedor, conceptoegreso, sucursal)
  if proveedor.blank? && (conceptoegreso == "Seleccione un Concepto" || conceptoegreso.nil?)
     @consultas = Cabplaegreso.find_by_sql(['select cpe.cpeg_nroplanilla as nrope, cc.id_cabcompra as comprobante, p.prov_nombre as nombre, ce.cegr_detalle as concepto, cc.ccom_total as importe
from sucursal as s, cabplaegreso as cpe, cabcompra as cc, proveedor as p, conceptoegreso as ce
where cpe.id_sucursal = s.id_sucursal and cc.id_sucursal = s.id_sucursal and p.id_sucursal = s.id_sucursal and s.id_sucursal = ? and cc.id_cabplaegreso = cpe.id_cabplaegreso and p.id_proveedor = cc.id_proveedor and cc.id_conceptoegreso = ce.id_conceptoegreso  and cpe.cpeg_fecha >= ? and cpe.cpeg_fecha <= ? ORDER BY ce.id_conceptoegreso, p.id_proveedor', sucursal, fechadesde, fechahasta])
  elsif  proveedor.blank? && conceptoegreso != "Seleccione un Concepto"
     @consultas = Cabplaegreso.find_by_sql(['select cpe.cpeg_nroplanilla as nrope, cc.id_cabcompra as comprobante, p.prov_nombre as nombre, ce.cegr_detalle as concepto, cc.ccom_total as importe
from sucursal as s, cabplaegreso as cpe, cabcompra as cc, proveedor as p, conceptoegreso as ce
where cpe.id_sucursal = s.id_sucursal and cc.id_sucursal = s.id_sucursal and p.id_sucursal = s.id_sucursal and s.id_sucursal = ? and cc.id_cabplaegreso = cpe.id_cabplaegreso and p.id_proveedor = cc.id_proveedor and cc.id_conceptoegreso = ce.id_conceptoegreso and ce.id_conceptoegreso = ? and cpe.cpeg_fecha >= ? and cpe.cpeg_fecha <= ? ORDER BY ce.id_conceptoegreso, p.id_proveedor', sucursal,  conceptoegreso, fechadesde, fechahasta])
  elsif !proveedor.blank? && conceptoegreso == "Seleccione un Concepto"
     @consultas = Cabplaegreso.find_by_sql(['select cpe.cpeg_nroplanilla as nrope, cc.id_cabcompra as comprobante, p.prov_nombre as nombre, ce.cegr_detalle as concepto, cc.ccom_total as importe
from sucursal as s, cabplaegreso as cpe, cabcompra as cc, proveedor as p, conceptoegreso as ce
where cpe.id_sucursal = s.id_sucursal and cc.id_sucursal = s.id_sucursal and p.id_sucursal = s.id_sucursal and s.id_sucursal = ? and cc.id_cabplaegreso = cpe.id_cabplaegreso and  p.prov_cuit = ? and p.id_proveedor = cc.id_proveedor and cc.id_conceptoegreso = ce.id_conceptoegreso and cpe.cpeg_fecha >= ? and cpe.cpeg_fecha <= ? ORDER BY ce.id_conceptoegreso, p.id_proveedor', sucursal, proveedor, fechadesde, fechahasta])
  elsif !proveedor.blank? && conceptoegreso != "Seleccione un Concepto"
     @consultas = Cabplaegreso.find_by_sql(['select cpe.cpeg_nroplanilla as nrope, cc.id_cabcompra as comprobante, p.prov_nombre as nombre, ce.cegr_detalle as concepto, cc.ccom_total as importe
from sucursal as s, cabplaegreso as cpe, cabcompra as cc, proveedor as p, conceptoegreso as ce
where cpe.id_sucursal = s.id_sucursal and cc.id_sucursal = s.id_sucursal and p.id_sucursal = s.id_sucursal and s.id_sucursal = ? and cc.id_cabplaegreso = cpe.id_cabplaegreso and  p.prov_cuit = ? and p.id_proveedor = cc.id_proveedor and cc.id_conceptoegreso = ce.id_conceptoegreso and ce.id_conceptoegreso = ? and cpe.cpeg_fecha >= ? and cpe.cpeg_fecha <= ? ORDER BY ce.id_conceptoegreso, p.id_proveedor', sucursal, proveedor, conceptoegreso, fechadesde, fechahasta])
  end
 end
#si la caja de ingreso en la que esta la pe esta cerrada
def self.cajaingresocerrada(peid, sucursal)
  @cajaingreso = Cabplaegreso.find_by_sql(['Select ccaj.id_cabcaja
                from cabcaja as ccaj, cabplaegreso as ce, cabcompra as cc
                where ce.id_cabplaegreso = ? and ce.id_cabcaja = ccaj.id_cabcaja and  ce.id_sucursal = ?
                and ccaj.id_sucursal = ce.id_sucursal and ccaj.id_cabcaja != 0 and ccaj.ccaj_cerrada = "S"', peid, sucursal])
end

end
