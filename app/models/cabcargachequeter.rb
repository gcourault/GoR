class Cabcargachequeter < ActiveRecord::Base
 has_many :rencargachequeter

 validates_numericality_of :ccht_total

 validates_each :ccht_fecha do |record, attr,value|
   if $idanterior > 0
      database_record = Cabcargachequeter.find_by_id($idanterior)
      record.errors.add(attr,"La fecha del nuevo comprobante debe ser mayor o igual a la fecha del ultimo comprobante") if (value.to_date < database_record.ccht_fecha.to_date)
   end
 end

end
