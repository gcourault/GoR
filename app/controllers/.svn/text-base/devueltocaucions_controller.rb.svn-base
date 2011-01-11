class DevueltocaucionsController < ApplicationController
   before_filter :login_required
   access_control  [:list, :new, :create, :update, :edit, :show, :index] => '(rol 4 | rol 5 | rol 6 | rol 7)'

 def permission_denied
    flash[:notice] = "Usted no tiene los privilegios para realizar esta acción." 
    return redirect_to(:controller => 'login', :action => 'denied')
 end
  # GET /devueltocaucions
  # GET /devueltocaucions.xml
  def index
   
    @devueltocaucions = Devueltocaucion.paginate(:per_page => 20, :page => params[:page] || 1, :order => ['devc_fecha DESC'])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @devueltocaucions }
    end
  end

  # GET /devueltocaucions/1
  # GET /devueltocaucions/1.xml
  def show
    @devueltocaucion = Devueltocaucion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @devueltocaucion }
    end
  end

  # GET /devueltocaucions/new
  # GET /devueltocaucions/new.xml
  def new
    @devueltocaucion = Devueltocaucion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @devueltocaucion }
    end
  end

  # GET /devueltocaucions/1/edit
  def edit
    @devueltocaucion = Devueltocaucion.find(params[:id])
  end

  # POST /devueltocaucions
  # POST /devueltocaucions.xml
  def create
    @devueltocaucion = Devueltocaucion.new(params[:devueltocaucion])
    @devueltocaucion.devc_ultmod = DateTime.now
    @devueltocaucion.devc_usuario = session[:user].usur_nombre
    respond_to do |format|
      if @devueltocaucion.save
        flash[:notice] = 'Devueltocaucion was successfully created.'
        format.html { redirect_to(@devueltocaucion) }
        format.xml  { render :xml => @devueltocaucion, :status => :created, :location => @devueltocaucion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @devueltocaucion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /devueltocaucions/1
  # PUT /devueltocaucions/1.xml
  def update
    @devueltocaucion = Devueltocaucion.find(params[:id])
    @devueltocaucion.devc_ultmod = DateTime.now
    @devueltocaucion.devc_usuario = session[:user].usur_nombre
    respond_to do |format|
      if @devueltocaucion.update_attributes(params[:devueltocaucion])
        pag = (params[:valor][:page].to_i > 0 ? params[:valor][:page] : 1)
        flash[:notice] = 'Devueltocaucion was successfully updated.'
        format.html { redirect_to(:controller => 'devueltocaucions', :action => 'index', :page => pag )}
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @devueltocaucion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /devueltocaucions/1
  # DELETE /devueltocaucions/1.xml
  def destroy
    @devueltocaucion = Devueltocaucion.find(params[:id])
    @devueltocaucion.destroy

    respond_to do |format|
      format.html { redirect_to(devueltocaucions_url) }
      format.xml  { head :ok }
    end
  end
end
