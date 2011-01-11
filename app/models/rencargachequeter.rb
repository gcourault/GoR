class Rencargachequeter < ActiveRecord::Base
   belongs_to :cabcargachequeter
   belongs_to :chequetercero , :foreign_key => [ :chequetercero_id , :sucursal_id ]
   belongs_to :banco

   # Sumo los cheques que estan en los renglones

   def self.totalcheques( idcomp , idsuc )
     Rencargachequeter.sum(:cter_importe , :joins => [ "left join chequeterceros on rencargachequeters.chequetercero_id = chequeterceros.id "] , :conditions => ["rencargachequeters.cabcargachequeter_id = ? and rencargachequeters.sucursal_id = ?", idcomp , idsuc] ) 
   end

end

