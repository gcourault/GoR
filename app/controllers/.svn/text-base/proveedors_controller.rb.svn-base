class ProveedorsController < ApplicationController

  auto_complete_forlocalidadprov  :localidad, :loca_nombre,  :limit => 15
  # GET /proveedors
  # GET /proveedors.xml
  def index
    if (params[:cuitc]!= nil)
      @proveedors = Proveedor.paginate :per_page => 20, :page => params[:page] || 1, :conditions => ['sucursal_id = ? and prov_cuit = ? ' , session[:sucursal], "#{params[:cuit]}"] 
    else
      @proveedors = Proveedor.paginate :per_page => 20, :page => params[:page] || 1, :conditions => ['sucursal_id = ? and prov_nombre like ? ' , session[:sucursal], "%#{params[:razonsocial]}%"] 
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @proveedors }
    end
  end

  # GET /proveedors/1
  # GET /proveedors/1.xml
  def show
    @proveedor = Proveedor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @proveedor }
    end
  end

  # GET /proveedors/new
  # GET /proveedors/new.xml
  def new
    @proveedor = Proveedor.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @proveedor }
    end
  end

  # GET /proveedors/1/edit
  def edit
    @proveedor = Proveedor.find(params[:id])
    @localidad = Localidad.find(@proveedor.localidad_id) if @proveedor.localidad_id
  end

  # POST /proveedors
  # POST /proveedors.xml
  def create
    @proveedor = Proveedor.new(params[:proveedor])
    idproveedor = Proveedor.maximum(:id, :conditions => ["sucursal_id = ?", session[:sucursal]]) 
    @proveedor.id = [idproveedor.to_i + 1, session[:sucursal]]
    codproveedor = Proveedor.maximum(:prov_codigo, :conditions => ["sucursal_id = ?", session[:sucursal]]) 
    @proveedor.prov_codigo = codproveedor.to_i + 1
    # grabo localidad
    str_tokens = ""
    str_tokens = params[:localidad][:loca_nombre].split("|") if params[:localidad]
    #@localidad = Localidad.find(:first, :conditions => ["id = ? ", str_tokens[3].lstrip] ) 
 
    @localidad = Localidad.find(:first, :conditions => ["id = ? ", str_tokens[3].lstrip] ) if str_tokens[3] 
    @proveedor.localidad_id = @localidad.id  if str_tokens[3]     
 #@proveedor.localidad_id = @localidad.id 

   # @proveedor.localidad_id = str_tokens[3].lstrip if str_tokens[3]
    @localidad.loca_nombre = params[:localidad][:loca_nombre].to_s if str_tokens[3]
    @proveedor.prov_ultmod = DateTime.now
    @proveedor.prov_usuario = session[:user].usur_nombre
    respond_to do |format|
      if @proveedor.save
        flash[:notice] = 'El proveedor ha sido creado'
        format.html { redirect_to(:controller => 'proveedors', :action => 'index') }
        format.xml  { render :xml => @proveedor, :status => :created, :location => @proveedor }
      else
      #  @localidad.loca_nombre = str_tokens[3].lstrip if str_tokens[3]
        format.html { render :action => "new" }
        format.xml  { render :xml => @proveedor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /proveedors/1
  # PUT /proveedors/1.xml
  def update
    @proveedor = Proveedor.find(params[:id])
    @proveedor.prov_ultmod = DateTime.now
    @proveedor.prov_usuario = session[:user].usur_nombre
    str_tokens = params[:localidad][:loca_nombre].split("|") 
    @proveedor.localidad_id = str_tokens[3].lstrip if str_tokens[3]
    @proveedor.localidad_id = params[:localidad][:id] if !str_tokens[3]

    respond_to do |format|
      if @proveedor.update_attributes(params[:proveedor])
        pag = (params[:valor][:page].to_i > 0 ? params[:valor][:page] : 1)
        flash[:notice] = 'El proveedor ha sido modificado'
        format.html { redirect_to(:controller => 'proveedors', :action => 'index', :page => pag )}
        format.xml  { head :ok }
      else
        @localidad = Localidad.find(@proveedor.localidad_id)
        format.html { render :action => "edit" }
        format.xml  { render :xml => @proveedor.errors, :status => :unprocessable_entity }
      end
    end
  end

end
