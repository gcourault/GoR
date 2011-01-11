class CoeficientesController < ApplicationController
   before_filter :login_required
   access_control  [:index, :list, :edit, :new, :update, :create] => '(rol 5 | rol 6 | rol 7)'
 
  def permission_denied
     flash[:notice] = "Usted no tiene permiso necesario para realizar esta acción." 
     return redirect_to(:controller => 'login', :action => 'denied')
  end
  # GET /coeficientes
  # GET /coeficientes.xml
  def index
    @coeficientes = Coeficiente.find(:all, :conditions => ['coef_descripcion like ?', "%#{params[:descrip]}%"])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @coeficientes }
    end
  end

  # GET /coeficientes/1
  # GET /coeficientes/1.xml
  def show
    @coeficiente = Coeficiente.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @coeficiente }
    end
  end

  # GET /coeficientes/new
  # GET /coeficientes/new.xml
  def new
    @coeficiente = Coeficiente.new
    @ejercicios = Ejercicio.find(:all, :order => ['ejer_desde DESC'])
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @coeficiente }
    end
  end

  # GET /coeficientes/1/edit
  def edit
    @coeficiente = Coeficiente.find(params[:id])
    @ejercicios = Ejercicio.find(:all, :order => ['ejer_desde DESC'])
  end

  # POST /coeficientes
  # POST /coeficientes.xml
  def create
    @coeficiente = Coeficiente.new(params[:coeficiente])
    @coeficiente.coef_ultmod = DateTime.now
    @coeficiente.coef_usuario = session[:user].usur_nombre
    respond_to do |format|
      if @coeficiente.save
        flash[:notice] = 'Los coeficientes han sido creados'
        format.html { redirect_to(:controller => 'coeficientes', :action => 'index')}
        format.xml  { render :xml => @coeficiente, :status => :created, :location => @coeficiente }
      else
         @ejercicios = Ejercicio.find(:all, :order => ['ejer_desde DESC'])
        format.html { render :action => "new" }
        format.xml  { render :xml => @coeficiente.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /coeficientes/1
  # PUT /coeficientes/1.xml
  def update
    @coeficiente = Coeficiente.find(params[:id])
    @coeficiente.coef_ultmod = DateTime.now
    @coeficiente.coef_usuario = session[:user].usur_nombre
    respond_to do |format|
      if @coeficiente.update_attributes(params[:coeficiente])
        flash[:notice] = 'Los coeficientes han sido actualizados'
        format.html { redirect_to(:controller => 'coeficientes', :action => 'index')}
        format.xml  { head :ok }
      else
        @ejercicios = Ejercicio.find(:all, :order => ['ejer_desde DESC'])
        format.html { render :action => "edit" }
        format.xml  { render :xml => @coeficiente.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /coeficientes/1
  # DELETE /coeficientes/1.xml
  def destroy
    @coeficiente = Coeficiente.find(params[:id])
    @coeficiente.destroy

    respond_to do |format|
      format.html { redirect_to(coeficientes_url) }
      format.xml  { head :ok }
    end
  end
end
