class ListadocaucionsController < ApplicationController

   before_filter :login_required
   access_control  [:list, :new, :create, :update, :edit, :show, :estadocaucion, :index, :pendiente] => '(rol 4 | rol 5 | rol 6 | rol 7)'

 def permission_denied
    flash[:notice] = "Usted no tiene los privilegios para realizar esta acción." 
    return redirect_to(:controller => 'login', :action => 'denied')
 end
  # GET /listadocaucions
  # GET /listadocaucions.xml
 def index
    listadocaucions = Listadocaucion.busqueda()
    @listadocaucions = listadocaucions.paginate(:per_page => 20, :page => params[:page] || 1)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @listadocaucions }
    end
 end

  # GET /listadocaucions/1
  # GET /listadocaucions/1.xml
 # para hacer la conciliacion de caucion
 def estadocaucion 
    if params[:fechadesde].blank?
    else
      params[:fechadesde] = Date.civil params[:fechadesde]["year"].to_i, params[:fechadesde]["month"].to_i, params[:fechadesde]["day"].to_i
    end
    if params[:fechahasta].blank?
    else
      params[:fechahasta] = Date.civil params[:fechahasta]["year"].to_i, params[:fechahasta]["month"].to_i, params[:fechahasta]["day"].to_i
    end
  
    params[:fecha] = params[:fechadesde]
    if  params[:fechadesde]
       params[:fecha] =  params[:fechadesde] - 20.days
    end

    @saldobancocaucions = Listadocaucion.saldobancocaucion(params[:fechadesde])
    @saldocaucions = Listadocaucion.saldocaucion(params[:fechadesde])
    @reingresos = Listadocaucion.reingreso(params[:fechadesde])
    @ajustemanualinis = Listadocaucion.ajustemanualini(params[:fechadesde], params[:fecha])
    @listadoscaucions = Listadocaucion.listadoscaucion(params[:fechadesde], params[:fechahasta])
    @valorcaucions = Listadocaucion.valorescaucion(params[:fechadesde], params[:fechahasta])
    @pendientes = Listadocaucion.pendiente(params[:fechadesde], params[:fechahasta])
    @valorreingresados = Listadocaucion.valoresreingresado(params[:fechadesde], params[:fechahasta])
    @ajustes = Listadocaucion.ajuste(params[:fechadesde], params[:fechahasta])
    @ajustereingresobancos = Listadocaucion.ajustereingresobanco(params[:fechadesde], params[:fechahasta])
    @ajustemanuals = Listadocaucion.ajustemanual(params[:fechadesde], params[:fechahasta])
    @ajustemanualdgs = Listadocaucion.ajustemanualdg(params[:fechadesde], params[:fechahasta])
    respond_to do |format|
      format.html # estadocaucion.html.erb
      format.xml  { render :xml => @listadoscaucions }
      prawnto :prawn => {
      :page_size => 'A4'}
      format.pdf  { render :layout => false }
    end
 end
  
 def pendiente
     if params[:fechadesde].blank?
    else
      params[:fechadesde] = Date.civil params[:fechadesde]["year"].to_i, params[:fechadesde]["month"].to_i, params[:fechadesde]["day"].to_i
    end
    if params[:fechahasta].blank?
    else
      params[:fechahasta] = Date.civil params[:fechahasta]["year"].to_i, params[:fechahasta]["month"].to_i, params[:fechahasta]["day"].to_i
    end
    @pendientes = Listadocaucion.pendiente(params[:fechadesde], params[:fechahasta])
 end

  # GET /listadocaucions/1
  # GET /listadocaucions/1.xml
 def show
    @listadocaucion = Listadocaucion.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @listadocaucion }
    end
 end

  # GET /listadocaucions/new
  # GET /listadocaucions/new.xml
 def new
    @listadocaucion = Listadocaucion.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @listadocaucion }
    end
 end

  # GET /listadocaucions/1/edit
 def edit
    @listadocaucion = Listadocaucion.find(params[:id])
 end

  # POST /listadocaucions
  # POST /listadocaucions.xml
 def create
    @listadocaucion = Listadocaucion.new(params[:listadocaucion])
    @listadocaucion.lcau_ultmod = DateTime.now
    @listadocaucion.lcau_usuario = session[:user].usur_nombre
    respond_to do |format|
      if @listadocaucion.save
        flash[:notice] = 'El listado de caucion ha sido creado.'
        format.html { redirect_to(@listadocaucion) }
        format.xml  { render :xml => @listadocaucion, :status => :created, :location => @listadocaucion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @listadocaucion.errors, :status => :unprocessable_entity }
      end
    end
 end

  # PUT /listadocaucions/1
  # PUT /listadocaucions/1.xml
 def update
    @listadocaucion = Listadocaucion.find(params[:id])
    @listadocaucion.lcau_ultmod = DateTime.now
    @listadocaucion.lcau_usuario = session[:user].usur_nombre
    respond_to do |format|
      if @listadocaucion.update_attributes(params[:listadocaucion])
        flash[:notice] = 'El listado de caución ha sido actualizado.'
        format.html { redirect_to(@listadocaucion) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @listadocaucion.errors, :status => :unprocessable_entity }
      end
    end
 end
 
  # DELETE /listadocaucions/1
  # DELETE /listadocaucions/1.xml
 def destroy
    @listadocaucion = Listadocaucion.find(params[:id])
    @listadocaucion.destroy
    respond_to do |format|
      format.html { redirect_to(listadocaucions_url) }
      format.xml  { head :ok }
    end
 end

end
