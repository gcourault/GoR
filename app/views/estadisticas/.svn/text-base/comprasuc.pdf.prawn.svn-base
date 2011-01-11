pdf.text "Fleming y Martolio SRL" , :size => 22, :style => :bold_italic, :spacing => 6, :align  => :center
pdf.text "Compras de artículos Pirelli por sucursal y rubro" , :size => 18, :style => :bold_italic, :spacing => 6, :align  => :center
pdf.text "En el periodo comprendido entre #{params[:from_time]} y #{params[:to_time]} " , :size => 12, :style => :bold_italic, :spacing => 6, :align  => :center
pdf.move_down 10
grafico = "#{RAILS_ROOT}/public/images/compraagruppdf.jpg"  
pdf.image(grafico)

pdf.move_down 10
@sucursals = Sucursal.find(:all)
@comprasucus = Estadistica.comprasucu(params[:from_time], params[:to_time])
 totaltodas = 0
 if @comprasucus.size > 0 

   for sucu in @sucursals 
        total = 0 
          @comprasucus.each do |comp|
            if (comp.sucursal == sucu.sucu_abreviatura)
              total = total + comp.cantidad.to_i
            end
          end
         
           items= @comprasucus.select{|compra| compra.sucursal == sucu.sucu_abreviatura}.map do |compra|
              [
                compra.sucursal,
                compra.rubro,
                compra.cantidad
              ]
           end 
             if items.size > 0    
                 pdf.table items, :position => :center, :width => 550,  
                :row_colors => ["FFFFFF","EEEEEE"],
                :widths => { 0 => 150, 1 => 300, 2 => 100 }, 
                :headers => ["Sucursal", "Rubro", "Cantidad"], :font_size => 8,
                :vertical_padding   => 1.5,
                :align => { 0 => :left , 1 => :left , 2 => :center }
             end
  if (total > 0)
    pdf.move_down 5
    pdf.text   "Total:  #{total}", :size => 10,  :align => :right
   end
totaltodas = totaltodas + total  
end #sucursal

pdf.text   "Total todas sucursales:  #{totaltodas}", :size => 10,  :align => :right
end #if comprasucu

pdf.move_down 20
pdf.text "Cantidad de atículos Pirelli comprados por rubro en todas las sucursales" , :size => 12, :spacing => 6, :align  => :left
@comprasucuagrups = Estadistica.comprasucuagrup(params[:from_time], params[:to_time])
 if @comprasucuagrups.size > 0 
            items = @comprasucuagrups.map do |item|
                   [
                    item.rubro,
                    item.cantidad
                   ]
                   end
                pdf.table items, :position => :center, :width => 350,  
                :row_colors => ["FFFFFF","EEEEEE"],
                :widths => { 0 => 200, 1 => 100 }, 
                :headers => ["Rubro", "Cantidad"], :font_size => 8,
                :vertical_padding   => 1.5,
                :align => { 0 => :center , 1 => :right }
end
pdf.move_down 5
pdf.text   "Total: #{params[:totalrub]}", :size => 10,  :align => :right




