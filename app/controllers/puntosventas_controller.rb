class PuntosventasController < ApplicationController
   before_filter :login_required
   access_control [:index, :list, :new, :create, :update, :edit, :show] => '( rol 5 | rol 6 | rol 7)'

 def permission_denied
    flash[:notice] = "Usted no tiene permiso para realizar esta acción." 
    return redirect_to(:controller => 'login', :action => 'denied')
 end

  # GET /puntosventas
  # GET /puntosventas.xml
  def index
    @puntosventas = Puntosventa.all
    @puntosventas = Puntosventa.paginate(:per_page => 20, :page => params[:page] || 1)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @puntosventas }
    end
  end

  # GET /puntosventas/1
  # GET /puntosventas/1.xml
  def show
    @puntosventa = Puntosventa.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @puntosventa }
    end
  end

  # GET /puntosventas/new
  # GET /puntosventas/new.xml
  def new
    @puntosventa = Puntosventa.new
    @sucursales = Sucursal.find(:all, :order =>"sucu_nombre")
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @puntosventa }
    end
  end

  # GET /puntosventas/1/edit
  def edit
    @puntosventa = Puntosventa.find(params[:id])
    @sucursales = Sucursal.find(:all, :order =>"sucu_nombre")  
  end

  # POST /puntosventas
  # POST /puntosventas.xml
  def create
    @puntosventa = Puntosventa.new(params[:puntosventa])
    @puntosventa.pven_ultmod = DateTime.now
    @puntosventa.pven_usuario = session[:user].usur_nombre
    respond_to do |format|
      if @puntosventa.save
        flash[:notice] = 'El punto de venta ha sido ingresado.'
         format.html{ redirect_to(:controller => 'puntosventas', :action => 'index')}
        format.xml  { render :xml => @puntosventa, :status => :created, :location => @puntosventa }
      else
        @sucursales = Sucursal.find(:all, :order =>"sucu_nombre")
        format.html { render :action => "new" }
        format.xml  { render :xml => @puntosventa.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /puntosventas/1
  # PUT /puntosventas/1.xml
  def update
    @puntosventa = Puntosventa.find(params[:id])
    @puntosventa.pven_ultmod = DateTime.now
    @puntosventa.pven_usuario = session[:user].usur_nombre
    respond_to do |format|
      if @puntosventa.update_attributes(params[:puntosventa])
        flash[:notice] = 'El punto de venta ha sido modificado.'
         pag = (params[:valor][:page].to_i > 0 ? params[:valor][:page] : 1)
         format.html{ redirect_to(:controller => 'puntosventas', :action => 'index', :page => pag)}
        format.xml  { head :ok }
      else
        @sucursales = Sucursal.find(:all, :order =>"sucu_nombre")
        format.html { render :action => "edit" }
        format.xml  { render :xml => @puntosventa.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /puntosventas/1
  # DELETE /puntosventas/1.xml
  def destroy
    @puntosventa = Puntosventa.find(params[:id])
    @puntosventa.destroy

    respond_to do |format|
      format.html { redirect_to(puntosventas_url) }
      format.xml  { head :ok }
    end
  end
end
