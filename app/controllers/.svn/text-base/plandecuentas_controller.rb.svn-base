class PlandecuentasController < ApplicationController
   before_filter :login_required
   access_control [:index, :list, :new, :create, :update, :edit, :show, :destroy] => '(rol 6 | rol 7 )'
                 
  def permission_denied
    flash[:notice] = "Usted no tiene permiso para realizar esta acción." 
    return redirect_to(:controller => 'login', :action => 'denied')
  end

  # GET /plandecuentas
  # GET /plandecuentas.xml
  def index
   # @plandecuentas = Plandecuenta.paginate(:per_page => 20, :page => params[:page] || 1, :conditions => ['pcue_descripcion like ?', "%#{params[:cuenta]}%"])
    @plandecuentas = Plandecuenta.find(:all, :order => ['pcue_cuenta, pcue_nivel'])
    @naturalezas = ["Activo", "Pasivo", "PatrimonioNeto", "Resultados", "CuentadeOrden"]
    @niveles = ["1", "2", "3", "4", "5"] 
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @plandecuentas }
    end
  end

  # GET /plandecuentas/1
  # GET /plandecuentas/1.xml
  def show
    @plandecuenta = Plandecuenta.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @plandecuenta }
    end
  end

  # GET /plandecuentas/new
  # GET /plandecuentas/new.xml
  def new
    @plandecuenta = Plandecuenta.new
    @sucursales = Sucursal.find(:all, :order =>"sucu_nombre")
    render :partial => "new"
  end

  # GET /plandecuentas/1/edit
  def edit
    @plandecuenta = Plandecuenta.find(params[:id])
    @sucursales = Sucursal.find(:all, :order =>"sucu_nombre")
  
  end

  def editar
    @plandecuenta = Plandecuenta.find(params[:id])
    @sucursales = Sucursal.find(:all, :order =>"sucu_nombre")
    render :partial => 'plandecuentas/editar', :object => @plandecuenta 
  end

  # POST /plandecuentas
  # POST /plandecuentas.xml
  def create
    @plandecuenta = Plandecuenta.new(params[:plandecuenta])
    @plandecuenta.pcue_ultmod = DateTime.now
    @plandecuenta.pcue_usuario = session[:user].usur_nombre
    @plandecuenta.sucursal_id = 0 if params[:plandecuenta][:sucursal_id].blank?
    respond_to do |format|
      if @plandecuenta.save
        flash[:notice] = 'La cuenta ha sido creada'
        format.html { redirect_to(:controller => 'plandecuentas', :action => 'index')}
        format.xml  { render :xml => @plandecuenta, :status => :created, :location => @plandecuenta }
      else
        @sucursales = Sucursal.find(:all, :order =>"sucu_nombre")
        params[:cuentap] = @plandecuenta.pcue_padre
        params[:naturaleza] = @plandecuenta.pcue_naturaleza
        params[:nivel] = (@plandecuenta.pcue_nivel.to_s.to_i - 1).to_s
        format.html { render :partial => "new", :layout => 'application'}
        format.xml  { render :xml => @plandecuenta.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /plandecuentas/1
  # PUT /plandecuentas/1.xml
  def update
    @plandecuenta = Plandecuenta.find(params[:id])
    @plandecuenta.pcue_ultmod = DateTime.now
    @plandecuenta.pcue_usuario = session[:user].usur_nombre
    respond_to do |format|
      if @plandecuenta.update_attributes(params[:plandecuenta])
        flash[:notice] = 'La cuenta ha sido modificada.'
        format.html { redirect_to(:controller => 'plandecuentas', :action => 'index')}
        format.xml  { head :ok }
      else
        @sucursales = Sucursal.find(:all, :order =>"sucu_nombre")
       format.html {  render :partial => 'plandecuentas/editar', :object => @plandecuenta, :layout => 'application'}
        format.xml  { render :xml => @plandecuenta.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /plandecuentas/1
  # DELETE /plandecuentas/1.xml
  def destroy
    @plandecuenta = Plandecuenta.find(params[:id])
    @plandecuenta.destroy

    respond_to do |format|
      format.html { redirect_to(plandecuentas_url) }
      format.xml  { head :ok }
    end
  end
end
