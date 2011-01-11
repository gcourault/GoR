require 'composite_primary_keys'
class Cabfactura < ActiveRecord::Base
 set_primary_keys :id, :sucursal_id
 belongs_to :revendedor, :foreign_key => [:revendedor_id, :sucursal_id]
 belongs_to :vendedor
 belongs_to :cliente, :foreign_key => [:cliente_id, :sucursal_id]
 belongs_to :tipocomprobante
 belongs_to :jurisdiccion
 has_many :chequetercero
 has_many :renfactura
 belongs_to :condicionpago
end
