class Tipodocumento < ActiveRecord::Base
 has_many :proveedor
 has_many :cliente
end
