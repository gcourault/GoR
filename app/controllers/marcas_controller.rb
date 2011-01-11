class MarcasController < ApplicationController
   before_filter :login_required
   access_control  [:list, :new, :create, :update, :edit, :show] => '(rol 3)',
                   :index => '( rol 1 | rol 2 | rol 3 | rol 4 | rol 5 | rol 6 | rol 7)'

                 
  def permission_denied
    flash[:notice] = "Usted no tiene permiso para realizar esta acción." 
    return redirect_to :controller => 'usuario', :action => 'denied'
  end
  # GET /marcas
  # GET /marcas.xml
  def index
    @marcas = Marca.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @marcas }
    end
  end

  # GET /marcas/1
  # GET /marcas/1.xml
  def show
    @marca = Marca.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @marca }
    end
  end

  # GET /marcas/new
  # GET /marcas/new.xml
  def new
    if session[:user].usur_rol.to_i < 2 
    permission_denied()
    else
    @marca = Marca.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @marca }
    end
   end
  end

  # GET /marcas/1/edit
  def edit
    @marca = Marca.find(params[:id])
  end

  # POST /marcas
  # POST /marcas.xml
  def create
    @marca = Marca.new(params[:marca])

    respond_to do |format|
      if @marca.save
        flash[:notice] = 'Marca was successfully created.'
        format.html { redirect_to(@marca) }
        format.xml  { render :xml => @marca, :status => :created, :location => @marca }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @marca.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /marcas/1
  # PUT /marcas/1.xml
  def update
  if session[:user].usur_rol.to_i < 2 
    permission_denied()
    else
    @marca = Marca.find(params[:id])

    respond_to do |format|
      if @marca.update_attributes(params[:marca])
        flash[:notice] = 'Marca was successfully updated.'
        format.html { redirect_to(@marca) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @marca.errors, :status => :unprocessable_entity }
      end
    end
   end
  end

  # DELETE /marcas/1
  # DELETE /marcas/1.xml
  def destroy
    @marca = Marca.find(params[:id])
    @marca.destroy

    respond_to do |format|
      format.html { redirect_to(marcas_url) }
      format.xml  { head :ok }
    end
  end
end
