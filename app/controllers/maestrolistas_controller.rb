class MaestrolistasController < ApplicationController
  # GET /maestrolistas
  # GET /maestrolistas.xml
   before_filter :login_required
   access_control [:index, :list, :new, :create, :update, :edit, :show, :crealista, :descuentolista] => '( rol 4 | rol 6 | rol 7 )'
                 
  def permission_denied
    flash[:notice] = "Usted no tiene los privilegios para realizar esta acción." 
    return redirect_to(:controller => 'login', :action => 'denied')
  end

  def index
    maestrolistas = Maestrolista.find(:all, :order => ['id DESC'])
    @maestrolistas = maestrolistas.paginate(:per_page => 20, :page => params[:page] || 1)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @maestrolistas }
    end
  end


  # GET /maestrolistas/1
  # GET /maestrolistas/1.xml
  def show
    @maestrolista = Maestrolista.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @maestrolista }
    end
  end

  # GET /maestrolistas/new
  # GET /maestrolistas/new.xml
  def new
    @maestrolista = Maestrolista.new
      respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @maestrolista }
    end
  end

  # GET /maestrolistas/1/edit
  def edit
     @maestrolista = Maestrolista.find(params[:id])
     #lo quito para editar observaciones
     #valido que solo puedan modificarse las lista que no estan en vigencia
     #  if  @maestrolista.mlis_vigencia 
     #     permission_denied()
     #  end
  end

  # POST /maestrolistas
  # POST /maestrolistas.xml

 def crealista
    @crealista = Maestrolista.crealista(params[:maestroidorig], params[:maestroidnuevo])
 end


  def create
   Maestrolista.transaction do
     @maestrolista = Maestrolista.new(params[:maestrolista])
     @maestrolista.mlis_ultmod = DateTime.now
     @maestrolista.mlis_usuario = session[:user].usur_nombre
     @maestrolista.mlis_creacion = DateTime.now
     @maestrolista.mlis_nrolista = 0
     respond_to do |format|
      if @maestrolista.save
        if (@maestrolista.mlis_nrolistaorigen > 0)
        #genera los registros en la lista de precio y en la grilla
        @registro = Maestrolista.find_by_mlis_nrolista(@maestrolista.mlis_nrolistaorigen) 
        params[:maestroidorig] =  @registro.id 
        params[:maestroidnuevo] = Maestrolista.maximum(:id)
        crealista()
      end
        flash[:notice] = 'La lista ha sido creada.'
        format.html   { redirect_to(@maestrolista) }
        format.xml  { render :xml => @maestrolista }       
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @maestrolista.errors, :status => :unprocessable_entity }
      end
   end
 end 
  
 end

 def descuentolista
    @descuentolista = Maestrolista.descuentolista(params[:nrolista], params[:nrolistaorig], params[:maestroidnuevo])
 end
  # PUT /maestrolistas/1
  # PUT /maestrolistas/1.xml

  def update
    @maestrolista = Maestrolista.find(params[:id])
    @maestrolista.mlis_ultmod = DateTime.now
    @maestrolista.mlis_usuario = session[:user].usur_nombre

  
    respond_to do |format|
      if @maestrolista.update_attributes(params[:maestrolista])
        flash[:notice] = 'La lista ha sido actualizada.'
        format.html { redirect_to(@maestrolista) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @maestrolista.errors, :status => :unprocessable_entity }
      end
    end
       #para grabar solo las observaciones
       if @maestrolista.mlis_nrolista.nil? 
        else
        #cuando da alta la lista graba el numero de lista en lista de precios
        @listaprecio = Listaprecio.find(:all, :conditions => ["maestrolista_id = ?", params[:id]])
        @listaprecio.each {|l| l.update_attribute 'lpre_nrolista',@maestrolista.mlis_nrolista}
        
        #cuando das de alta la lista se graban los descuentolista para esa lista
        params[:nrolista] = @maestrolista.mlis_nrolista
        params[:nrolistaorig] = @maestrolista.mlis_nrolistaorigen
        params[:maestroidnuevo] = @maestrolista.id
     
        descuentolista()
        end
        #cuando da alta la lista graba el numero de lista en las grillas lista ver si es necesario o se saca el campo nro. lista en las grillas
        #@grillalista = Grillalista.find(:all, :conditions => ["maestrolista_id = ?", params[:id]])
        #@grillalista.each {|g| g.update_attribute 'glis_nrolista',@maestrolista.mlis_nrolista}
  end

  def comentarioweb
   @maestrolista = Maestrolista.find(params[:id])
  end

  def grabacomentarioweb
    @maestrolista = Maestrolista.find( params[:id] )
    @maestrolista.update_attribute( :mlis_comentarioweb , params[:mlis_comentarioweb].to_s )
    redirect_to :controler=>'maestrolista', :action=>'index'
  end

end
