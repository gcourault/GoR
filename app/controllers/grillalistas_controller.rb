class GrillalistasController < ApplicationController
  # GET /grillalistas
  # GET /grillalistas.xml
   before_filter :login_required
   access_control [:index, :list, :new, :create, :update, :edit, :show, :destroy] => '( rol 4 | rol 5 | rol 6 | rol 7)'
                 
  def permission_denied
    flash[:notice] = "Usted no tiene permiso para realizar esta acción." 
    return redirect_to(:controller => 'usuario', :action => 'denied')
  end

  def index
    @grillalistas = Grillalista.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @grillalistas }
    end
  end

  # GET /grillalistas/1
  # GET /grillalistas/1.xml
  def show
    #@grillalista = Grillalista.find(params[:id])
     # respond_to do |format|
     # format.html # show.html.erb
     # format.xml  { render :xml => @grillalista }
    #end
  end

  # GET /grillalistas/new
  # GET /grillalistas/new.xml
  def new
    #@grillalista = Grillalista.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @grillalista }
    end
  end

  # GET /grillalistas/1/edit
  def edit
   # @grillalista = Grillalista.find(params[:id])
  end

  # POST /grillalistas
  # POST /grillalistas.xml
  def create
    @grillalista = Grillalista.new(params[:grillalista])
    @grillalista.glis_ultmod = DateTime.now
    @grillalista.glis_usuario = session[:user].usur_nombre
    #para no perder el valor del parametro cuando voy al servidor
    params[:listaprecioid] = @grillalista.listaprecio_id
    respond_to do |format|
      if @grillalista.save
        flash[:notice] = 'La grilla de la lista ha sido creada.'
        # para redireccionar al editar articulo de la lista de precios
        format.html { redirect_to(:controller => 'listaprecios', :action => 'edit', :id => @grillalista.listaprecio_id)}
        format.xml  { head :ok }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @grillalista.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /grillalistas/1
  # PUT /grillalistas/1.xml
  def update
    @grillalista = Grillalista.find(params[:id])
    @grillalista.glis_ultmod = DateTime.now
    @grillalista.glis_usuario = session[:user].usur_nombre
    respond_to do |format|
      if @grillalista.update_attributes(params[:grillalista])
        flash[:notice] = 'La grilla de la lista ha sido actualizada.'
        # para redireccionar al editar articulo de la lista de precios y actualizar los precios en el edit de la lista de precios
        format.html { redirect_to(:controller => 'listaprecios', :action => 'edit', :id => @grillalista.listaprecio_id)}
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @grillalista.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /grillalistas/1
  # DELETE /grillalistas/1.xml
  def destroy
    @grillalista = Grillalista.find(params[:id])
    @grillalista.destroy
    
    respond_to do |format|
      # para refrescar y actualizar la pantalla actual, editar items de la lista de precios
      format.html { redirect_to(:controller => 'listaprecios', :action => 'edit', :id => @grillalista.listaprecio_id)}
      format.xml  { head :ok }
    end
  end

end
