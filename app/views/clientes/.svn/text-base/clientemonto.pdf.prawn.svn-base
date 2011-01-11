pdf.text "Fleming y Martolio SRL" , :size => 14, :style => :bold_italic, :spacing => 6, :align  => :center
pdf.move_down 3
pdf.text "Cartera de clientes que compran más de #{params[:monto]}" , :size => 12, :style => :bold_italic, :spacing => 6, :align  => :center
pdf.move_down 3
@sucu = Sucursal.find(params[:sucursal])
pdf.text "Sucursal #{@sucu.sucu_nombre} en el periodo del  #{params[:from_time]} al  #{params[:to_time]}" , :size => 12, :style => :bold_italic, :spacing => 6, :align  => :center
pdf.move_down 10

@clientepormontos = Cliente.clientepormonto(params[:monto], params[:sucursal], params[:from_time], params[:to_time])
 if @clientepormontos.size > 0 
       
           items= @clientepormontos.map do |item|
              [
                item.clie_razonsocial,
                item.clie_cuit,
                item.cantidad,
                number_to_currency(item.monto, :precision => 2, :separator => ",", :delimiter => ".")
              ]
           end 
             if items.size > 0    
                 pdf.table items, :position => :center, :width => 550,  
                :row_colors => ["FFFFFF","EEEEEE"],
                :column_widths => { 0 => 350, 1 => 50, 2 => 50, 3 => 100 }, 
                :headers => ["Razón social", "CUIT", "Unidades", "Importe"], :font_size => 8,
                :vertical_padding   => 1.5,
                :align => { 0 => :left , 1 => :left , 2 => :center }
             end
  
end

