require 'composite_primary_keys'
class Cabrecibo < ActiveRecord::Base
  set_primary_keys :id, :sucursal_id 
  belongs_to :cliente
  belongs_to :tipocomprobante
  has_many :chequetercero
end
