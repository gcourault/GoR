require 'composite_primary_keys'
class Cabcaja < ActiveRecord::Base
 belongs_to :sucursal
 belongs_to :vendedor
 belongs_to :chequetercero
 has_many :cabasiento
 has_many :cabplaegreso



 has_many :cabasiento

 set_primary_keys :id, :sucursal_id

 def self.cajas()

   @cajas = Cabcaja.find(:all, :joins => 'left join cabasientos on cabasientos.cabcaja_id=cabcajas.id and cabasientos.sucursal_id=cabcajas.sucursal_id', :conditions => ["ccaj_cerrada = 'S' and ccaj_importar = 'Si' and cabasientos.cabcaja_id is null"] , :order => ["ccaj_nrocaja"])

 end

end
