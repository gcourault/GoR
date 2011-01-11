class FormapagosController < ApplicationController
   before_filter :login_required
   access_control [:index, :list, :new, :create, :update, :edit, :show, :destroy] => '( rol 7 )'
                 
  def permission_denied
    flash[:notice] = "Usted no tiene los privilegios para realizar esta acción." 
    return redirect_to(:controller => 'login', :action => 'denied')
  end
  # GET /formapagos
  # GET /formapagos.xml
  def index
    # @formapagos = Formapago.all
      @formapagos = Formapago.paginate(:per_page => 20, :page => params[:page] || 1, :conditions => ['fpag_nombre like ?', "%#{params[:nombre]}%"])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @formapagos }
    end
  end

  # GET /formapagos/1
  # GET /formapagos/1.xml
  def show
    @formapago = Formapago.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @formapago }
    end
  end

  # GET /formapagos/new
  # GET /formapagos/new.xml
  def new
    @formapago = Formapago.new
    @plandecuenta = Plandecuenta.find(:all, :order => 'pcue_cuenta')
    codigo = Formapago.maximum(:fpag_codigo)
    @codigonuevo = codigo.to_i + 1
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @formapago }
    end
  end

  # GET /formapagos/1/edit
  def edit
    @formapago = Formapago.find(params[:id])
    @plandecuenta = Plandecuenta.find(:all, :order => 'pcue_cuenta')
  end

  # POST /formapagos
  # POST /formapagos.xml
  def create
    @formapago = Formapago.new(params[:formapago])
    @formapago.fpag_ultmod = DateTime.now
    @formapago.fpag_usuario = session[:user].usur_nombre
    respond_to do |format|
      if @formapago.save
        flash[:notice] = 'Formapago was successfully created.'
        pag = (params[:valor][:page].to_i > 0 ? params[:valor][:page] : 1)
        format.html { redirect_to(:controller => 'formapagos', :action => 'index', :page => pag)}
        format.xml  { render :xml => @formapago, :status => :created, :location => @formapago }
      else
        @plandecuenta = Plandecuenta.find(:all, :order => 'pcue_cuenta')
        codigo = Formapago.maximum(:fpag_codigo)
        @codigonuevo = codigo.to_i + 1
        format.html { render :action => "new" }
        format.xml  { render :xml => @formapago.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /formapagos/1
  # PUT /formapagos/1.xml
  def update
    @formapago = Formapago.find(params[:id])
    @formapago.fpag_ultmod = DateTime.now
    @formapago.fpag_usuario = session[:user].usur_nombre
    respond_to do |format|
      if @formapago.update_attributes(params[:formapago])
        flash[:notice] = 'Formapago was successfully updated.'
        pag = (params[:valor][:page].to_i > 0 ? params[:valor][:page] : 1)
        format.html { redirect_to(:controller => 'formapagos', :action => 'index', :page => pag)}
        format.xml  { head :ok }
      else
        @plandecuenta = Plandecuenta.find(:all, :order => 'pcue_cuenta')
        format.html { render :action => "edit" }
        format.xml  { render :xml => @formapago.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /formapagos/1
  # DELETE /formapagos/1.xml
  def destroy
    @formapago = Formapago.find(params[:id])
    @formapago.destroy

    respond_to do |format|
      format.html { redirect_to(formapagos_url) }
      format.xml  { head :ok }
    end
  end
end
