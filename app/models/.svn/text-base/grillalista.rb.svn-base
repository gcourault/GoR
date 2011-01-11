class Grillalista < ActiveRecord::Base
belongs_to :listaprecio

#validación de numero de grilla
validates_numericality_of :glis_nrogrilla, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 2, :message => "El nro. de grilla puede ser 1 o 2"  

#validacón de numero de columna
validates_numericality_of :glis_nrocolumna, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 5, :message => "El nro. de columna puede ser del 1 al 5"

#validar que no se repitan las columnas por grilla y articulo
validates_uniqueness_of :glis_nrocolumna,  :scope => [:glis_nrogrilla, :listaprecio_id], :on => :create, :message => "El número de grilla y columna ya existen"

#busca las grillas para actualizar por lotes en la lista de precio
def self.actualizagrilla(id, nrogrilla, nrocolumna)
	@actualizagrilla = Grillalista.find(:all, :conditions => ["listaprecio_id = ? AND glis_nrogrilla = ? AND glis_nrocolumna = ?", "#{id}", "#{nrogrilla}", "#{nrocolumna}"], :readonly => false)
end

end
