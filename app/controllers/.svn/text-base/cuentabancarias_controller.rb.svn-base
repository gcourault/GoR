class CuentabancariasController < ApplicationController
   before_filter :login_required
   access_control [:index, :list, :new, :create, :update, :edit, :show, :destroy] => '(rol 6 | rol 7 )'
                 
  def permission_denied
    flash[:notice] = "Usted no tiene permisos para realizar esta acción." 
    return redirect_to(:controller => 'login', :action => 'denied')
  end

  # GET /cuentabancarias
  # GET /cuentabancarias.xml
  def index
     @cuentabancarias = Cuentabancaria.paginate(:per_page => 20, :page => params[:page] || 1, :conditions => ['cban_descripcion like ?', "%#{params[:cuenta]}%"])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cuentabancarias }
    end
  end

  # GET /cuentabancarias/1
  # GET /cuentabancarias/1.xml
  def show
    @cuentabancaria = Cuentabancaria.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cuentabancaria }
    end
  end

  # GET /cuentabancarias/new
  # GET /cuentabancarias/new.xml
  def new
    @cuentabancaria = Cuentabancaria.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cuentabancaria }
    end
  end

  # GET /cuentabancarias/1/edit
  def edit
    @cuentabancaria = Cuentabancaria.find(params[:id])
  end

  # POST /cuentabancarias
  # POST /cuentabancarias.xml
  def create
    @cuentabancaria = Cuentabancaria.new(params[:cuentabancaria])
    @cuentabancaria.cban_ultmod = DateTime.now
    @cuentabancaria.cban_usuario = session[:user].usur_nombre
    respond_to do |format|
      if @cuentabancaria.save
        flash[:notice] = 'La cuenta bancaria ha sido creada.'
        format.html { redirect_to(:controller => 'cuentabancarias', :action => 'index')}
        format.xml  { render :xml => @cuentabancaria, :status => :created, :location => @cuentabancaria }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cuentabancaria.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cuentabancarias/1
  # PUT /cuentabancarias/1.xml
  def update
    @cuentabancaria = Cuentabancaria.find(params[:id])
    @cuentabancaria.cban_ultmod = DateTime.now
    @cuentabancaria.cban_usuario = session[:user].usur_nombre
    respond_to do |format|
      if @cuentabancaria.update_attributes(params[:cuentabancaria])
        flash[:notice] = 'La cuenta bancaria ha sido modificada.'
        pag = (params[:valor][:page].to_i > 0 ? params[:valor][:page] : 1)
        format.html { redirect_to(:controller => 'cuentabancarias', :action => 'index', :page => pag )}
        
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cuentabancaria.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cuentabancarias/1
  # DELETE /cuentabancarias/1.xml
  def destroy
    @cuentabancaria = Cuentabancaria.find(params[:id])
    @cuentabancaria.destroy

    respond_to do |format|
      format.html { redirect_to(cuentabancarias_url) }
      format.xml  { head :ok }
    end
  end
end
