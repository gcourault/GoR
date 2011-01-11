class ArticulosController < ApplicationController
  # GET /articulos
  # GET /articulos.xml
   before_filter :login_required
   access_control [:index, :list, :new, :create, :update, :edit, :show] => '( rol 4 | rol 5 | rol 6 | rol 7)'
                 
 
  def permission_denied
    flash[:notice] = "Usted no tiene permiso para realizar esta acción." 
    return redirect_to(:controller => 'login', :action => 'denied')
  end

  def index
    #@articulos = Articulo.all
    if (params[:modmed]!=nil)
           @articulos = Articulo.modelo(params[:modelo],  params[:medida])
    else
           @articulos = Articulo.search(params[:modelo],  params[:medida], params[:marcaid],  params[:rubroid])
    end
    #@articulos = articulos.paginate(:per_page => 12, :page => params[:page] || 1)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @articulos }
    end
  end

  # GET /articulos/1
  # GET /articulos/1.xml
  def show
    @articulo = Articulo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @articulo }
    end
  end

  # GET /articulos/new
  # GET /articulos/new.xml
  def new
    @articulo = Articulo.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @articulo }
    end
  end

  # GET /articulos/1/edit
  def edit
    @articulo = Articulo.find(params[:id])
  end

  # POST /articulos
  # POST /articulos.xml
  def create
    @articulo = Articulo.new(params[:articulo])
    @articulo.arti_ultmod = DateTime.now
    @articulo.arti_usuario = session[:user].usur_nombre
    # @rolusuario = RolesUsuario.new
    # @rolusuario.role_id = 9
    # @rolusuario.usuario_id = 9
    # @rolusuario.save
    if @articulo.arti_fechabaja.nil?
      @articulo.arti_fechabaja = 0000-00-00
    end
    if @articulo.consignatario_id.blank?
      @articulo.consignatario_id = 0
    end
    respond_to do |format|
      if @articulo.save
        flash[:notice] = 'El articulo ha sido creado.'
        format.html { redirect_to(:controller => 'articulos', :action => 'index', :marcaid => @articulo.marca.marc_codigo, :rubroid => @articulo.rubro.rubr_codigo) }
        format.xml  { render :xml => @articulo, :status => :created, :location => @articulo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @articulo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /articulos/1
  # PUT /articulos/1.xml
  def update
    @articulo = Articulo.find(params[:id])
    @articulo.arti_ultmod = DateTime.now
    @articulo.arti_usuario = session[:user].usur_nombre
    respond_to do |format|
      if @articulo.update_attributes(params[:articulo])
         if @articulo.arti_fechabaja.nil?
           @articulo.update_attribute(:arti_fechabaja, 0000-00-00)
        end
         if @articulo.consignatario_id.blank?
           @articulo.update_attribute(:consignatario_id, 0)
         end
        flash[:notice] = 'El articulo ha sido actualizado.'
        format.html {  redirect_to(:controller => 'articulos', :action => 'index', :marcaid => @articulo.marca.marc_codigo, :rubroid => @articulo.rubro.rubr_codigo, :idmodificado => @articulo.id)}
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @articulo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /articulos/1
  # DELETE /articulos/1.xml
 # def destroy
 #   @articulo = Articulo.find(params[:id])
 #   @articulo.destroy

 #   respond_to do |format|
 #     format.html { redirect_to(articulos_url) }
 #     format.xml  { head :ok }
 #   end
 # end
end
