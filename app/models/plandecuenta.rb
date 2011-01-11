class Plandecuenta < ActiveRecord::Base
 has_many :cuentabancaria
 has_many :conceptoegreso
 has_many :cuentacaja
 has_many :formapago
 belongs_to :sucursal
 has_many :renasiento

 validates_format_of  :pcue_cuenta, :with => /[0-9]{9,9}/, :message => "El número de la cuenta debe tener 9 digitos"
 validates_presence_of :pcue_descripcion, :pcue_cuenta
 validates_uniqueness_of :pcue_cuenta

   def codigo_nombre
     self.pcue_cuenta.to_s + ' - ' + self.pcue_descripcion.to_s
   end

   def nombre_codigo
    self.pcue_descripcion.to_s.lstrip.rstrip   + ' - ' + self.pcue_cuenta.to_s 
   end

end
