class CabpedidowebsController < ApplicationController
   before_filter :login_required
   access_control [:index, :list, :new, :create, :update, :edit, :show, :grabarenglonespedidoweb, :pedidos, :hayitems, :send_email] => '(rol 1 | rol 2 | rol 3 | rol 4 | rol 5 | rol 6 | rol 7)'
 def permission_denied
    flash[:notice] = "Usted no tiene permisos para realizar esta acción." 
    return redirect_to(:controller => 'login', :action => 'denied')
 end

  # GET /cabpedidowebs
  # GET /cabpedidowebs.xml
  def index
    #solo se muestran los pedidos del usuario logueado por su nro de cliente
    @cabpedidowebs = Cabpedidoweb.paginate(:all, :conditions => ["cliente_id = ?", session[:user].cliente_id], :order => 'id DESC', :per_page => 20, :page => params[:page] || 1) 
    @renpedidowebs = Renpedidoweb.find(:all, :conditions => ["cabpedidoweb_id = ?", params[:idcabpedidoweb].to_i]) if params[:idcabpedidoweb].to_i != 0
    @cabpedidoweb = Cabpedidoweb.find(params[:idcabpedidoweb].to_i) if params[:idcabpedidoweb].to_i != 0
    #@cabpedidowebs = cabpedidowebs.paginate(:per_page => 20, :page => params[:page] || 1)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cabpedidowebs }
    end
  end

  # GET /cabpedidowebs/1
  # GET /cabpedidowebs/1.xml
  def show
    @cabpedidoweb = Cabpedidoweb.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cabpedidoweb }
    end
  end

  # GET /cabpedidowebs/new
  # GET /cabpedidowebs/new.xml
  def new
    @cabpedidoweb = Cabpedidoweb.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cabpedidoweb }
    end
  end

  # GET /cabpedidowebs/1/edit
  def edit
    @cabpedidoweb = Cabpedidoweb.find(params[:id])
  end

  # POST /cabpedidowebs
  # POST /cabpedidowebs.xml
  def create
    if hayitems()
       @cabpedidoweb = Cabpedidoweb.new(params[:cabpedidoweb])
       @cabpedidoweb.sucursal_id = session[:user].sucursal_id
       @cabpedidoweb.cliente_id = session[:user].cliente_id
       @cabpedidoweb.pweb_fecha = DateTime.now
       @cabpedidoweb.pweb_estado = "Abierto"
       @cabpedidoweb.pweb_usuario = session[:user].usur_nombre
       @cabpedidoweb.pweb_ultmod = DateTime.now
       respond_to do |format|
         if @cabpedidoweb.save
          grabarenglonespedidoweb()
          flash[:notice] = 'El pedido fue creado.'
          #format.html { redirect_to(@cabpedidoweb) }
          format.html { redirect_to(:action => 'index', :idcabpedidoweb => @cabpedidoweb.id)}
          format.xml  { render :xml => @cabpedidoweb, :status => :created, :location => @cabpedidoweb }
         else
          format.html { render :action => "new" }
          format.xml  { render :xml => @cabpedidoweb.errors, :status => :unprocessable_entity }
         end
      end
    else
       flash[:notice] = 'No se creo su pedido porque no se seleccionaron items'
     #  redirect_to :controller => 'cabpedidowebs', :action => 'index', :idcabpedidoweb => @cabpedidoweb.id
    end
  end

  # PUT /cabpedidowebs/1
  # PUT /cabpedidowebs/1.xml
  def update
    @cabpedidoweb = Cabpedidoweb.find(params[:id])
    respond_to do |format|
      if @cabpedidoweb.update_attributes(params[:cabpedidoweb])
        flash[:notice] = 'El pedido a sido actualizado.'
        format.html { redirect_to(@cabpedidoweb) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cabpedidoweb.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cabpedidowebs/1
  # DELETE /cabpedidowebs/1.xml
  def destroy
    @cabpedidoweb = Cabpedidoweb.find(params[:id])
    @cabpedidoweb.destroy

    respond_to do |format|
      format.html { redirect_to(cabpedidowebs_url) }
      format.xml  { head :ok }
    end
  end

  def grabarenglonespedidoweb
   p = 0
   params[:pedido][:cantidad].each { |pedido|
     if pedido.to_i > 0
       @renglonpedidoweb = Renpedidoweb.new
       @renglonpedidoweb.cabpedidoweb_id = @cabpedidoweb.id
       @renglonpedidoweb.articulo_id = params[:pedido][:idarticulo][p].to_i
       @renglonpedidoweb.rweb_cantidad = pedido.to_i
       @renglonpedidoweb.rweb_procesado = "No"
       @renglonpedidoweb.save
     end 
     p += 1 }
  end

  def pedidos
    @renpedidowebs = Renpedidoweb.find(:all, :conditions => ["cabpedidoweb_id = ?", params[:idcabpedidoweb].to_i])
    @cabpedidoweb = Cabpedidoweb.find(params[:idcabpedidoweb])
    render :partial => "pedidos"
  end

  def hayitems
   params[:pedido][:cantidad].each { |pedido|
     if pedido.to_i > 0
       return true 
     end 
     }
     return false
  end

  def send_email
    # para enviar el mail
    mails = params["clienteemail"].lstrip.rstrip
   if mails.blank?
    render :text => 'Lo sientimos pero su direccion de email no es correcta', :layout => "application"
   else
    logger.debug  "send_email begin "
    result = Emailer.deliver_email_template(params[:idcabpedidoweb], params["sucursalemail"], params["clienteemail"], params[:cliente], params[:cuit],params[:clientecodigo])
    #return if request.xhr?
    #render :text => 'El mensaje ha sido enviado', :layout => "application"
    logger.debug "send_email end "
    #cambia el estado del pedido
    @cabpedidoweb = Cabpedidoweb.find(params[:idcabpedidoweb])
    @cabpedidoweb.update_attribute(:pweb_estado, "Enviado")
    @cabpedidoweb.update_attribute(:pweb_ultmod, DateTime.now)
    redirect_to :action => 'index'
        
  end
end

end
