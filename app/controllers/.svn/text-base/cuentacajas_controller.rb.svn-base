class CuentacajasController < ApplicationController
   before_filter :login_required
   access_control [:index, :list, :new, :create, :update, :edit, :show, :destroy] => '( rol 7 )'
                 
  def permission_denied
    flash[:notice] = "Usted no tiene los privilegios para realizar esta acción." 
    return redirect_to(:controller => 'login', :action => 'denied')
  end

  # GET /cuentacajas
  # GET /cuentacajas.xml
  def index
    
    @cuentacajas = Cuentacaja.paginate(:per_page => 20, :page => params[:page] || 1, :joins => [:plandecuenta], :conditions => ['plandecuentas.pcue_descripcion like ?', "%#{params[:concepto]}%"])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cuentacajas }
    end
  end

  # GET /cuentacajas/1
  # GET /cuentacajas/1.xml
  def show
    @cuentacaja = Cuentacaja.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cuentacaja }
    end
  end

  # GET /cuentacajas/new
  # GET /cuentacajas/new.xml
  def new
    @cuentacaja = Cuentacaja.new
    @plandecuentas = Plandecuenta.find(:all, :order => 'pcue_cuenta')
    @sucursals = Sucursal.find(:all)
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cuentacaja }
    end
  end

  # GET /cuentacajas/1/edit
  def edit
    @cuentacaja = Cuentacaja.find(params[:id])
    @plandecuentas = Plandecuenta.find(:all, :order => 'pcue_cuenta')
    @sucursals = Sucursal.find(:all)
  end

  # POST /cuentacajas
  # POST /cuentacajas.xml
  def create
    @cuentacaja = Cuentacaja.new(params[:cuentacaja])
    @cuentacaja.ccaj_ultmod = DateTime.now
    @cuentacaja.ccaj_usuario = session[:user].usur_nombre
    respond_to do |format|
      if @cuentacaja.save
        flash[:notice] = 'La cuenta de caja ha sido creada.'
        pag = (params[:valor][:page].to_i > 0 ? params[:valor][:page] : 1)
        format.html { redirect_to(:controller => 'cuentacajas', :action => 'index', :page => pag )}
     
        format.xml  { render :xml => @cuentacaja, :status => :created, :location => @cuentacaja }
      else
        @plandecuentas = Plandecuenta.find(:all, :order => 'pcue_cuenta')
        @sucursals = Sucursal.find(:all)
        format.html { render :action => "new" }
        format.xml  { render :xml => @cuentacaja.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cuentacajas/1
  # PUT /cuentacajas/1.xml
  def update
    @cuentacaja = Cuentacaja.find(params[:id])
    @cuentacaja.ccaj_ultmod = DateTime.now
    @cuentacaja.ccaj_usuario = session[:user].usur_nombre
    respond_to do |format|
      if @cuentacaja.update_attributes(params[:cuentacaja])
        flash[:notice] = 'La cuenta de caja ha sido actualizada.'
        pag = (params[:valor][:page].to_i > 0 ? params[:valor][:page] : 1)
        format.html { redirect_to(:controller => 'cuentacajas', :action => 'index', :page => pag )}
     
        format.xml  { head :ok }
      else
        @plandecuentas = Plandecuenta.find(:all, :order => 'pcue_cuenta')
        @sucursals = Sucursal.find(:all)
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cuentacaja.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cuentacajas/1
  # DELETE /cuentacajas/1.xml
  def destroy
    @cuentacaja = Cuentacaja.find(params[:id])
    @cuentacaja.destroy

    respond_to do |format|
      format.html { redirect_to(cuentacajas_url) }
      format.xml  { head :ok }
    end
  end
end
