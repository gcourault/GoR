require 'composite_primary_keys'
class Rencompra < ActiveRecord::Base
 set_primary_keys :id, :sucursal_id
 belongs_to :alicuotaiva
 belongs_to :cabcompra
end
