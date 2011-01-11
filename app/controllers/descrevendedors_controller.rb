class DescrevendedorsController < ApplicationController

 before_filter :login_required
 access_control [:index, :list, :new, :create, :update, :edit, :show] => '( rol 6 | rol 7 )'
 def permission_denied
    flash[:notice] = "Usted no tiene los privilegios para realizar esta acción." 
    return redirect_to(:controller => 'login', :action => 'denied')
 end
                 
  # GET /descrevendedors
  # GET /descrevendedors.xml
  def index
    descrevendedors = Descrevendedor.find(:all, :joins => [:marca, :rubro], :order => ['marcas.marc_codigo,  rubros.rubr_codigo'])
    @descrevendedors = descrevendedors.paginate(:per_page => 20, :page => params[:page] || 1)
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @descrevendedors }
    end
  end

  # GET /descrevendedors/1
  # GET /descrevendedors/1.xml
  def show
    @descrevendedor = Descrevendedor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @descrevendedor }
    end
  end

  # GET /descrevendedors/new
  # GET /descrevendedors/new.xml
  def new
    @descrevendedor = Descrevendedor.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @descrevendedor }
    end
  end

  # GET /descrevendedors/1/edit
  def edit
    @descrevendedor = Descrevendedor.find(params[:id])
  end

  # POST /descrevendedors
  # POST /descrevendedors.xml
  def create
    @descrevendedor = Descrevendedor.new(params[:descrevendedor])
    @descrevendedor.drev_ultmod = DateTime.now
    @descrevendedor.drev_usuario = session[:user].usur_nombre
      if @descrevendedor.drev_descuento1.nil?
        @descrevendedor.drev_descuento1 = 0.0
    end
    if  @descrevendedor.drev_descuento2.nil?
        @descrevendedor.drev_descuento2 = 0.0
    end
    if  @descrevendedor.drev_descuento3.nil?
        @descrevendedor.drev_descuento3 = 0.0 
    end
    respond_to do |format|
      if @descrevendedor.save
        flash[:notice] = 'Descrevendedor was successfully created.'
        format.html { redirect_to(@descrevendedor) }
        format.xml  { render :xml => @descrevendedor, :status => :created, :location => @descrevendedor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @descrevendedor.errors, :status => :unprocessable_entity}
      end
    end
  end

  # PUT /descrevendedors/1
  # PUT /descrevendedors/1.xml
  def update
    @descrevendedor = Descrevendedor.find(params[:id])
    @descrevendedor.drev_ultmod = DateTime.now
    @descrevendedor.drev_usuario = session[:user].usur_nombre

    respond_to do |format|
      if @descrevendedor.update_attributes(params[:descrevendedor])
        if @descrevendedor.drev_descuento1.nil?
           @descrevendedor.update_attribute(:drev_descuento1, 0)
        end
        if @descrevendedor.drev_descuento2.nil?
           @descrevendedor.update_attribute(:drev_descuento2, 0)
        end
        if @descrevendedor.drev_descuento3.nil?
           @descrevendedor.update_attribute(:drev_descuento3, 0)
        end
        flash[:notice] = 'Descrevendedor was successfully updated.'
        pag = (params[:valor][:page].to_i > 0 ? params[:valor][:page] : 1)
        format.html { redirect_to(:controller => 'descrevendedors', :action => 'index', :page => pag )}
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @descrevendedor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /descrevendedors/1
  # DELETE /descrevendedors/1.xml
  def destroy
    @descrevendedor = Descrevendedor.find(params[:id])
    @descrevendedor.destroy

    respond_to do |format|
      format.html { redirect_to(descrevendedors_url) }
      format.xml  { head :ok }
    end
  end
end
