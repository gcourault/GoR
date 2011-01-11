require 'composite_primary_keys'
class Cabcompra < ActiveRecord::Base
 set_primary_keys :id, :sucursal_id
 belongs_to :tipocomprobante
 belongs_to :proveedor, :foreign_key => [:proveedor_id, :sucursal_id]
 belongs_to :jurisdiccion
 belongs_to :conceptoegreso
 has_many :rencompra
 belongs_to :pagocompra
 belongs_to :retencionganancia


validates_numericality_of :ccom_retencioniva, :greater_than_or_equal_to => 0, :message => "El nro. debe ser cero o mayor"  
validates_numericality_of :ccom_percepcioniva, :greater_than_or_equal_to => 0, :message => "El nro. debe ser cero o mayor" 
validates_numericality_of :ccom_retencionganancia, :greater_than_or_equal_to => 0, :message => "El nro. debe ser cero o mayor"  
validates_numericality_of :ccom_retencionib, :greater_than_or_equal_to => 0, :message => "El nro. debe ser cero o mayor"  
validates_numericality_of :ccom_percepcionib, :greater_than_or_equal_to => 0, :message => "El nro. debe ser cero o mayor" 
validates_numericality_of :ccom_retencionmunicipal, :greater_than_or_equal_to => 0, :message => "El nro. debe ser cero o mayor"
validates_numericality_of :ccom_nogravado, :greater_than_or_equal_to => 0, :message => "El nro. debe ser cero o mayor"  
validates_numericality_of :ccom_impuestointerno, :greater_than_or_equal_to => 0, :message => "El nro. debe ser cero o mayor" 
validates_numericality_of :ccom_total, :greater_than => 0, :message => "El total debe ser mayor a cero"  

validates_numericality_of :proveedor_id, :greater_than => 0, :message => "Debe ingresar el proveedor. Si el comprobante tiene iva, no olvide ingresar los valores del renglón"
validates_numericality_of :ccom_puntosventa, :greater_thanor_equal_to => 0, :message => "Debe ingresar el punto de venta"

validates_presence_of :ccom_desdecompro, :message => "Debe ingresar el numero de comprobante o cero"
validates_numericality_of :ccom_desdecompro, :greater_than => 0, :message => "El numero de comprobante debe ser mayor a cero", :if => Proc.new { |cabcompra| cabcompra.tipocomprobante.tcom_discriminaiva.to_s == "Si" }


validates_uniqueness_of :ccom_desdecompro,  :scope => [:proveedor_id, :tipocomprobante_id, :ccom_puntosventa], :on => :create,  :message => "El numero de comprobante ya existe para ese proveedor, pto de venta y tipo de comprobante. Si el comprobante tiene iva, no olvide ingresar los valores del renglón", :if => Proc.new { |proveedor| $proveedor > 2 } && Proc.new { |cabcompra| cabcompra.tipocomprobante.tcom_validanro.to_s == "S" }
# por ahora que el proveedor sea mayor que 2 para la carga de compras a pirrelli y firestone


validates_each :ccom_desdecompro, :on => :update do |record, attr, value|
 database_record = Cabcompra.count(:conditions => ['ccom_desdecompro = ? AND proveedor_id = ? AND tipocomprobante_id = ? AND ccom_puntosventa = ? and id <> ?', $desdecompro, $proveedor, $tipocomp, $ptoventa, $id])
record.errors.add(attr, "El numero de comprobante ya existe para ese proveedor, pto de venta y tipo de comprobante.") if database_record > 0 and $proveedor > 2 and  Proc.new { |cabcompra| cabcompra.tipocomprobante.tcom_validanro.to_s == "S" }
end


validates_each :ccom_fecha do |record, attr, value|
 database_record = Cabplaegreso.find([$plaegid, $sucursal])
 record.errors.add(attr, "La fecha del comprobante no puede ser mayor a la fecha de la planilla de egreso. Si el comprobante tiene iva, no olvide ingresar los valores del renglón") if (value.to_date > database_record.cpeg_fecha.to_date && $plaegid.to_i > 0)
# agrego  $plaegid.to_i > 0 para anular la validacion en los comprobantes cargados por afuera de una planilla de egreso
end


 #valida que las facturas sean del mes de la planilla de egreso
validates_each :ccom_fecha do |record, attr, value|
 database_record = Cabplaegreso.find([$plaegid, $sucursal])
 record.errors.add(attr, "La fecha del comprobante no puede ser de un mes anterior a la fecha de la planilla de egreso. Si el comprobante tiene iva, no olvide ingresar los valores del renglón") if (value.to_date.month < database_record.cpeg_fecha.to_date.month && $plaegid.to_i > 0)
 # agrego  $plaegid.to_i > 0 para anular la validacion en los comprobantes cargados por afuera de una planilla de egreso
end

#validar q el comprobante no tenga retenciones afectadas a una planilla en caja de ingreso

 
#def before_destroy
#  if retencionganancia_id.to_i > 0
#   errors.add_to_base "No se puede borrar el comprobante porque tiene asociada una retencion de ganancia. Primero borre la retención de ganancia."
#    false
  
# end
#end

 #suma el total de comprobantes entre fechas
 def self.totalpe(id, sucursal, fechadesde, fechahasta)
   @total = Cabcompra.find_by_sql(['SELECT sum(if(tc.tcom_sumaresta="+", cc.ccom_total , -cc.ccom_total)) as total
   FROM cabcompras as cc, tipocomprobante as tc
   WHERE cc.tipocomprobante_id = tc.id_tipocomprobante and cc.cabplaegreso_id  = ? and cc.sucursal_id = ? and cc.ccom_fecha >= ? and cc.ccom_fecha <= ?', id, sucursal, fechadesde, fechahasta])
 end

end
