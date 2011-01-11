if (params[:nrolista] == '0')
  params[:nrolistanro] = "En elaboración"
 else 
  params[:nrolistanro] =  params[:nrolista].to_s
end 
logo = "#{RAILS_ROOT}/public/images/logo.jpg"  
pdf.image(logo, :scale => 0.5, :align => :left, :at => [5, 770])
pdf.text "Fleming y Martolio SRL" , :size => 22, :style => :bold_italic, :spacing => 6, :align  => :center, :at => [150,750]
pdf.text  "Lista de precios nro: #{params[:nrolistanro]}", :size => 14, :style => :italic, :spacing => 6, :align  => :center, :at => [170,720]

@maestro = Maestrolista.find_by_mlis_nrolista(params[:nrolista])
if @maestro.nil?
 if (params[:nrolista] == 0)
   else
     if @maestro.mlis_vigencia.to_date.nil?
     else
     anio = @maestro.mlis_vigencia.to_date.year
     mes = @maestro.mlis_vigencia.to_date.month
     dia = @maestro.mlis_vigencia.to_date.day
     pdf.font "Helvetica"
     pdf.text "Fecha de vigencia: #{dia}/#{mes}/#{anio}", :padding => 5, :at => [360,710] 
    end
 end
end
pdf.move_down 80
@marcas = Marca.find(:all) 
@rubros = Rubro.find(:all) 
  pdf.footer [pdf.margin_box.left, pdf.margin_box.bottom + 90] do
	# pdf.stroke_horizontal_rule
	
	if "#{pdf.page_count.to_s}".to_i < 17 
         nose = "#{pdf.page_count.to_s}.jpg"
         stef = "#{RAILS_ROOT}/public/images/#{nose}"  
         pdf.image(stef, :scale => 0.95, :align => :right)
       end
    pdf.text "Pagina: #{pdf.page_count.to_s}", :size => 6, :align => :right
  end
                                   
  pdf.bounding_box [pdf.bounds.left, pdf.bounds.top], :width  => pdf.bounds.width, :height => pdf.bounds.height - 95 do  
   if "#{pdf.page_count.to_s}".to_i < 2 
     pdf.move_down 80
   end  
   for marca in @marcas 
     params[:marcaid] = marca.id
       for rubro in @rubros
            params[:rubroid] = rubro.id 
      	     @listaprecios = Listaprecio.search(params[:nrolista] , params[:modelo],  params[:marcaid],  params[:rubroid], params[:maestrolistaid]) 
              if @listaprecios.size > 0 
                   pdf.move_down 10
                   pdf.table [["Marca: #{marca.marc_descripcion} Rubro: #{rubro.rubr_descripcion}"]], :width => 480, :position => :center, 
                   :font_size => 12,
                   :style => :bold,
                   :border_style => :grid,
                   :border_color => 'FFFFFF',
                   :align => :left
           	                      
                   items = @listaprecios.map do |item|
                   [
                    "#{item.articulo.marca.marc_codigo} - #{item.articulo.rubro.rubr_codigo} - #{item.articulo.arti_codigo}", 
                    item.articulo.arti_modelo,
                    item.articulo.arti_medida,
                    item.articulo.arti_conosincamara,
                    item.articulo.arti_telas,
                    item.lpre_precioventa.round(0)
                   ]
                   end
                pdf.table items, :border_style => :grid, :position => :center, :width => 480, 
                :row_colors => ["FFFFFF","EEEEEE"],
                :widths => { 0 => 50, 1 => 100, 2 => 150, 3 => 100, 4 => 80 }, 
                :vertical_padding   => 1.5,
                :headers => ["Codigo","Modelo", "Medida"," ", "Telas", "Precio"], :font_size => 8,
                :align => { 0 => :left , 1 => :left , 2 => :left, 3 => :left, 4 => :left,  5 => :right}
              end 
       end
   end
  end


