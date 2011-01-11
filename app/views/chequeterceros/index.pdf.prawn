logo = "#{RAILS_ROOT}/public/images/logo.jpg"  
pdf.image(logo, :scale => 0.5, :align => :left, :at => [5, 770])
pdf.text "Fleming y Martolio SRL" , :size => 22, :style => :bold_italic, :spacing => 6, :align  => :center, :at => [150,750]
pdf.text  "Listado de cheques en cartera ", :size => 14, :style => :italic, :spacing => 6, :align  => :center, :at => [170,720]
pdf.text  "(Listado de uso interno) ", :size => 10, :style => :italic, :spacing => 6, :align  => :center, :at => [370,720]
pdf.text  "Fecha de vencimiento mayor igual a : #{params[:fechavenc]} y monto mayor o igual a $#{params[:monto]}", :size => 10, :style => :italic, :spacing => 6, :align  => :center, :at => [170,700]
 pdf.move_down 80
     if @chequetercerospdf.size > 0 
        items = @chequetercerospdf.map do |item|
           [     
            " #{item.cter_cuitlibrador} - #{item.razonsocial}",              
            "#{item.localidad} - #{item.provincia}",
             item.cantidad,
             number_with_delimiter(item.importe, :precision => 2, :separator => ",", :delimiter => ".")  
           ]
           end
         pdf.table items, :border_style => :grid, :position => :center, :width => 550, :border_color => 'FFFFFF',
         :row_colors => ["FFFFFF","EEEEEE"],
         :column_widths => { 0 => 270, 1 => 175, 2 => 30, 3 => 75}, 
         :vertical_padding   => 1.5,
         :headers => [ "CUIT - Razón Social", "Localidad - Provincia",  "Cant", "Monto"], :font_size => 8,
         :align => { 0 => :left , 1 => :left , 2 => :left, 3 => :left}
     end 

