
class Cabasiento < ActiveRecord::Base
  has_many :renasiento
  belongs_to :cabcaja , :foreign_key => [:cabcaja_id , :sucursal_id]

end
