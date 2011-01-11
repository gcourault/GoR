require 'composite_primary_keys'
class Pagocompra < ActiveRecord::Base
 set_primary_keys :id, :sucursal_id
 has_many :cabcompras

# validates_each :total do |record, attr, value|
#      record.errors.add attr, 'El total no coincide con el total de los comprobantes. Verifique los montos ingresados.' if ( $suma != $total )
# end

 def total
     self.pcpr_efectivo.to_i + self.pcpr_cheque.to_i + self.pcpr_depotransf.to_i + self.pcpr_otro.to_i
 end

 def self.comprobante(nroplanilla, proveedor, concepto, sucursal)
    @comprobantes = Cabcompra.find(:all, :conditions =>['cabplaegreso_id = ? and proveedor_id = ? and conceptoegreso_id = ? and sucursal_id = ?', "#{nroplanilla}", "#{proveedor}", "#{concepto}", "#{sucursal}"]) 
 end


end
