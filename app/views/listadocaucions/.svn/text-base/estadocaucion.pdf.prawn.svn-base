pdf.text "Fleming y Martolio SRL" , :size => 16, :style => :bold_italic, :spacing => 6, :align  => :center
pdf.text "Caución" , :size => 14, :style => :bold_italic, :spacing => 6, :align  => :center

pdf.move_down 10
pdf.table [["SALDO CONTABLE                                    #{params[:saldoinicio]}"]], :width => 560, :position => :center,    
       :font_size => 10,
       :style => :bold,
       :row_colors => ["EEEEEE"],
       :border_style => :grid,
       :border_color => 'FFFFFF',
       :align => :left
pdf.text   "#{params[:saldocont1]}", :size => 10,  :align => :right

pdf.move_down 10
pdf.text "Valores Presentados:" , :size => 10, :spacing => 6, :align  => :left
@listadoscaucions = Listadocaucion.listadoscaucion(params[:from_time], params[:to_time])
 if @listadoscaucions.size > 0 
            items = @listadoscaucions.map do |item|
                   [
                    item.id,
                    item.lcau_fecha,
                    number_to_currency(item.lcau_importetotal, :precision => 2, :separator => ",", :delimiter => ".")
                   ]
                   end
                 pdf.table items, :position => :center, :width => 300,  :border_color => 'FFFFFF',
                :widths => { 0 => 100, 1 => 100, 2 => 100 }, 
                :headers => ["Nro. listado", "Fecha", "Importe"], :font_size => 8,
                :vertical_padding   => 1.5,
                :align => { 0 => :center , 1 => :center , 2 => :right }


pdf.text   "#{params[:totalpres]}", :size => 10,  :align => :right
end
pdf.move_down 10

pdf.text "Valores Depositados:" , :size => 10, :spacing => 6, :align  => :left
params[:fecha] =  params[:from_time].to_date - 20.days
@ajustemanualinis = Listadocaucion.ajustemanualini(params[:from_time], params[:fecha]) if params[:fecha]
 if @ajustemanualinis.size > 0 
     items = @ajustemanualinis.map do |item|
                   [
                    item.devc_detalle,
                    item.devc_fecha,
		    number_to_currency(item.devc_importe, :precision => 2, :separator => ",", :delimiter => ".")
                   ]
                   end
                 pdf.table items, :position => :right, :width => 400,  :border_color => 'FFFFFF', :font_size => 8,
                :widths => { 0 => 200 , 1 => 100, 2 => 100 }, 
                :vertical_padding   => 1.5,
                :align => { 0 => :right , 1 => :center, 2 => :right }  


 end
@valorcaucions = Listadocaucion.valorescaucion(params[:from_time], params[:to_time])
 if @valorcaucions.size > 0 
            items = @valorcaucions.map do |item|
                   [
                    item.fechavenc,
                    number_to_currency(item.importe, :precision => 2, :separator => ",", :delimiter => ".")
                   ]
                   end
                 pdf.table items, :position => :center, :width => 300,  :border_color => 'FFFFFF',
                :widths => { 0 => 150, 1 => 150}, 
                :headers => ["Fecha vencimiento", "Importe"], :font_size => 8,
                :vertical_padding   => 1.5,
                :align => { 0 => :center , 1 => :right }


pdf.text   "-#{params[:totalpendientetodo]}", :size => 10,  :align => :right
end
pdf.move_down 10
pdf.text "Valores Reingresados:" , :size => 10, :spacing => 6, :align  => :left
@valorreingresados = Listadocaucion.valoresreingresado(params[:from_time], params[:to_time])
 if @valorreingresados.size > 0 
            items = @valorreingresados.map do |item|
                   [
                    item.devc_detalle,
                    item.devc_fecha,
                    number_to_currency(item.devc_importe, :precision => 2, :separator => ",", :delimiter => ".")
                   ]
                   end
                 pdf.table items, :position => :center, :width => 400,  :border_color => 'FFFFFF',
                :widths => { 0 => 150, 1 => 100, 2 => 150 }, 
                :headers => ["Detalle", "Fecha", "Importe"], :font_size => 8,
                :vertical_padding   => 1.5,
                :align => { 0 => :right , 1 => :center , 2 => :right }

pdf.text   "-#{params[:totalreing]}", :size => 10,  :align => :right
end


@ajustemanualdgs = Listadocaucion.ajustemanualdg(params[:from_time], params[:to_time])
 if @ajustemanualdgs.size > 0 
pdf.text "Ajustes Deposito Caución:" , :size => 10, :spacing => 6, :align  => :left
            items = @ajustemanualdgs.map do |item|
                   [
                    item.devc_detalle,
                    item.devc_fecha,
                    number_to_currency( item.devc_importe, :precision => 2, :separator => ",", :delimiter => ".")
                   ]
                   end
                 pdf.table items, :position => :center, :width => 400,  :border_color => 'FFFFFF',
                :widths => { 0 => 150, 1 => 100, 2 => 150 }, 
                :headers => ["Detalle", "Fecha", "Importe"], :font_size => 8,
                :vertical_padding   => 1.5,
                :align => { 0 => :right , 1 => :center , 2 => :right }

pdf.text   "#{params[:totalajusdg]}", :size => 10,  :align => :right
end

pdf.move_down 10
pdf.table [["SALDO CONTABLE                                    #{params[:to_time]}"]], :width => 560, :position => :center,    
       :font_size => 10,
       :style => :bold,
       :row_colors => ["EEEEEE"],
       :border_style => :grid,
       :border_color => 'FFFFFF',
       :align => :left

pdf.text   "#{params[:saldocont2]}", :size => 10,  :align => :right, :style => :bold

pdf.move_down 10
pdf.text   "Ajustes", :size => 10,  :align => :left
@ajustes = Listadocaucion.ajuste(params[:from_time], params[:to_time])
 if @ajustes.size > 0 
     items = @ajustes.map do |item|
                   [
                    item.lcau_fecha,
                    item.lisb_fecha,
		    item.listadocaucion_id,
                    number_to_currency( item.lcau_importetotal, :precision => 2, :separator => ",", :delimiter => ".")
                   ]
                   end
                 pdf.table items, :position => :right, :width => 400,  :border_color => 'FFFFFF',
                :widths => { 0 => 100 , 1 => 100, 2 => 100, 3 => 100 }, 
                :headers => ["Valores entregados al", "procesados al", "(listado)", "Importe"], :font_size => 8,
                :vertical_padding   => 1.5,
                :align => { 0 => :right , 1 => :center , 2 => :center, 3 => :right }  

pdf.text   "-#{params[:valorajuste]}", :size => 10,  :align => :right
 end

@ajustemanuals = Listadocaucion.ajustemanual(params[:from_time], params[:to_time])
 if @ajustemanuals.size > 0 
     items = @ajustemanuals.map do |item|
                   [
                    item.devc_detalle,
                    item.devc_fecha,
		    number_to_currency(item.devc_importe, :precision => 2, :separator => ",", :delimiter => ".")
                   ]
                   end
                 pdf.table items, :position => :right, :width => 400,  :border_color => 'FFFFFF', :font_size => 8,
                :widths => { 0 => 200 , 1 => 100, 2 => 100 }, 
                :vertical_padding   => 1.5,
                :align => { 0 => :right , 1 => :center, 2 => :right }  

pdf.text   "#{params[:valorajustemanual]}", :size => 10,  :align => :right
 end
@ajustereingresobancos = Listadocaucion.ajustereingresobanco(params[:from_time], params[:to_time])
 if @ajustereingresobancos.size > 0 
     items = @ajustereingresobancos.map do |item|
                   [
                    item.devc_detalle,
                    item.devc_fecha,
		    number_to_currency(item.devc_importe, :precision => 2, :separator => ",", :delimiter => ".") 
                   ]
                   end
                 pdf.table items, :position => :right, :width => 400,  :border_color => 'FFFFFF', :font_size => 8,
                :widths => { 0 => 200 , 1 => 100, 2 => 100 }, 
                :vertical_padding   => 1.5,
                :align => { 0 => :right , 1 => :center, 2 => :right }  

pdf.text   "#{params[:valorajusreing]}", :size => 10,  :align => :right
end


pdf.move_down 10
pdf.table [["SALDO s/BANCO                                   #{params[:to_time]}"]], :width => 560, :position => :center,    
       :font_size => 10,
       :style => :bold,
       :row_colors => ["EEEEEE"],
       :border_style => :grid,
       :border_color => 'FFFFFF',
       :align => :left
pdf.text   "#{params[:saldocont3]}", :size => 10,  :align => :right, :style => :bold
#:column_font_sizes => { 0 => 8, 2 => 12 } 
