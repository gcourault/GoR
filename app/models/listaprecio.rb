class Listaprecio < ActiveRecord::Base
  belongs_to :articulo
  belongs_to :maestrolista
  has_many :grillalista
  named_scope :articulosmarcarubro , lambda { |m,r| { :conditions => [ "listaprecio.articulo.marca_id = ? AND listaprecio.articulo.rubro_id = ?" , m , r ] } }
 
#validar que el articulo que se agrega no esta en la lista
validates_uniqueness_of :articulo_id, :scope => :maestrolista_id, :on => :create, :message => "El articulo ya esta en la lista"

#validar ingreso de precio de lista 
validates_numericality_of :lpre_preciolista



#def self.search(maestrolistaid)
def self.search( nrolista, modelo, marcaid, rubroid, maestrolistaid )
	if maestrolistaid 
	@listaprecios = Listaprecio.find(:all, :joins => [:articulo, :maestrolista], :conditions => ["listaprecios.lpre_codigolista = 'T' AND listaprecios.maestrolista_id = ? AND articulos.marca_id = ? AND articulos.rubro_id = ?", "#{maestrolistaid}", "#{marcaid}", "#{rubroid}"], :order => ["articulos.arti_modelo, articulos.arti_medida, articulos.arti_telas"])
    
#@listaprecios = Listaprecio.find_all_by_maestrolista_id(maestrolistaid)
#@listaprecios = Listaprecio.find_by_sql(['SELECT * FROM listaprecios INNER JOIN articulos ON articulos.id = listaprecios.articulo_id INNER JOIN maestrolistas ON maestrolistas.id = listaprecios.maestrolista_id INNER JOIN marcas  ON marcas.id = articulos.marca_id  INNER JOIN rubros  ON rubros.id = articulos.rubro_id  WHERE (articulos.arti_codigolista = "T" AND listaprecios.maestrolista_id = ?)', maestrolistaid ]) 
	else
	@listaprecios = Listaprecio.find_by_sql(['SELECT * FROM listaprecios INNER JOIN articulos ON articulos.id = listaprecios.articulo_id INNER JOIN     marcas  ON marcas.id = articulos.marca_id  INNER JOIN rubros  ON rubros.id = articulos.rubro_id  WHERE (lpre_codigolista = "T" AND lpre_nrolista = ? AND   articulos.arti_modelo LIKE ? AND articulos.marca_id = ? AND articulos.rubro_id = ? ) ORDER BY  articulos.arti_modelo, articulos.arti_medida, articulos.arti_telas', nrolista , "%#{modelo}%" ,  marcaid, rubroid ]) 
        end

	#	@listaprecios = Listaprecio.find_by_sql(['SELECT *, marcas.marc_descripcion AS marca, rubros.rubr_descripcion AS rubro FROM listaprecios INNER JOIN articulos ON articulos.id = listaprecios.articulo_id INNER JOIN marcas  ON marcas.id = articulos.marca_id  INNER JOIN rubros  ON rubros.id = articulos.rubro_id  WHERE (lpre_codigolista = "T" AND listaprecios.maestrolista_id = "11" ) ORDER BY articulos.marca_id, articulos.rubro_id, articulos.arti_modelo, articulos.arti_medida ', maestrolistaid ]) 

#	@listaprecios = Listaprecio.find(:all, :joins => [:articulo, :maestrolista], :conditions => ["listaprecios.lpre_codigolista = 'T' AND listaprecios.maestrolista_id = '11' "], :order => ["articulos.marca_id, articulos.rubro_id, articulos.arti_modelo, articulos.arti_medida"])
end

def self.modelo (modelo, maestrolistaid)
	@listaprecios = Listaprecio.find(:all, :joins => [:articulo, :maestrolista], :conditions => ["listaprecios.lpre_codigolista = 'T' AND listaprecios.maestrolista_id = ? AND articulos.arti_modelo LIKE ?" , "#{maestrolistaid}",  "%#{modelo}%"])
end

#trae todos los articulos de la lista con T o no
def self.searchtodos( nrolista, modelo, marcaid, rubroid, maestrolistaid )
	if maestrolistaid 
	@listaprecios = Listaprecio.find(:all, :joins => [:articulo, :maestrolista], :conditions => ["listaprecios.maestrolista_id = ? AND articulos.marca_id = ? AND articulos.rubro_id = ?", "#{maestrolistaid}", "#{marcaid}", "#{rubroid}"], :order => ["articulos.arti_modelo, articulos.arti_medida, articulos.arti_telas"])
    
        else
	@listaprecios = Listaprecio.find_by_sql(['SELECT * FROM listaprecios INNER JOIN articulos ON articulos.id = listaprecios.articulo_id INNER JOIN     marcas  ON marcas.id = articulos.marca_id  INNER JOIN rubros  ON rubros.id = articulos.rubro_id  WHERE (lpre_nrolista = ? AND   articulos.arti_modelo LIKE ? AND articulos.marca_id = ? AND articulos.rubro_id = ? ) ORDER BY articulos.arti_modelo, articulos.arti_medida ', nrolista , "%#{modelo}%" ,  marcaid, rubroid]) 
     end
end

#trae todos los articulos de la lista con T o no
def self.modelotodos (modelo, maestrolistaid)
	@listaprecios = Listaprecio.find(:all, :joins => [:articulo, :maestrolista], :conditions => ["listaprecios.maestrolista_id = ? AND articulos.arti_modelo LIKE ?" , "#{maestrolistaid}",  "%#{modelo}%"])
end

#actualizar listas por marcas y rubros todos
def self.actualizalista(marcaid, rubroid, maestrolistaid)
	@actualizalista = Listaprecio.find(:all, :joins => [:articulo, :maestrolista], :conditions => ["listaprecios.maestrolista_id = ? AND articulos.marca_id = ? AND articulos.rubro_id = ?", "#{maestrolistaid}", "#{marcaid}", "#{rubroid}"], :readonly => false)
end

def self.xls(nrolista)
	@listaprecios = Listaprecio.find_by_sql(['SELECT * FROM listaprecios INNER JOIN articulos ON articulos.id = listaprecios.articulo_id INNER JOIN     marcas  ON marcas.id = articulos.marca_id  INNER JOIN rubros  ON rubros.id = articulos.rubro_id  WHERE (lpre_codigolista = "T" AND lpre_nrolista = ?) ORDER BY articulos.marca_id, articulos.rubro_id, articulos.arti_modelo, articulos.arti_medida, articulos.arti_telas', nrolista]) 
end

#para el xls de la lista de alliance
def self.xlsalliance(nrolista)
	@listaprecios = Listaprecio.find_by_sql(['SELECT * FROM listaprecios INNER JOIN articulos ON articulos.id = listaprecios.articulo_id INNER JOIN   marcas  ON marcas.id = articulos.marca_id and marcas.id = 3 INNER JOIN rubros  ON rubros.id = articulos.rubro_id  WHERE (lpre_codigolista = "O" AND lpre_nrolista = ?) ORDER BY articulos.marca_id, articulos.rubro_id, articulos.arti_modelo, articulos.arti_medida, articulos.arti_telas', nrolista]) 
end

def self.xlsbkt(nrolista)
	@listaprecios = Listaprecio.find_by_sql(['SELECT * FROM listaprecios INNER JOIN articulos ON articulos.id = listaprecios.articulo_id INNER JOIN   marcas  ON marcas.id = articulos.marca_id and marcas.id = 15 INNER JOIN rubros  ON rubros.id = articulos.rubro_id  WHERE (lpre_codigolista = "O" AND lpre_nrolista = ?) ORDER BY articulos.marca_id, articulos.rubro_id, articulos.arti_modelo, articulos.arti_medida, articulos.arti_telas', nrolista]) 
end



def self.searchalliance( nrolista, modelo, marcaid, rubroid, maestrolistaid )
	if maestrolistaid 
	@listaprecios = Listaprecio.find(:all, :joins => [:articulo, :maestrolista], :conditions => ["listaprecios.lpre_codigolista = 'O' AND listaprecios.maestrolista_id = ? AND articulos.marca_id = ? AND articulos.rubro_id = ?", "#{maestrolistaid}", "#{marcaid}", "#{rubroid}"], :order => ["articulos.arti_modelo, articulos.arti_medida, articulos.arti_telas"])

	else
	@listaprecios = Listaprecio.find_by_sql(['SELECT * FROM listaprecios INNER JOIN articulos ON articulos.id = listaprecios.articulo_id INNER JOIN     marcas  ON marcas.id = articulos.marca_id  INNER JOIN rubros  ON rubros.id = articulos.rubro_id  WHERE (lpre_codigolista = "O" AND lpre_nrolista = ? AND   articulos.arti_modelo LIKE ? AND articulos.marca_id = ? AND articulos.rubro_id = ? ) ORDER BY  articulos.arti_modelo, articulos.arti_medida, articulos.arti_telas', nrolista , "%#{modelo}%" ,  marcaid, rubroid ]) 
        end
end


def self.searchbkt( nrolista, modelo, marcaid, rubroid, maestrolistaid )
	if maestrolistaid 
	@listaprecios = Listaprecio.find(:all, :joins => [:articulo, :maestrolista], :conditions => ["listaprecios.lpre_codigolista = 'O' AND listaprecios.maestrolista_id = ? AND articulos.marca_id = ? AND articulos.rubro_id = ?", "#{maestrolistaid}", "#{marcaid}", "#{rubroid}"], :order => ["articulos.arti_modelo, articulos.arti_medida, articulos.arti_telas"])
	else
	@listaprecios = Listaprecio.find_by_sql(['SELECT * FROM listaprecios INNER JOIN articulos ON articulos.id = listaprecios.articulo_id INNER JOIN     marcas  ON marcas.id = articulos.marca_id  INNER JOIN rubros  ON rubros.id = articulos.rubro_id  WHERE (lpre_codigolista = "O" AND lpre_nrolista = ? AND   articulos.arti_modelo LIKE ? AND articulos.marca_id = ? AND articulos.rubro_id = ? ) ORDER BY  articulos.arti_modelo, articulos.arti_medida, articulos.arti_telas', nrolista , "%#{modelo}%" ,  marcaid, rubroid ]) 
        end
end

end
