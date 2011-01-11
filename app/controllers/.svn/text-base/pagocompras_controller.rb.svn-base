class PagocomprasController < ApplicationController
 before_filter :login_required
   access_control [:index, :list, :show, :pagocomprobante, :new, :edit, :create, :update] => '(rol 2 | rol 3 | rol 4 | rol 5 | rol 6 | rol 7)'


  # GET /pagocompras
  # GET /pagocompras.xml
  def index
    @pagocompras = Pagocompra.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pagocompras }
    end
  end

  # GET /pagocompras/1
  # GET /pagocompras/1.xml
  def show
    @pagocompra = Pagocompra.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      
    end
  end

  # GET /pagocompras/new
  # GET /pagocompras/new.xml
  def new
   @pagocompra = Pagocompra.new
     respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pagocompra }
    end
  end

  # GET /pagocompras/1/edit
  def edit
    @pagocompra = Pagocompra.find(params[:id])
  end

  # POST /pagocompras
  # POST /pagocompras.xml
  def create
    @pagocompra = Pagocompra.new(params[:pagocompra])
    $total = params[:total].to_d
    $suma = ((@pagocompra.pcpr_efectivo.nil? ? 0 : @pagocompra.pcpr_efectivo) + (@pagocompra.pcpr_cheque.nil? ? 0 : @pagocompra.pcpr_cheque) + (@pagocompra.pcpr_depotransf.nil? ? 0 : @pagocompra.pcpr_depotransf) + (@pagocompra.pcpr_otro.nil? ? 0 : @pagocompra.pcpr_otro))
    idpagocompra = Pagocompra.maximum(:id, :conditions => ["sucursal_id = ?", session[:sucursal]]) 
    @pagocompra.id = [idpagocompra.to_i + 1, session[:sucursal]]
    @pagocompra.pcpr_usuario = session[:user].usur_nombre 
    @pagocompra.pcpr_ultmod = DateTime.now
    respond_to do |format|
      if @pagocompra.save
        pagocomprobante()
        flash[:notice] = 'Pagocompra was successfully created.'
        format.html { redirect_to(:controller => 'cabplaegresos', :action => 'formapago', :id => 1,  :idpe => [params[:idpeid].to_s, session[:sucursal].to_s]) }
        format.xml  { render :xml => @pagocompra, :status => :created, :location => @pagocompra }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pagocompra.errors, :status => :unprocessable_entity }
        params[:idpe] = [params[:idpeid], session[:sucursal]]
      end
    end
  end

  def pagocomprobante
   @comprobantes = Pagocompra.comprobante(params[:idpeid], params[:proveedor], params[:concepto], session[:sucursal])
   @comprobantes.each do |comp|
    comp.update_attribute(:pagocompra_id, @pagocompra.id[0])
   end
  end

  # PUT /pagocompras/1
  # PUT /pagocompras/1.xml
  def update
    @pagocompra = Pagocompra.find(params[:id])
    $total = params[:total].to_d
    $suma = ((params[:pagocompra][:pcpr_efectivo].nil? ? 0 : params[:pagocompra][:pcpr_efectivo].to_d) + (params[:pagocompra][:pcpr_cheque].nil? ? 0 : params[:pagocompra][:pcpr_cheque].to_d) + (params[:pagocompra][:pcpr_depotransf].nil? ? 0 : params[:pagocompra][:pcpr_depotransf].to_d) + (params[:pagocompra][:pcpr_otro].nil? ? 0 : params[:pagocompra][:pcpr_otro].to_d))
    respond_to do |format|
      if @pagocompra.update_attributes(params[:pagocompra])
      flash[:notice] = 'Pagocompra ha sido actualizado.'
      format.html { redirect_to(:controller => 'cabplaegresos', :action => 'edit', :id => ""+params[:idpeid].to_s+","+session[:sucursal].to_s+"") }
        format.xml  { head :ok }
      else
        params[:idpe] = [params[:idpeid], session[:sucursal]]
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pagocompra.errors, :status => :unprocessable_entity }

      end
    end
  end



  # DELETE /pagocompras/1
  # DELETE /pagocompras/1.xml
  def destroy
    @pagocompra = Pagocompra.find(params[:id])
    @pagocompra.destroy

    respond_to do |format|
      format.html { redirect_to(pagocompras_url) }
      format.xml  { head :ok }
    end
  end
end
