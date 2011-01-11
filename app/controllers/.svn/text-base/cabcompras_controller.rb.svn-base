class CabcomprasController < ApplicationController
   before_filter :login_required
   access_control [:index, :list, :new, :create,  :show, :destroy, :renglones, :grabarenglonescompra, :comprobantes, :fechas] => '(rol 2 | rol 3 | rol 4 | rol 5 | rol 6 | rol 7)',
[:update, :edit] => '( rol 5  | rol 6 | rol 7)'

auto_complete_forprovsucursal  :proveedor, :prov_cuit,  :limit => 15

  def permission_denied
    flash[:notice] = "Usted no tiene permiso para realizar esta acción." 
    return redirect_to(:controller => 'login', :action => 'denied')
  end

  # GET /cabcompras
  # GET /cabcompras.xml
  def index
    @cabcompras = Cabcompra.find(:all, :conditions => ["cabplaegreso_id = ? and sucursal_id = ?", params[:idpe].to_i, session[:sucursal]], :order => 'id DESC')
    @cabplaegreso = Cabplaegreso.find_by_id(params[:idpe], session[:sucursal])
    @cabcompra = Cabcompra.new
    @tipocomprobantes = Tipocomprobante.find(:all, :conditions => ["tcom_ambitocompra = ?", "S"], :order => "tcom_codigo")
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cabcompras }
      prawnto :prawn => {
      :page_size => 'A4'}
      format.pdf  { render :layout => false }
    end
  end

  def fechas
    params[:fechadesde] = convierte_fecha(params[:fechadesde]) if !params[:fechadesde].blank?
    params[:fechahasta] = convierte_fecha(params[:fechahasta]) if !params[:fechahasta].blank?
  end

  def comprobantes
    fechas()
    @cabcompras = Cabcompra.find(:all, :conditions => ["cabplaegreso_id = ? and sucursal_id = ? and ccom_fecha >= ? and ccom_fecha <= ?", params[:idpe].to_i, session[:sucursal], params[:fechadesde], params[:fechahasta]], :order => 'id DESC')
    @cabplaegreso = Cabplaegreso.find_by_id(params[:idpe], session[:sucursal])
    @cabcompra = Cabcompra.new
    @tipocomprobantes = Tipocomprobante.find(:all, :conditions => ["tcom_ambitocompra = ?", "S"], :order => "tcom_codigo")
    @total = Cabcompra.totalpe(0, session[:sucursal], params[:fechadesde], params[:fechahasta])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cabcompras }
    end
  end
  # GET /cabcompras/1
  # GET /cabcompras/1.xml
  def show
    @cabcompra = Cabcompra.find(params[:id])
    str_tokens = @cabcompra.id.to_s.split(",") 
    @rencompras = Rencompra.find(:all, :conditions => ["cabcompra_id = ? and sucursal_id = ?", str_tokens[0].lstrip.to_i, str_tokens[1].lstrip.to_i])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cabcompra }
    end
  end

  # GET /cabcompras/new
  # GET /cabcompras/new.xml
  def new
    @cabcompra = Cabcompra.new
    @rencompra = Rencompra.new
    @cabplaegreso = Cabplaegreso.find([params[:idpe], session[:sucursal]])
    @tipocomprobantes = Tipocomprobante.find(:all, :order =>"tcom_nombre")
  # @proveedores = Proveedor.find(:all, :conditions => ['sucursal_id = ?', session[:sucursal]], :order =>"prov_nombre")
    @jurisdiccions = Jurisdiccion.find(:all, :order =>"juri_nombre")
    @conceptoegresos = Conceptoegreso.find(:all, :order =>"cegr_detalle")
    @alicuotaivas = Alicuotaiva.find(:all) 
    if params[:cabcompra].nil? 
      @iva = Tipocomprobante.find(1)
    else
      @iva = Tipocomprobante.find(params[:cabcompra][:tipocomprobante_id]) 
    end
  end

  # GET /cabcompras/1/edit
  def edit
    @cabcompra = Cabcompra.find(params[:id])
    @iva = Tipocomprobante.find(@cabcompra.tipocomprobante_id) 
    @alicuotaivas = Alicuotaiva.find(:all) 
    @cabplaegreso = Cabplaegreso.find(@cabcompra.cabplaegreso_id, session[:sucursal])
    @tipocomprobantes = Tipocomprobante.find(:all, :order =>"tcom_nombre")
    @proveedor = Proveedor.find(@cabcompra.proveedor_id, @cabcompra.sucursal_id)
    @jurisdiccions = Jurisdiccion.find(:all, :order =>"juri_nombre")
    @conceptoegresos = Conceptoegreso.find(:all, :order =>"cegr_detalle")
    str_tokens = @cabcompra.id.to_s.split(",") 
    @rencompras = Rencompra.find(:all, :conditions => ["cabcompra_id = ? and sucursal_id = ?", str_tokens[0].lstrip.to_i, str_tokens[1].lstrip.to_i])
    @edita = 1
  end

  # POST /cabcompras
  # POST /cabcompras.xml
  def create
   Cabcompra.transaction do
    @cabcompra = Cabcompra.new(params[:cabcompra])
    @comprobante =  Tipocomprobante.find(@cabcompra.tipocomprobante_id)
    if ((@comprobante.tcom_discriminaiva.to_s == 'No') || ((params[:rencompras][:rcom_netorenglon].nil?) || (params[:rencompras][:rcom_netorenglon][0].to_i > 0)))
      idplanilla = Cabcompra.maximum(:id, :conditions => ["sucursal_id = ?", session[:sucursal]]) 
      @cabcompra.id = [idplanilla.to_i + 1, session[:sucursal]]
      # busco y grabo proveedor_id 
      str_tokens = ""
      str_tokens = params[:proveedor][:prov_cuit].split("|") if params[:proveedor]
    
      @proveedor = Proveedor.find(:first, :conditions => ["sucursal_id = ? and prov_codigo = ? ", session[:sucursal], str_tokens[2].lstrip] ) if str_tokens[2] 
      @cabcompra.proveedor_id = @proveedor.id[0]  if str_tokens[2] 
      $proveedor = @proveedor.id[0] if str_tokens[2] #para la validacion de proveedores 1 y 2
      @proveedor.prov_cuit = params[:proveedor][:prov_cuit].to_s if str_tokens[2] # por si vuelve con error
      @cabcompra.ccom_ultmod = DateTime.now
      @cabcompra.ccom_usuario = session[:user].usur_nombre
      @cabcompra.ccom_hastacompro = (params[:cabcompra][:ccom_hastacompro].nil? || params[:cabcompra][:ccom_hastacompro].to_i == 0) ? params[:cabcompra][:ccom_desdecompro] : params[:cabcompra][:ccom_hastacompro]
      str_tokens = @cabcompra.id.to_s.split(",") 
      $plaegid = params[:cabcompra][:cabplaegreso_id]
      $sucursal = session[:sucursal]
      #graba compra o gasto segun el comprobante tenga o no iva
      if (params[:cabcompra][:ccom_iva].nil? || params[:cabcompra][:ccom_iva].to_d == 0 )
        @cabcompra.ccom_gastocompra = 'GASTO'
      else
        @cabcompra.ccom_gastocompra = 'COMPRA'
      end
      @cabcompra.ccom_gastocompra = 'COMPRA' if  @comprobante.tcom_cabecera.to_s == 'S' #para los comprobantes de retenciones
      respond_to do |format|
        if @cabcompra.save
          if ((@comprobante.tcom_discriminaiva.to_s == 'Si') && (params[:rencompras][:rcom_netorenglon][0].to_d > 0) && @comprobante.tcom_cabecera.to_s == 'N') 
             grabarenglonescompra()
         end
        
        flash[:notice] = 'El comprobante ha sido creado.'
         if @cabcompra.cabplaegreso_id > 0
           format.html { redirect_to(:controller => 'cabcompras', :action => 'index', :nrope => @cabcompra.ccom_nroplaegreso, :idpe => @cabcompra.cabplaegreso_id) }
         else
            format.html { redirect_to(:controller => 'cabcompras', :action => 'comprobantes', :id => 0) }
         end
        format.xml  { render :xml => @cabcompra, :status => :created, :location => @cabcompra }
      else
        params[:idpe] = params[:cabcompra][:cabplaegreso_id]
        params[:nrope] =  params[:cabcompra][:ccom_nroplaegreso]
 
        @alicuotaivas = Alicuotaiva.find(:all) 
        @rencompra = Rencompra.new
        @jurisdiccions = Jurisdiccion.find(:all, :order =>"juri_nombre")
        @cabplaegreso = Cabplaegreso.find([params[:idpe], session[:sucursal]])
        @conceptoegresos = Conceptoegreso.find(:all, :order =>"cegr_detalle")
        @tipocomprobantes = Tipocomprobante.find(:all, :order =>"tcom_nombre")
        @iva = Tipocomprobante.find(@cabcompra.tipocomprobante_id) 
     
        format.html { render :action => "new" }
        format.xml  { render :xml => @cabcompra.errors, :status => :unprocessable_entity }
      end
    end
    else
     render :text => "<h7> El comprobante no se guardo porque no cargo ningun detalle (renglón) </h7>", :layout => 'application' 
    end
  end
 end
 
 def grabarenglonescompra
     i = 0
     params[:rencompras][:rcom_netorenglon].each { |reng|
        if reng.to_d > 0
   	 idrenglon = Rencompra.maximum(:id, :conditions => ["sucursal_id = ?", session[:sucursal]]) 
   	 @rengloncompra = Rencompra.new
    	 @rengloncompra.id = [idrenglon.to_i + 1, session[:sucursal]]
  	 str_tokens = @cabcompra.id.to_s.split(",") 
  	 @rengloncompra.cabcompra_id = str_tokens[0].lstrip.to_i
         @alicuota = Alicuotaiva.find_by_aiva_alicuota(params[:rencompras][:alicuota][i])
  	 @rengloncompra.alicuotaiva_id = @alicuota.id
   	 @rengloncompra.rcom_netorenglon = reng.to_d
  	 # @alicuota = Alicuotaiva.find_by_id(params[:rencompras][:alicuotaiva_id].to_i)
 	 # iva = (params[:rencompras][:rcom_netorenglon].to_d * (@alicuota.aiva_alicuota.to_d/100))
  	 # @rengloncompra.rcom_ivarenglon = iva
   	 # @rengloncompra.rcom_totalrenglon = (params[:rencompras][:rcom_netorenglon].to_d + iva)
	 @rengloncompra.rcom_ivarenglon = params[:rencompras][:rcom_ivarenglon][i].to_d
         @rengloncompra.rcom_totalrenglon = params[:rencompras][:rcom_totalrenglon][i].to_d
   	 @rengloncompra.rcom_usuario = session[:user].usur_nombre 
   	 @rengloncompra.rcom_ultmod = DateTime.now
  	 @rengloncompra.save
        end 
      i += 1  }
  end
  # PUT /cabcompras/1
  # PUT /cabcompras/1.xml
  def update
    @cabcompra = Cabcompra.find(params[:id])
    @cabcompra.ccom_ultmod = DateTime.now
    @cabcompra.ccom_usuario = session[:user].usur_nombre
    $plaegid = params[:cabcompra][:cabplaegreso_id]
    $sucursal = session[:sucursal]
    #para la validacion de nro de comprobante en el update
    $desdecompro = params[:cabcompra][:ccom_desdecompro]
    $proveedor =   @cabcompra.proveedor_id
    $tipocomp =  params[:cabcompra][:tipocomprobante_id]
    $ptoventa = params[:cabcompra][:ccom_puntosventa]
    $id = params[:id]

    nroplaeg = params[:cabcompra][:ccom_nroplaegreso]
    respond_to do |format|
      if @cabcompra.update_attributes(params[:cabcompra])
        flash[:notice] = 'El comprobante ha sido modificado.'
        format.html { redirect_to(:controller => 'cabcompras', :action => 'index', :nrope => nroplaeg, :idpe =>  $plaegid) }
        format.xml  { head :ok }
      else
        @iva = Tipocomprobante.find(@cabcompra.tipocomprobante_id) 
        @alicuotaivas = Alicuotaiva.find(:all) 
        @tipocomprobantes = Tipocomprobante.find(:all, :order =>"tcom_nombre")
        @proveedor = Proveedor.find(@cabcompra.proveedor_id, @cabcompra.sucursal_id)
        @jurisdiccions = Jurisdiccion.find(:all, :order =>"juri_nombre")
        @conceptoegresos = Conceptoegreso.find(:all, :order =>"cegr_detalle")
        str_tokens = @cabcompra.id.to_s.split(",") 
        @rencompras = Rencompra.find(:all, :conditions => ["cabcompra_id = ? and sucursal_id = ?", str_tokens[0].lstrip.to_i, str_tokens[1].lstrip.to_i])
        @edita = 1
        params[:idpe] =  $plaegid
        params[:nrope] = nroplaeg
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cabcompra.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cabcompras/1
  # DELETE /cabcompras/1.xml
 def destroy
   @cabcompra = Cabcompra.find(params[:id])
   if @cabcompra.retencionganancia_id.to_i > 0
      render :text => "<h7> No se puede borrar el comprobante porque tiene asociada una retencion de ganancia. Primero borre la retención de ganancia. </h7>", :layout => 'application' 
   else
    Cabcompra.transaction do
      nroplaeg = @cabcompra.ccom_nroplaegreso
 
      idpe = @cabcompra.cabplaegreso_id
      #borra el comprobante de pago y le saca los pagocompra_id a los comprobantes afectados a dicho comp de pago
       if ((@cabcompra.pagocompra_id.nil?) || (@cabcompra.pagocompra_id.to_i == 0))
       else
         @comprobpagados = Cabcompra.find(:all, :conditions => ["sucursal_id = ? and pagocompra_id = ?", session[:sucursal], @cabcompra.pagocompra_id])
         @pagocompra = Pagocompra.find(@cabcompra.pagocompra_id, session[:sucursal])
         @comprobpagados.each do |cp|
         cp.update_attribute(:pagocompra_id, nil) 
      end
      @pagocompra.destroy
    end
     #borra la retencion de ganancia y le saca los retencionganancia_id a los comprobantes afectados a dicha retenciongan
    if ((@cabcompra.retencionganancia_id.nil?) || (@cabcompra.retencionganancia_id.to_i == 0))
    else
      @comprobretgan = Cabcompra.find(:all, :conditions => ["sucursal_id = ? and retencionganancia_id = ?", session[:sucursal], @cabcompra.retencionganancia_id])
      @retencion = Retencionganancia.find(@cabcompra.retencionganancia_id, session[:sucursal])
      @comprobretgan.each do |cp|
         cp.update_attribute(:retencionganancia_id, nil) 
      end
      @retencion.destroy
    end
    #borra renglones del comprobante
    str_tokens = @cabcompra.id.to_s.split(",") 
    @renglones = Rencompra.find(:all, :conditions => ["cabcompra_id = ? and sucursal_id = ?",  str_tokens[0].lstrip.to_i, str_tokens[1].lstrip.to_i])
    @renglones.each do |ren|
       ren.destroy
  end

    @cabcompra.destroy
     
    respond_to do |format|
      if idpe > 0
        format.html { redirect_to(:controller => 'cabcompras', :action => 'index', :nrope => nroplaeg, :idpe => idpe) }
      else
        format.html { redirect_to(:controller => 'cabcompras', :action => 'comprobantes', :id => 0)}
      end
      format.xml  { head :ok }
    end
  end
 end
 end

 def renglones
  # @renglones = Rencompra.find(:all, :conditions => ["cabcompra_id = ? and sucursal_id = ?", params[:idcabcompra][0], params[:idcabcompra][1] ])
  # render :partial => "renglones"
 end

 def tipocomp
  # @cabcompra = Cabcompra.new
  # @tipocomprobantes = Tipocomprobante.find(:all)
  # render :partial => "tipocomp", :object => @cabcompra
 end

end
