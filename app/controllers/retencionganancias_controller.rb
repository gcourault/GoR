class RetenciongananciasController < ApplicationController
   before_filter :login_required
   access_control [:index, :list, :new, :create, :update, :edit, :show, :destroy, :cabretencionganancia, :retgan, :editar] => '(rol 2 | rol 3 | rol 4 | rol 5 | rol 6 | rol 7)'
                 
  def permission_denied
    flash[:notice] = "Usted no tiene permiso para realizar esta acción." 
    return redirect_to(:controller => 'usuario', :action => 'denied')
  end
  # GET /retencionganancias
  # GET /retencionganancias.xml
  def index
    @retencionganancias = Retencionganancia.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @retencionganancias }
    end
  end

  # GET /retencionganancias/1
  # GET /retencionganancias/1.xml
  def show
    @retencionganancia = Retencionganancia.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @retencionganancia }
    end
  end

  # GET /retencionganancias/new
  # GET /retencionganancias/new.xml
  def new
   #@retencionganancia = Retencionganancia.new
   @comprobanteretgens = Cabplaegreso.comprobanteretgen(session[:sucursal], params[:fecha], params[:provid], params[:conceptoegresoid])
   render :partial => "new"
  end

  # GET /retencionganancias/1/edit
  def edit
    @retencionganancia = Retencionganancia.find(params[:id])
  end

  def editar
     @retencionganancia = Retencionganancia.find(params[:id])
     render :partial => 'retencionganancias/editar', :object => @retencionganancia 
  end

  # POST /retencionganancias
  # POST /retencionganancias.xml
  def create
   Retencionganancia.transaction do
    @retencionganancia = Retencionganancia.new(params[:retencionganancia])
    idret = Retencionganancia.maximum(:id, :conditions => ["sucursal_id = ?", session[:sucursal]]) 
    @retencionganancia.id = [idret.to_i + 1, session[:sucursal]]
    @retencionganancia.rtga_ultmod = DateTime.now
    @retencionganancia.rtga_usuario = session[:user].usur_nombre
    respond_to do |format|
      if @retencionganancia.save
       cabretencionganancia()
        flash[:notice] = 'La retencion de ganancia ha sido creada.'
         format.html{ redirect_to(:controller => 'cabplaegresos', :action => 'edit', :id => @retencionganancia.rtga_plaegresoid.to_s+","+session[:sucursal].to_s, :nroplanillaegreso => @retencionganancia.rtga_plaegresoid, :fecha => params[:fecha])} 
      
        format.xml  { render :xml => @retencionganancia, :status => :created, :location => @retencionganancia }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @retencionganancia.errors, :status => :unprocessable_entity }
      end
    end
   end
  end
 
  def cabretencionganancia
    @comprobanteretgens = Cabplaegreso.comprobanteretgen(session[:sucursal], params[:fecha], params[:provid], params[:conceptoegresoid])
    @comprobanteretgens.each do |comp|
    @cabcompra = Cabcompra.find([comp.cabcid, session[:sucursal]])
    @cabcompra.update_attribute(:retencionganancia_id, @retencionganancia.id[0])
   end
  end
  # PUT /retencionganancias/1
  # PUT /retencionganancias/1.xml
  def update
    @retencionganancia = Retencionganancia.find(params[:id])
    
    respond_to do |format|
      if @retencionganancia.update_attributes(params[:retencionganancia])
        flash[:notice] = 'La retencion de ganancia ha sido actualizada.'
        format.html{ redirect_to(:controller => 'retencionganancias', :action => 'retgan', :id => 1, :idpe => [@retencionganancia.rtga_plaegresoid, session[:sucursal]] )}
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @retencionganancia.errors, :status => :unprocessable_entity }
      end
    end
  end

  def retgan
     @retgans = Cabplaegreso.retgan(params[:idpe][0], session[:sucursal])
     @planillaegreso = Cabplaegreso.find(params[:idpe])
  end
  # DELETE /retencionganancias/1
  # DELETE /retencionganancias/1.xml
  def destroy
 
    @retencionganancia = Retencionganancia.find(params[:id])
    penro = @retencionganancia.rtga_plaegresoid
    @comprobantes = Cabcompra.find(:all, :conditions => ['retencionganancia_id = ? and sucursal_id = ?', @retencionganancia.id[0], session[:sucursal] ])
    @comprobantes.each do |crg|
         crg.update_attribute(:retencionganancia_id, nil) 
      end
    
    @retencionganancia.destroy

    respond_to do |format|
      format.html{ redirect_to(:controller => 'retencionganancias', :action => 'retgan', :id => 1, :idpe => [penro, session[:sucursal]] )}
      format.xml  { head :ok }
    end
  end

end
