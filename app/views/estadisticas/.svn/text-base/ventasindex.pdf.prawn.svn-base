pdf.text "Fleming y Martolio SRL" , :size => 22, :style => :bold_italic, :spacing => 6, :align  => :center
if (params[:tipo].to_i == 3)
pdf.text "Ventas 03 de artículos Pirelli por sucursal y rubro" , :size => 18, :style => :bold_italic, :spacing => 6, :align  => :center
else
pdf.text "Ventas de artículos Pirelli por sucursal y rubro" , :size => 18, :style => :bold_italic, :spacing => 6, :align  => :center
end
pdf.text "En el periodo comprendido entre #{params[:from_time]} y #{params[:to_time]} " , :size => 12, :style => :bold_italic, :spacing => 6, :align  => :center
pdf.move_down 10
if (params[:tipo].to_i == 3)
grafico = "#{RAILS_ROOT}/public/images/ventarubropdf03.jpg"  
pdf.image(grafico, :position => :center)
else
grafico = "#{RAILS_ROOT}/public/images/ventarubropdf.jpg"  
grafico1 = "#{RAILS_ROOT}/public/images/ventarubroimppdf.jpg" 
pdf.image(grafico, :position => :center)

pdf.image(grafico1, :position => :center)
end


pdf.move_down 10

if (params[:tipo].to_i == 3)
@ventasbs = Estadistica.ventasb03(params[:from_time], params[:to_time])

else
#@sucursales = Sucursal.find(:all)
@ventasbs = Estadistica.ventasb(params[:from_time], params[:to_time])
end
 totaltodas = 0
 totalimptodas = 0
 if @ventasbs.size > 0 
  sucu = []
    @ventasbs.each do |v|
       sucu <<  v.sucursal
    end
    @sucursales = sucu.uniq
   for sucu in @sucursales 
        total = 0 
        importe = 0
          @ventasbs.each do |vent|
            if (vent.sucursal == sucu)
              total = total + vent.cantidad.to_i
              importe = importe + vent.monto.to_d  if (params[:tipo].to_i == 0)
            end
          end
          # if sucu.id == 1 || sucu.id == 2 || sucu.id == 4 || sucu.id == 10
            if (params[:tipo].to_i == 0)
                  items= @ventasbs.select{|venta| venta.sucursal == sucu}.map do |venta|

                   [
                    venta.sucursal,
                    venta.rubro,
                    venta.cantidad,
                    number_to_currency(venta.monto, :precision => 2, :separator => ",", :delimiter => ".")
	           ]
                  end 
                      pdf.table items, :position => :center, :width => 550,  
                :row_colors => ["FFFFFF","EEEEEE"],
                :widths => { 0 => 150, 1 => 300, 2 => 100 }, 
                :headers => ["Sucursal", "Rubro", "Cantidad", "Importe"], :font_size => 8,
                :vertical_padding   => 1.5,
                :align => { 0 => :left , 1 => :left , 2 => :center }
              else
               items= @ventasbs.select{|venta| venta.sucursal == sucu}.map do |venta|
                  [
                     venta.sucursal,
                     venta.rubro,
                     venta.cantidad
                 ]
                    end 
       
               
                 pdf.table items, :position => :center, :width => 550,  
                :row_colors => ["FFFFFF","EEEEEE"],
                :widths => { 0 => 150, 1 => 300, 2 => 100 }, 
                :headers => ["Sucursal", "Rubro", "Cantidad"], :font_size => 8,
                :vertical_padding   => 1.5,
                :align => { 0 => :left , 1 => :left , 2 => :center }
             end
  if (importe > 0)
     pdf.move_down 5
    #end # if para las 03
    pdf.text   "TOTAL:  Cantidad: #{total}, Importe:  #{number_to_currency(importe, :precision => 2, :separator => ",", :delimiter => ".")}", :size => 10,  :align => :right
     totaltodas = totaltodas + total 
     totalimptodas = totalimptodas + importe 
    else
     if (total > 0)
       pdf.move_down 5
       #end # if para las 03
       pdf.text   "Total:  #{total}", :size => 10,  :align => :right
     end
     totaltodas = totaltodas + total  
  end
 end #sucursal
pdf.move_down 5
if (totalimptodas > 0)
  pdf.text   "TOTAL todas sucursales: Cantidas: #{totaltodas}, Importe: #{number_to_currency(totalimptodas, :precision => 2, :separator => ",", :delimiter => ".")}", :size => 10,  :align => :right
else
  pdf.text   "Total todas sucursales:  #{totaltodas}", :size => 10,  :align => :right
end
end #if comprasucu

pdf.move_down 20
pdf.text "Cantidad de atículos Pirelli vendidos por rubro en todas las sucursales" , :size => 12, :spacing => 6, :align  => :left
if (params[:tipo].to_i == 3)
@ventasagruprubros = Estadistica.ventasagruprubro03(params[:from_time], params[:to_time])
@ventasagruprubrocps = Estadistica.ventasagruprubrocp03(params[:from_time], params[:to_time])
else
@ventasagruprubros = Estadistica.ventasagruprubro(params[:from_time], params[:to_time])
@ventasagruprubrocps = Estadistica.ventasagruprubrocp(params[:from_time], params[:to_time])
end
 if (params[:tipo].to_i == 0)
  if @ventasagruprubros.size > 0 
            items = @ventasagruprubros.map do |item|
                   [
                    item.rubro,
                    item.totalrubros,
                    number_to_currency(item.totalmontos, :precision => 2, :separator => ",", :delimiter => ".")
                   ]
                   end
                 pdf.table items, :position => :center, :width => 350,  
                :row_colors => ["FFFFFF","EEEEEE"],
                :widths => { 0 => 200, 1 => 100 }, 
                :headers => ["Rubro", "Cantidad", "Importe"], :font_size => 8,
                :vertical_padding   => 1.5,
                :align => { 0 => :center , 1 => :right, 2 => :right }
  end
  else
   if @ventasagruprubros.size > 0 
            items = @ventasagruprubros.map do |item|
                   [
                    item.rubro,
                    item.totalrubros
                   ]
                   end
                 pdf.table items, :position => :center, :width => 350,  
                :row_colors => ["FFFFFF","EEEEEE"],
                :widths => { 0 => 200, 1 => 100 }, 
                :headers => ["Rubro", "Cantidad"], :font_size => 8,
                :vertical_padding   => 1.5,
                :align => { 0 => :center , 1 => :right }
  end
end
 pdf.move_down 5
if (params[:totalrubimp].to_i > 0)
pdf.text   "Total cubiertas: Cantidad: #{params[:totalrub]}, Importe: #{number_to_currency(params[:totalrubimp], :precision => 2, :separator => ",", :delimiter => ".")}", :size => 10,  :align => :right
else
pdf.text   "Total cubiertas: #{params[:totalrub]}", :size => 10,  :align => :right
end
 if (params[:tipo].to_i == 0)
   if @ventasagruprubrocps.size > 0 
            items = @ventasagruprubrocps.map do |item|
                   [
                    item.rubro,
                    item.totalrubros,
		    item.totalmontos
                   ]
                   end
                 pdf.table items, :position => :center, :width => 350,  
                :row_colors => ["FFFFFF","EEEEEE"],
                :widths => { 0 => 200, 1 => 100 }, 
                :headers => ["Rubro", "Cantidad", "Importe"], :font_size => 8,
                :vertical_padding   => 1.5,
                :align => { 0 => :center , 1 => :right, 2 => :right }
   end
   else
   if @ventasagruprubrocps.size > 0 
            items = @ventasagruprubrocps.map do |item|
                   [
                    item.rubro,
                    item.totalrubros
                   ]
                   end
                 pdf.table items, :position => :center, :width => 350,  
                :row_colors => ["FFFFFF","EEEEEE"],
                :widths => { 0 => 200, 1 => 100 }, 
                :headers => ["Rubro", "Cantidad"], :font_size => 8,
                :vertical_padding   => 1.5,
                :align => { 0 => :center , 1 => :right }
   end
end
 pdf.move_down 5
if (params[:totalrubcpimp].to_i > 0)
pdf.text   "Total camaras/protectores: Cantidad: #{params[:totalrubcp]}, Importe: #{number_to_currency(params[:totalrubcpimp], :precision => 2, :separator => ",", :delimiter => ".")}", :size => 10,  :align => :right
else
pdf.text   "Total camaras/protectores: #{params[:totalrubcp]}", :size => 10,  :align => :right
end



