class Banco < ActiveRecord::Base
has_many :chequetercero
has_many :listadocaucion
has_many :cuentabancaria

  
   def cod_nombre
     self.banc_codigo.to_s + ' - ' + self.banc_nombre
   end
end
