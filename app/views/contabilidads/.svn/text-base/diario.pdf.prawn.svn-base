
pdf.text "Fleming y Martolio SRL" , :size => 16, :style => :bold_italic, :spacing => 6, :align  => :center
pdf.move_down 5

pdf.text  "Libro diario (borrador)", :size => 14, :style => :italic, :spacing => 6, :align  => :center
pdf.move_down 5
pdf.text  "Período: #{params[:from_time]} - #{params[:to_time]}", :size => 12, :style => :italic, :spacing => 6, :align  => :center
pdf.move_down 10

  @asientos = Contabilidad.librodiario(params[:from_time], params[:to_time])

       if @asientos.size > 0 
         @asientos.map do |item|
           items=              
              [["Nro: #{item.id}",
                "Fecha: #{item.casi_fecha}",
                "Descripción: #{item.casi_descripcion}"
              ]]
            
              pdf.table items, :position => :center, :width => 550,  
                :column_widths => { 0 => 100, 1 => 100, 2 => 350}, 
                :font_size => 9,
                :vertical_padding   => 1.5,
                :align => { 0 => :left , 1 => :left , 2 => :left }

               @renglon = Contabilidad.renasiento(item.id)
                 totaldebe = 0 
                 totalhaber = 0 
            rengs= @renglon.map do |reng|
              debe = reng.rasi_importe.to_s.to_d > 0 ? reng.rasi_importe : " "
              haber= reng.rasi_importe.to_s.to_d < 0 ? reng.rasi_importe : " "
              totaldebe = totaldebe + debe.to_s.to_d
              totalhaber = totalhaber + haber.to_s.to_d
    
              [
                reng.cabasiento.id ,
                reng.plandecuenta.codigo_nombre,
                number_to_currency(debe, :precision => 2, :separator => ",", :delimiter => ".", :unit => " "),
                number_to_currency(haber, :precision => 2, :separator => ",", :delimiter => ".", :unit => " ") 
          
              ]
           end 
             
               
                 pdf.table rengs, :position => :center, :width => 550,  
                :row_colors => ["FFFFFF","EEEEEE"],
                :column_widths => { 0 => 40, 1 => 310, 2 => 100, 3 => 100 }, 
                :headers => ["Nro", "Cuenta", "Debe ", "Haber"], :font_size => 8,
                :vertical_padding   => 1.5,
                :align => { 0 => :left , 1 => :left , 2 => :right, 3 => :right }
          
          subtotal=              
              [[" ",
                " ",
                totaldebe,
                totalhaber.abs
              ]]
            
              pdf.table subtotal, :position => :center, :width => 550,  
                 :column_widths => { 0 => 40, 1 => 310, 2 => 100, 3 => 100 }, 
                :font_size => 9,
                :vertical_padding   => 1.5,
               :align => { 0 => :left , 1 => :left , 2 => :right, 3 => :right }
          
     end
end

