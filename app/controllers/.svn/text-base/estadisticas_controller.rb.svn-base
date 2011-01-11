# require 'gruff'

#gema para expotar a excel
require 'spreadsheet/excel'
include Spreadsheet

class EstadisticasController < ApplicationController
   before_filter :login_required
   access_control  [:index, :costoventa, :grafico, :fechas, :comprasuc, :rubrosucu, :graficocompras, :comprasuc, :comprasucu, :graficoventas, :ventasmonto, :ventastipo, :graficotarjeta, :graficotarjetasucu, :tarjeta, :xlscosto, :comprasucuval] => '(rol 3 | rol 5 | rol 6 | rol 7 )'
 def permission_denied
    flash[:notice] = "Usted no tiene los privilegios para realizar esta acción." 
    return redirect_to(:controller => 'login', :action => 'denied')
 end

  def grafico
    g = Gruff::Bar.new('600x450') # Define a custom size
    gi = Gruff::Bar.new('600x450') 
    g3 = Gruff::Bar.new('700x500') 
    gt = Gruff::Bar.new('700x500') 
    gpdf = Gruff::Bar.new('460x310') 
    gpdfi = Gruff::Bar.new('460x310') 
    gpdf03 = Gruff::Bar.new('500x350') 

    g.sort = false # Do NOT sort data based on values
    g.maximum_value = 1000 # Declare a max value for the Y axis
    g.minimum_value = 0 # Declare a min value for the Y axis

    gi.sort = false # Do NOT sort data based on values

    g3.sort = false 
    g3.maximum_value = 500 
    g3.minimum_value = 0 

    gt.sort = false 
    gt.maximum_value = 1000 
    gt.minimum_value = 0 
   
    gpdf.sort = false 
    gpdf.maximum_value = 1000 
    gpdf.minimum_value = 0
   
    gpdfi.sort = false 

    gpdf03.sort = false 
    gpdf03.maximum_value = 1000 
    gpdf03.minimum_value = 0
    # g.theme_37signals # Declare a theme from the presets available
    # g.theme = {:colors => ['#7F0099', '#2F85ED', '#2FED09','#EC962F'], :marker_color => '#aaa', :background_colors => ['#E8E8E8','#B9FD6C'] }
    # g.theme = {:colors => ['#8A0808', '#08088A', '#088A08','#D7DF01', '#2E9AFE', '#F3F781', '#F5D0A9'], :background_colors => ['#FFFFFF','#E0ECF8']}
    g.theme = {:colors => ['#FF4500', '#FFA500', '#FFFF66','#339933', '#0066FF', '#0000FF', '#CC00FF'], :marker_color => '#FFFFFF', :background_colors => ['#000000', '#FFFFFF']}
    g.font_color = '#FFFFFF'

    gi.theme = {:colors => ['#FF4500', '#FFA500', '#FFFF66','#339933', '#0066FF', '#0000FF', '#CC00FF'], :marker_color => '#FFFFFF', :background_colors => ['#000000', '#FFFFFF']}
    gi.font_color = '#FFFFFF'
    
    g3.theme = {:colors => ['#FF4500', '#FFA500', '#FFFF66','#339933', '#0066FF', '#0000FF', '#CC00FF'], :marker_color => '#FFFFFF', :background_colors => ['#000000', '#FFFFFF']}
    g3.font_color = '#FFFFFF'
   
    gt.theme = {:colors => ['#FF4500', '#FFA500', '#FFFF66','#339933', '#0066FF', '#0000FF', '#CC00FF'], :marker_color => '#FFFFFF', :background_colors => ['#000000', '#FFFFFF']}
    gt.font_color = '#FFFFFF'
   
    gpdf.theme = {:colors => ['#E6E6E6', '#DDDDDD', '#A4A4A4','#6E6E6E', '#1C1C1C'], :marker_color => '#000000', :background_colors => ['#FFFFFF', '#FFFFFF']}
    gpdf.font_color = '#000000'

    gpdfi.theme = {:colors => ['#E6E6E6', '#DDDDDD', '#A4A4A4','#6E6E6E', '#1C1C1C'], :marker_color => '#000000', :background_colors => ['#FFFFFF', '#FFFFFF']}
    gpdfi.font_color = '#000000'

    gpdf03.theme = {:colors => ['#E6E6E6', '#DDDDDD', '#A4A4A4','#6E6E6E', '#1C1C1C'], :marker_color => '#000000', :background_colors => ['#FFFFFF', '#FFFFFF']}
    gpdf03.font_color = '#000000'

    g.title_font_size = 20
    g.legend_box_size = 6
    g.legend_font_size = 12
    g.marker_font_size = 12
   # g.hide_legend = 'True'

    gi.title_font_size = 20
    gi.legend_box_size = 6
    gi.legend_font_size = 12
    gi.marker_font_size = 12
 
    g3.title_font_size = 20
    g3.legend_box_size = 6
    g3.legend_font_size = 12
    g3.marker_font_size = 12

    gt.title_font_size = 20
    gt.legend_box_size = 6
    gt.legend_font_size = 12
    gt.marker_font_size = 12

    gpdf.title_font_size = 16
    gpdf.legend_box_size = 6
    gpdf.legend_font_size = 12
    gpdf.marker_font_size = 12
    
    gpdfi.title_font_size = 16
    gpdfi.legend_box_size = 6
    gpdfi.legend_font_size = 12
    gpdfi.marker_font_size = 12
    
    gpdf03.title_font_size = 20
    gpdf03.legend_box_size = 6
    gpdf03.legend_font_size = 12
    gpdf03.marker_font_size = 12

    g.title = 'Total cubiertas Pirelli vendidas por rubro'
    @ventasagruprubros.each {|ventasagruprubros| g.data(ventasagruprubros.rubro, [ventasagruprubros.totalrubros.to_i])}
    g.write('public/images/ventarubro.png')
    
    gi.title = 'Importe de cubiertas Pirelli vendidas por rubro'
    @ventasagruprubros.each {|ventasagruprubros| gi.data(ventasagruprubros.rubro, [ventasagruprubros.totalmontos.to_d])}
    gi.write('public/images/ventarubroimp.png')

    g3.title = 'Total cubiertas Pirelli vendidas por rubro (tipo 03)'
    @ventasagruprubros03.each {|ventasagruprubros| g3.data(ventasagruprubros.rubro, [ventasagruprubros.totalrubros.to_i])}
    g3.write('public/images/ventarubro03.png')
    
    gpdf.title = 'Total cubiertas Pirelli vendidas por rubro'
    @ventasagruprubros.each {|ventasagruprubros| gpdf.data(ventasagruprubros.rubro, [ventasagruprubros.totalrubros.to_i])}
    gpdf.write('public/images/ventarubropdf.jpg')

    gpdfi.title = 'Importe de cubiertas Pirelli vendidas por rubro'
    @ventasagruprubros.each {|ventasagruprubros| gpdfi.data(ventasagruprubros.rubro, [ventasagruprubros.totalmontos.to_d])}
    gpdfi.write('public/images/ventarubroimppdf.jpg')

    gpdf03.title = 'Total cubiertas Pirelli vendidas 03 por rubro'
    @ventasagruprubros03.each {|ventasagruprubros03| gpdf03.data(ventasagruprubros03.rubro, [ventasagruprubros03.totalrubros.to_i])}
    gpdf03.write('public/images/ventarubropdf03.jpg')

    gt.title = 'Total cubiertas Pirelli vendidas por rubro (incluye tipo 03)'
      #para camaras y protectores 
      idrc = []
      @ventasagruprubrototalcps.each do |v|
         idrc <<  v.idr.to_i
      end
      @idrcs = idrc.uniq

      idr = []
      @ventasagruprubrototals.each do |v|
         idr <<  v.idr.to_i
      end
      @idrs = idr.uniq
      @idrs.each do |idrub|
      cant = 0
      rubro = " "
        @ventasagruprubrototals.each do |vent| 
           if (idrub == vent.idr.to_i)
             rubro = vent.rubro
             cant = cant + vent.totalrubros.to_i
           end
         end
       gt.data(rubro, cant)
      end
     
     # @ventasagruprubrototals.each {|ventasagruprubros| gt.data(ventasagruprubros.rubro, [ventasagruprubros.totalrubros.to_i])}
     gt.write('public/images/ventarubrot.png')
     # g.labels = {0 => 'Last year', 1 => 'This year', 2 => 'Next year'} # Define labels for each of the "columns" in data
     # g.write('public/images/'+file_name+'.png') 
  end

  def fechas
    if params[:fechadesde].blank?
      else
        params[:fechadesde] = convierte_fecha(params[:fechadesde])
    end
    if params[:fechahasta].blank?
     else
       params[:fechahasta] = convierte_fecha(params[:fechahasta])
    end
  end
  
  # GET /estadisticas
  # GET /estadisticas.xml
  def index
    fechas()
    #params[:tipo] = params[:tipo].to_s.to_i
    @ventasbs =  Estadistica.ventasb(params[:fechadesde], params[:fechahasta]) 
    @ventasbs03 =  Estadistica.ventasb03(params[:fechadesde], params[:fechahasta])
    @ventasbtotales =  Estadistica.ventasbtotale(params[:fechadesde], params[:fechahasta])
    @ventasagruprubros =  Estadistica.ventasagruprubro(params[:fechadesde], params[:fechahasta])
    @ventasagruprubrocps =  Estadistica.ventasagruprubrocp(params[:fechadesde], params[:fechahasta])
    @ventasagruprubros03 =  Estadistica.ventasagruprubro03(params[:fechadesde], params[:fechahasta])
    @ventasagruprubroscp03 =  Estadistica.ventasagruprubrocp03(params[:fechadesde], params[:fechahasta])
    @ventasagruprubrototals =  Estadistica.ventasagruprubrototal(params[:fechadesde], params[:fechahasta])
    @ventasagruprubrototalcps =  Estadistica.ventasagruprubrototalcp(params[:fechadesde], params[:fechahasta])
    grafico()
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ventasbs }
    end
  end

  #metodo para el costo de las ventas
  def costoventa
    fechas()
    @costoventas =  Estadistica.costoventa(params[:fechadesde], params[:fechahasta])
    @costoventas03 =  Estadistica.costoventa03(params[:nrolista],params[:fechadesde], params[:fechahasta])
    @costoventaspen03 =  Estadistica.costoventapen03(params[:nrolista],params[:fechadesde], params[:fechahasta])
    @costoventauds =  Estadistica.costoventaud(params[:nrolista], params[:fechadesde], params[:fechahasta])
     respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @costoventas }
    end
  end
  
  #exportar a excel los costos
  def xlscosto
      #genera el xls
      @sucursals = Sucursal.find(:all)
    
      workbook = Excel.new('public/xls/lista_costos.xls')
      # Añadimos hoja LISTA
      hoja_costos = workbook.add_worksheet("Costo")
      f1 = workbook.add_format(:color=>"blue", :bold=>1, :italic=>true)
      f2 = workbook.add_format(:color=>"blue", :bold=>1, :italic=>true,  :size => 18, :font =>'Lucida Calligraphy') 
      f3 = workbook.add_format(:num_format => '$#,##0.00', :italic=>true, :bold=>1)
      f4 = workbook.add_format(:num_format => '$#,##0.00', :color=>"blue", :bold=>1, :italic=>true)
      hoja_costos.write(1,0,'Listado de unidades y costo por articulos entre el '+params[:fechadesde].to_s+' y el '+params[:fechahasta].to_s+' Nro. lista: '+params[:nrolista].to_s+'',f2)
      # Fila de cabecera
      @cabecera = %w(Sucursal Marca Rubro Articulo Unidades Costo)
      columna = 0
      @cabecera.each do |cab|
        hoja_costos.write(3,columna,cab,f1)
        columna += 1
      end
      # Una fila para cada items
         fila = 4
         @costoventas =  Estadistica.costoventa(params[:fechadesde], params[:fechahasta])  
         @costoventas03 =  Estadistica.costoventa03(params[:nrolista], params[:fechadesde], params[:fechahasta])  
         @costoventaspen03 =  Estadistica.costoventapen03(params[:nrolista], params[:fechadesde], params[:fechahasta])  
       
            totaltodas = 0 
            totaltodascosto = 0 
            totaltodas03 = 0 
            totaltodascosto03 = 0 
            totaltodaspen03 = 0 
            totaltodascostopen03 = 0 
            for sucu in @sucursals
              if @costoventas.size > 0
              total = 0
              totalcosto = 0
            #  totalcostopen = 0          
               for c in @costoventas
                # Añado la fila con los datos en sus respectivas columnas
                 if c.sucursal == sucu.sucu_abreviatura
                  hoja_costos.write(fila,0,c.sucursal)
                  hoja_costos.write(fila,1,c.marca)
                  hoja_costos.write(fila,2,c.rubro)
                  hoja_costos.write(fila,3,c.arti)
                  hoja_costos.write(fila,4,c.totalarti)
                  hoja_costos.write(fila,5,c.totalcosto,f3)
                  total = total + c.totalarti.to_i 
    		  totalcosto = totalcosto + c.totalcosto.to_d 
                  # Pasamos a la siguiente empiesa en una nueva fila
                  fila += 1
                 end #end if
                end #end for
                if (total > 0) 
                  hoja_costos.write(fila,3,'Total por sucursal unidades y costos:',f1)
                  hoja_costos.write(fila,4,total,f1)
                  hoja_costos.write(fila,5,totalcosto,f4)
                  fila += 1
               end # end if
               totaltodas = totaltodas + total
               totaltodascosto = totaltodascosto + totalcosto 
               end # end if costo>0
               # desde aca para 03
               total03 = 0
               totalcosto03 = 0
               if @costoventas03.size > 0
                for c3 in @costoventas03
                 # Añado la fila con los datos en sus respectivas columnas
                  if c3.sucursal == sucu.sucu_abreviatura
                   hoja_costos.write(fila,0,c3.sucursal)
                   hoja_costos.write(fila,1,c3.marca)
                   hoja_costos.write(fila,2,c3.rubro)
                   hoja_costos.write(fila,3,c3.arti)
                   hoja_costos.write(fila,4,c3.totalarti)
                   hoja_costos.write(fila,5,c3.totalcosto,f3)
                   total03 = total03 + c3.totalarti.to_i 
    		   totalcosto03 = totalcosto03 + c3.totalcosto.to_d 
                   fila += 1
                  end # end if sucu ==
                 end # end for 03
                 if (total03 > 0) 
                   hoja_costos.write(fila,3,'Total por sucursal unidades y costos 03:',f1)
                   hoja_costos.write(fila,4,total03,f1)
                   hoja_costos.write(fila,5,totalcosto03,f4)
                   fila += 1
                end # end if
                totaltodas03 = totaltodas03 + total03
                totaltodascosto03 = totaltodascosto03 + totalcosto03 
             end # end if 03

  # desde aca para 03 pendientes
               totalpen03 = 0
               totalcostopen03 = 0
               if @costoventaspen03.size > 0
                 for cp3 in @costoventaspen03
                 # Añado la fila con los datos en sus respectivas columnas
                  if cp3.sucursal == sucu.sucu_abreviatura
                   hoja_costos.write(fila,0,cp3.sucursal)
                   hoja_costos.write(fila,1,cp3.marca)
                   hoja_costos.write(fila,2,cp3.rubro)
                   hoja_costos.write(fila,3,cp3.arti)
                   hoja_costos.write(fila,4,cp3.totalarti)
                   hoja_costos.write(fila,5,cp3.totalcosto,f3)
                   totalpen03 = totalpen03 + cp3.totalarti.to_i 
    		   totalcostopen03 = totalcostopen03 + cp3.totalcosto.to_d 
                   fila += 1
                  end # end if sucu ==
                 end # end for 03 pen
                 if (totalpen03 > 0) 
                   hoja_costos.write(fila,3,'Total por sucursal unidades y costos 03 pendientes:',f1)
                   hoja_costos.write(fila,4,totalpen03,f1)
                   hoja_costos.write(fila,5,totalcostopen03,f4)
                   fila += 1
                end # end if
                totaltodaspen03 = totaltodaspen03 + totalpen03
                totaltodascostopen03 = totaltodascostopen03 + totalcostopen03 
             end # end if 03 pen
            end #end for sucu
               fila += 1
               hoja_costos.write(fila,3,'Total todas las sucursales unidades y costos:',f1)
               hoja_costos.write(fila,4,totaltodas,f1)
               hoja_costos.write(fila,5,totaltodascosto,f4)
               fila += 1
               hoja_costos.write(fila,3,'Total todas las sucursales unidades y costos 03:',f1)
               hoja_costos.write(fila,4,totaltodas03,f1)
               hoja_costos.write(fila,5,totaltodascosto03,f4)
               fila += 1
               hoja_costos.write(fila,3,'Total todas las sucursales unidades y costos con costos 03:',f1)
               hoja_costos.write(fila,4,(totaltodas + totaltodas03),f1)
               hoja_costos.write(fila,5,(totaltodascosto + totaltodascosto03),f4)
               fila += 1
               hoja_costos.write(fila,3,'Total todas las sucursales unidades y costos 03 pendientes:',f1)
               hoja_costos.write(fila,4,totaltodaspen03,f1)
               hoja_costos.write(fila,5,totaltodascostopen03,f4)
        
  
     workbook.close
  end

  
  #exportar a excel los costos de las compras
  def xlscostocompra
      #genera el xls
      @sucursals = Sucursal.find(:all)
    
      workbook = Excel.new('public/xls/costocompras.xls')
      # Añadimos hoja LISTA
      hoja_costos = workbook.add_worksheet("Compra")
      f1 = workbook.add_format(:color=>"blue", :bold=>1, :italic=>true)
      f3 = workbook.add_format(:num_format => '$#,##0.00')
      f2 = workbook.add_format(:color=>"blue", :bold=>1, :italic=>true,  :size => 18, :font =>'Lucida Calligraphy') 
      f4 = workbook.add_format(:num_format => '$#,##0.00', :color=>"blue", :bold=>1, :italic=>true)
      hoja_costos.write(1,0,'Listado de unidades entregadas entre el '+params[:fechadesde].to_s+' y el '+params[:fechahasta].to_s+' Nro. lista: '+params[:nrolista].to_s+'',f2)
      # Fila de cabecera
      @cabecera = %w(Sucursal Rubro Articulo Unidades Costo)
      columna = 0
      @cabecera.each do |cab|
        hoja_costos.write(3,columna,cab,f1)
        columna += 1
      end
      # Una fila para cada items
         fila = 4
         @comprasucuvals =  Estadistica.comprasucuval(params[:nrolista], params[:fechadesde], params[:fechahasta])  
       
            totaltodas = 0 
            totaltodascosto = 0 
            
            for sucu in @sucursals
              if @comprasucuvals.size > 0
              total = 0
              totalcosto = 0
            #  totalcostopen = 0          
               for c in @comprasucuvals
                # Añado la fila con los datos en sus respectivas columnas
                 if c.sucursal == sucu.sucu_abreviatura
                  hoja_costos.write(fila,0,c.sucursal)
                  hoja_costos.write(fila,1,c.rubro)
                  hoja_costos.write(fila,2,c.arti)
                  hoja_costos.write(fila,3,c.cantidad)
                  hoja_costos.write(fila,4,c.costo,f3)
                  total = total + c.cantidad.to_i 
    		  totalcosto = totalcosto + c.costo.to_d 
                  # Pasamos a la siguiente empiesa en una nueva fila
                  fila += 1
                 end #end if
                end #end for
                if (total > 0) 
                  hoja_costos.write(fila,2,'Total por sucursal unidades y costos:',f1)
                  hoja_costos.write(fila,3,total,f1)
                  hoja_costos.write(fila,4,totalcosto,f4)
                  fila += 1
               end # end if
               totaltodas = totaltodas + total
               totaltodascosto = totaltodascosto + totalcosto 
               end # end if costo>0
             
            end #end for sucu
               fila += 1
               hoja_costos.write(fila,2,'Total todas las sucursales unidades y costos:',f1)
               hoja_costos.write(fila,3,totaltodas,f1)
               hoja_costos.write(fila,4,totaltodascosto,f4)
              
     workbook.close
  end
  def comprasuc
     fechas()
     @ventasbs =  Estadistica.ventasb(params[:fechadesde], params[:fechahasta])
     @ventasagruprubros =  Estadistica.ventasagruprubro(params[:fechadesde], params[:fechahasta])
     respond_to do |format|
       format.html # estadocaucion.html.erb
       format.xml  { render :xml => @ventasbs }
       prawnto :prawn => {
       :page_size => 'A4'}
       format.pdf  { render :layout => false }
     end
  end


  def rubrosucu 
    fechas()   
    @ventasrubrosucus =  Estadistica.ventasrubrosucu(params[:sucursal], params[:fechadesde], params[:fechahasta])
      #TODO separar en otro metodo
      #obtengo los meses que estan en la consulta 
       meses = []
       @ventasrubrosucus.each do |v|
          meses <<  v.mes.to_i
       end
       meses.uniq
       @mesess = meses.uniq
       @mesess.each do |elemento|
        g = Gruff::Bar.new('500x300') 
        g.sort = false 
        g.maximum_value = 3000 
        g.minimum_value = 0 
        g.title_font_size = 20
        g.legend_box_size = 6
        g.legend_font_size = 12
        g.marker_font_size = 12
        g.title = 'Cubiertas Pirelli vendidas en el mes '+elemento.to_s+' por rubro' 
        @ventasrubrosucus.each do |v|
          if elemento == v.mes.to_i
            g.data(v.rubro, [v.cantidad.to_i])
          end #end if
        end # end each ventasrubrossuc
        
        g.write('public/images/rubrosucumes'+elemento.to_s+'.png') 
       end # end  array
   end

   def graficocompras
        g = Gruff::Bar.new('700x500') 
        g.sort = false 
        g.maximum_value = 3000 
        g.minimum_value = 0 
  	g.title_font_size = 20
        g.legend_box_size = 6
        g.legend_font_size = 12
        g.marker_font_size = 12
        g.theme = {:colors => ['#FF4500', '#FFA500', '#FFFF66','#339933', '#0066FF', '#0000FF', '#CC00FF'], :marker_color => '#FFFFFF', :background_colors => ['#000000', '#FFFFFF']}
        g.font_color = '#FFFFFF'
        g.title = 'Compras totales de cubiertas Pirelli por rubro'
        @comprasucuagrups.each {|comprasucuagrups| g.data(comprasucuagrups.rubro, [comprasucuagrups.cantidad.to_i])} 
        g.write('public/images/comprasucuagrup.png') 

        gpdf = Gruff::Bar.new('500x350') 
        gpdf.sort = false 
        gpdf.maximum_value = 3000 
        gpdf.minimum_value = 0 
  	gpdf.title_font_size = 20
        gpdf.legend_box_size = 6
        gpdf.legend_font_size = 12
        gpdf.marker_font_size = 12
        gpdf.theme = {:colors => ['#E6E6E6', '#DDDDDD', '#A4A4A4','#6E6E6E', '#1C1C1C'], :marker_color => '#000000', :background_colors => ['#FFFFFF', '#FFFFFF']}
        gpdf.font_color = '#000000'
        gpdf.title = 'Compras totales de cubiertas Pirelli por rubro'
        @comprasucuagrups.each {|comprasucuagrups| gpdf.data(comprasucuagrups.rubro, [comprasucuagrups.cantidad.to_i])} 
        gpdf.write('public/images/compraagruppdf.jpg') 
   end

  def comprasuc
     fechas()
     @comprasucus =  Estadistica.comprasucu(params[:fechadesde], params[:fechahasta])
     @comprasucuagrups =  Estadistica.comprasucuagrup(params[:fechadesde], params[:fechahasta])
   
     respond_to do |format|
       format.html # estadocaucion.html.erb
       format.xml  { render :xml => @comprasucus }
       prawnto :prawn => {
       :page_size => 'A4'}
       format.pdf  { render :layout => false }
     end
  end

  def comprasucu 
     fechas()
     @comprasucus =  Estadistica.comprasucu(params[:fechadesde], params[:fechahasta])
     @comprasucuagrups =  Estadistica.comprasucuagrup(params[:fechadesde], params[:fechahasta])
     graficocompras()
  end

  def comprasucuval 
     fechas()
     @comprasucuvals =  Estadistica.comprasucuval(params[:nrolista], params[:fechadesde], params[:fechahasta])
     @comprasucusagrupvals =  Estadistica.comprasucuagrupval(params[:nrolista], params[:fechadesde], params[:fechahasta])
  end

  def graficoventas
        g = Gruff::Line.new('700x500') 
        g.sort = false 
       	g.title_font_size = 20
        g.legend_box_size = 10
        g.legend_font_size = 14
        g.marker_font_size = 12
        g.maximum_value = 12000000
        g.minimum_value = 5000000
        g.theme = {:colors => ['#FF4500', '#FFA500', '#FFFF66','#339933', '#0066FF', '#0000FF', '#CC00FF'], :marker_color => '#000000', :background_colors => ['#FFFFFF', '#FFFFFF']}
        g.font_color = '#000000'
        g.title = 'Evolución de ventas por mes'
        @sucursal = Sucursal.find(:all)
        meses = []
        @label_key = 0
        @hash_labels = {}
        
       #desde
        datos = []
         @ventamontogrups.each do |v|
            datos << v.cantidad.to_f
             @hash_labels[@label_key] = v.mes.to_s + '-' + v.anio.to_s
               @label_key += 1
         end
       #hasta
       g.labels = @hash_labels
       g.data("ventas totales", datos)
       g.write('public/images/ventasmontototales.png')

       #grafico con cada sucursal
       gs = Gruff::Line.new('700x500') 
       gs.sort = false 
       gs.title_font_size = 20
       gs.legend_box_size = 6
       gs.legend_font_size = 12
       gs.marker_font_size = 12
       gs.maximum_value = 3000000
       gs.minimum_value = 500000
       gs.theme = {:colors => ['#FF4500', '#FFA500', '#FFFF66','#339933', '#0066FF', '#A9D0F5', '#08088A', '#B4045F','#AEB404', '#81F7F3', '#088A85', '#E3CEF6', '#A9A9F5'], :marker_color => '#000000', :background_colors => ['#FFFFFF', '#D8D8D8']}
       gs.font_color = '#000000'
       gs.title = 'Evolución de ventas por mes en cada sucursal'
       gs.labels = @hash_labels
       @sucursal = Sucursal.find(:all)
       @sucursal.each do |suc|
       gs.data(suc.sucu_abreviatura, @ventamontos.select{|vent| vent.sucursal == suc.sucu_abreviatura}.map do |vent| vent.cantidad.to_f end ) 
       end #sucursales
       gs.write('public/images/ventasmontos.png')
  end

  def ventasmonto
    fechas()
     @ventamontos =  Estadistica.ventamonto(params[:fechadesde], params[:fechahasta])
     @ventamontogrups =  Estadistica.ventamontogrup(params[:fechadesde], params[:fechahasta])
     graficoventas()
  end

  def graficoventatipo
      gt = Gruff::Pie.new("700x500")
      gt.title_font_size = 20
      gt.legend_box_size = 10
      gt.legend_font_size = 14
      gt.theme = {:colors => ['#FF4500', '#0066FF', '#CC00FF','#FFFFFF', '#339933', '#0B0B61', '#FFFF66', '#FFA500', '#BEF781', '#088A85'], :marker_color => '#FFFFFF', :background_colors => ['#000000', '#FFFFFF']}
      gt.font_color = '#FFFFFF'
      gt.title = 'Formas de pago de las ventas'
      idp = []
      @ventatipos.each do |v|
         idp <<  v.idpago.to_i
       end
      @idps = idp.uniq
      @idps.each do |idpag|
         cant = 0
         formapago = " "
         @ventatipos.each do |vent| 
           if (idpag == vent.idpago.to_i)
             formapago = vent.formap
             cant = cant + vent.importe.to_f
           end
         end
        gt.data(formapago, cant)
      end
     gt.write('public/images/ventatipo.png')
  end

  def ventastipo
    fechas()
    @ventatipos = Estadistica.ventatipo(params[:fechadesde], params[:fechahasta])
    graficoventatipo()
  end

  def graficotarjeta
      gt = Gruff::Pie.new("700x500")
      gt.title_font_size = 20
      gt.legend_box_size = 8
      gt.legend_font_size = 10
      gt.theme = {:colors => ['#FF4500', '#0066FF', '#CC00FF','#FFFFFF', '#339933', '#0B0B61', '#FFFF66', '#FFA500', '#BEF781', '#088A85'], :marker_color => '#FFFFFF', :background_colors => ['#000000', '#FFFFFF']}
      gt.font_color = '#FFFFFF'
      gt.title = 'Porcentajes de las distintas tarjetas de credito'
      # @tarjetas.each {|tarjeta| gt.data(tarjeta.nombre, [tarjeta.importe.to_d])} 
      # comento la linea de arriba y hago esto para eliminar del grafico los porcentajes del 0%
      total = 0
      @tarjetas.each do |t|
         total = total + t.importe.to_d
       end
       cant = 0
       nombre = " "
       @tarjetas.each do |tarj| 
          porc = (tarj.importe.to_d * 100) / total
          if porc >= 1
              gt.data(tarj.nombre, [tarj.importe.to_d])
          end
       end

      # gt.data(formapago, cant)
      gt.write('public/images/tarjeta.png')
  end

  def graficotarjetasucu
    @sucursal = Sucursal.find(:all)
    @sucursal.each do |suc|
      params[:sucursal] = suc.id.to_i
      gt = Gruff::Pie.new("500x350")
      gt.title_font_size = 20
      gt.legend_box_size = 8
      gt.legend_font_size = 10
      gt.theme = {:colors => ['#FF4500', '#0066FF', '#CC00FF','#FFFFFF', '#339933', '#0B0B61', '#FFFF66', '#FFA500', '#BEF781', '#088A85'], :marker_color => '#FFFFFF', :background_colors => ['#000000', '#FFFFFF']}
      gt.font_color = '#FFFFFF'
      gt.title = 'Porcentajes de las distintas tarjetas de credito de la sucursal '+suc.sucu_abreviatura.to_s+''
      @tarjetasucus = Estadistica.tarjetasucu(params[:sucursal],params[:fechadesde], params[:fechahasta])
     # @tarjetasucus.each {|tarjeta| gt.data(tarjeta.nombre, [tarjeta.importe.to_d])} 
     # comento la linea de arriba y hago esto para eliminar del grafico los porcentajes del 0%
       total = 0
      @tarjetasucus.each do |t|
         total = total + t.importe.to_d
      end
       cant = 0
       nombre = " "
       @tarjetasucus.each do |tarj| 
          porc = (tarj.importe.to_d * 100) / total
          if porc >= 1
              gt.data(tarj.nombre, [tarj.importe.to_d])
          end
       end
       gt.write('public/images/tarjetasucu'+suc.id.to_s+'.png')
   end
  end

  def tarjeta
    fechas()
    @tarjetas = Estadistica.tarjeta(params[:fechadesde], params[:fechahasta])
    graficotarjeta()
    graficotarjetasucu()
  end

end
