class Cuentabancaria < ActiveRecord::Base
 belongs_to :plandecuenta
 belongs_to :banco

 validates_presence_of :cban_descripcion

end
