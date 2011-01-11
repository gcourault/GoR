class Tipocomprobante < ActiveRecord::Base
has_many :cabcompra
has_many :cabfactura
has_many :cabrecibo

def numero_nombre
   self.tcom_codigo.to_s + ' - ' + self.tcom_nombre
end


end
