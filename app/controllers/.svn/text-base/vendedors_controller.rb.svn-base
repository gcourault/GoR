class VendedorsController < ApplicationController
  # GET /vendedors
  # GET /vendedors.xml
   before_filter :login_required
   access_control [:index, :list, :new, :create, :update, :edit, :show, :informevendedor] => '( rol 5 | rol 6 | rol 7)'

  def permission_denied
    flash[:notice] = "Usted no tiene permiso para realizar esta acción." 
    return redirect_to(:controller => 'login', :action => 'denied')
  end
  def index
   # fechas()
        if params[:fechadesde].blank? || params[:fechadesde].to_s.length == 10 
         else
         params[:fechadesde] = convierte_fecha(params[:fechadesde])
        end
        if params[:fechahasta].blank? || params[:fechahasta].to_s.length == 10
        else
         params[:fechahasta] = convierte_fecha(params[:fechahasta])
       end
    @vendedors = Vendedor.all
    @vendedor = Vendedor.find_by_id(params[:id])
    @revendedors = Revendedor.find_all_by_vendedor_id(params[:id])
    @revendedors = Vendedor.reveendedorfact(params[:id], params[:fechadesde], params[:fechahasta], session[:sucursal])
    @totalvendedors = Vendedor.totalvendedor(params[:fechadesde], params[:fechahasta], session[:sucursal])
    @totalrevendedors = Vendedor.totalrevendedor(params[:fechadesde], params[:fechahasta], session[:sucursal])
    @totalpropios = Vendedor.totalpropio(params[:fechadesde], params[:fechahasta], session[:sucursal])
    @comisions = Vendedor.comision(params[:fechadesde], params[:fechahasta], session[:sucursal])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @vendedors }
    end
  end

  def detallerevendedores
   @revendedors = Vendedor.reveendedorfact(params[:id], params[:fechadesde], params[:fechahasta], session[:sucursal])
   render :partial => "detallerevendedores"
  end
  
  # GET /vendedors/1
  # GET /vendedors/1.xml
  def show
    @vendedor = Vendedor.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @vendedor }
    end
  end

  # GET /vendedors/new
  # GET /vendedors/new.xml
  def new
    @vendedor = Vendedor.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @vendedor }
    end
  end
  
  # GET /vendedors/1/edit
  def edit
    @vendedor = Vendedor.find(params[:id])
  end

  # POST /vendedors
  # POST /vendedors.xml
  def create
    @vendedor = Vendedor.new(params[:vendedor])
    respond_to do |format|
      if @vendedor.save
        flash[:notice] = 'Vendedor was successfully created.'
        format.html { redirect_to(@vendedor) }
        format.xml  { render :xml => @vendedor, :status => :created, :location => @vendedor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @vendedor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /vendedors/1
  # PUT /vendedors/1.xml
  def update
    @vendedor = Vendedor.find(params[:id])
    respond_to do |format|
      if @vendedor.update_attributes(params[:vendedor])
        flash[:notice] = 'Vendedor was successfully updated.'
        format.html { redirect_to(@vendedor) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @vendedor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /vendedors/1
  # DELETE /vendedors/1.xml
  def destroy
    @vendedor = Vendedor.find(params[:id])
    @vendedor.destroy

    respond_to do |format|
      format.html { redirect_to(vendedors_url) }
      format.xml  { head :ok }
    end
  end
end
