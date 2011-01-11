pdf.text "Fleming y Martolio SRL" , :size => 18, :style => :bold_italic, :spacing => 6, :align  => :center
pdf.move_down 3
pdf.text "Comprobantes de la planilla de egreso Nro. #{params[:nrope]}" , :size => 14, :style => :bold_italic, :spacing => 6, :align  => :center

pdf.move_down 10

@cabcompras = Cabcompra.find(:all, :conditions => ["cabplaegreso_id = ? and sucursal_id = ?", params[:idpe].to_i, session[:sucursal]], :order => 'id DESC')
 if @cabcompras.size > 0 
       
           items= @cabcompras.map do |item|
              [
                item.ccom_puntosventa,
                item.ccom_desdecompro,
                item.ccom_fecha,
                item.tipocomprobante.tcom_nombre,
                item.proveedor.prov_nombre,
                item.conceptoegreso.cegr_detalle,
                number_to_currency(item.ccom_total, :precision => 2, :separator => ",", :delimiter => ".")
              ]
           end 
             if items.size > 0    
                 pdf.table items, :position => :center, :width => 550,  
                :row_colors => ["FFFFFF","EEEEEE"],
                :column_widths => { 0 => 30, 1 => 40, 2 => 70, 3 => 70, 4 => 130, 5 => 130, 6 => 80 }, 
                :headers => ["Pto venta", "Comprob", "Fecha ", "Tipo", "Proveedor", "Concepto", "Importe "], :font_size => 8,
                :vertical_padding   => 1.5,
                :align => { 0 => :left , 1 => :left , 2 => :center }
             end
  
end

