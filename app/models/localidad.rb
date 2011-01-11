class Localidad < ActiveRecord::Base
 has_many :proveedor
 has_many :cliente
 belongs_to :provincia
def nombre_prov
   self.loca_nombre + ' - ' + self.provincia.pcia_nombre.to_s + ' - ' + self.loca_codigopostal.to_s
end
end
