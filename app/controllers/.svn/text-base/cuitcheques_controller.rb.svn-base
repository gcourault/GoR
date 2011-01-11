class CuitchequesController < ApplicationController

   before_filter :login_required
   access_control [:list, :new, :create, :update, :edit, :show] => '( rol 3 | rol 4  | rol 5  | rol 6 | rol 7)',
                 :index => '(rol 2 | rol 3 | rol 4  | rol 5  | rol 6 | rol 7 )'
 def permission_denied
    flash[:notice] = "Usted no tiene los privilegios para realizar esta acción." 
    return redirect_to(:controller => 'login', :action => 'denied')
 end

  # GET /cuitcheques
  # GET /cuitcheques.xml
  def index
    @cuitcheques = Cuitcheque.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cuitcheques }
    end
  end

  # GET /cuitcheques/1
  # GET /cuitcheques/1.xml
  def show
    @cuitcheque = Cuitcheque.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cuitcheque }
    end
  end

  # GET /cuitcheques/new
  # GET /cuitcheques/new.xml
  def new
    @cuitcheque = Cuitcheque.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cuitcheque }
    end
  end

  # GET /cuitcheques/1/edit
  def edit
    @cuitcheque = Cuitcheque.find(params[:id])
  end

  # POST /cuitcheques
  # POST /cuitcheques.xml
  def create
    @cuitcheque = Cuitcheque.new(params[:cuitcheque])

    respond_to do |format|
      if @cuitcheque.save
        flash[:notice] = 'El los datos pertenecientes a dicho CUIT han sido cargados.'
        format.html { redirect_to(:controller => 'chequeterceros', :action => 'index', :page => (params[:valor][:page].to_i < 1  ? 1 : params[:valor][:page]), :monto => params[:valor][:monto]) } # vuelve a la pagina de consulta de cheques
        format.xml  { render :xml => @cuitcheque, :status => :created, :location => @cuitcheque }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cuitcheque.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cuitcheques/1
  # PUT /cuitcheques/1.xml
  def update
    @cuitcheque = Cuitcheque.find(params[:id])
    respond_to do |format|
      if @cuitcheque.update_attributes(params[:cuitcheque])
        flash[:notice] = 'Los datos del CUIT han sido actualizados.'
        format.html { redirect_to(@cuitcheque) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cuitcheque.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cuitcheques/1
  # DELETE /cuitcheques/1.xml
  def destroy
    @cuitcheque = Cuitcheque.find(params[:id])
    @cuitcheque.destroy
    respond_to do |format|
      format.html { redirect_to(cuitcheques_url) }
      format.xml  { head :ok }
    end
  end

end
