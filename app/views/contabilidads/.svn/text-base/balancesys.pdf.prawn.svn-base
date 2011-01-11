pdf.text "Fleming y Martolio SRL" , :size => 16, :style => :bold_italic, :spacing => 6, :align  => :center
pdf.move_down 5
pdf.text  "Balance de Sumas y Saldos", :size => 14, :style => :italic, :spacing => 6, :align  => :center
pdf.move_down 5
pdf.text  "Ejercicio: #{params[:ejerciciodesc]}        Fecha hasta: #{params[:to_time]}", :size => 12, :style => :italic, :spacing => 6, :align  => :center
pdf.move_down 10

 acumdebito = 0
 acumcredito = 0
 acumsaldodeu = 0
 acumsaldoacre = 0

   @plandecuentas = Plandecuenta.find(:all, :conditions => ['pcue_permiteasiento = "Si"'], :order => ['pcue_cuenta, pcue_nivel'])
   @ejerc = Ejercicio.find(params[:ejercicio].to_i) 
     itemscab=  [["Cuenta", "Acumulados", "Saldos"]]
              
                pdf.table itemscab, :position => :center, :width => 550,  
                :column_widths => { 0 => 210, 1 => 170, 2 => 170 }, 
                :font_size => 8,
                :vertical_padding   => 1.5,
                :align => { 0 => :left , 1 => :center , 2 => :center}


       items = @plandecuentas.map do |item|
             @debito = Contabilidad.sumadebito(item.id, @ejerc.ejer_desde, params[:to_time])
             @credito = Contabilidad.sumacredito(item.id, @ejerc.ejer_desde, params[:to_time]) 
             acumdebito = acumdebito +  @debito.to_f 
             acumcredito = acumcredito +  @credito.to_f
             saldo = (@debito.to_f - @credito.to_f.abs)
             acumsaldodeu = (acumsaldodeu + saldo.to_f) if saldo > 0 
             acumsaldoacre = (acumsaldoacre + saldo.to_f) if saldo < 0 
        
                    [item.codigo_nombre,
                     number_to_currency(@debito, :precision => 2, :unit => " ", :separator => ",", :delimiter => "."),
                     number_to_currency(@credito, :precision => 2, :unit => " ", :separator => ",", :delimiter => "."),
                     saldo > 0 ? number_to_currency(saldo, :precision => 2, :unit => " ", :separator => ",", :delimiter => ".") : " ",
                     saldo < 0 ? number_to_currency(saldo, :precision => 2, :unit => " ", :separator => ",", :delimiter => ".") : " "
                    ]
             end
           
                    
               pdf.table items, :border_style => :grid, :position => :center, :width => 550, 
               :row_colors => ["FFFFFF", "EEEEEE"],
               :column_widths => { 0 => 210, 1 => 85, 2 => 85, 3 => 85, 4 => 85}, 
               :headers => [" ", "Debitos", "Creditos ", "Deudor", "Acreedor"], :font_size => 8,
               :vertical_padding   => 1.5,
               :font_size => 8,  
               :align => { 0 => :left , 1 => :right, 2 => :right, 3 => :right, 4 => :right}
    
   itemstot=  [["TOTALES", number_to_currency(acumdebito, :precision => 2, :unit => " ", :separator => ",", :delimiter => "."), number_to_currency(acumcredito, :precision => 2, :unit => " ", :separator => ",", :delimiter => "."),  number_to_currency(acumsaldodeu, :precision => 2, :unit => " ", :separator => ",", :delimiter => "."), number_to_currency(acumsaldoacre, :precision => 2, :unit => " ", :separator => ",", :delimiter => ".")]]
              
                pdf.table itemstot, :position => :center, :width => 550,  
                :column_widths => { 0 => 210, 1 => 85, 2 => 85, 3 => 85, 4 => 85}, 
                :font_size => 8,
                :font_style => :bold,
                :vertical_padding   => 1.5,
                :align => { 0 => :center , 1 => :right , 2 => :right, 3 => :right, 4 => :right}



