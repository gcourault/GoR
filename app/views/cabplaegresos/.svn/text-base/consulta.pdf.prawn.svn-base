pdf.text "Fleming y Martolio SRL" , :size => 22, :style => :bold_italic, :spacing => 6, :align  => :center
pdf.move_down 3
pdf.text " Resumen de Compras/Gastos" , :size => 18, :style => :bold_italic, :spacing => 6, :align  => :center
pdf.move_down 3
pdf.text "En el periodo comprendido entre #{params[:from_time]} y #{params[:to_time]} " , :size => 12, :style => :bold_italic, :spacing => 6, :align  => :center
sucu = Sucursal.find(params[:sucursal])

pdf.text "corresponiente a la sucursal: #{sucu.sucu_nombre}"  , :size => 12, :style => :bold_italic, :spacing => 6, :align  => :center

pdf.move_down 10

@consultas = Cabplaegreso.consulta(params[:from_time], params[:to_time],  params[:proveedor], params[:conceptoegreso], params[:sucursal])
 if @consultas.size > 0 
       
           items= @consultas.map do |item|
              [
                item.nrope,
                item.comprobante,
                item.nombre,
                item.concepto,
	        number_to_currency(item.importe, :precision => 2, :separator => ",", :delimiter => ".")
              ]
           end 
             if items.size > 0    
                 pdf.table items, :position => :center, :width => 550,  
                :row_colors => ["FFFFFF","EEEEEE"],
                :widths => { 0 => 150, 1 => 300, 2 => 100 }, 
                :headers => ["Nº plaeg", "Nº comprob", "Proveedor", "Concepto", "Importe"], :font_size => 8,
                :vertical_padding   => 1.5,
                :align => { 0 => :left , 1 => :left , 2 => :center }
             end
  if (params[:total].to_d > 0)
    pdf.move_down 5
    pdf.text   "Total:  #{number_to_currency(params[:total], :precision => 2, :separator => ",", :delimiter => ".")}", :size => 10,  :align => :right
   end
end

