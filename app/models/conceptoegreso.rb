class Conceptoegreso < ActiveRecord::Base
 has_many :cabcompra
 belongs_to :plandecuenta
 validates_uniqueness_of :cegr_codigo
 has_many :renplaegreso
 
end
