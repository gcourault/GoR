require 'digest/sha1'

class UsuariosController < ApplicationController
   before_filter :login_required
   access_control  [:list, :new, :create, :update, :edit, :show, :index, :buscacliente, :asignasucursal, :traecliente] => '(rol 7)'
 def permission_denied
    flash[:notice] = "Usted no tiene permisos para realizar esta acción." 
    return redirect_to(:controller => 'login', :action => 'denied')
 end

#auto_complete_for  :usuario, :cliente_clie_razonsocial, :limit => 15
auto_complete_forsucursal  :cliente, :clie_razonsocial,  :limit => 15
def index
  usuario = Usuario.all
  @usuario = usuario.paginate(:per_page => 20, :page => params[:page] || 1)
  respond_to do |format|
     format.html 
     format.xml { render :xml => @usuario }
  end
end

def show 
   @usuario = Usuario.find(params[:id])
   @roles = Role.find(:all)
   @selected = @usuario.roles.collect { |rol| rol.id.to_i }
   respond_to do |format| 
     format.html 
     format.xml { render :xml => @usuario }
   end
end

def new
#  @cliente = Cliente.find(:all, :conditions => ["sucursal_id = 1 "], :limit => 20)#sacarlo cuando se use field con autocomplete
  @sucursal = Sucursal.find(:all)
  @usuario = Usuario.new
  @roles = Role.find(:all)
  @selected = []
  respond_to do |format|
    format.html 
    format.xml { render :xml => @usuario }
  end
end

def edit
  @sucursal = Sucursal.find(:all)
  @roles = Role.all
  @usuario = Usuario.find(params[:id])
  @selected = @usuario.roles.collect { |rol| rol.id.to_i }
  @cliente = Cliente.find(@usuario.cliente_id, @usuario.sucursal_id) if @usuario.cliente_id 
  
  respond_to do |format|
    format.html
    format.xml { render :xml => @usuario }
  end
end

def create 
 @usuario = Usuario.new(params[:usuario])
 @usuario.usur_contrasena = Digest::SHA1.hexdigest( @usuario.usur_contrasena.to_s ) 
 # grabo cliente_id en la tabla usuarios
 @usuario.cliente_id = params[:cliente][:id] if params[:cliente]
 #
 # Grabo el rol en la tabla de roles
 #
 @usuario.roles = Role.find(params[:roles]) if params[:roles]

 respond_to do |format|
   if @usuario.save
     flash[:notice] = 'Usuario creado exitosamente.' 
     format.html { redirect_to :action => 'index' }  
     format.xml { render :xml => @usuario, :status => :created, :location => @usuario }
   else
     @sucursal = Sucursal.all
     @cliente = Cliente.find(:first, :conditions => ["sucursal_id = ? and id = ? ", session[:sucursalseleccionada], params[:cliente][:id] ] ) 
     @roles = Role.all
     @selected = []
     format.html { render :action => "new" }
     format.xml  { render :xml => @usuario.errors, :status => :unprocessable_entity }
   end
 end
end

def update
   @usuario = Usuario.find(params[:id])
   @usuario.usur_contrasena = Digest::SHA1.hexdigest(params[:login][:pass].to_s) if (params[:login][:pass].lstrip.rstrip != "")
   @usuario.roles = Role.find(params[:roles]) if params[:roles]
    # grabo cliente_id en la tabla usuarios
   @usuario.cliente_id = params[:cliente][:id] if params[:cliente]
   
   respond_to do |format|
     if @usuario.update_attributes(params[:usuario])
       pag = (params[:valor][:page].to_i > 0 ? params[:valor][:page] : 1)
        # @usuario.update_attribute(:usur_contrasena, Digest::SHA1.hexdigest(@usuario.usur_contrasena.to_s)) if @usuario.usur_contrasena
        flash[:notice] = 'Usuario actualizado'
        format.html {redirect_to(:controller => 'usuarios', :action => 'index', :page => pag ) }
        format.xml { head :ok }
      else
        @sucursal = Sucursal.all
        @roles = Role.all
        @selected = @usuario.roles.collect { |rol| rol.id.to_i }
        @cliente = Cliente.find(:first, :conditions => ["sucursal_id = ? and id = ? ", session[:sucursalseleccionada], params[:cliente][:id] ] ) 
        format.html { render :action => "edit" }
        format.xml  { render :xml => @usuario.errors, :status => :unprocessable_entity }
      end
   end
end

def destroy
   @usuario = Usuario.find(params[:id])
   @usuario.destroy
   respond_to do |format|
     format.html {redirect_to(usuarios_url) }
     format.xml { head :ok }
   end
end

def buscacliente
    @cliente = Cliente.find(:all, :conditions => ["sucursal_id = ? ", params[:sucursal_id]],  :limit => 20)
    render :update do |page|
        page.replace_html('sucursal_clientes', :partial => 'buscacliente', :objects => @cliente )
    end
end

def asignasucursal
  session[:sucursalseleccionada] = params[:sucursal_id]
  render :update do |page|
     page.replace_html('datos_clientes', :partial => 'traeclientes')
  end
end


def traecliente
  str_tokens = params[:search].split("|")
  @cliente = Cliente.find(:first, :conditions => ["sucursal_id = ? and id = ? ", session[:sucursalseleccionada], str_tokens[1].lstrip ] ) 
  render :update do |page|
     page.replace_html('datos_clientes', :partial => 'traeclientes', :objects => @cliente )
  end
end

end
