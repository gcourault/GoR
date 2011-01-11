class CabcargachequetersController < ApplicationController
   before_filter :login_required
   access_control [:index, :list, :new, :create, :update, :edit, :show, :borrarenglones, :grabarenglones] => '(rol 2 | rol 3 | rol 4 | rol 5 | rol 6 | rol 7)'

  def permission_denied
      flash[:notice] = "Usted no tiene permiso para realizar esta acción." 
      return redirect_to(:controller => 'login', :action => 'denied')
  end


  # GET /cabcargachequeters
  # GET /cabcargachequeters.xml
  def index
    @cabcargachequeters = Cabcargachequeter.paginate(:per_page =>15, :page => params[:page] || 1, :order => ['ccht_fecha DESC, id DESC'])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cabcargachequeters }
    end
  end

  # GET /cabcargachequeters/1
  # GET /cabcargachequeters/1.xml
  def show
    @cabcargachequeter = Cabcargachequeter.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cabcargachequeter }
    end
  end

  # GET /cabcargachequeters/new
  # GET /cabcargachequeters/new.xml
  def new
    @sucursal = Sucursal.find(:all)
    @cabcargachequeter = Cabcargachequeter.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cabcargachequeter }
    end
  end

  # GET /cabcargachequeters/1/edit
  def edit
    @sucursal = Sucursal.find(:all)
    @cabcargachequeter = Cabcargachequeter.find(params[:id])
  end

  # POST /cabcargachequeters
  # POST /cabcargachequeters.xml
  def create
    @cabcargachequeter = Cabcargachequeter.new(params[:cabcargachequeter])

    # Busco el ultimo id de casa central y calculo el siguiente
    
    idcheter = Cabcargachequeter.maximum( :id )
    @cabcargachequeter.id = idcheter.to_i + 1
    @cabcargachequeter.ccht_cerrado = 'No'
    @cabcargachequeter.ccht_anulado = 'No'
    @cabcargachequeter.ccht_total = 0
    @cabcargachequeter.ccht_usuario = session[:user].usur_nombre
    @cabcargachequeter.ccht_ultmod = DateTime.now
    $idanterior = (@cabcargachequeter.id.to_i - 1) 
    respond_to do |format|
      if @cabcargachequeter.save
        flash[:notice] = 'El comprobante de carga de cheques ha sido creado.'
        format.html { redirect_to(:controller => 'cabcargachequeters' , :action => 'index') }
        format.xml  { render :xml => @cabcargachequeter, :status => :created, :location => @cabcargachequeter }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cabcargachequeter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cabcargachequeters/1
  # PUT /cabcargachequeters/1.xml
  def update
    total = Rencargachequeter.totalcheques( params[:id] , session[:sucursal] )

    @cabcargachequeter = Cabcargachequeter.find(params[:id])
    @cabcargachequeter.ccht_total   = total.to_d
    @cabcargachequeter.ccht_ultmod  = DateTime.now
    @cabcargachequeter.ccht_usuario = session[:user].usur_nombre
    $idanterior = (@cabcargachequeter.id.to_i - 1) 

    respond_to do |format|
      if @cabcargachequeter.update_attributes(params[:cabcargachequeter])
        flash[:notice] = 'El comprobante de carga de cheques ha sido modificado'
  #     format.html { redirect_to(@cabcargachequeter) }
        format.html { redirect_to( :action => "index" , :page => params[:page]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cabcargachequeter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cabcargachequeters/1
  # DELETE /cabcargachequeters/1.xml
  def destroy
    @cabcargachequeter = Cabcargachequeter.find(params[:id])
    @cabcargachequeter.destroy

    respond_to do |format|
      format.html { redirect_to(cabcargachequeters_url) }
      format.xml  { head :ok }
    end
  end
end
