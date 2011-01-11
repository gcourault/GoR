class ReclamosController < ApplicationController
  # GET /reclamos
  # GET /reclamos.xml
  #para control de acceso a metodos del controlador a traves de url
   before_filter :login_required
   access_control [:list, :new, :create, :update, :edit, :show] => '( rol 3 | rol 4  | rol 5  | rol 6 | rol 7)',
                 :index => '(rol 2 | rol 3 | rol 4  | rol 5  | rol 6 | rol 7)'
 
  def permission_denied
    flash[:notice] = "Usted no tiene permiso para realizar esta acción." 
    return redirect_to(:controller => 'usuario', :action => 'denied')
  end

  def index
     if (params[:prt]!=nil)
      reclamos = Reclamo.find(:all, :conditions => ['recl_nroprt LIKE ?', params[:nroprt].to_s])
      else
     reclamos = Reclamo.search( params[:nroint] , params[:cliente], params[:sucursal], params[:anio] )
     #@reclamos = Reclamo.all
     
     end
   
     @reclamos = reclamos.paginate(:per_page => 20, :page => params[:page] || 1)
   
     respond_to do |format|
      format.html { render :action => "index" } 
      format.xml  { render :xml => @reclamos }
      format.pdf  { render :layout => false }
      prawnto :prawn => {
      :page_size => 'A4'}
      format.pdf  { render :layout => false }
     end
  end

  def clientes
    @clientes = Cliente.clientes( params[:sucursal] )
    respond_to do |format|
    format.html
    format.xml { render :xml => @clientes }
    end
  end


  # GET /reclamos/1
  # GET /reclamos/1.xml
  def show
    @reclamo = Reclamo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @reclamo }
    end
  end

  # GET /reclamos/new
  # GET /reclamos/new.xml
  def new
    @reclamo = Reclamo.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @reclamo }
    end
 
  end

  # GET /reclamos/1/edit
  def edit
    @reclamo = Reclamo.find(params[:id])
  end

  # POST /reclamos
  # POST /reclamos.xml
  def create
    @reclamo = Reclamo.new(params[:reclamo])
    @reclamo.recl_ultmod = DateTime.now
    @reclamo.recl_usuario = session[:user].usur_nombre
    respond_to do |format|
      if @reclamo.save
        flash[:notice] = 'El Reclamo ha sido creado.'
        format.html { redirect_to(@reclamo) }
        format.xml  { render :xml => @reclamo, :status => :created, :location => @reclamo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @reclamo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /reclamos/1
  # PUT /reclamos/1.xml
  def update
    @reclamo = Reclamo.find(params[:id])
    @reclamo.recl_ultmod = DateTime.now
    @reclamo.recl_usuario = session[:user].usur_nombre
    respond_to do |format|
      if @reclamo.update_attributes(params[:reclamo])
        pag = (params[:valor][:page].to_i > 0 ? params[:valor][:page] : 1)
        flash[:notice] = 'Reclamo was successfully updated.'
        format.html { redirect_to(:controller => 'reclamos', :action => 'index', :sucursal => @reclamo.sucursal_id, :anio => (@reclamo.recl_fecha).year, :page => pag )} # vuelve a la pagina de consulta de cheques
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @reclamo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reclamos/1
  # DELETE /reclamos/1.xml
  def destroy
    @reclamo = Reclamo.find(params[:id])
    @reclamo.destroy

    respond_to do |format|
      format.html { redirect_to(reclamos_url) }
      format.xml  { head :ok }
    end
  end

end
