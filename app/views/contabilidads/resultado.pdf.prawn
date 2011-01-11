pdf.text "Fleming y Martolio SRL" , :size => 16, :style => :bold_italic, :spacing => 6, :align  => :center
pdf.move_down 5
pdf.text  "Estado de resultado", :size => 14, :style => :italic, :spacing => 6, :align  => :center
pdf.move_down 5
pdf.text  "Ejercicio: #{params[:ejerciciodesc]}        Período: #{params[:from_time]} - #{params[:to_time]}", :size => 12, :style => :italic, :spacing => 6, :align  => :center
pdf.move_down 20

blanco=" "
acumtotal = 0
@niveles = ["1", "2", "3", "4", "5"] 
if params[:todascuentas].to_s == "Cuentas con movimientos"
 @ejrcic = Ejercicio.find(params[:ejercicio])
 @plandecuentas = Contabilidad.conmovimientonaturaleza(params[:from_time], params[:to_time], params[:naturaleza])
else
  @plandecuentas = Plandecuenta.find(:all, :conditions => ['pcue_naturaleza like ?', params[:naturaleza]], :order => ['pcue_cuenta, pcue_nivel'])
end
  @plandecuentas.each do |pcuen| 
     
            for nivel in @niveles 
             
              if  pcuen.pcue_nivel.to_s == nivel.to_s 
               @acumcuenta = 0                
               if pcuen.pcue_nivel.to_s == @niveles[0].to_s 
                 @pcuenta = Plandecuenta.find(:all, :conditions => ['id = ?', pcuen.id ])
                 @acumcuenta = Contabilidad.sumacuenta(pcuen.pcue_cuenta, (pcuen.pcue_cuenta.to_i + params[:cuentanivel1].to_i), params[:from_time], params[:to_time])
                acumtotal = acumtotal + @acumcuenta.to_f
                 items = @pcuenta.map do |item|
                    [ item.codigo_nombre,
                     blanco,
                     blanco,
                     blanco,
                     blanco,
                     number_to_currency( @acumcuenta, :precision => 2, :unit => " ", :separator => ",", :delimiter => "."),
                    ]
                   end
           
                    
                pdf.table items, :border_style => :grid, :position => :center, :width => 550, 
                :row_colors => ["EEEEEE"],
                :column_widths => { 0 => 220, 1 => 66, 2 => 66, 3 => 66, 4 => 66, 5 => 66}, 
                :vertical_padding   => 1.5,
                :font_size => 8,  
                :align => { 0 => :left , 1 => :left , 2 => :left, 3 => :left, 4 => :left,  5 => :right}
           
                        
               elsif pcuen.pcue_nivel.to_s == @niveles[1].to_s 
                 @pcuenta = Plandecuenta.find(:all, :conditions => ['id = ?', pcuen.id ])
                 @acumcuenta = Contabilidad.sumacuenta(pcuen.pcue_cuenta, (pcuen.pcue_cuenta.to_i + params[:cuentanivel2].to_i), params[:from_time], params[:to_time])
                
                   items = @pcuenta.map do |item|
                    [ item.codigo_nombre,
                     blanco,
                     blanco,
                     blanco,
   		     number_to_currency( @acumcuenta, :precision => 2, :unit => " ", :separator => ",", :delimiter => "."),
                     blanco
                  
                    ]
                   end
                
                    
               pdf.table items, :border_style => :grid, :position => :center, :width => 550, 
                :row_colors => ["FFFFFF","EEEEEE"],
                :column_widths => { 0 => 220, 1 => 66, 2 => 66, 3 => 66, 4 => 66, 5 => 66},  
                :vertical_padding   => 1.5,
                :font_size => 8, 
                :align => { 0 => :left , 1 => :left , 2 => :left, 3 => :left, 4 => :right,  5 => :right}
            
           
                elsif pcuen.pcue_nivel.to_s == @niveles[2].to_s 
                 @pcuenta = Plandecuenta.find(:all, :conditions => ['id = ?', pcuen.id ])
                 @acumcuenta = Contabilidad.sumacuenta(pcuen.pcue_cuenta, (pcuen.pcue_cuenta.to_i + params[:cuentanivel3].to_i), params[:from_time], params[:to_time])
               
                   items = @pcuenta.map do |item|
                    [ item.codigo_nombre,
                     blanco,
                     blanco,
                     number_to_currency( @acumcuenta, :precision => 2, :unit => " ", :separator => ",", :delimiter => "."),
		     blanco,
                     blanco
                     ]
                   end
             
                    
               pdf.table items, :border_style => :grid, :position => :center, :width => 550, 
                :row_colors => ["FFFFFF","EEEEEE"],
                :column_widths => { 0 => 220, 1 => 66, 2 => 66, 3 => 66, 4 => 66, 5 => 66}, 
                :vertical_padding   => 1.5,
                :font_size => 8,
                :align => { 0 => :left , 1 => :left , 2 => :left, 3 => :right, 4 => :left,  5 => :right}
             
          
              elsif pcuen.pcue_nivel.to_s == @niveles[3].to_s 
                 @pcuenta = Plandecuenta.find(:all, :conditions => ['id = ?', pcuen.id ])
                 @acumcuenta = Contabilidad.sumacuenta(pcuen.pcue_cuenta, (pcuen.pcue_cuenta.to_i + params[:cuentanivel4].to_i), params[:from_time], params[:to_time])
                
                   items = @pcuenta.map do |item|
                    [ item.codigo_nombre,
                     blanco,
                     number_to_currency( @acumcuenta, :precision => 2, :unit => " ", :separator => ",", :delimiter => "."),
                     blanco,
		     blanco,
                     blanco
                     ]
                   end
              
                    
               pdf.table items, :border_style => :grid, :position => :center, :width => 550, 
                :row_colors => ["FFFFFF","EEEEEE"],
                :column_widths => { 0 => 220, 1 => 66, 2 => 66, 3 => 66, 4 => 66, 5 => 66}, 
                :vertical_padding   => 1.5,
                :font_size => 8,
                :align => { 0 => :left , 1 => :left , 2 => :right, 3 => :left, 4 => :left,  5 => :right}
         
        
             elsif pcuen.pcue_nivel.to_s == @niveles[4].to_s 
                 @pcuenta = Plandecuenta.find(:all, :conditions => ['id = ?', pcuen.id ])
                 @acumcuenta = Contabilidad.sumacuenta(pcuen.pcue_cuenta, (pcuen.pcue_cuenta.to_i + params[:cuentanivel5].to_i), params[:from_time], params[:to_time])
                
                   items = @pcuenta.map do |item|
                    [ item.codigo_nombre,
                     number_to_currency( @acumcuenta, :precision => 2, :unit => " ", :separator => ",", :delimiter => "."),
                     blanco,
                     blanco,
		     blanco,
                     blanco
                     ]
                   end
             
                    
               pdf.table items, :border_style => :grid, :position => :center, :width => 550, 
                :row_colors => ["FFFFFF","EEEEEE"],
                :column_widths => { 0 => 220, 1 => 66, 2 => 66, 3 => 66, 4 => 66, 5 => 66}, 
                :vertical_padding   => 1.5,
                :font_size => 8,
                :align => { 0 => :left , 1 => :right , 2 => :left, 3 => :left, 4 => :left,  5 => :right}
              end 
         end
end
end



pdf.move_down 10
pdf.text  "TOTAL:                                                                              #{number_to_currency(acumtotal, :precision => 2, :unit => " ", :separator => ",", :delimiter => ".")}", :size => 10, :style => :italic, :spacing => 6, :align  => :right

