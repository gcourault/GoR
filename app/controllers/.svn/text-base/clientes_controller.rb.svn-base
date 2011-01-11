class ClientesController < ApplicationController
   before_filter :login_required
   access_control [:index, :list, :new, :create, :update, :edit, :show, :resumencliente, :asignasucursal, :fechas, :detallearticulo, :detallefactura, :graficoclienterubro, :detalleclientes, :clientemonto] => '(rol 2 | rol 3 | rol 4 | rol 5 | rol 6 | rol 7)'
                 
 
  def permission_denied
    flash[:notice] = "Usted no tiene permiso para realizar esta acción." 
    return redirect_to(:controller => 'login', :action => 'denied')
  end

# auto_complete_for :cliente, :clie_razonsocial
auto_complete_forsucursal  :cliente, :clie_razonsocial,  :limit => 15
  # GET /clientes
  # GET /clientes.xml
  def index
    # @clientes = Cliente.find(2)
    @clientes = Cliente.find(:all, :condition => ['clie_razonsocial LIKE ? and sucursal_id = ?', '#{params[:search]} , #{params[:sucursal_id]}'] )
   
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @clientes }
      format.js
    end
  end

#Este metodo es para filtrar clientes po sucursal en el select 
#def get_clientes
#  @clientes = Cliente.find(:all, :conditions => ['cliente.sucursal_id = ?', params[:sucursal_id]])
#  return render(:partial => '_getclientes', :layout => false) if request.xhr? 
#end
#o este
#def get_froms
#  @froms = From.find(:all, :conditions => ['origin_id = ?', params[:select_froms_id]])
#  return render(:partial => '_getclientes', :layout => false) if request.xhr? 
#end

  # GET /clientes/1
  # GET /clientes/1.xml
  def show
    @cliente = Cliente.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cliente }
    end
  end

  # GET /clientes/new
  # GET /clientes/new.xml
  def new
    @cliente = Cliente.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cliente }
    end
  end

  # GET /clientes/1/edit
  def edit
    @cliente = Cliente.find(params[:id])
  end

  # POST /clientes
  # POST /clientes.xml
  def create
    @cliente = Cliente.new(params[:cliente])
    respond_to do |format|
      if @cliente.save
        flash[:notice] = 'El cliente ha sido creado.'
        format.html { redirect_to(@cliente) }
        format.xml  { render :xml => @cliente, :status => :created, :location => @cliente }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cliente.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /clientes/1
  # PUT /clientes/1.xml
  def update
    @cliente = Cliente.find(params[:id])

    respond_to do |format|
      if @cliente.update_attributes(params[:cliente])
        flash[:notice] = 'El cliente ha sido modificado.'
        format.html { redirect_to(@cliente) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cliente.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /clientes/1
  # DELETE /clientes/1.xml
  def destroy
    @cliente = Cliente.find(params[:id])
    @cliente.destroy

    respond_to do |format|
      format.html { redirect_to(clientes_url) }
      format.xml  { head :ok }
    end
  end

  def fechas
    params[:fechadesde] = convierte_fecha(params[:fechadesde]) if !params[:fechadesde].blank?
    params[:fechahasta] = convierte_fecha(params[:fechahasta]) if !params[:fechahasta].blank?
  end

  def resumencliente
    fechas()
     @sucursals = Sucursal.find(:all)
    if !params[:cliente].nil?
      if (params[:bcuit]!=nil)
        for sucu in @sucursals
         @cliente = Cliente.find(:first, :conditions => ["sucursal_id = ? and clie_cuit = ? ", sucu, params[:clientecuit] ])
         break if !@cliente.nil? 
        end
     else 
       str_tokens = params[:cliente][:clie_razonsocial].split("|") 
       @cliente = Cliente.find(:first, :conditions => ["sucursal_id = ? and id = ? ", session[:sucursalseleccionada], str_tokens[1].lstrip ]) if str_tokens[1]  
     end
    end

    if !@cliente.nil?
      
      #para obtener movimientos del periodo solicitado
      @movimientounicos = Cliente.movimiento(@cliente.id[0], params[:fechadesde], params[:fechahasta], session[:sucursalseleccionada])
      @saldoantunico = Cliente.saldoant(session[:sucursalseleccionada], params[:fechadesde], @cliente.id[0])
      @saldomovunico = Cliente.saldomov(session[:sucursalseleccionada], params[:fechadesde], params[:fechahasta], @cliente.id[0])
      #obtener los articulos que compro en el periodo
      @articulounicos = Cliente.articulo(@cliente.id[0], params[:fechadesde], params[:fechahasta], session[:sucursalseleccionada])
      #los cheques del cliente entre esas fecha
      @chequefacturaunicos = Cliente.chequefactura(@cliente.id[0], params[:fechadesde], params[:fechahasta], session[:sucursalseleccionada]) 
      #obtener los cheque pendiente a la fecha hasta y los rechazados
      @chequeunicos = Cliente.cheque(@cliente.id[0], params[:fechahasta], session[:sucursalseleccionada])
      #cheques rechazados dados por el cliente
      @chequerechazadounicos = Cliente.chequerechazado(@cliente.id[0], session[:sucursalseleccionada])
      #obtener facturas del cliente
      @facturaunicos = Cliente.factura(@cliente.id[0], params[:fechadesde], params[:fechahasta], session[:sucursalseleccionada]) 
      #remitos pendientes
      nrolista = Maestrolista.maximum(:mlis_nrolista) 
      @remitospendienteunicos = Cliente.remitospendiente(@cliente.id[0], nrolista, params[:fechadesde], params[:fechahasta], session[:sucursalseleccionada])
      #articulos agrupados por rubros
      Cliente.graficorubro(@cliente.id[0], params[:fechadesde], params[:fechahasta], session[:sucursalseleccionada], 99)
    end 
  end
     

  def detallefactura
  # @facturadetalles = Cliente.facturadetalle(params[:idfactura], params[:sucursal])
   @factura = Cabfactura.find(params[:id])
  
  end

  def clientearticulo
    fechas()
    if !params[:cliente].nil?
      if (params[:bcuit]!=nil)
        @cliente = Cliente.find(:first, :conditions => ["sucursal_id = ? and clie_cuit = ? ", session[:sucursalseleccionada], params[:clientecuit] ])
     else 
       str_tokens = params[:cliente][:clie_razonsocial].split("|") 
       @cliente = Cliente.find(:first, :conditions => ["sucursal_id = ? and id = ? ", session[:sucursalseleccionada], str_tokens[1].lstrip ]) if str_tokens[1]  
     end
    end
   
     if !@cliente.nil?
       #para obtener los articulos comprados poe el cliente cuit 0
       @articuloclientes = Cliente.articulocliente(@cliente.id[0], params[:fechadesde], params[:fechahasta], params[:articulo], session[:sucursalseleccionada])
      else
        @articuloclientes = Cliente.articuloclientetodos(params[:fechadesde], params[:fechahasta], params[:articulo], session[:sucursalseleccionada])
     end
  end

  def detallearticulo
  end

  def clientemonto
    fechas()
    @clientemontos = Cliente.clientepormonto(params[:monto], params[:sucursal], params[:fechadesde], params[:fechahasta])
  end
 def graficoclienterubro
       
       g = Gruff::Line.new('700x500') 
       g.sort = false 
       g.title_font_size = 20
       g.legend_box_size = 6
       g.legend_font_size = 12
       g.marker_font_size = 12
       #g.maximum_value = 2000
       #g.minimum_value = 0
       g.theme = {:colors => ['#FF4500', '#FFA500', '#FFFF66','#339933', '#0066FF', '#A9D0F5', '#08088A', '#B4045F','#AEB404', '#81F7F3', '#088A85', '#E3CEF6', '#A9A9F5', '#F33F66', '#FAA0F0', '#660000', '#33FF33' ], :marker_color => '#000000', :background_colors => ['#FFFFFF', '#D8D8D8']}
       g.font_color = '#000000'
       g.title = 'Evolución de las compras por rubro en $'

       @label_key = 0
       @hash_labels = {}
        
       #desde
        datos = []
        fecha = []
        mes = []
        anio = []
        @clientepormontomes.each do |v|
           datos << v.rubro.to_s
           fecha << (v.mes.to_s + '-' + v.anio.to_s)
           mes << v.mes.to_i 
           anio << v.anio.to_i
         end
          @fecha = fecha.uniq
          @fecha.each do |f|
           @hash_labels[@label_key] = f
           @label_key += 1
          end
         
       
        @mes = mes.uniq
        @anio = anio.uniq
        g.labels = @hash_labels
        @rubro = datos.uniq.sort
          
             @rubro.each do |rub|
              data = []
                @fecha.each do |f|
                   datovar = 0
                   fech = f.split("-")
                   @clientepormontomes.each do |p|
                     datovar = p.monto.to_f  if p.rubro == rub &&  p.mes.to_i == fech[0].to_i && p.anio.to_i == fech[1].to_i
                   end
                   data << datovar
                  end
             g.data(rub, data) 
            end #rubro
             
       g.write('public/images/clienterubro.png')
       
       gu = Gruff::Line.new('700x500') 
       gu.sort = false 
       gu.title_font_size = 20
       gu.legend_box_size = 6
       gu.legend_font_size = 12
       gu.marker_font_size = 12
      # g.maximum_value = 2000
      # g.minimum_value = 0
       gu.theme = {:colors => ['#FF4500', '#FFA500', '#FFFF66','#339933', '#0066FF', '#A9D0F5', '#08088A', '#B4045F','#AEB404', '#81F7F3', '#088A85', '#E3CEF6', '#A9A9F5', '#F33F66', '#FAA0F0', '#660000', '#33FF33'], :marker_color => '#000000', :background_colors => ['#FFFFFF', '#D8D8D8']}
       gu.font_color = '#000000'
       gu.title = 'Evolución de las compras por rubro en unidades'

       gu.labels = @hash_labels
           @rubro.each do |rub|
              data = []
                @fecha.each do |f|
                   datovar = 0
                   fech = f.split("-")
                   @clientepormontomes.each do |p|
                     datovar = p.cantidad.to_i  if p.rubro == rub &&  p.mes.to_i == fech[0].to_i && p.anio.to_i == fech[1].to_i
                   end
                   data << datovar
                  end
             gu.data(rub, data) 
            end #rubro
             
       gu.write('public/images/clienterubrouni.png')
  end


  def detalleclientes 
       @clientepormontomes = Cliente.clientepormontome(params[:idcliente], params[:sucursal], params[:fechadesde], params[:fechahasta])
       mes = []
       anio = []
       fecha = []
      @clientepormontomes.each do |v|
         mes <<  v.mes.to_i
         anio <<  v.anio.to_i
         fecha << (v.mes.to_s + '-' + v.anio.to_s)
      end
     
      @mes = mes.uniq
     @fecha = fecha
     @anio = anio.uniq
     graficoclienterubro()
  end

  def asignasucursal
    session[:sucursalseleccionada] = params[:sucursal_id]

    #render :update do |page|
    #  page.replace_html('datos_clientes', :partial => 'traeclientes')
    #end
  end
  

end
