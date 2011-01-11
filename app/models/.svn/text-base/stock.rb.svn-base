class Stock < ActiveRecord::Base
 
  def self.search(marcacod, rubrocod, codigo)
   @articulos = Articulo.find(:all, :joins => [:marca, :rubro], :conditions => ['arti_codigo = ? and marcas.marc_codigo = ? and rubros.rubr_codigo = ?',codigo, marcacod, rubrocod], :order => ["arti_modelo, arti_medida"])
  end

 def self.buscapormodelo(modelo, medida)
   @articulos = Articulo.find(:all, :conditions => ['arti_modelo LIKE ? and arti_medida  LIKE ? ', "%#{modelo}%", "%#{medida}%"], :order => ["arti_modelo, arti_medida"])
 end 
 
 def self.traeunidades(arti)
   @stocks = Sucursal.find_by_sql(['select s.sucu_nombre as nombresucu, st.stoc_actual as unidades from stock as st, sucursal as s
                                    where st.id_sucursal = s.id_sucursal and st.id_articulo = ?',  arti])
 end
end
