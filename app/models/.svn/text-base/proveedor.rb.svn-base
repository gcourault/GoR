require 'composite_primary_keys'
class Proveedor < ActiveRecord::Base
   belongs_to :localidad
   belongs_to :tipodocumento
   belongs_to :situacionafip
   set_primary_keys :id, :sucursal_id
   has_many :cabcompra

   validates_format_of  :prov_cuit, :with => /[0-9]{11,11}/, :message => "El número de CUIT debe tener 11 números"

   validates_presence_of :prov_nombre, :prov_calle, :prov_puerta, :prov_cuit, :prov_ingbrutos, :prov_regimenretencion
   validates_numericality_of :localidad_id, :greater_than => 0, :message => "Debe ingresar una localidad"

   validates_uniqueness_of :prov_cuit,  :scope => :sucursal_id, :on => :create, :message => "La CUIT ya esta ingresado."
 
   def validate
       cuit = es_cuit(prov_cuit)
       if cuit
       else
         errors.add(:prov_cuit, "La cuit ingresado no es valido.")
       end
   end

   #metodo para validar una cuit TODO: pasar a una clase donde esten todos los metodos de validacion genericos
   def es_cuit(cuit)
      numero_validador = 54327654321 # orden de los dígitos a multiplicar
      arre_validador = numero_validador.to_s.split('') 
      arre_cuit = cuit.to_s.split('') 
      suma = arre_validador.zip(arre_cuit).inject(0) {|sum, par_ordenado|
      sum += par_ordenado.first.to_i * par_ordenado.second.to_i } #array cada elemento es un array de dos elementos, uno de cada array despues se hace la sumatoria almacenándola en la variable sum, inicializada en 0.
      return suma.multiple_of?(11) # verificamos si la suma es múltiplo de 11
   end


   def cuit_nombre
     self.prov_cuit.to_s + ' - ' + self.prov_nombre
   end

   def nombre_cuit
     self.prov_nombre + ' - ' + self.prov_cuit.to_s
   end

end
