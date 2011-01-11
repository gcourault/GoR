class Articulo < ActiveRecord::Base
  belongs_to :rubro
  belongs_to :marca
 # belongs_to :proveedor
  belongs_to :alicuotaiva
  has_many :listaprecio
  has_many :reclamo
  has_many :renfactura
  has_many :renpedidoweb
  belongs_to :consignatario
 # belongs_to_enum :articulo, { 'C' => :C, 'I' => :I, 'T' => :T}
  validates_presence_of :arti_codigo, :arti_descripcion
  validates_uniqueness_of :arti_codigo,  :on => :create

validates_numericality_of :consignatario_id, :greater_than => 0,  :message => "Si es por cuenta y orden debe seleccionar un consignatario", :if => Proc.new { |articulo| articulo.arti_ventactaord.to_s == "S" }

def self.search(modelo, medida, marcaid, rubroid)
	@articulos = Articulo.find(:all, :joins => [:marca, :rubro], :conditions => ["marcas.marc_codigo = ? AND rubros.rubr_codigo = ?",  "#{marcaid}", "#{rubroid}"], :order => ["articulos.arti_modelo, articulos.arti_medida"])
end

def self.modelo(modelo, medida)
	@articulos = Articulo.find(:all, :conditions => ["articulos.arti_modelo LIKE ? AND articulos.arti_medida LIKE ?", "%#{modelo}%", "%#{medida}%"], :order => ["articulos.arti_modelo, articulos.arti_medida"])
end

end
