class ConceptoegresosController < ApplicationController
   before_filter :login_required
   access_control [:index, :list, :new, :create, :update, :edit, :show, :destroy] => '( rol 7 )'
                 
  def permission_denied
    flash[:notice] = "Usted no tiene permisos para realizar esta acción." 
    return redirect_to(:controller => 'login', :action => 'denied')
  end
  # GET /conceptoegresos
  # GET /conceptoegresos.xml
  def index
   # @conceptoegresos = Conceptoegreso.all
    @conceptoegresos = Conceptoegreso.paginate(:per_page => 20, :page => params[:page] || 1, :conditions => ['cegr_detalle like ?', "%#{params[:concepto]}%"])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @conceptoegresos }
    end
  end

  # GET /conceptoegresos/1
  # GET /conceptoegresos/1.xml
  def show
    @conceptoegreso = Conceptoegreso.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @conceptoegreso }
    end
  end

  # GET /conceptoegresos/new
  # GET /conceptoegresos/new.xml
  def new
    @conceptoegreso = Conceptoegreso.new
    @plandecuenta = Plandecuenta.find(:all, :order => 'pcue_cuenta')
    codigo = Conceptoegreso.maximum(:cegr_codigo)
    @codigonuevo = codigo.to_i + 1
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @conceptoegreso }
    end
  end

  # GET /conceptoegresos/1/edit
  def edit
    @conceptoegreso = Conceptoegreso.find(params[:id])
    @plandecuenta = Plandecuenta.find(:all, :order => 'pcue_cuenta')
  end

  # POST /conceptoegresos
  # POST /conceptoegresos.xml
  def create
    @conceptoegreso = Conceptoegreso.new(params[:conceptoegreso])
    @conceptoegreso.cegr_ultmod = DateTime.now
    @conceptoegreso.cegr_usuario = session[:user].usur_nombre
    @conceptoegreso.planimpositivo_id = 0
    respond_to do |format|
      if @conceptoegreso.save
        flash[:notice] = 'EL concepto de egreso ha sido creado.'
        pag = (params[:valor][:page].to_i > 0 ? params[:valor][:page] : 1)
        format.html { redirect_to(:controller => 'conceptoegresos', :action => 'index', :page => pag)}
       
      else
        @plandecuenta = Plandecuenta.find(:all, :order => 'pcue_cuenta')
        codigo = Conceptoegreso.maximum(:cegr_codigo)
        @codigonuevo = codigo.to_i + 1
        format.html { render :action => "new" }
        format.xml  { render :xml => @conceptoegreso.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /conceptoegresos/1
  # PUT /conceptoegresos/1.xml
  def update
    @conceptoegreso = Conceptoegreso.find(params[:id])
    @conceptoegreso.cegr_ultmod = DateTime.now
    @conceptoegreso.cegr_usuario = session[:user].usur_nombre
    respond_to do |format|
      if @conceptoegreso.update_attributes(params[:conceptoegreso])
        flash[:notice] = 'El concepto de egreso ha sido actualizado.'
        pag = (params[:valor][:page].to_i > 0 ? params[:valor][:page] : 1)
        format.html { redirect_to(:controller => 'conceptoegresos', :action => 'index', :page => pag )}
        format.xml  { head :ok }
      else
        @plandecuenta = Plandecuenta.find(:all, :order => 'pcue_cuenta')
        format.html { render :action => "edit" }
        format.xml  { render :xml => @conceptoegreso.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /conceptoegresos/1
  # DELETE /conceptoegresos/1.xml
  def destroy
    @conceptoegreso = Conceptoegreso.find(params[:id])
    @conceptoegreso.destroy

    respond_to do |format|
      format.html { redirect_to(conceptoegresos_url) }
      format.xml  { head :ok }
    end
  end
end
