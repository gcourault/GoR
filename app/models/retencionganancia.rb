class Retencionganancia < ActiveRecord::Base
 set_primary_keys :id, :sucursal_id
 has_many :cabcompras

end
