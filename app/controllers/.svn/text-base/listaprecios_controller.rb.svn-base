class ListapreciosController < ApplicationController
  #gema para expotar a ecxel
   require 'spreadsheet/excel'
   include Spreadsheet
  
   before_filter :login_required
   access_control  [:index, :list, :new, :create, :update, :edit, :show, :actualizalista, :actualizagrilla, :remarque, :remarcar, :actualizaprecio, :remarquecheckgraba] => '(rol 4 | rol 7)',
       [:cosultalista] => '(rol 4 | rol 5 | rol 6 | rol 7)',
                    [:listaprecio, :xls, :listaprecioalliance, :xlsalliance, :listapreciobkt, :xlsbkt] => '( rol 1 | rol 2 | rol 3 | rol 4 | rol 5 | rol 6 | rol 7)'
                  
 # GET /listaprecios
 # GET /listaprecios.xml  
 def permission_denied
    flash[:notice] = "Usted no tiene los privilegios para realizar esta acción." 
    return redirect_to(:controller => 'login', :action => 'denied')
 end

 def index
     if (params[:todos]!=nil)
       if (params[:mod]!=nil)
           @listaprecios = Listaprecio.modelotodos(params[:modelo] ,params[:maestrolistaid])
        else
           if (params[:marcacod].blank?)
           else
           @marca = Marca.find_by_marc_codigo(params[:marcacod].to_s.to_i)
           params[:marcaid] = @marca.id 
           end
           if (params[:rubrocod].blank?)
           else
           @rubro =  Rubro.find_by_rubr_codigo(params[:rubrocod].to_s.to_i)
           params[:rubroid] = @rubro.id 
           end
           @listaprecios = Listaprecio.searchtodos(params[:nrolista] , params[:modelo],  params[:marcaid],  params[:rubroid], params[:maestrolistaid])
           end
        else
        if (params[:mod]!=nil)
           @listaprecios = Listaprecio.modelo(params[:modelo] ,params[:maestrolistaid])
        else
           @marca = Marca.find_by_marc_codigo(params[:marcacod].to_s.to_i)
             if(@marca.blank?)
             else
              params[:marcaid] = @marca.id
             end 
           @rubro =  Rubro.find_by_rubr_codigo(params[:rubrocod].to_s.to_i)
             if(@rubro.blank?)
             else
              params[:rubroid] = @rubro.id 
             end
           @listaprecios = Listaprecio.search(params[:nrolista] , params[:modelo],  params[:marcaid],  params[:rubroid], params[:maestrolistaid])
        end
      end
     #@listaprecios = Listaprecio.search(params[:maestrolistaid])
     respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @listaprecios }
       prawnto :prawn => {
      :page_size => 'A4'}
      format.pdf  { render :layout => false }
     end
 end

 def xls
     #genera el xls 
     @marcas = Marca.find(:all)
     @rubros = Rubro.find(:all)
    
      workbook = Excel.new('public/xls/lista_precios.xls')
      # Añadimos hoja LISTA
      hoja_listas = workbook.add_worksheet("Lista")
      f1 = workbook.add_format(:color=>"blue", :bold=>1, :italic=>true)
      f2 = workbook.add_format(:color=>"blue", :bold=>1, :italic=>true, :size => 18, :font =>'Lucida Calligraphy') 
      f3 = workbook.add_format(:num_format => '$#,##0.00')
      hoja_listas.write(1,1,'Lista de precios Nro: '+params[:nrolista].to_s+'',f2)
      # Fila de cabecera
      if session[:user].usur_usuario.to_s == "lperiolo"
         @cabecera = %w(CodigoPirelli Codigo Modelo Medida Camara Telas Precio)
      else
         @cabecera = %w(Codigo Modelo Medida Camara Telas Precio)
      end
      columna = 0
      @cabecera.each do |cab|
        hoja_listas.write(3,columna,cab,f1)
        columna += 1
      end
      # Una fila para cada items
          fila = 4
            @lista = Listaprecio.xls(params[:nrolista])  
              if @lista.size > 0
              
                # Añado la fila con los datos en sus respectivas columnas
                if session[:user].usur_usuario.to_s == "lperiolo"
                 for l in @lista
                  hoja_listas.write(fila,0,l.articulo.arti_clavesecundaria)
                  hoja_listas.write(fila,1,''+l.articulo.marca.marc_codigo.to_s+'-'+l.articulo.rubro.rubr_codigo.to_s+'-'+l.articulo.arti_codigo.to_s)
                  hoja_listas.write(fila,2,l.articulo.arti_modelo)
                  hoja_listas.write(fila,3,l.articulo.arti_medida)
                  hoja_listas.write(fila,4,l.articulo.arti_conosincamara)
                  hoja_listas.write(fila,5,l.articulo.arti_telas)
                  hoja_listas.write(fila,6,l.lpre_precioventa.round(0), f3)
                  # Pasamos a la siguiente empresa en una nueva fila
                  fila += 1
                  end
                 else
                  for l in @lista
                   hoja_listas.write(fila,0,''+l.articulo.marca.marc_codigo.to_s+'-'+l.articulo.rubro.rubr_codigo.to_s+'-'+l.articulo.arti_codigo.to_s)
                  hoja_listas.write(fila,1,l.articulo.arti_modelo)
                  hoja_listas.write(fila,2,l.articulo.arti_medida)
                  hoja_listas.write(fila,3,l.articulo.arti_conosincamara)
                  hoja_listas.write(fila,4,l.articulo.arti_telas)
                  hoja_listas.write(fila,5,l.lpre_precioventa.round(0), f3)
                  # Pasamos a la siguiente empresa en una nueva fila
                  fila += 1
                  end
                 end
              
            end
  
     workbook.close
 end
 def xlsbkt
     #genera el xls 
     @marcas = Marca.find(:all)
     @rubros = Rubro.find(:all)
    
      workbook = Excel.new('public/xls/lista_precios_bkt.xls')
      # Añadimos hoja LISTA
      hoja_listas = workbook.add_worksheet("Lista")
      f1 = workbook.add_format(:color=>"blue", :bold=>1, :italic=>true)
      f2 = workbook.add_format(:color=>"blue", :bold=>1, :italic=>true, :size => 18, :font =>'Lucida Calligraphy') 
      f3 = workbook.add_format(:num_format => '$#,##0.00')
      hoja_listas.write(1,1,'Lista de precios BKT Nro: '+params[:nrolista].to_s+'',f2)
      # Fila de cabecera
   
         @cabecera = %w(Codigomarca Codigo Modelo Medida Camara Telas Precio)
  
      columna = 0
      @cabecera.each do |cab|
        hoja_listas.write(3,columna,cab,f1)
        columna += 1
      end
      # Una fila para cada items
          fila = 4
            @lista = Listaprecio.xlsbkt(params[:nrolista])  
              if @lista.size > 0
              
                # Añado la fila con los datos en sus respectivas columnas
               
                 for l in @lista
                  hoja_listas.write(fila,0,l.articulo.arti_clavesecundaria)
                  hoja_listas.write(fila,1,''+l.articulo.marca.marc_codigo.to_s+'-'+l.articulo.rubro.rubr_codigo.to_s+'-'+l.articulo.arti_codigo.to_s)
                  hoja_listas.write(fila,2,l.articulo.arti_modelo)
                  hoja_listas.write(fila,3,l.articulo.arti_medida)
                  hoja_listas.write(fila,4,l.articulo.arti_conosincamara)
                  hoja_listas.write(fila,5,l.articulo.arti_telas)
                  hoja_listas.write(fila,6,l.lpre_precioventa.round(0), f3)
                  # Pasamos a la siguiente empresa en una nueva fila
                  fila += 1
                  end
                 
              
            end
  
     workbook.close
 end

 def xlsalliance
     #genera el xls 
     @marcas = Marca.find(:all)
     @rubros = Rubro.find(:all)
    
      workbook = Excel.new('public/xls/lista_precios_alliance.xls')
      # Añadimos hoja LISTA
      hoja_listas = workbook.add_worksheet("Lista")
      f1 = workbook.add_format(:color=>"blue", :bold=>1, :italic=>true)
      f2 = workbook.add_format(:color=>"blue", :bold=>1, :italic=>true, :size => 18, :font =>'Lucida Calligraphy') 
      f3 = workbook.add_format(:num_format => '$#,##0.00')
      hoja_listas.write(1,1,'Lista de precios Alliance Nro: '+params[:nrolista].to_s+'',f2)
      # Fila de cabecera
      
         @cabecera = %w(Codigo Modelo Medida Camara Telas Precio)
   
      columna = 0
      @cabecera.each do |cab|
        hoja_listas.write(3,columna,cab,f1)
        columna += 1
      end
      # Una fila para cada items
          fila = 4
            @lista = Listaprecio.xlsalliance(params[:nrolista])  
              if @lista.size > 0
              
                 for l in @lista
                   hoja_listas.write(fila,0,''+l.articulo.marca.marc_codigo.to_s+'-'+l.articulo.rubro.rubr_codigo.to_s+'-'+l.articulo.arti_codigo.to_s)
                  hoja_listas.write(fila,1,l.articulo.arti_modelo)
                  hoja_listas.write(fila,2,l.articulo.arti_medida)
                  hoja_listas.write(fila,3,l.articulo.arti_conosincamara)
                  hoja_listas.write(fila,4,l.articulo.arti_telas)
                  hoja_listas.write(fila,5,l.lpre_precioventa.round(0), f3)
                  # Pasamos a la siguiente empresa en una nueva fila
                  fila += 1
                  end
              
              
            end
  
     workbook.close
 end
 def listaprecio
     @listaprecios = Listaprecio.search(params[:nrolista] , params[:modelo],  params[:marcaid],  params[:rubroid], params[:maestrolistaid])
     #@listaprecios = Listaprecio.search(params[:maestrolistaid])
     xls()
     respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @listaprecios }
       prawnto :prawn => {
      :page_size => 'A4'}
      format.pdf  { render :layout => false }
     end
 end


 def listapedicion
     @listaprecios = Listaprecio.search(params[:maestrolistaid])
 end

#TODO: ver creo que no se usa!!
  def marcarubro 
   @marcarubro = Listaprecio.agrupamiento
   respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @marcarubro }
      format.pdf  { render :layout => false }
   end
 end

 def actualizaprecio 
   @listagrillas = Grillalista.find_all_by_listaprecio_id(params[:id])
   @listaprecio = Listaprecio.find(params[:id])
   pcosto = @listaprecio.lpre_preciolista
    @listagrillas.each do |g| 
      pcosto = pcosto * ((100 + g.glis_porcentaje) / 100)
    end
  @listaprecio.update_attribute(:lpre_preciocosto, pcosto.round(2))
  pventa = pcosto * ((100 + @listaprecio.lpre_remarque) / 100)
  pventa = pventa * ((100 + @listaprecio.lpre_remarque2) / 100)
  pventa = pventa * ((100 + @listaprecio.lpre_remarque3) / 100)
  @listaprecio.update_attribute(:lpre_precioventa, pventa.round(2))
 end

# TODO: ver y sacar creo que no se usa!!!
 def listamarcarubro
    respond_to do |format|
   # format.xml { render :xml => @marcarubro }
    @marcarubro = Listaprecio.agrupamiento
       marcarubro.each do |mc|
         @articulospormarcayrubro = Listaprecio.find.articulosmarcarubro( mc.marca_id, mc.rubro_id )
       end
    end
    @tablalistaprecio = @marcarubro.map { | marcarubro.marca_id, marcarubro.rubro_id | Listaprecio.find.articulosmacarubro( m , r) }
 end 

 # GET /listaprecios/1
 # GET /listaprecios/1.xml
 def show
    @listaprecio = Listaprecio.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @listaprecio }
      format.pdf  { render :pdf => false }
    end
 end

 def new 
   @listaprecio = Listaprecio.new 
   respond_to do |format| 
    format.html # new.html.erb 
    format.xml  { render :xml => @listaprecio } 
   end 
 end

 def actualizalista
   @actualizalista = Listaprecio.actualizalista(params[:marcaid], params[:rubroid], params[:maestrolistaid])
 end


 def actualizagrilla
   @actualizagrilla = Grillalista.actualizagrilla(params[:id], params[:nrogrilla], params[:nrocolumna])
 end

 def remarcar
   @listaprecio = Listaprecio.find_by_maestrolista_id(params[:id])
 end

 # actualiza los remarques y las grillas por marcas y rubros
 def remarque
    Listaprecio.transaction do
      @listaprecio = Listaprecio.find(params[:id])
      params[:maestrolistaid] = @listaprecio.maestrolista_id

      if params[:rubrodesde].to_s.to_i > params[:rubrohasta].to_s.to_i 
       aux = params[:rubrodesde]
       params[:rubrodesde] = params[:rubrohasta]
       params[:rubrohasta] = aux
     end
       @idporcodigomarca = Marca.find_by_marc_codigo(params[:marcadesde])
       params[:marcaid] =  @idporcodigomarca.id
       # para que empieze desde el primer rubro para cada marca
       #params[:rubrod]  = params[:rubrodesde]
       while  params[:rubrodesde].to_s.to_i <= params[:rubrohasta].to_s.to_i do
        @idporcodigorubro = Rubro.find_by_rubr_codigo(params[:rubrodesde])
        if @idporcodigorubro.nil?
          else
              params[:rubroid] =  @idporcodigorubro.id
              @actualizalista = actualizalista() 
                  
              @actualizalista.each do |alista|
                 plista = alista.lpre_preciolista
                 plista = plista * ((100 + params[:preciolista].to_s.to_f) / 100)
                 alista.update_attribute(:lpre_preciolista, plista.round(2))
              end
      
             if (params[:re1]!=nil)
              @actualizalista.each {|l| l.update_attribute 'lpre_remarque', params[:remarque].to_s.to_f}
             end
             if (params[:re2]!=nil)
              @actualizalista.each {|l| l.update_attribute 'lpre_remarque2', params[:remarque2].to_s.to_f}
             end
             if (params[:re3]!=nil)
              @actualizalista.each {|l| l.update_attribute 'lpre_remarque3', params[:remarque3].to_s.to_f }
             end
             if (params[:remarque].to_s.to_f > 0 || params[:remarque2].to_s.to_f > 0 || params[:remarque3].to_s.to_f > 0)
              @actualizalista.each {|l| l.update_attribute 'lpre_ultmod', DateTime.now }
              @actualizalista.each {|l| l.update_attribute 'lpre_usuario',  session[:user].usur_nombre }
             end
             if params[:nrogrilla].to_s.to_i > 0 and params[:nrocolumna].to_s.to_i > 0
                @actualizalista.each do |p|
                     params[:id] = p.id
                     @grillalista = actualizagrilla()
                     #grillalista = Grillalista.find_by_id_and_glis_nrogrilla_and_glis_nrocolumna(params[:id], params[:nrogrilla], params[:nrocolumna])
                     @grillalista.each {|g| g.update_attribute 'glis_porcentaje', params[:porcentaje].to_s.to_f }
                     # guarda usuario y fecha de modificacion
                     @grillalista.each {|g| g.update_attribute 'glis_ultmod', DateTime.now }
                     @grillalista.each {|g| g.update_attribute 'glis_usuario',  session[:user].usur_nombre }
                end
            end
            #agrega una grilla para la lista de precio por marca y rubro
            if (params[:agregagrilla]!=nil)
                 @actualizalista.each do |lista|
                 @grilla = Grillalista.new
                 @grilla.maestrolista_id = lista.maestrolista_id
                 @grilla.listaprecio_id = lista.id
                 @grilla.glis_nrogrilla = params[:nrogrillanue].to_s.to_i			
                 @grilla.glis_nrocolumna = params[:nrocolumnanue].to_s.to_i	
                 @grilla.glis_porcentaje = params[:porcentajenue].to_s.to_d
                 @grilla.glis_usuario = session[:user].usur_nombre
                 @grilla.glis_ultmod = DateTime.now
                 @grilla.save
                end
            end
       
         @actualizalista.each do |lpa| 
           params[:id] = lpa.id
           actualizaprecio()
         end
  
      end #if idporcodigorubro
    params[:rubrodesde] = params[:rubrodesde].to_s.to_i + 1 
    end # del while

     respond_to do |format|
      if @listaprecio.update_attributes(params[:listaprecio])
        flash[:notice] = 'Los cambios fueron realizados exitozamente!.'
        format.html { redirect_to(:controller => 'listaprecios', :action => 'remarcar', :id => @listaprecio.maestrolista_id, :maestrolistaid => @listaprecio.maestrolista_id)}
        format.xml  { head :ok }
      else
        format.html { redirect_to(:controller => 'listaprecios', :action => 'remarcar', :id => @listaprecio.maestrolista_id, :maestrolistaid => @listaprecio.maestrolista_id)}
        format.xml  { head :ok }
      end
    end
  end #transaction 
 end

#remarques por checkbox
 def remarquecheck
   render :partial => 'listaprecios/remarquecheck'
 end

 def remarquecheckgraba
params[:listap] = 0
  if !params[:listaprecio].nil? 
   Listaprecio.transaction do
    params[:listaprecio][:idlista].each { |arti|
     @alista = Listaprecio.find(arti)

     plista = @alista.lpre_preciolista
     plista = plista * ((100 + params[:preciolista].to_s.to_f) / 100)
     @alista.update_attribute(:lpre_preciolista, plista.round(2))
    
      if (params[:re1]!=nil)
        @alista.update_attribute 'lpre_remarque', params[:remarque].to_s.to_f
      end
      if (params[:re2]!=nil)
        @alista.update_attribute 'lpre_remarque2', params[:remarque2].to_s.to_f
      end
      if (params[:re3]!=nil)
        @alista.update_attribute 'lpre_remarque3', params[:remarque3].to_s.to_f
      end
      if (params[:remarque].to_s.to_f > 0 || params[:remarque2].to_s.to_f > 0 || params[:remarque3].to_s.to_f > 0)
        @alista.update_attribute 'lpre_ultmod', DateTime.now 
        @alista.update_attribute 'lpre_usuario',  session[:user].usur_nombre 
      end

      if params[:nrogrilla].to_s.to_i > 0 and params[:nrocolumna].to_s.to_i > 0
           params[:id] = @alista.id
           @grillalista = actualizagrilla()
           @grillalista.each {|g| g.update_attribute 'glis_porcentaje', params[:porcentaje].to_s.to_f }
           @grillalista.each {|g| g.update_attribute 'glis_ultmod', DateTime.now }
           @grillalista.each {|g| g.update_attribute 'glis_usuario',  session[:user].usur_nombre }
      end

     if (params[:agregagrilla]!=nil)
           @grilla = Grillalista.new
           @grilla.maestrolista_id =  @alista.maestrolista_id
           @grilla.listaprecio_id =  @alista.id
           @grilla.glis_nrogrilla = params[:nrogrillanue].to_s.to_i			
           @grilla.glis_nrocolumna = params[:nrocolumnanue].to_s.to_i	
           @grilla.glis_porcentaje = params[:porcentajenue].to_s.to_d
           @grilla.glis_usuario = session[:user].usur_nombre
           @grilla.glis_ultmod = DateTime.now
           @grilla.save
      end

      params[:id] = @alista.id
      actualizaprecio()    }
 params[:listap] = params[:listaprecio][:idlista] 
  end 
 end
   respond_to do |format|
     format.html { redirect_to(:controller => 'listaprecios', :action => 'index', :maestrolistaid => params[:maestrolistaid], :marcacod => params[:marcacod], :rubrocod => params[:rubrocod], :listamod => params[:listap] ) }
     format.xml  { head :ok }
   end

 end

 def edit
    @listaprecio = Listaprecio.find(params[:id])
    actualizaprecio()
 end
# actualiza los precio de las lista con porcentaje de grillas y remarques

  # POST /listaprecios
  # POST /listaprecios.xml
 def create
    @listaprecio = Listaprecio.new(params[:listaprecio])
    @listaprecio.lpre_ultmod = DateTime.now
    @listaprecio.lpre_usuario = session[:user].usur_nombre

    #para no perder el valor cuando no graba por articulo repetido
    params[:maestrolistaid] = @listaprecio.maestrolista_id
    respond_to do |format|
      if @listaprecio.save
        flash[:notice] = 'Listaprecio was successfully created.'
        format.html { redirect_to(:controller => 'listaprecios', :action => 'index', :maestrolistaid => @listaprecio.maestrolista_id, :marcacod => @listaprecio.articulo.marca.marc_codigo, :rubrocod => @listaprecio.articulo.rubro.rubr_codigo) }
        format.xml  { render :xml => @listaprecio, :status => :created, :location => @listaprecio }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @listaprecio.errors, :status => :unprocessable_entity }
      end
    end
 end

  # PUT /listaprecios/1
  # PUT /listaprecios/1.xml
 def update
   Listaprecio.transaction do
    @listaprecio = Listaprecio.find(params[:id])
    @listaprecio.lpre_ultmod = DateTime.now
    @listaprecio.lpre_usuario = session[:user].usur_nombre
    respond_to do |format|
      if @listaprecio.update_attributes(params[:listaprecio])
        flash[:notice] = 'La lista de precios ha sido actualizada.'
        format.html { redirect_to(:controller => 'listaprecios', :action => 'index', :maestrolistaid => @listaprecio.maestrolista_id, :marcacod => @listaprecio.articulo.marca.marc_codigo, :rubrocod => @listaprecio.articulo.rubro.rubr_codigo, :idmodificado => @listaprecio.id) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @listaprecio.errors, :status => :unprocessable_entity }
      end
    end
     actualizaprecio()
  end #transaction
 end

 def cosultalista
 end
 def listaprecioalliance
      @listaprecios = Listaprecio.searchalliance(params[:nrolista] , params[:modelo],  params[:marcaid],  params[:rubroid], params[:maestrolistaid])
 end
 def listapreciobkt
      @listaprecios = Listaprecio.searchbkt(params[:nrolista] , params[:modelo],  params[:marcaid],  params[:rubroid], params[:maestrolistaid])
 end

end

