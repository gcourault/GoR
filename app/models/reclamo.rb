class Reclamo < ActiveRecord::Base
 belongs_to :articulo
 belongs_to :sucursal
 belongs_to :cliente
 validates_presence_of :recl_estado, :recl_fecha, :recl_nrointerno, :sucursal_id, :recl_codip, :recl_motivo, :articulo_id, :recl_nombrecliente, :recl_documento
  
 def self.search( nroint, cliente, sucursal, anio)

	if (sucursal != "Seleccione una sucursal" && anio != "Seleccione un año")
          @reclamo = Reclamo.find(:all, :joins => [:sucursal], :conditions => ["recl_nrointerno LIKE ?  AND (reclamos.recl_nombrecliente LIKE ? OR reclamos.recl_nombrecliente IS NULL)  AND reclamos.sucursal_id = ? AND YEAR(reclamos.recl_fecha) = ?",  "#{nroint}%" , "#{cliente}%" , "#{sucursal}", "#{anio}"], :order => "recl_nrointerno" )
          return @reclamo
        end
	if (sucursal != "Seleccione una sucursal" && anio == "Seleccione un año")
          @reclamo = Reclamo.find(:all, :joins => [:sucursal], :conditions => ["recl_nrointerno LIKE ?  AND (reclamos.recl_nombrecliente LIKE ? OR reclamos.recl_nombrecliente IS NULL)  AND reclamos.sucursal_id = ?",  "#{nroint}%" , "#{cliente}%" , "#{sucursal}"], :order => "recl_nrointerno" )
          return @reclamo
        end
        if (sucursal == "Seleccione una sucursal" && anio != "Seleccione un año")
          @reclamo = Reclamo.find(:all, :joins => [:sucursal], :conditions => ["recl_nrointerno LIKE ?  AND (reclamos.recl_nombrecliente LIKE ? OR reclamos.recl_nombrecliente IS NULL)  AND  YEAR(reclamos.recl_fecha) = ?",  "#{nroint}%" , "#{cliente}%" , "#{anio}"], :order => "recl_nrointerno" )
          return @reclamo
        end
        if (sucursal == "Seleccione una sucursal" && anio == "Seleccione un año")
	  @reclamo = Reclamo.find(:all)
          return @reclamo
        end
	
 end

end


