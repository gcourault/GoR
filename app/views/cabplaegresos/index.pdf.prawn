pdf.text "Fleming y Martolio SRL" , :size => 16, :style => :bold_italic, :spacing => 6, :align  => :center
pdf.move_down 3
pdf.text "Planilla de egreso Nro.: #{params[:nrope]}           Fecha: #{params[:fecha]}" , :size => 12, :style => :bold_italic, :spacing => 6, :align  => :center
pdf.move_down 3
pdf.text "Sucursal: #{params[:sucu]}               Caja de ingreso: #{params[:caja]}" , :size => 12, :style => :bold_italic, :spacing => 6, :align  => :center
pdf.move_down 10

@renplaegresos = Renplaegreso.find(:all, :conditions => ["cabplaegreso_id = ? and sucursal_id = ?", params[:idpe].to_i, session[:sucursal]], :order => 'id DESC')
importe = 0
 if @renplaegresos.size > 0 
   @renplaegresos.each do |r|
     importe = importe + r.rpeg_importe.to_f
   end    
           items= @renplaegresos.map do |item|
              [
                item.conceptoegreso.cegr_detalle,
                number_to_currency(item.rpeg_importe, :precision => 2, :separator => ",", :delimiter => ".")
              ]
          
           end 
             if items.size > 0    
                 pdf.table items, :position => :center, :width => 550,  
                :row_colors => ["FFFFFF","EEEEEE"],
                :column_widths => { 0 => 430, 1 => 120 }, 
                :headers => ["CONCEPTO", "IMPORTE"], :font_size => 8, :style => :bold,
                :vertical_padding   => 1.5,
                :align => { 0 => :left , 1 => :center }
             end
 if (importe > 0)
     pdf.move_down 5
    #end # if para las 03
    pdf.text   "TOTAL:  #{number_to_currency(importe, :precision => 2, :separator => ",", :delimiter => ".")}", :size => 9,  :align => :right, :style => :bold
 end 
end

