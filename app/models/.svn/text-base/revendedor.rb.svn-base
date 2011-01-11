require 'composite_primary_keys'
class Revendedor < ActiveRecord::Base
 set_primary_keys :id, :sucursal_id
 belongs_to :sucursal
 belongs_to :vendedor
 has_many :cabfactura
end
