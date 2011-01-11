class RenpedidowebsController < ApplicationController
   before_filter :login_required
   access_control [:index, :list, :new, :create, :update, :edit, :show] => '(rol 1 | rol 2 | rol 3 | rol 4 | rol 5 | rol 6 | rol 7)'
  # GET /renpedidowebs
  # GET /renpedidowebs.xml
  def index
    @renpedidowebs = Renpedidoweb.find(:all, :conditions => ["cabpedidoweb_id = ?", params[:idcabpedido]])
    @cabpedidoweb = Cabpedidoweb.find(params[:idcabpedido])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @renpedidowebs }
    end
  end

  # GET /renpedidowebs/1
  # GET /renpedidowebs/1.xml
  def show
    @renpedidoweb = Renpedidoweb.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @renpedidoweb }
    end
  end

  # GET /renpedidowebs/new
  # GET /renpedidowebs/new.xml
  def new
    @renpedidoweb = Renpedidoweb.new
    # Articulos que estan en la lista para llenar los combos
    @articulos = Articulo.find(:all, :joins => [:listaprecio], :conditions => ["listaprecios.lpre_codigolista = 'T'"], :order =>"arti_descripcion")
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @renpedidoweb }
    end
  end

  # GET /renpedidowebs/1/edit
  def edit
    @renpedidoweb = Renpedidoweb.find(params[:id])
    @cabpedidoweb = Cabpedidoweb.find(@renpedidoweb.cabpedidoweb_id) #para editar solo renglones de pedidos abierto por URL
    @articulos = Articulo.find(:all, :joins => [:listaprecio], :conditions => ["listaprecios.lpre_codigolista = 'T'"], :order =>"arti_descripcion")
  end

  # POST /renpedidowebs
  # POST /renpedidowebs.xml
  def create
    @renpedidoweb = Renpedidoweb.new(params[:renpedidoweb])
    @renpedidoweb.rweb_procesado = "No"
    @renpedidoweb.rweb_cantidad = 0 if  @renpedidoweb.rweb_cantidad.blank?
    @renpedidoweb.rweb_usuario = session[:user].usur_nombre
    @renpedidoweb.rweb_ultmod = DateTime.now
    respond_to do |format|
      if @renpedidoweb.save
        flash[:notice] = 'El articulo ha sido agregado al pedido.'
       # format.html { redirect_to(@renpedidoweb) }
        format.html { redirect_to(:controller => 'renpedidowebs', :action => 'index', :idcabpedido => @renpedidoweb.cabpedidoweb_id)}
        format.xml  { render :xml => @renpedidoweb, :status => :created, :location => @renpedidoweb }
      else
        @articulos = Articulo.find(:all, :joins => [:listaprecio], :conditions => ["listaprecios.lpre_codigolista = 'T'"], :order =>"arti_descripcion")
        format.html { render :action => "new" }
        format.xml  { render :xml => @renpedidoweb.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /renpedidowebs/1
  # PUT /renpedidowebs/1.xml
  def update
    @renpedidoweb = Renpedidoweb.find(params[:id])
    @renpedidoweb.rweb_usuario = session[:user].usur_nombre
    @renpedidoweb.rweb_ultmod = DateTime.now
    respond_to do |format|
      if @renpedidoweb.update_attributes(params[:renpedidoweb])
        flash[:notice] = 'El items ha sido actualizado.'
        # format.html { redirect_to(@renpedidoweb) }
        format.html { redirect_to(:controller => 'renpedidowebs', :action => 'index', :idcabpedido => @renpedidoweb.cabpedidoweb_id)}
        format.xml  { head :ok }
      else
        @articulos = Articulo.find(:all, :joins => [:listaprecio], :conditions => ["listaprecios.lpre_codigolista = 'T'"], :order =>"arti_descripcion")
        format.html { render :action => "edit" }
        format.xml  { render :xml => @renpedidoweb.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /renpedidowebs/1
  # DELETE /renpedidowebs/1.xml
  def destroy
    @renpedidoweb = Renpedidoweb.find(params[:id])
    @renpedidoweb.destroy

    respond_to do |format|
     # format.html { redirect_to(renpedidowebs_url) }
      format.html { redirect_to(:controller => 'renpedidowebs', :action => 'index', :idcabpedido => @renpedidoweb.cabpedidoweb_id )}
      format.xml  { head :ok }
    end
  end
end
