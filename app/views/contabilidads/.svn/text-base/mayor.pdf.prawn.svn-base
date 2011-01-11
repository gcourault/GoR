if !params[:cuenta].nil?
pdf.text "Fleming y Martolio SRL" , :size => 16, :style => :bold_italic, :spacing => 6, :align  => :center
pdf.move_down 5

@cuenta = Plandecuenta.find(params[:cuenta])
pdf.text  "Mayor de la cuenta:  #{@cuenta.nombre_codigo}", :size => 14, :style => :italic, :spacing => 6, :align  => :center
pdf.move_down 5
pdf.text  "Período: #{params[:from_time]} - #{params[:to_time]}", :size => 12, :style => :italic, :spacing => 6, :align  => :center
pdf.move_down 10

 @mayors = Contabilidad.mayor(params[:cuenta], params[:from_time], params[:to_time])
 if params[:saldo].to_s == "Con saldo anterior"
    @fechainiejer = Contabilidad.ejercicio(params[:from_time])
    @saldoants = Contabilidad.saldoant(params[:cuenta], params[:from_time], @fechainiejer.ejer_desde)
 end

 saldo = 0
 sumdebe = 0
 sumhaber = 0
 itemscab=  [["Fecha", "Detalle", "Debe", "Haber", "Saldo", "Asiento"]]
              
                pdf.table itemscab, :position => :center, :width => 550,  
                :column_widths => { 0 => 50, 1 => 230, 2 => 75, 3 => 75, 4 => 75, 5 => 45 }, 
                :font_size => 8,
                :vertical_padding   => 1.5,
                :align => { 0 => :left , 1 => :left , 2 => :center, 3 => :center, 4 => :center, 5 => :right }
            
  if !@saldoants.nil? 
               saldo = @saldoants.to_s.to_d
               itemsaldo = [
                ["Saldo anterior",
                number_to_currency(@saldoants, :precision => 2, :separator => ",", :delimiter => ".", :unit => " ")]
                ]
                pdf.table itemsaldo, :position => :center, :width => 550,  
                :row_colors => ["FFFFFF","EEEEEE"],
                :column_widths => { 0 => 280, 1 => 225, 2 => 45 }, 
                :font_size => 9,
                :font_style => :bold,
                :vertical_padding   => 1.5,
                :align => { 0 => :right , 1 => :right  }

  end 
 if @mayors.size > 0 
       
           items= @mayors.map do |item|
                saldo = saldo + item.rasi_importe.to_s.to_d 
                debe = item.rasi_importe.to_s.to_d > 0 ? item.rasi_importe : " "
                haber= item.rasi_importe.to_s.to_d < 0 ? item.rasi_importe : " "
                sumdebe = (sumdebe + debe.to_s.to_d)
                sumhaber = (sumhaber + haber.to_s.to_d)

              [
                item.cabasiento.casi_fecha,
                item.cabasiento.casi_descripcion,
                number_to_currency(debe, :precision => 2, :separator => ",", :delimiter => ".", :unit => " "),
                number_to_currency(haber, :precision => 2, :separator => ",", :delimiter => ".", :unit => " "),
                number_to_currency(saldo, :precision => 2, :separator => ",", :delimiter => ".", :unit => " "),
                item.cabasiento.id 
                
              ]
           end 
             if items.size > 0    
                 pdf.table items, :position => :center, :width => 550,  
                :row_colors => ["FFFFFF","EEEEEE"],
                :column_widths => { 0 => 50, 1 => 230, 2 => 75, 3 => 75, 4 => 75, 5 => 45 }, 
                :font_size => 8,
                :vertical_padding   => 1.5,
                :align => { 0 => :left , 1 => :left , 2 => :right, 3 => :right, 4 => :right, 5 => :right }
             end
  
 
               itemtotal = [
                ["TOTALES",
  		number_to_currency(sumdebe, :precision => 2, :separator => ",", :delimiter => ".", :unit => " "),
  		number_to_currency(sumhaber, :precision => 2, :separator => ",", :delimiter => ".", :unit => " "),
                number_to_currency(saldo, :precision => 2, :separator => ",", :delimiter => ".", :unit => " ")]
                ]
            
                pdf.table itemtotal, :position => :center, :width => 550,  
                :row_colors => ["FFFFFF","EEEEEE"],
                :column_widths => { 0 => 280, 1 => 75, 2 => 75, 3 => 75, 4 => 45 }, 
                :font_size => 9,  
                :vertical_padding   => 1.5,
                :align => { 0 => :right , 1 => :right, 2 => :right, 3 => :right},
	        :style => :bold
                
 end
end
