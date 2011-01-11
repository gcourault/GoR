if (params[:nrolista].nil? || params[:nrolista].empty?)
  params[:nrolista] = Listaprecio.maximum(:lpre_nrolista)
end 

logo = "#{RAILS_ROOT}/public/images/logo.jpg"  
pdf.image(logo, :scale => 0.5, :align => :left, :at => [5, 700])
pdf.text "Fleming y Martolio SRL" , :size => 22, :style => :bold_italic, :spacing => 6, :align  => :center, :at => [150,690]
pdf.text  "Lista de precios Alliance nro: #{params[:nrolista]}", :size => 14, :style => :italic, :spacing => 6, :align  => :center, :at => [170,660]

@maestro = Maestrolista.find_by_mlis_nrolista(params[:nrolista])
if @maestro.nil?
   else
if @maestro.mlis_vigencia.to_date.nil?
   else
   anio = @maestro.mlis_vigencia.to_date.year
   mes = @maestro.mlis_vigencia.to_date.month
   dia = @maestro.mlis_vigencia.to_date.day
   pdf.font "Helvetica"
  
end
end
pdf.move_down 60


@marcas = Marca.find(:all, :conditions => ['id = 3'], :order => ['marc_codigo']) 
@rubros = Rubro.find(:all, :order => ['rubr_codigo']) 
  pdf.footer [pdf.margin_box.left, pdf.margin_box.bottom + 150] do
	# pdf.stroke_horizontal_rule
	
	if ("#{pdf.page_count.to_s}".to_i < 10)
         pag = "#{pdf.page_count}".to_i 
         nose = "#{pag.to_s}a.jpg"
         stef = "#{RAILS_ROOT}/public/images/#{nose}"  
         pdf.image(stef, :scale => 0.95, :align => :right)
       end
    pdf.text "Pagina: #{pdf.page_count.to_s}", :size => 6, :align => :right
  end
                                   
  pdf.bounding_box [pdf.bounds.left, pdf.bounds.top], :width  => pdf.bounds.width, :height => pdf.bounds.height - 150 do  
   if "#{pdf.page_count.to_s}".to_i < 2 
     pdf.move_down 60
   end  
   for marca in @marcas 
     params[:marcaid] = marca.id
       for rubro in @rubros
            params[:rubroid] = rubro.id 
      	     @listaprecios = Listaprecio.searchalliance(params[:nrolista] , params[:modelo],  params[:marcaid],  params[:rubroid], params[:maestrolistaid]) 
              if @listaprecios.size > 0 
                   pdf.move_down 70
                
                           

                   pdf.table [["Marca: #{marca.marc_descripcion} Rubro: #{rubro.rubr_descripcion}"]], :width => 480, :position => :center, 
                   :font_size => 16,
                   :style => :bold,
                   :border_style => :grid,
                   :border_color => 'FFFFFF',
                   :align => :left

      	    pdf.move_down 20
 
                   itemscab= [[" ", "Dimension", " "]]
                   pdf.table itemscab, :position => :center, :width => 550,  
                   :column_widths => { 0 => 300, 1 => 80, 2 => 170 }, 
                   :font_size => 10,
                   :vertical_padding   => 1.5,
                   :align => { 0 => :left , 1 => :center , 2 => :center}          
            
                   items = @listaprecios.map do |item|
                   [
                    item.articulo.arti_clavesecundaria, 
                    item.articulo.arti_modelo,
                    item.articulo.arti_medida,
                    item.articulo.arti_ancho,
                    item.articulo.arti_diametro,
                    item.articulo.arti_aro,
                    item.articulo.arti_conosincamara,
                    item.articulo.arti_telas,
                    number_to_currency(item.lpre_precioventa.round(0), :precision => 2, :separator => ",", :delimiter => ".") 
                   ]
                   end
                pdf.table items, :border_style => :grid, :position => :center, :width => 550, 
                :row_colors => ["FFFFFF","EEEEEE"],
                :column_widths  => { 0 => 60, 1 => 100, 2 => 140, 3=> 40, 4 => 40, 5 => 45, 6 => 25, 7 => 35, 8 => 65 }, 
                :vertical_padding   => 1.5,
                :headers => ["Codigo","Modelo", "Medida", "Ancho", "Diam", "Aro", " ", "Telas", "Precio"], :font_size => 9.5,
                :align => { 0 => :left , 1 => :left , 2 => :left, 3 => :left, 4 => :left, 5 => :left, 6 => :left, 7 => :left, 8 => :right}
              end 
       end
   end
  end


