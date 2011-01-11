class CabplaegresosController < ApplicationController
   before_filter :login_required
   access_control [:index, :list, :new, :create, :update, :edit, :show, :formapago, :verformapago, :verfp, :retgan, :retganpe, :borrarenglones, :grabarenglones, :consulta, :fechas] => '(rol 2 | rol 3 | rol 4 | rol 5 | rol 6 | rol 7)'

 def permission_denied
    flash[:notice] = "Usted no tiene permiso para realizar esta acción." 
    return redirect_to(:controller => 'login', :action => 'denied')
 end

  # GET /cabplaegresos
  # GET /cabplaegresos.xml
  def index
     if (params[:numpe]!=nil)
      @cabplaegresos = Cabplaegreso.paginate(:conditions => ["sucursal_id = ? and cpeg_nroplanilla = ?", session[:sucursal], params[:nroplaeg]], :per_page => 20, :page => params[:page] || 1, :order => ['cpeg_fecha DESC, cpeg_nroplanilla DESC '])
    else
      @cabplaegresos = Cabplaegreso.paginate(:conditions => ["sucursal_id = ?", session[:sucursal]], :per_page => 20, :page => params[:page] || 1, :order => ['cpeg_fecha DESC, cpeg_nroplanilla DESC '])
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cabplaegresos }
       prawnto :prawn => {
      :page_size => 'A4'}
      format.pdf  { render :layout => false }
    end
  end

  # GET /cabplaegresos/1
  # GET /cabplaegresos/1.xml
  def show
    @cabplaegreso = Cabplaegreso.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cabplaegreso }
    end
  end

  # GET /cabplaegresos/new
  # GET /cabplaegresos/new.xml
  def new
    @cabplaegreso = Cabplaegreso.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cabplaegreso }
    end
  end

  # GET /cabplaegresos/1/edit
  def edit
    @cabplaegreso = Cabplaegreso.find(params[:id])
    @cajaingreso = Cabplaegreso.cajaingresocerrada(@cabplaegreso.id[0], @cabplaegreso.id[1]) 

    userrol =[]
    role = [5, 6, 7]
    userrol = session[:user].roles.collect { |rol| rol.id.to_i }
    inter = role & userrol
     if ((inter.length >= 1) || (@cabplaegreso.cpeg_cerrada.to_s == "N"))
      else
        if @cajaingreso.size > 0 
         render :text => "<h7>La planilla de egreso que intenta editar esta asociada a una caja de ingreso. NO SE PUEDE MODIFICAR.</h7>",  :layout => 'application' 
        end
     end
  end

  # POST /cabplaegresos
  # POST /cabplaegresos.xml
  def create
    @cabplaegreso = Cabplaegreso.new(params[:cabplaegreso])
    #busco el ultimo id por sucursal y calculo el siguiente 
    idplanilla = Cabplaegreso.maximum(:id, :conditions => ["sucursal_id = ?", session[:sucursal]]) 
    @cabplaegreso.id = [idplanilla.to_i + 1, session[:sucursal]]
    @cabplaegreso.cpeg_cerrada = 'N'
    @cabplaegreso.cpeg_control = 'N'
    @cabplaegreso.cpeg_exportada = 'N'
    @cabplaegreso.cpeg_importe = 0
    @cabplaegreso.cpeg_fecharegistro = "0000-00-00"
    @cabplaegreso.cpeg_ultmod = DateTime.now
    @cabplaegreso.cpeg_usuario = session[:user].usur_nombre
    $nroplaegant = (@cabplaegreso.cpeg_nroplanilla.to_i - 1)
    $sucursal = session[:sucursal]
    respond_to do |format|
      if @cabplaegreso.save
        flash[:notice] = 'La planilla de egreso ha sido creada.'
        format.html { redirect_to(:controller => 'cabplaegresos', :action => 'index')}
        format.xml  { render :xml => @cabplaegreso, :status => :created, :location => @cabplaegreso }
      else
        format.html { render :action => "new"}
        format.xml  { render :xml => @cabplaegreso.errors, :status => :unprocessable_entity }
      end
    end
  end

  def formapago
     @totalproveedors = Cabplaegreso.totalproveedor(params[:idpe][0], session[:sucursal])
  end

   def verformapago
     @totalproveedors = Cabplaegreso.totalproveedor(params[:idpe][0], session[:sucursal])
     @planillaegreso = Cabplaegreso.find(params[:idpe])
  end
   
  def retganancia
     @cabplaegreso = Cabplaegreso.find(params[:idpe])
     @retencionganancias = Cabplaegreso.retencionganancia(@cabplaegreso.id[0], params[:fecha], session[:sucursal])
  end
  

  # PUT /cabplaegresos/1
  # PUT /cabplaegresos/1.xml
  def update
    @cabplaegreso = Cabplaegreso.find(params[:id])
    @totalproveedors = Cabplaegreso.totalproveedor(@cabplaegreso.id[0], session[:sucursal])
    @retencionganancias = Cabplaegreso.retencionganancia(@cabplaegreso.id[0], @cabplaegreso.cpeg_fecha,  session[:sucursal])
    
    comprobantepagonulosarray = []
    for totalproveedor in @totalproveedors
       @comprobantepagonulos = Cabplaegreso.comprobantepagonulo(totalproveedor.cabplaegreso_id, totalproveedor.proveedor_id, totalproveedor.conceptoegreso_id, session[:sucursal])
      if @comprobantepagonulos.size > 0
       comprobantepagonulosarray << 1
      end
    end

    if ((@totalproveedors.size > 0) && (params[:cabplaegreso][:cpeg_cerrada].to_s == 'S') && (comprobantepagonulosarray.size > 0))
      respond_to do |format|
        format.html{ redirect_to(:controller => 'cabplaegresos', :action => 'formapago', :id => 1, :idpe => @cabplaegreso.id, :nroplanillaegreso => @cabplaegreso.cpeg_nroplanilla.to_i)}
        format.xml  { head :ok }
      end  
    elsif 
       (@retencionganancias.size > 0 && (params[:cabplaegreso][:cpeg_cerrada].to_s == 'S'))
        respond_to do |format|
        format.html{ redirect_to(:controller => 'cabplaegresos', :action => 'retganancia', :id => 1, :idpe => @cabplaegreso.id, :nroplanillaegreso => @cabplaegreso.cpeg_nroplanilla.to_i, :fecha => @cabplaegreso.cpeg_fecha)}
        format.xml  { head :ok }
       end  
    else
      retganpe = 0
    #  importe =  Cabcompra.sum(:ccom_total, :conditions => ['cabplaegreso_id = ? and sucursal_id = ?', @cabplaegreso.id[0], session[:sucursal]])

      @total = Cabplaegreso.totalpe(@cabplaegreso.id[0], session[:sucursal])
      importe = 0
      @total.each do |tot|
       importe = tot.total.to_d if tot.total
      end
      retganpe = Retencionganancia.sum(:rtga_importe, :conditions => ['rtga_plaegresoid = ? and sucursal_id = ?', @cabplaegreso.id[0], session[:sucursal]])
      @cabplaegreso.cpeg_importe = (importe - retganpe)
      @cabplaegreso.cpeg_ultmod = DateTime.now
      @cabplaegreso.cpeg_usuario = session[:user].usur_nombre
      $nroplaegant = (@cabplaegreso.cpeg_nroplanilla.to_i - 1)
      $sucursal = session[:sucursal]
      $nroplaeg = @cabplaegreso.cpeg_nroplanilla.to_i
      $idpeg = @cabplaegreso.id[0]
      $cerrar = params[:cabplaegreso][:cpeg_cerrada]
      #grabar renglones de planilla de egresos
      if (params[:cabplaegreso][:cpeg_cerrada].to_s == 'S')
       borrarenglones()
       grabarenglones()
      end
      respond_to do |format|
        if @cabplaegreso.update_attributes(params[:cabplaegreso])
          flash[:notice] = 'La planilla de egreso ha sido modificada.'
          format.html{ redirect_to(:controller => 'cabplaegresos', :action => 'index')}
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @cabplaegreso.errors, :status => :unprocessable_entity }
        end
      end
    end
 end

 def borrarenglones
    str_tokens = @cabplaegreso.id.to_s.split(",") 
    @renglonespe = Renplaegreso.find(:all, :conditions => ["cabplaegreso_id = ? and sucursal_id = ?",  str_tokens[0].lstrip.to_i, str_tokens[1].lstrip.to_i])
    @renglonespe.each do |ren|
       ren.destroy
    end
 end

 def grabarenglones
   str_tokens = @cabplaegreso.id.to_s.split(",") 
   @porconceptos = Cabplaegreso.agrupconcepto(str_tokens[0].lstrip.to_i, str_tokens[1].lstrip.to_i)
   @porconceptos.each do |concepto|
     idrenglon = Renplaegreso.maximum(:id, :conditions => ["sucursal_id = ?", session[:sucursal]]) 
     @renplaegreso = Renplaegreso.new
     @renplaegreso.id = [idrenglon.to_i + 1, session[:sucursal]]
     @renplaegreso.conceptoegreso_id = concepto.conceptoegreso_id
     #trae las ret de gan para esa plaeg y ese rubro
     sumaret = 0
     @retenciongancids = Cabplaegreso.retenciongancid(concepto.conceptoegreso_id, concepto.cabplaegreso_id, session[:sucursal])
        @retenciongancids.each do |retganimp|
           sumaret = sumaret + retganimp.importeretg.to_d
        end 
     @renplaegreso.rpeg_importe = (concepto.total.to_d - sumaret)
     @renplaegreso.cabplaegreso_id = concepto.cabplaegreso_id
     @renplaegreso.rpeg_usuario = session[:user].usur_nombre 
     @renplaegreso.rpeg_ultmod = DateTime.now
     @renplaegreso.save
   end
 end  

 def verfp
   @pagocompra = Pagocompra.find(params[:id])
   render :partial => "verfp"
 end


  # DELETE /cabplaegresos/1
  # DELETE /cabplaegresos/1.xml
  def destroy
    @cabplaegreso = Cabplaegreso.find(params[:id])
    @cabplaegreso.destroy

    respond_to do |format|
      format.html { redirect_to(cabplaegresos_url) }
      format.xml  { head :ok }
    end
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

 def consulta
   fechas()
   @consultas = Cabplaegreso.consulta(params[:fechadesde], params[:fechahasta], params[:proveedor], params[:conceptoegreso], session[:sucursal])
    respond_to do |format|
       format.html 
       format.xml  { render :xml => @consultas  }
       prawnto :prawn => {
       :page_size => 'A4'}
       format.pdf  { render :layout => false }
     end
 end
end
