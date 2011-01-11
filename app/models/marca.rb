class Marca < ActiveRecord::Base
 has_many :articulo
 has_many :descrevendedor
end
