if (params[:sucursal].nil? || params[:sucursal].empty?)
  params[:sucursal] = 1
end 
if (params[:anio].nil? || params[:anio].empty?)
  params[:anio] = "2010"
end 
pdf.text  "Listado de reclamos sucursal #{params[:sucursal]}, año #{params[:anio]} ", :size => 14, :style => :italic, :spacing => 6, :align  => :center
pdf.move_down 20
@reclamos = Reclamo.search( params[:nroprt] , params[:cliente], params[:sucursal], params[:anio] )

if @reclamos.size > 0 
 items = @reclamos.map do |item|
                   [
                    item.recl_nombrecliente,
                    item.recl_notacredito,
                    item.recl_descripcionprod,
                    item.recl_estado,
                    item.recl_bonificacion,
                    item.recl_nroprt,
                    item.recl_fecha,
                    item.recl_nrointerno
                   ]
                   end
                 pdf.table items, :position => :center, :width => 550,  
                :row_colors => ["FFFFFF","EEEEEE"],
                :widths => { 0 => 100, 1 => 50, 2 => 150, 3 => 50, 4 => 50, 5 => 50, 6 => 50, 7 => 50 }, 
                :headers => ["Cliente", "Nota credito", "Artículo", "Estado", "Bonificación", "Nro PRT", "Fecha", "Nro Interno"], :font_size => 8,
                :vertical_padding   => 1.5,
                :align => { 0 => :center , 1 => :center, 2 => :center, 3 => :center, 4 => :center, 5 => :center, 6 => :center, 7 => :center }
end
