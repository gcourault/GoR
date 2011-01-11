class RencomprasController < ApplicationController
   before_filter :login_required
   access_control [:index, :list, :new, :create, :update, :edit, :show] => '(rol 2 | rol 3 | rol 4 | rol 5 | rol 6 | rol 7)'

 def permission_denied
    flash[:notice] = "Usted no tiene permiso para realizar esta acción." 
    return redirect_to(:controller => 'login', :action => 'denied')
 end
  # GET /rencompras
  # GET /rencompras.xml
  def index
    @rencompras = Rencompra.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rencompras }
    end
  end

  # GET /rencompras/1
  # GET /rencompras/1.xml
  def show
    @rencompra = Rencompra.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @rencompra }
    end
  end

  # GET /rencompras/new
  # GET /rencompras/new.xml
  def new
    #@rencompra = Rencompra.new
    @alicuotaivas = Alicuotaiva.find(:all)

   # respond_to do |format|
   #   format.html # new.html.erb
   #   format.xml  { render :xml => @rencompra }
   # end
  end

  # GET /rencompras/1/edit
  def edit
    @rencompra = Rencompra.find(params[:id])
  end

  # POST /rencompras
  # POST /rencompras.xml
  def create
    @rencompra = Rencompra.new(params[:rencompra])
    idrenglon = Rencompra.maximum(:id, :conditions => ["sucursal_id = ?", session[:sucursal]]) 
    @rencompra.id = [idrenglon.to_i + 1, session[:sucursal]]
    @alicuota = Alicuotaiva.find_by_id(@rencompra.alicuotaiva_id.to_i)
     iva = (@rencompra.rcom_netorenglon.to_f * (@alicuota.aiva_alicuota.to_d/100))
    @rencompra.rcom_ivarenglon = iva
    @rencompra.rcom_totalrenglon = (@rencompra.rcom_netorenglon.to_f  + iva)
    @rencompra.rcom_usuario = session[:user].usur_nombre 
    @rencompra.rcom_ultmod = DateTime.now
    respond_to do |format|
      if @rencompra.save
        flash[:notice] = 'Rencompra was successfully created.'
       format.html { redirect_to(:controller => 'cabcompras', :action => 'index')}
        format.xml  { render :xml => @rencompra, :status => :created, :location => @rencompra }
      else
        @alicuotaivas = Alicuotaiva.find(:all)
        format.html { render :action => "new" }
        format.xml  { render :xml => @rencompra.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rencompras/1
  # PUT /rencompras/1.xml
  def update
    @rencompra = Rencompra.find(params[:id])
    @rencompra.rcom_usuario = session[:user].usur_nombre 
    @rencompra.rcom_ultmod = DateTime.now
    respond_to do |format|
      if @rencompra.update_attributes(params[:rencompra])
        flash[:notice] = 'Rencompra was successfully updated.'
        format.html { redirect_to(@rencompra) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rencompra.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rencompras/1
  # DELETE /rencompras/1.xml
  def destroy
    @rencompra = Rencompra.find(params[:id])
    @rencompra.destroy

    respond_to do |format|
      format.html { redirect_to(rencompras_url) }
      format.xml  { head :ok }
    end
  end
end
