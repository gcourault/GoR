class ListadobancosController < ApplicationController
   before_filter :login_required
   access_control  [:list, :new, :create, :update, :edit, :show, :index] => '(rol 4 | rol 5 | rol 6 | rol 7)'

 def permission_denied
    flash[:notice] = "Usted no tiene los privilegios para realizar esta acción." 
    return redirect_to(:controller => 'login', :action => 'denied')
 end
  # GET /listadobancos
  # GET /listadobancos.xml
  def index
    @listadobancos = Listadobanco.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @listadobancos }
    end
  end

  # GET /listadobancos/1
  # GET /listadobancos/1.xml
  def show
    @listadobanco = Listadobanco.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @listadobanco }
    end
  end

  # GET /listadobancos/new
  # GET /listadobancos/new.xml
  def new
    @listadobanco = Listadobanco.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @listadobanco }
    end
  end

  # GET /listadobancos/1/edit
  def edit
    @listadobanco = Listadobanco.find_by_listadocaucion_id(params[:listadoid])
  end

  # POST /listadobancos
  # POST /listadobancos.xml
  def create
    @listadobanco = Listadobanco.new(params[:listadobanco])
    @listadobanco.lisb_ultmod = DateTime.now
    @listadobanco.lisb_usuario = session[:user].usur_nombre
    respond_to do |format|
      if @listadobanco.save
        flash[:notice] = 'EL listado del banco ha sido creado.'
         pag = (params[:valor][:page].to_i > 0 ? params[:valor][:page] : 1)
        format.html  { redirect_to(:controller => 'listadocaucions', :action => 'index', :page => pag )}
        format.xml  { render :xml => @listadobanco, :status => :created, :location => @listadobanco }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @listadobanco.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /listadobancos/1
  # PUT /listadobancos/1.xml
  def update
    @listadobanco = Listadobanco.find(params[:id])
    @listadobanco.lisb_ultmod = DateTime.now
    @listadobanco.lisb_usuario = session[:user].usur_nombre
    respond_to do |format|
      if @listadobanco.update_attributes(params[:listadobanco])
        flash[:notice] = 'EL listado del banco ha sido actualizado'
        pag = (params[:valor][:page].to_i > 0 ? params[:valor][:page] : 1)
        format.html  { redirect_to(:controller => 'listadocaucions', :action => 'index', :page => pag )}
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @listadobanco.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /listadobancos/1
  # DELETE /listadobancos/1.xml
  def destroy
    @listadobanco = Listadobanco.find(params[:id])
    @listadobanco.destroy

    respond_to do |format|
      format.html { redirect_to(listadobancos_url) }
      format.xml  { head :ok }
    end
  end
end
